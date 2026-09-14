SELECT
job_postings_fact.job_title_short,
Round(AVG(job_postings_fact.salary_year_avg),0) AS Average_Salary,
Round(AVG(job_postings_fact.salary_year_avg) Filter (WHERE job_postings_fact.job_work_from_home = 'TRUE' AND salary_year_avg Is NOT NULL),0) AS Average_Salary_WFH,
skills_dim.skills,
Count(skills_job_dim.job_id) AS Job_Count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short LIKE 'Data %' AND salary_year_avg Is NOT NULL 

Group BY job_title_short, skills
Having Count(skills_job_dim.job_id) >= 10
ORDER BY Average_Salary DESC
LIMIT 20

-- Top Average salary skills