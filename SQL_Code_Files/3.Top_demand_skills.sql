WITH Top_Skills AS (
    SELECT job_postings_fact.job_title_short,
        MAX(job_postings_fact.salary_year_avg) AS Max_Salary,
        MIN(job_postings_fact.salary_year_avg) AS Min_Salary,
        skills_dim.skill_id,
        skills_dim.skills,
        Count (skills_job_dim.job_id) AS Skill_demand
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short LIKE 'Data %' AND salary_year_avg Is NOT NULL
    GROUP BY 
        skills_dim.skills,
        job_title_short,
        skills_dim.skill_id
    ORDER BY 
            Skill_demand DESC,
            Max_Salary DESC
    Limit 20
)
SELECT 
    Row_Number() OVER(ORDER BY NULL) AS Index,
    *
FROM Top_Skills

-- This query used to filter out the top skills based on the no of job postings for that skill.