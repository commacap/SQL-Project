/*
What are the top-paying jobs for my role?
-Find top 10 Data Analyst roles available remotely.
-Jobs must have specific salaries (NOT NULL)
*/
SELECT
    job_id,
    job_title,
    company_dim.name AS hiring_company,
    job_location,
    job_schedule_type,
    job_posted_date,
    salary_year_avg
FROM job_postings_fact
/*decided to add company name*/
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10