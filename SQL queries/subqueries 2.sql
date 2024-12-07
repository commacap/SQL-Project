SELECT
    company_id,
    jobs_posted,
CASE
    WHEN jobs_posted < 10 THEN 'Small'
    WHEN jobs_posted BETWEEN 10 AND 50 THEN 'Medium'
    ELSE 'Large'
END AS company_categories
FROM    
    (SELECT
    company_id,
    COUNT(company_id) AS jobs_posted
FROM job_postings_fact
GROUP BY company_id
    ) AS jobs_companies
