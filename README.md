# SQL Analysis: Optimal Skills and Top-Paying Jobs

## Introduction  
This project aims to provide insights into the job market for **Data Analyst roles**, focusing on the top-paying jobs, required skills, and optimal learning strategies for career advancement. By analyzing job postings, salaries, and skill trends, this project answers the following key questions:
- What are the top-paying jobs for my role?
- What skills are required for these top-paying roles?
- What are the most in-demand skills for my role?
- What are the top skills based on salary?
- What are the most optimal skills to learn?

The analysis is conducted using SQL, and the queries target structured job market data.

---

## Background  
In today's competitive job market, understanding the relationship between skills, salary, and demand is crucial for career growth. This project focuses on identifying patterns in job postings for **Data Analysts** by analyzing salary trends and required skills, particularly for remote opportunities.  

The primary objectives include:
1. Discovering the highest-paying Data Analyst roles.
2. Identifying skills that drive higher salaries.
3. Finding in-demand skills to prioritize for learning.

---

## Tools I Used  
The following tools and technologies were used to perform the analysis:
- **SQL**: For querying and analyzing job market data from relational databases.
- **GitHub**: To manage and share project files.
- **Database structure**:
  - `job_postings_fact`: Contains job-related data such as job IDs, titles, salaries, and locations.
  - `company_dim`: Provides information about hiring companies.
  - `skills_job_dim`: Links jobs to required skills.
  - `skills_dim`: Stores details about individual skills.

---

## The Analysis  
The project is divided into five stages, each addressing a specific question through SQL queries:

1. **Top-Paying Jobs**  
   *Query:* Identify the top 10 remote Data Analyst roles with specific salary information (`NOT NULL`).  
   *Key Metrics:* Job titles, hiring companies, locations, and average yearly salaries.  
   *File:* `1_top_paying_jobs.sql`

2. **Skills for Top-Paying Jobs**  
   *Query:* List the skills required for the top-paying jobs identified in stage 1.  
   *Key Metrics:* Skill IDs, job titles, and locations.  
   *File:* `2_top_paying_job_skills.sql`

3. **Most In-Demand Skills**  
   *Query:* Identify the most frequently required skills across all Data Analyst job postings.  
   *Key Metrics:* Skill names and demand frequency.  
   *File:* `3_in_demand_skills.sql`

4. **Top Skills Based on Salary**  
   *Query:* Rank skills based on the average salaries of jobs requiring them.  
   *Key Metrics:* Skills with the highest earning potential.  
   *File:* `4_top_paying_skills.sql`

5. **Optimal Skills to Learn**  
   *Query:* Combine skill demand and salary data to determine the best skills to learn (high demand + high salary).  
   *Key Metrics:* Skills balancing demand and salary potential.  
   *File:* `5_optimal_skills.sql`

---

## What I Learned  
This project provided the following insights:
1. High-paying Data Analyst roles often require specific technical and analytical skills.
2. Certain skills (e.g., proficiency in SQL, Python) consistently appear in top-paying and high-demand roles.
3. Optimal skills for learning align with a combination of high demand and salary potential, helping prioritize career development efforts.

---

## How to Use  
1. Clone the repository from GitHub.
2. Load the SQL files into your preferred database environment.
3. Execute the queries in the listed order (`1` to `5`) to replicate the analysis.
