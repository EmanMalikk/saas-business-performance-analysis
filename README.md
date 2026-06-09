# SaaS Business Performance Analysis

## Project Overview
A comprehensive data analysis project investigating the revenue health and churn crisis of a fictional B2B SaaS company offering project management tools. The company offers three subscription tiers (Free, Pro, Business) and has been experiencing plateauing revenue despite growing signups.

This project answers 4 core business questions:
- Is our revenue healthy and growing?
- Where exactly is churn happening and why?
- Which customer cohorts are most valuable?
- Which pricing plan drives the most revenue?

---

## Business Scenario
A SaaS Project Management startup has been operating for 3 years (2022–2024). Despite consistent new signups, monthly revenue growth has slowed from 64% in early 2022 to less than 1% by end of 2024. Leadership suspects a churn problem but has no visibility into where or why customers are leaving.

**This analysis diagnoses the problem and surfaces actionable insights.**

---

## Key Findings
- MRR grew from $9,110 in Jan 2022 to a peak of $172,156 in Oct 2024 before declining
- MRR growth rate dropped from 64% to under 1% — revenue is plateauing
- Over 80% of early cohorts eventually churned
- Free plan has the highest churn (42%) but Business plan customers stay 8.6 months on average
- Business plan generates 74% of total revenue with only 27% of customers
- Top churn reason is competitor switching (25.7%) followed by "no longer needed" (15.4%)
- Expansion MRR from upgrades is growing but not enough to offset churned MRR

---

## Tools & Technologies
| Tool | Purpose |
|------|---------|
| Python (Pandas, Faker) | Data generation and cleaning |
| Excel | Initial data profiling and EDA |
| MySQL | Data storage and SQL analysis |
| Power BI | Interactive dashboard and KPI reporting |
| VS Code + Jupyter | Development environment |
| GitHub | Version control and portfolio |

---

## Dataset
Synthetic dataset generated using Python's Faker library simulating a realistic SaaS business with 3 years of data.

| Table | Rows | Description |
|-------|------|-------------|
| customers | 5,000 | Customer profiles, plans, signup dates |
| subscriptions | 4,271 | Subscription history and status |
| transactions | 43,171 | Monthly payment records |
| events | 4,846 | Churn, upgrade and downgrade events |

---

## Project Structure

├── data/
│   ├── cleaned/          # Cleaned CSV files
│   └── EDA/              # Raw data files
├── powerbi_data/         # Exported SQL query results for Power BI
├── sql/
│   ├── 01_mrr_analysis.sql
│   ├── 02_churn_analysis.sql
│   ├── 03_cohort_analysis.sql
│   └── 04_plan_analysis.sql
├── 01_data_generation.ipynb
├── 02_data_cleaning.ipynb
├── dashboards.pbix
└── README.md

---

## Data Pipeline
Python (Data Generation)
→ Excel (Profiling & EDA)
→ Python (Deep Cleaning)
→ MySQL (Storage & Analysis)
→ Power BI (Dashboard)

---

## SQL Analysis
Four structured SQL files covering:
- **MRR Analysis** — Monthly revenue trends, growth rates, revenue by plan
- **Churn Analysis** — Monthly churn, churn by plan, churn reasons, customer lifetime
- **Cohort Analysis** — Cohort size, churn rates, upgrade rates by signup month
- **Plan Analysis** — Revenue contribution, upgrade/downgrade flows, plan performance

---

## Dashboard Pages
1. **MRR Overview** — Revenue trend, MRR by plan, growth rate, KPI cards
2. **Churn Analysis** — Monthly churn trend, churn by plan, churn reasons breakdown
3. **Cohort Analysis** — Cohort churn rates, cohort size comparison
4. **Plan Performance** — Revenue distribution, customer lifetime, upgrade flow

---

## Author
**Eman Malik**  
