With Skill_demand as (
    SELECT
    Rank() OVER (PARTITION BY job_postings_fact.job_title_short ORDER BY Count(skills_job_dim.job_id) DESC) AS Rank_no_Skills, 
    job_postings_fact.job_title_short,
    UPPER(skills_dim.skills) AS skills,
    Count(skills_job_dim.skill_id) AS Skill_count,
    Max(job_postings_fact.salary_year_avg) AS Max_Salary,
    Min(job_postings_fact.salary_year_avg) AS Min_Salary        
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short LIKE 'Data %' AND salary_year_avg Is NOT NULL
GROUP BY job_title_short, skills_dim.skills
ORDER BY job_title_short, Max_Salary DESC
)

SELECT *
FROM Skill_demand
WHERE Rank_no_Skills <= 7
ORDER BY job_title_short, Max_Salary DESC