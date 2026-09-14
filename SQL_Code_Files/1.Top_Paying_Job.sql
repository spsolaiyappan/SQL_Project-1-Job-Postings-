SELECT 
    Row_Number() OVER ( ORDER BY NULL ) AS Index,
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
