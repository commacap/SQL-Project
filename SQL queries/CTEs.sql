WITH remote_skills AS
    (SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM skills_job_dim
INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE job_work_from_home = TRUE
GROUP BY skill_id)

SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skill_name,
    skill_count
FROM remote_skills
INNER JOIN skills_dim ON remote_skills.skill_id = skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5