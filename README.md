HireSync — Recruitment Analytics & Hiring Funnel Dashboard
Project Overview

HireSync is a recruitment analytics project designed to analyze the hiring pipeline from application to successful hire.

The project simulates a real-world recruitment data environment where multiple employers post jobs and candidates move through different recruitment stages such as:

Applied → Screened → Interviewed → Offered → Hired

The main purpose of this project is to understand how efficiently candidates move through the recruitment funnel, identify drop-off points, measure time to hire, and compare hiring performance across employers.

The project uses MySQL for data storage and SQL analysis and Microsoft Power BI for data visualization and dashboard development.

The simulated dataset was generated to represent a realistic recruitment environment and can later be replaced with live recruitment data.

🎯 Project Objective

The main objective of HireSync is to turn recruitment data into actionable business insights.

The analysis focuses on:

Understanding the candidate recruitment funnel
Measuring the number of applications and successful hires
Calculating overall hiring conversion
Measuring average time to hire
Identifying major recruitment drop-off points
Comparing hiring performance between employers
Tracking hiring trends over time
Creating a business-ready Power BI dashboard
Preparing SQL queries that can later work with live recruitment data

In short, the goal is to help recruitment teams answer:

Where are candidates dropping out, how efficiently are employers hiring, and where can the recruitment process be improved?

🏗️ Project Workflow

The complete project was developed in five phases:

Phase 1
Database Schema
       ↓
Phase 2
Simulated Recruitment Data
       ↓
Phase 3
SQL Business Analysis
       ↓
Phase 4
Power BI Dashboard
       ↓
Phase 5
Business Summary & Insights
🗂️ Database Structure

The HireSync database contains five main tables:

                    ┌─────────────────┐
                    │    Employers    │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │      Jobs       │
                    └────────┬────────┘
                             │
                             ▼
┌─────────────────┐  ┌─────────────────┐
│    Candidates   │──│   Applications  │
└─────────────────┘  └────────┬────────┘
                              │
                              ▼
                   ┌──────────────────────┐
                   │ Application Stage    │
                   │      History        │
                   └──────────────────────┘
Main Tables
Table	Purpose
employers	Stores employer/company information
jobs	Stores job postings
candidates	Stores candidate information
applications	Records candidate applications
application_stage_history	Tracks candidate movement through recruitment stages
📊 Recruitment Funnel

The recruitment process is analyzed through the following stages:

Applied
   ↓
Screened
   ↓
Interviewed
   ↓
Offered
   ↓
Hired

The stage history table records when an application moves through each stage.

This makes it possible to analyze:

Candidate progression
Stage-level conversion
Drop-offs
Hiring performance
Time between recruitment stages
🛠️ Technologies Used
Database
MySQL
Data Generation
Python
Faker
Data Analysis
SQL
MySQL queries
Aggregate functions
GROUP BY
HAVING
JOIN
CASE
Date calculations
Subqueries
Data Visualization
Microsoft Power BI
Power BI Data Model
DAX Measures
KPI Cards
Funnel Chart
Line Chart
Bar Chart
Table Visual
📌 Key Business Questions

The SQL analysis was designed around real recruitment questions.

1. How long does it take to hire someone?

The project calculates the average time between the candidate's application date and the hiring stage.

Application Date
       ↓
Candidate Recruitment Process
       ↓
Hired Date

This helps recruitment teams understand their average hiring cycle.

2. What percentage of candidates move forward at each stage?

The analysis calculates stage-level candidate progression.

For example:

Applied
  ↓
Screened
  ↓
Interviewed
  ↓
Offered
  ↓
Hired

This makes it possible to identify stages where candidate progression decreases significantly.

3. Which stage has the biggest drop-off?

Stage counts are compared to determine where the largest reduction occurs.

In the simulated dataset, the main recruitment progression shows a significant reduction between:

Interviewed → Offered

Interviewed = 598
Offered      = 308

Reduction = 290 candidates

This represents approximately 48.5% of interviewed candidates not progressing to the offer stage.

4. How does hiring performance differ between employers?

Employer-level metrics were calculated to compare:

Total Applications
Total Hires
Hiring Conversion Rate
Average Time to Hire

This helps identify employers with stronger or weaker recruitment performance.

📈 Power BI Dashboard

The final HireSync dashboard was developed in Microsoft Power BI.

The dashboard contains:

KPI Cards
Total Applications
Total Hires
Hiring Conversion Rate
Average Time to Hire
Recruitment Funnel

Shows candidate movement through the recruitment stages.

Hiring Trend Over Time

Shows how successful hires change across different dates.

Employer Hiring Performance

Compares the number of successful hires across employers.

Employer Performance Table

Provides a detailed employer-level comparison.

📊 Dashboard KPIs

Based on the simulated dataset:

KPI	Result
Total Applications	778
Total Hires	225
Hiring Conversion Rate	28.92%
Average Time to Hire	21.42 days
🏢 Employer Performance

The employer analysis provides several useful findings.

Highest Number of Hires

Vega-Wolfe

Applications: 84
Hires: 32
Conversion Rate: 38.10%
Average Time to Hire: 21.59 days
Highest Hiring Conversion Rate

Duran-Torres

Applications: 62
Hires: 24
Conversion Rate: 38.71%
Average Time to Hire: 21.58 days
Fastest Average Hiring Time

Martin, Hammond and Snyder

Applications: 56
Hires: 19
Conversion Rate: 33.93%
Average Time to Hire: 17.89 days

These comparisons demonstrate why looking only at total hires is not enough. An employer can have fewer applications but still have a strong conversion rate or faster hiring cycle.

🔎 Key Insights
1. Overall Hiring Performance

The simulated recruitment system contains:

778 applications → 225 hires

This produces an overall hiring conversion rate of:

28.92%

2. Recruitment Bottleneck

The largest reduction in the main recruitment progression occurs between:

Interviewed → Offered

Interviewed    598
       ↓
Offered        308

A total of 290 candidates are lost between these stages.

This indicates that the interview-to-offer stage deserves further investigation.

Possible business areas to investigate with real data could include:

Interview evaluation criteria
Candidate-job fit
Interview quality
Hiring manager decisions
Compensation expectations
Skill requirements

These are potential areas for investigation rather than conclusions from the simulated dataset.

3. Hiring Speed

The average time to hire is:

21.42 days

This provides a baseline for evaluating recruitment efficiency when real production data becomes available.

4. Employer Performance

Employer performance varies across:

Number of applications
Number of hires
Conversion rate
Average time to hire

For example, Vega-Wolfe records the highest number of hires, while Duran-Torres records the highest hiring conversion rate among the employers shown in the dashboard.

💼 Business Use Case

HireSync can help recruitment teams monitor the complete hiring pipeline from application to hire.

The dashboard can be used by:

Recruitment Teams

To identify recruitment bottlenecks and monitor candidate progression.

Hiring Managers

To understand hiring efficiency and compare performance.

HR Teams

To monitor hiring conversion and average hiring time.

Business Managers

To compare employer-level recruitment performance and identify areas for improvement.

🚀 Real-World Applications

The same analytical framework can be used in real recruitment environments for:

Recruitment funnel monitoring
Hiring performance tracking
Employer comparison
Recruiter performance analysis
Time-to-hire monitoring
Candidate drop-off analysis
Recruitment forecasting
Hiring process optimization

Once live recruitment data is available, the same SQL queries and Power BI dashboard can be connected to the production data pipeline.

🧮 Important DAX Measures

Some of the Power BI measures used in the dashboard include:

Total Applications
Total Applications =
DISTINCTCOUNT(
    'hiresync applications'[application_id]
)
Total Hires
Total Hires =
CALCULATE(
    DISTINCTCOUNT(
        'hiresync application_stage_history'[application_id]
    ),
    'hiresync application_stage_history'[stage] = "Hired"
)
Hiring Conversion Rate
Hiring Conversion Rate =
DIVIDE(
    [Total Hires],
    [Total Applications],
    0
)
Hires by Date
Hires by Date =
CALCULATE(
    DISTINCTCOUNT(
        'hiresync application_stage_history'[application_id]
    ),
    'hiresync application_stage_history'[stage] = "Hired"
)
📁 Project Files

The project data is organized into the following CSV files:

HireSync_Final_Data/
│
├── applications.csv
├── application_stage_history.csv
├── candidates.csv
├── employers.csv
├── jobs.csv
└── sample_data/

The database contains the corresponding MySQL tables used for analysis.

🔄 Data Generation

Because live recruitment data was not available for the project, simulated recruitment data was generated using Python Faker.

The generated data was designed to represent:

Candidates
Employers
Job postings
Applications
Recruitment stage history

This allowed the complete analytical workflow to be developed before real data becomes available.

📌 Project Outcome

The project successfully demonstrates a complete data analytics workflow:

Raw / Simulated Data
        ↓
Data Generation
        ↓
MySQL Database
        ↓
SQL Analysis
        ↓
Data Modeling
        ↓
DAX Measures
        ↓
Power BI Dashboard
        ↓
Business Insights

The project therefore demonstrates both technical data analysis skills and the ability to translate data into business-oriented insights.

🔮 Future Improvements

The current project can be extended further by:

Connecting the dashboard to a live recruitment database
Automating data refresh
Adding recruiter-level analysis
Adding job-category analysis
Adding location-based hiring analysis
Adding candidate source analysis
Adding monthly/weekly hiring KPIs
Adding recruitment cost metrics
Adding predictive candidate drop-off analysis
Adding Power BI drill-through pages
Adding real-time recruitment monitoring
🎓 What I Learned

Through this project, I gained practical experience in:

Designing a relational database
Working with MySQL
Creating and managing foreign-key relationships
Generating realistic simulated datasets
Writing business-oriented SQL queries
Performing recruitment funnel analysis
Creating DAX measures
Building Power BI data models
Creating interactive dashboards
Comparing employer performance
Converting analytical results into business insights

Most importantly, I learned how to move from raw data → analysis → visualization → business decision-making.

📝 Project Summary

HireSync demonstrates how data analytics can be applied to recruitment operations.

The simulated dataset contains 778 applications and 225 hires, resulting in a 28.92% hiring conversion rate, with an average hiring time of 21.42 days.

The analysis identifies the Interviewed → Offered stage as the largest reduction in the main recruitment progression. Employer-level analysis also highlights differences in hiring volume, conversion rates, and hiring speed.

The Power BI dashboard brings these insights together in a single view, allowing stakeholders to monitor recruitment performance and identify potential improvement areas.

HireSync turns recruitment data into actionable insights that can help organizations understand their hiring funnel, identify bottlenecks, and improve recruitment efficiency.

📷 Dashboard Preview

Add your final Power BI dashboard screenshot here:

![HireSync Recruitment Analytics Dashboard](images/hiresync-dashboard.png)

Recommended GitHub structure:

HireSync/
│
├── data/
│   ├── applications.csv
│   ├── application_stage_history.csv
│   ├── candidates.csv
│   ├── employers.csv
│   └── jobs.csv
│
├── sql/
│   ├── schema.sql
│   └── analysis_queries.sql
│
├── powerbi/
│   └── HireSync_Dashboard.pbix
│
├── images/
│   └── hiresync-dashboard.png
│
└── README.md
▶️ How to Run the Project
1. Clone the repository
git clone https://github.com/shivamkumar-0064/hiresync.git
cd hiresync

Replace hiresync with your actual GitHub repository name if you choose a different name.

2. Set up MySQL

Create the database:

CREATE DATABASE hiresync;
USE hiresync;

Create the required tables using the provided SQL schema.

3. Import the CSV data

Import:

employers.csv
jobs.csv
candidates.csv
applications.csv
application_stage_history.csv

into the corresponding MySQL tables.

4. Run SQL Analysis

Execute the SQL queries provided in:

sql/analysis_queries.sql
5. Open Power BI

Open:

HireSync_Dashboard.pbix

Connect/refresh the data and explore the dashboard.

📚 Skills Demonstrated
SQL
MySQL
Power BI
DAX
Data Modeling
Data Visualization
Funnel Analysis
Recruitment Analytics
KPI Development
Business Analysis
Data Cleaning
Data Generation
👨‍💻 Author

Shivam Kumar — Data Analyst

I am interested in using data to solve business problems and turn raw information into clear, actionable insights.

Skills: SQL | MySQL | Python | Power BI | Tableau | Excel | Pandas | Data Analysis

🔗 Connect With Me
💻 GitHub: Shivam Kumar
🔗 LinkedIn: Shivam Kumar
