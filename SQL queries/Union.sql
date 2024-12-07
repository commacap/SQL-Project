WITH q1_jobs AS
(SELECT *
FROM jan_jobs

UNION ALL

SELECT *
FROM feb_jobs
UNION ALL

SELECT *
FROM mar_jobs)
SELECT *
FROM q1_jobs
WHERE salary_year_avg > 70000 AND salary_year_avg IS NOT NULL