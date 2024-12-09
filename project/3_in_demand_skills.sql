/*
What are the most in-demand skills for my role?
-Ran a query on all the job postings available to find top skills
in demand for Data Analysts
*/
SELECT
    skills_job_dim.skill_id,
    skills_dim.skills,
    COUNT(*) AS skill_demand
FROM job_postings_fact
INNER JOIN skills_job_dim
     ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills_job_dim.skill_id, skills_dim.skills
ORDER BY skill_demand DESC
LIMIT 5