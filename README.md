# HireSync — Recruitment Analytics & Hiring Funnel Dashboard

🔗 **Repository:** [github.com/shivamkumar-0064/HireSync](https://github.com/shivamkumar-0064/HireSync)

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Project Objective](#-project-objective)
- [Project Workflow](#️-project-workflow)
- [Database Structure](#️-database-structure)
- [Recruitment Funnel](#-recruitment-funnel)
- [Technologies Used](#️-technologies-used)
- [Key Business Questions](#-key-business-questions)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Dashboard KPIs](#-dashboard-kpis)
- [Employer Performance](#-employer-performance)
- [Key Insights](#-key-insights)
- [Business Use Case](#-business-use-case)
- [Summary](#-summary)
- [Project Structure](#-project-structure)
- [How to Use This Repository](#-how-to-use-this-repository)
- [Author](#-author)

---

## 📖 Project Overview

HireSync is a recruitment analytics project designed to analyze the hiring pipeline from application to successful hire.

The project simulates a real-world recruitment data environment where multiple employers post jobs and candidates move through different recruitment stages such as:

```
Applied → Screened → Interviewed → Offered → Hired
```

The main purpose of this project is to understand how efficiently candidates move through the recruitment funnel, identify drop-off points, measure time to hire, and compare hiring performance across employers.

The project uses **MySQL** for data storage and SQL analysis, and **Microsoft Power BI** for data visualization and dashboard development.

The simulated dataset was generated to represent a realistic recruitment environment and can later be replaced with live recruitment data.

---

## 🎯 Project Objective

The main objective of HireSync is to turn recruitment data into actionable business insights.

The analysis focuses on:

- Understanding the candidate recruitment funnel
- Measuring the number of applications and successful hires
- Calculating overall hiring conversion
- Measuring average time to hire
- Identifying major recruitment drop-off points
- Comparing hiring performance between employers
- Tracking hiring trends over time
- Creating a business-ready Power BI dashboard
- Preparing SQL queries that can later work with live recruitment data

In short, the goal is to help recruitment teams answer:

> **Where are candidates dropping out, how efficiently are employers hiring, and where can the recruitment process be improved?**

---

## 🏗️ Project Workflow

### Data Generation

The dataset used in this project is synthetic, generated using the Python `Faker` library to simulate realistic recruitment data across employers, jobs, candidates, applications, and application stage history. No real personal or company data is used anywhere in this project.

📓 **Notebook:** [HireSync Data Generation – Google Colab](https://colab.research.google.com/drive/1bo0rVe5xUFa6w6_AXtN8KqiioMwZpIA1)

### Development Phases

The complete project was developed in five phases:

```
Phase 1 — Database Schema
       ↓
Phase 2 — Simulated Recruitment Data
       ↓
Phase 3 — SQL Business Analysis
       ↓
Phase 4 — Power BI Dashboard
       ↓
Phase 5 — Business Summary & Insights
```

---

## 🗂️ Database Structure

The HireSync database contains five main tables:

```
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
                    │  Application Stage   │
                    │       History        │
                    └──────────────────────┘
```

### Main Tables

| Table | Purpose |
|---|---|
| `employers` | Stores employer/company information |
| `jobs` | Stores job postings |
| `candidates` | Stores candidate information |
| `applications` | Records candidate applications |
| `application_stage_history` | Tracks candidate movement through recruitment stages |

---

## 📊 Recruitment Funnel

The recruitment process is analyzed through the following stages:

```
Applied
   ↓
Screened
   ↓
Interviewed
   ↓
Offered
   ↓
Hired
```

The stage history table records when an application moves through each stage. This makes it possible to analyze:

- Candidate progression
- Stage-level conversion
- Drop-offs
- Hiring performance
- Time between recruitment stages

---

## 🛠️ Technologies Used

| Category | Tools |
|---|---|
| **Database** | MySQL |
| **Data Generation** | Python, Faker |
| **Data Analysis** | SQL — Aggregate functions, `GROUP BY`, `HAVING`, `JOIN`, `CASE`, date calculations, subqueries |
| **Data Visualization** | Microsoft Power BI — Data model, DAX measures, KPI cards, funnel chart, line chart, bar chart, table visual |

---

## 📌 Key Business Questions

The SQL analysis was designed around real recruitment questions.

### 1. How long does it take to hire someone?

The project calculates the average time between the candidate's application date and the hiring stage.

```
Application Date
       ↓
Candidate Recruitment Process
       ↓
Hired Date
```

This helps recruitment teams understand their average hiring cycle.

### 2. What percentage of candidates move forward at each stage?

The analysis calculates stage-level candidate progression:

```
Applied → Screened → Interviewed → Offered → Hired
```

This makes it possible to identify stages where candidate progression decreases significantly.

### 3. Which stage has the biggest drop-off?

Stage counts are compared to determine where the largest reduction occurs. In the simulated dataset, the main recruitment progression shows a significant reduction between **Interviewed → Offered**:

| Stage | Count |
|---|---|
| Interviewed | 598 |
| Offered | 308 |
| **Reduction** | **290 candidates** |

This represents approximately **48.5%** of interviewed candidates not progressing to the offer stage.

### 4. How does hiring performance differ between employers?

Employer-level metrics were calculated to compare:

- Total Applications
- Total Hires
- Hiring Conversion Rate
- Average Time to Hire

This helps identify employers with stronger or weaker recruitment performance.

---

## 📈 Power BI Dashboard

The final HireSync dashboard was developed in Microsoft Power BI. The dashboard contains:

- **KPI Cards** — Total Applications, Total Hires, Hiring Conversion Rate, Average Time to Hire
- **Recruitment Funnel** — shows candidate movement through the recruitment stages
- **Hiring Trend Over Time** — shows how successful hires change across different dates
- **Employer Hiring Performance** — compares the number of successful hires across employers
- **Employer Performance Table** — provides a detailed employer-level comparison

📁 Dashboard file: [`powerbi/HireSync_Dashboard.pbix`](powerbi/HireSync_Dashboard.pbix)

---

## 📊 Dashboard KPIs

Based on the simulated dataset:

| KPI | Result |
|---|---|
| Total Applications | 778 |
| Total Hires | 225 |
| Hiring Conversion Rate | 28.92% |
| Average Time to Hire | 21.42 days |

---

## 🏢 Employer Performance

The employer analysis provides several useful findings.

**Highest Number of Hires — Vega-Wolfe**
- Applications: 84
- Hires: 32
- Conversion Rate: 38.10%
- Average Time to Hire: 21.59 days

**Highest Hiring Conversion Rate — Duran-Torres**
- Applications: 62
- Hires: 24
- Conversion Rate: 38.71%
- Average Time to Hire: 21.58 days

**Fastest Average Hiring Time — Martin, Hammond and Snyder**
- Applications: 56
- Hires: 19
- Conversion Rate: 33.93%
- Average Time to Hire: 17.89 days

These comparisons demonstrate why looking only at total hires is not enough. An employer can have fewer applications but still have a strong conversion rate or faster hiring cycle.

---

## 🔎 Key Insights

### 1. Overall Hiring Performance

The simulated recruitment system contains **778 applications → 225 hires**, producing an overall hiring conversion rate of **28.92%**.

### 2. Recruitment Bottleneck

The largest reduction in the main recruitment progression occurs between **Interviewed → Offered**:

```
Interviewed   598
      ↓
Offered       308
```

A total of **290 candidates** are lost between these stages. This indicates that the interview-to-offer stage deserves further investigation.

Possible business areas to investigate with real data could include:

- Interview evaluation criteria
- Candidate-job fit
- Interview quality
- Hiring manager decisions
- Compensation expectations
- Skill requirements

These are potential areas for investigation rather than conclusions from the simulated dataset.

### 3. Hiring Speed

The average time to hire is **21.42 days**, providing a baseline for evaluating recruitment efficiency when real production data becomes available.

### 4. Employer Performance

Employer performance varies across number of applications, number of hires, conversion rate, and average time to hire. For example, **Vega-Wolfe** records the highest number of hires, while **Duran-Torres** records the highest hiring conversion rate among the employers shown in the dashboard.

---

## 💼 Business Use Case

HireSync can help recruitment teams monitor the complete hiring pipeline from application to hire. The dashboard can be used by:

- **Recruitment Teams** — to identify recruitment bottlenecks and monitor candidate progression
- **Hiring Managers** — to compare employer/job performance and make data-driven hiring decisions
- **HR Leadership** — to track hiring speed and conversion trends over time and plan staffing strategy accordingly

---

## 📝 Summary

HireSync is an end-to-end recruitment analytics project that takes simulated hiring data from raw application records to a polished, business-ready dashboard. It combines a relational database (MySQL), a structured SQL analysis layer, and a Power BI visualization layer to answer the core questions every recruitment team cares about — how fast are we hiring, where do candidates drop off, and which employers are performing best.

Across **778 applications**, the pipeline converts **225 candidates** into hires — a **28.92%** overall conversion rate — with an average hiring cycle of **21.42 days**. The most significant funnel drop-off happens between the **Interviewed** and **Offered** stages, where roughly **48.5%** of interviewed candidates do not progress, flagging the interview-to-offer transition as the primary area for further investigation. Employer-level analysis further shows that hiring volume, conversion rate, and hiring speed don't always move together — making multi-metric comparison essential for fair performance evaluation.

While built on synthetic data, the project's schema, SQL logic, and dashboard structure are designed to be directly reusable with real recruitment data, making HireSync a practical template for recruitment analytics in production environments.

---

## 📁 Project Structure

```
HireSync
│
├── README.md
│
├── data/
│   ├── applications.csv               # Application-level records
│   ├── application_stage_history.csv  # Stage-by-stage funnel movement
│   ├── candidates.csv                 # Candidate profiles
│   ├── employers.csv                  # Employer/company details
│   └── jobs.csv                       # Job postings
│
├── sql/
│   ├── hiresync_database.sql          # Database schema + table creation
│   └── analysis_queries.sql           # Analytical queries used for insights
│
├── powerbi/
│   └── HireSync_Dashboard.pbix        # Power BI dashboard file
│
└── images/
    └── hiresync_dashboard.png         # Dashboard screenshot
```

---

## 🚀 How to Use This Repository

1. **Explore the raw data** in the [`data/`](data/) folder (CSV files)
2. **Review the database schema and analysis queries** in [`sql/`](sql/)
3. **Open the dashboard** in [`powerbi/HireSync_Dashboard.pbix`](powerbi/HireSync_Dashboard.pbix) using Power BI Desktop
4. **See the data generation logic** in the [Google Colab notebook](https://colab.research.google.com/drive/1bo0rVe5xUFa6w6_AXtN8KqiioMwZpIA1)

---

## 👤 Author

**Shivam Kumar**
GitHub: [@shivamkumar-0064](https://github.com/shivamkumar-0064)
Project: [HireSync](https://github.com/shivamkumar-0064/HireSync)
