# HireSync — Recruitment Analytics & Hiring Funnel Dashboard

🔗 **Repository:** [github.com/shivamkumar-0064/HireSync](https://github.com/shivamkumar-0064/HireSync)

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Project Objective](#-project-objective)
- [Project Workflow](#️-project-workflow)
- [Week 2 Update — Expanded Dataset](#-week-2-update--expanded-dataset)
- [Database Structure](#️-database-structure)
- [Recruitment Funnel](#-recruitment-funnel)
- [Technologies Used](#️-technologies-used)
- [Key Business Questions](#-key-business-questions)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Dashboard KPIs](#-dashboard-kpis)
- [Stage-to-Stage Timing](#-stage-to-stage-timing)
- [Employer Performance](#-employer-performance)
- [Job Role Performance](#-job-role-performance)
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
- Measuring average time to hire and stage-to-stage duration
- Identifying major recruitment drop-off points
- Comparing hiring performance between employers and job roles
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

The complete project was developed in five phases, then extended in Week 2 with a much larger dataset and a deeper stage-timing analysis:

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
       ↓
Week 2 — Expanded Dataset + Stage-Duration Analysis
```

---

## 🆕 Week 2 Update — Expanded Dataset

Week 2 focused on scaling the simulated dataset to something closer to a real hiring environment, and adding a proper *history* of every stage a candidate moved through — not just their latest status.

**Dataset growth:**

| Table | Records |
|---|---|
| Candidates | 2,000 |
| Job postings | 150 |
| Employers | 20 |
| Applications | 3,000 |
| Stage-history events | 11,320 |

Every application now has a full trail of stage-change events (`Applied → Screened → Interviewed → Offered → Hired`, or a `Dropped` exit at any point) with a timestamp per stage, instead of a single snapshot status.

**New SQL queries** (see [`sql/week2_analysis_queries.sql`](sql/week2_analysis_queries.sql)) were written to answer:

1. What's the overall recruitment funnel, stage by stage?
2. What's the average time-to-hire, from application to hire?
3. Where does the biggest drop-off happen, and by how much?
4. Which employers hire the most, and which convert most efficiently?
5. Which job roles generate the most hires?
6. Which stage-to-stage transition takes the longest on average?

**New visual:** an updated Power BI dashboard ([`powerbi/hiresyn.pbix`](powerbi/hiresyn.pbix), screenshot at [`images/hiresync_dashboard.png`](images/hiresync_dashboard.png)) with a funnel chart, top-employers-by-hires bar chart, hiring-by-job-role chart, and an application trend line over time.

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
| `application_stage_history` | Tracks candidate movement through recruitment stages, with a timestamp per stage |

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

(Candidates can also exit the funnel at any stage with a `Dropped` event.)

The stage history table records when an application moves through each stage. This makes it possible to analyze:

- Candidate progression
- Stage-level conversion and drop-off
- Time spent at each stage
- Hiring performance by employer and job role

---

## 🛠️ Technologies Used

| Category | Tools |
|---|---|
| **Database** | MySQL |
| **Data Generation** | Python, Faker |
| **Data Analysis** | SQL — Aggregate functions, `GROUP BY`, `HAVING`, `JOIN`, `CASE`, window functions (`LEAD`), date calculations, subqueries, CTEs |
| **Data Visualization** | Microsoft Power BI — Data model, DAX measures, KPI cards, funnel chart, bar chart, line chart |

---

## 📌 Key Business Questions

### 1. How long does it take to hire someone?

The project calculates the average time between a candidate's application date and the date they reach the "Hired" stage.

### 2. What percentage of candidates move forward at each stage?

Stage-level candidate progression is calculated across the full funnel:

```
Applied → Screened → Interviewed → Offered → Hired
```

### 3. Which stage has the biggest drop-off?

Out of 3,000 applications, the funnel narrows as follows:

| Stage | Applications | Drop from previous stage | Drop % |
|---|---|---|---|
| Applied | 3,000 | — | — |
| Screened | 2,571 | 429 | 14.30% |
| Interviewed | 1,776 | 795 | 30.92% |
| Offered | 973 | 803 | **45.21%** |
| Hired | 727 | 246 | 25.28% |

The **Interviewed → Offered** step is the biggest bottleneck — both in raw count (803 candidates lost) and in percentage terms (45.21% of interviewed candidates never receive an offer).

### 4. Which stage takes the longest to move a candidate forward?

Looking at the average number of days between consecutive stages:

| Transition | Avg. Days |
|---|---|
| Applied → Screened | 2.99 |
| Screened → Interviewed | 4.45 |
| **Interviewed → Offered** | **6.14** |
| Offered → Hired | 4.53 |

The Interviewed → Offered step is also the *slowest* transition — over double the Applied → Screened turnaround.

### 5. How does hiring performance differ between employers and job roles?

Employer- and job-level metrics were calculated to compare total applications, total hires, and conversion rate — see [Employer Performance](#-employer-performance) and [Job Role Performance](#-job-role-performance) below.

---

## 📈 Power BI Dashboard

The HireSync dashboard was built in Microsoft Power BI. It contains:

- **KPI Cards** — Total Applications, Total Hires, Hiring Conversion Rate, Average Time to Hire
- **Recruitment Funnel** — candidate movement through each recruitment stage
- **Top Employers by Hires** — bar chart comparing hiring volume across employers
- **Hiring by Job Role** — bar chart comparing hires across job titles
- **Applications by Recruitment Stage** — stage-level volume
- **Application Trend Over Time** — daily application volume across the dataset's date range

📁 Dashboard file: [`powerbi/hiresyn.pbix`](powerbi/hiresyn.pbix)
🖼️ Screenshot: [`images/hiresync_dashboard.png`](images/hiresync_dashboard.png)

---

## 📊 Dashboard KPIs

Based on the expanded Week 2 dataset:

| KPI | Result |
|---|---|
| Total Applications | 3,000 |
| Total Hires | 727 |
| Hiring Conversion Rate | 24.23% |
| Average Time to Hire | 18.64 days |

---

## ⏱️ Stage-to-Stage Timing

| From → To | Avg. Days |
|---|---|
| Applied → Screened | 2.99 |
| Screened → Interviewed | 4.45 |
| Interviewed → Offered | 6.14 |
| Offered → Hired | 4.53 |

The Interviewed → Offered decision window is the single longest step in the pipeline.

---

## 🏢 Employer Performance

**Highest number of hires**

| Employer | Applications | Hires |
|---|---|---|
| Cherry and Sons | 323 | 74 |
| Wilson-Rodriguez | 230 | 61 |
| Galloway LLC | 174 | 54 |
| Ellis PLC | 185 | 49 |

**Highest hiring conversion rate**

| Employer | Applications | Hires | Conversion Rate |
|---|---|---|---|
| Jones Ltd | 141 | 46 | 32.62% |
| Galloway LLC | 174 | 54 | 31.03% |
| Baxter Inc | 128 | 36 | 28.12% |

As with the earlier phase, volume and conversion rate don't move together — Cherry and Sons hires the most candidates overall, but Jones Ltd converts a higher share of the applicants it receives.

---

## 💼 Job Role Performance

| Job Title | Applications | Hires |
|---|---|---|
| Business Analyst | 376 | 113 |
| Backend Developer | 290 | 78 |
| Frontend Developer | 275 | 77 |
| Python Developer | 291 | 68 |
| Software Engineer | 248 | 53 |

Business Analyst roles generate both the most applications and the most hires of any job title in the dataset.

---

## 🔎 Key Insights

### 1. Overall Hiring Performance

The expanded dataset contains **3,000 applications → 727 hires**, an overall hiring conversion rate of **24.23%**, with an average time to hire of **18.64 days**.

### 2. Recruitment Bottleneck

The **Interviewed → Offered** stage is the clearest bottleneck in the funnel — it has both the largest raw drop-off (803 candidates) and the highest drop-off rate (45.21%), and it's also the slowest transition, averaging 6.14 days. Together, this suggests the interview-to-offer decision is where the recruitment process loses the most time and the most candidates.

Possible business areas to investigate with real data could include:

- Interview evaluation criteria and scoring consistency
- Hiring manager decision turnaround time
- Candidate-role fit at the interview stage
- Compensation or offer-approval bottlenecks

These are potential areas for investigation rather than conclusions from the simulated dataset.

### 3. Once an Offer Goes Out, Most Candidates Convert

Only 25.28% of offered candidates don't end up hired — meaningfully lower than the drop-off at earlier stages. This suggests that once a candidate reaches the offer stage, the process is comparatively efficient; the real friction is getting candidates *to* that offer.

### 4. Employer & Role Performance Vary Independently

Employer performance doesn't move in one direction: Cherry and Sons has the highest hiring volume, but Jones Ltd converts applicants most efficiently. The same pattern holds at the job-role level, where Business Analyst roles dominate both applications and hires — worth checking whether that's a hiring-need signal or simply a larger applicant pool.

---

## 💼 Business Use Case

HireSync can help recruitment teams monitor the complete hiring pipeline from application to hire. The dashboard can be used by:

- **Recruitment Teams** — to identify recruitment bottlenecks and monitor candidate progression
- **Hiring Managers** — to compare employer/job performance and make data-driven hiring decisions
- **HR Leadership** — to track hiring speed and conversion trends over time and plan staffing strategy accordingly

---

## 📝 Summary

HireSync is an end-to-end recruitment analytics project that takes simulated hiring data from raw application records to a polished, business-ready dashboard. It combines a relational database (MySQL), a structured SQL analysis layer, and a Power BI visualization layer to answer the core questions every recruitment team cares about — how fast are we hiring, where do candidates drop off, and which employers are performing best.

Following the Week 2 expansion, the dataset now spans **3,000 applications** across **2,000 candidates**, **150 job postings**, and **20 employers**, with a full stage-by-stage history of **11,320 events**. The pipeline converts **727 candidates** into hires — a **24.23%** overall conversion rate — with an average hiring cycle of **18.64 days**. The most significant funnel bottleneck is the **Interviewed → Offered** transition, both the biggest drop-off (45.21%) and the slowest step (6.14 days on average), flagging it as the primary area for further investigation. Employer- and role-level analysis further shows that hiring volume and conversion efficiency don't always move together, reinforcing the need for multi-metric comparison in any fair performance evaluation.

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
│   ├── hiresync_schema.sql            # Database schema + table creation
│   ├── analysis_queries.sql           # Phase 1 analytical queries
│   └── week2_analysis_queries.sql     # Week 2 expanded-dataset queries
│
├── powerbi/
│   └── hiresyn.pbix                   # Power BI dashboard file
│
└── images/
    └── hiresync_dashboard.png         # Dashboard screenshot
```

---

## 🚀 How to Use This Repository

1. **Explore the raw data** in the [`data/`](data/) folder (CSV files)
2. **Review the database schema and analysis queries** in [`sql/`](sql/), including the Week 2 queries
3. **Open the dashboard** in [`powerbi/hiresyn.pbix`](powerbi/hiresyn.pbix) using Power BI Desktop
4. **See the data generation logic** in the [Google Colab notebook](https://colab.research.google.com/drive/1bo0rVe5xUFa6w6_AXtN8KqiioMwZpIA1)

---

## 👤 Author

**Shivam Kumar**
GitHub: [@shivamkumar-0064](https://github.com/shivamkumar-0064)
Project: [HireSync](https://github.com/shivamkumar-0064/HireSync)
