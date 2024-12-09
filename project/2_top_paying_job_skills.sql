/*What are the skills required for these top-paying roles?*/
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS hiring_company,
        job_location,
        job_schedule_type,
        job_posted_date,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.job_id,
    skills_job_dim.skill_id,
    job_title,
    salary_year_avg,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
     ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
/*
The results found by running this query misposition the top 2 highest paying jobs(visible by running the subquery(CTE) alone.
This happens because of the use of INNER JOIN whereby the skill id and name are null for these jobs.
LEFT JOIN lists these jobs in the appropriate positions, combined with the ORDER BY salary command)
*/