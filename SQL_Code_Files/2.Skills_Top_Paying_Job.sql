WITH Top_Jobs AS(
    SELECT 
        Row_Number() OVER (ORDER BY NULL) AS Index,
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        job_postings_fact.job_title_short,
        job_postings_fact.job_schedule_type,
        job_postings_fact.job_location,
        job_postings_fact.salary_year_avg AS Salary,
        company_dim.name AS Company
    FROM job_postings_fact
        LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_title_short Like 'Data %'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 20
)
SELECT 
    Row_Number() OVER ( ORDER BY NULL ) AS Index,
    Top_Jobs.job_id,
    Top_Jobs.job_title,
    Top_Jobs.job_title_short,
    Top_Jobs.job_location,
    Top_Jobs.Salary,
    skills_dim.skills
FROM Top_Jobs
    INNER JOIN skills_job_dim ON Top_Jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY Top_Jobs.Salary DESC
LIMIT 20;