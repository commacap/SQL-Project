/*What are the most optimal skills to learn?
-High paying and most in demand*/

WITH demanded_skills AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(*) AS skill_demand
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
),
average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills, skills_job_dim.skill_id
    )
SELECT
    demanded_skills.skill_id,
    demanded_skills.skills,
    demanded_skills.skill_demand,
    average_salary.avg_salary
FROM demanded_skills
INNER JOIN average_salary ON demanded_skills.skill_id = average_salary.skill_id
ORDER BY 
    skill_demand DESC,
    avg_salary DESC;