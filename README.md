# SQL Analysis: Optimal Skills and Top-Paying Jobs

## Introduction  
This project aims to provide insights into the job market for **Data Analyst roles**, focusing on the top-paying jobs, required skills, and optimal learning strategies for career advancement. By analyzing job postings, salaries, and skill trends, this project answers the following key questions:
- What are the top-paying jobs for my role?
- What skills are required for these top-paying roles?
- What are the most in-demand skills for my role?
- What are the top skills based on salary?
- What are the most optimal skills to learn?

The analysis is conducted using SQL, and the queries target structured job market data. Find the specific queries here [project folder](/project/)

---

## Background  
In today's competitive job market, understanding the relationship between skills, salary, and demand is crucial for career growth. This project was guided by [Luke Barousse's SQL Course](lukebarousse.com/sql). It focuses on identifying patterns in job postings for **Data Analysts** from 2023 by analyzing salary trends and required skills, particularly for remote opportunities.  

The primary objectives include:
1. Discovering the highest-paying Data Analyst roles.
2. Identifying skills that drive higher salaries.
3. Finding in-demand skills to prioritize for learning.

---

## Tools I Used  
The following tools and technologies were used to perform the analysis:
- **SQL**: For querying and analyzing job market data from relational databases.
- **PostgreSQL:** My choice of database management system. Ideal for handling the job posting data.
- **Git and GitHub**: To control versions of my SQL scripts and allow for sharing.
- **Database structure**:
  - `job_postings_fact`: Contains job-related data such as job IDs, titles, salaries, and locations.
  - `company_dim`: Provides information about hiring companies.
  - `skills_job_dim`: Links jobs to required skills.
  - `skills_dim`: Stores details about individual skills.

---

## The Analysis  
The project is divided into five stages, each addressing a specific question through SQL queries:
1. **Top-Paying Jobs**  
   Identify the top 10 remote Data Analyst roles with specific salary information (`NOT NULL`).  
   *Key Metrics:* Job titles, hiring companies, locations, and average yearly salaries.  
   *File:* `1_top_paying_jobs.sql`
      ```sql
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
   ```
2. **Skills for Top-Paying Jobs**  
   The query finds the skills required for the top-paying jobs identified in stage 1.  
   *Key Metrics:* Skill IDs, job titles, and locations.  
   *File:* `2_top_paying_job_skills.sql`
```sql
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
```

3. **Most In-Demand Skills**  
   Identifies the most frequently required skills across all Data Analyst job postings.  
   *Key Metrics:* Skill names and demand frequency.  
   *File:* `3_in_demand_skills.sql`
```sql
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
```
4. **Top Skills Based on Salary**  
   Finds the highest paying skills that someone should focus on yo get the highest pay.  
   *Key Metrics:* Skills with the highest earning potential.  
   *File:* `4_top_paying_skills.sql`
```sql
SELECT
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
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 50
```
5. **Optimal Skills to Learn**  
   Combined skill demand and salary data to determine the best skills to learn (high demand + high salary).  
   *Key Metrics:* Skills balancing demand and salary potential.  
   *File:* `5_optimal_skills.sql`
```sql
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
```
---

## What I Learned 
This was my first exposure to SQL and I am glad I came from being a noob to semi-pro. I completed an excellent SQL course 🎓, covering the fundamentals and advanced concepts, with a practical project at the end. Here's a breakdown of my learning journey:

## 📖 Chapter 1️⃣: Basics

This chapter introduced the core concepts and foundational skills in SQL, including:
- **SQL Basics**: Writing basic queries and using comparisons.
- **Wildcards and Aliases**: Techniques for flexible querying and renaming.
- **Aggregations and NULL Values**: Summarizing data and handling missing values.
- **Joins and Execution Order**: Combining data from multiple tables and understanding how SQL processes queries.

### Key Takeaways:
- Writing clean and efficient SQL queries.
- Using `WHERE`, `LIKE`, `AS`, and other essential operators.
- Understanding the importance of joins for relational databases.

## 📖 Chapter 2️⃣: Advanced SQL

This chapter took a deeper dive into SQL, focusing on advanced techniques and tools:
- **PostgreSQL Setup**: Setting up a local database environment.
- **Data Types and Table Manipulation**: Understanding and modifying database structures.
- **Date Functions and Conditional Logic**: Using SQL functions for time-based analysis and `CASE` for conditional logic.
- **Subqueries and CTEs**: Simplifying complex queries with Common Table Expressions (CTEs).
- **UNION Operators**: Combining multiple query results.

### Key Takeaways:
- Leveraging advanced SQL functions for more complex analysis.
- Building modular, readable queries with CTEs and subqueries.

---

## 📖 Chapter 3️⃣: Project - Real-World Application

In this chapter, I applied what I learned by working on a SQL project involving job and skill data analysis.
### Key Takeaways:
- Applying SQL to real-world datasets for analysis.
- Developing actionable insights using SQL queries.
- Using GitHub to document and share projects.

🔗 Video Link

Learn SQL from this comprehensive video tutorial: [SQL for Data Analytics](https://www.youtube.com/watch?v=7mz73uXD9DA)

This course has strengthened my SQL skills, from foundational knowledge to real-world application. I'm excited to use these skills in future projects and data analysis tasks!

## Conclusion
This project provided the following insights:
### 1. Top paying jobs
Some of the industry leaders are compensating highly for data analyst roles. Some notable ones are Meta (Social Media), AT&T (Telecommunications) and Pinterest (Social Media).
### 2. Skills for top paying jobs 
The top-paying jobs often require skills like SQL, Python, or Tableau, suggesting a strong demand for technical proficiency. In addition to technical skills, some roles also list analytical thinking and communication as essential for higher pay. Some skills are common amongst all the top paying roles indicating their practicality in securing premium positions.
### 3. In-demand skills
SQL Dominates: SQL emerges as the most commonly required skill for Data Analyst roles, reflecting its centrality in data handling and analysis. Python’s growing role in automation and advanced analytics, combined with Excel’s ubiquity, makes them consistently in demand. Soft skills like data visualization, problem-solving, and teamwork also feature prominently, indicating their importance alongside technical capabilities.
## Skills Demand Analysis

The table below highlights the demand for various skills based on the number of job postings requiring each skill:

| Skill      | Demand  |
|------------|---------|
| SQL        | 92,628  |
| Excel      | 67,031  |
| Python     | 57,326  |
| Tableau    | 46,554  |
| Power BI   | 39,468  |

### 4. Top Skills Based on Salary
Advanced Analytics Skills Pay More: Skills like machine learning, advanced statistical methods, and big data technologies are associated with higher salaries.

Visualization Skills Stand Out: Proficiency in tools like Tableau or Power BI tends to boost earning potential significantly.

Emerging Tools Reward More: Familiarity with less commonly used or cutting-edge tools (e.g., Spark, Hadoop) is linked to premium pay.

### 5: Optimal Skills to Learn
High Demand + High Salary Skills: SQL, Python, and data visualization tools like Tableau are the most optimal to learn, balancing strong demand and lucrative pay.
Emerging Trends Matter: Skills in cloud-based data systems or machine learning are increasingly critical for maintaining competitive pay.
The results highlight specific areas for skill development that maximize both employability and salary potential.
## Skills Demand and Average Salaries

The table below provides insights into skill demand and the average salaries associated with each skill:

| Skill         | Skill Demand | Average Salary ($) |
|---------------|--------------|---------------------|
| SQL           | 398          | 97,237             |
| Excel         | 256          | 87,288             |
| Python        | 236          | 101,397            |
| Tableau       | 230          | 99,288             |
| R             | 148          | 100,499            |
| Power BI      | 110          | 97,431             |
| SAS           | 63           | 98,902             |
| PowerPoint    | 58           | 88,701             |
| Looker        | 49           | 103,795            |
| Word          | 48           | 82,576             |
| Snowflake     | 37           | 112,948            |
| Oracle        | 37           | 104,534            |
| SQL Server    | 35           | 97,786             |
| Azure         | 34           | 111,225            |
| AWS           | 32           | 108,317            |
| Sheets        | 32           | 86,088             |
| Flow          | 28           | 97,200             |
| Go            | 27           | 115,320            |
| SPSS          | 24           | 92,170             |

---

## How to Use 
1. Clone the repository from GitHub.
2. Load the SQL files into your preferred database environment.
3. Execute the queries in the listed order (`1` to `5`) to replicate the analysis.
