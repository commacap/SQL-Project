
SELECT
    skill_rank.skill_id,
    skills_dim.skills
FROM (
    SELECT
    skill_id,
    COUNT(*) AS skill_needed
FROM skills_job_dim
GROUP BY skill_id
ORDER BY skill_needed DESC
LIMIT 5)
AS skill_rank
JOIN skills_dim ON skill_rank.skill_id = skills_dim.skill_id
ORDER BY skill_rank.skill_needed DESC