SELECT *
FROM skills_job_dim
RIGHT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LIMIT 3