# 📊 Bellabeat Case Study – Data Analysis & SQL Pipeline

This repository contains the complete analytical workflow developed for the **Bellabeat Wellness Technology Case Study**, the final capstone project of the **Google Data Analytics Professional Certificate**.  

It demonstrates how SQL, Power BI, and structured analytics methodology can turn raw Fitbit-style activity data into actionable business intelligence for product and marketing strategy.

---

## 🧠 Project Overview

**Objective:**  
Analyze smart-device usage patterns to discover trends in users’ activity, sleep, and habits — and translate those insights into strategic recommendations for **Bellabeat**, a health-tech company focused on women’s wellness.

**Business Questions**
1. What are the main trends in smart-device usage?  
2. How do these trends apply to Bellabeat customers?  
3. How can these insights inform Bellabeat’s marketing strategy?

---

## 🧩 Tech Stack

| Tool | Purpose |
|------|----------|
| **Microsoft SQL Server (T-SQL)** | Data cleaning, transformation, and analysis |
| **Power BI** | Interactive dashboard visualization |
| **Excel / CSV** | Raw dataset management |
| **GitHub** | Version control and documentation |

---

## 🗂️ Repository Structure

| File / Folder | Description |
|----------------|-------------|
| `00_setup_database.sql` | Creates and activates the `BellaBeat` database |
| `01–03_*` | Data profiling, validation, and duplicate checks |
| `10–12_*` | Base cleaning and deduplication views (Activity, Steps, Sleep) |
| `20_view_v_dim_date.sql` | Date dimension for time-based analysis |
| `30–33_*` | Analytical queries for trends, correlations, and segmentation |
| `40–42_*` | KPI calculations used in Power BI |
| `50–52_*` | Final views feeding BI models |
| `Bellabeat_Case_Study.docx` | 📄 Full written report (methodology + recommendations) |
| `bellabeat_dashboards_V1.pdf` | 📊 Power BI dashboard export |
| `README.md` | Project documentation |

---

## 📄 Full Case Study Report

Read the complete written report for detailed methodology, SQL documentation, and business insights:\

👉 [**📄 View the Full Report (PDF)**](./Bellabeat_Case_Study_V1.pdf)

It includes:
- End-to-end analysis (Ask → Prepare → Process → Analyze → Share → Act)  
- Data exploration and cleaning procedures  
- Executive summary with strategic recommendations  
- Screenshots of the Power BI dashboards  
- New product ideas (e.g., Smart Scale, Blue-Light Glasses, and MindEase app) derived from trend analysis

---

## 📈 Key Insights

| Metric | Finding |
|---------|----------|
| **Average Daily Steps** | ~7,600 steps |
| **Sedentary Time** | ~16 hours/day |
| **Sleep Efficiency** | ~92%, ~40 minutes awake in bed |
| **Low-Movement Days** | 22.9% of all activity days |
| **High-Movers (10k+ steps)** | 18% of users, mostly midweek |

These findings supported Bellabeat’s product and marketing strategy by identifying opportunities to encourage more consistent daily movement and sleep optimization among users.

---

## 🚀 Power BI Dashboard

Interactive visuals built from the SQL pipeline highlight:

- Steps vs. Calories correlation  
- Sleep duration vs. Activity intensity  
- Weekday vs. Weekend behavior  
- User movement segmentation  

📄 **Preview:**  
[View Bellabeat Dashboard](./bellabeat_dashboads_V1.pdf)

---

## 🔁 Reproducibility

1. Run `00_setup_database.sql`  
2. Execute all numbered scripts sequentially (01 → 52)  
3. Connect Power BI to the `v_fact_daily` and `v_dim_date` views  
4. Refresh the dataset — dashboards will update automatically  

---

## 🧾 Certificate Reference

This case study was completed as part of the  
**Google Data Analytics Professional Certificate (Coursera)**.  

All data cleaning, SQL modeling, and visualization steps were designed and implemented by **Silvio Serafin**.

---

## 👨‍💻 Author

**Silvio Serafin**  
📍 Widnes / Liverpool, United Kingdom  
🎓 BSc Computing Science | Solent University  
💼 Junior Data Analyst & BI Enthusiast | Quality & Process Improvement Background  
📧 [LinkedIn](https://www.linkedin.com/in/silvioserafin)  

---

### ⭐ If you found this project useful or insightful, give it a star on GitHub!

