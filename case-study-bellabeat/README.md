# Bellabeat Wellness - Smart Device Behaviour Analysis

**Tools:** SQL (T-SQL) · Power BI · Excel  
**Role:** Data Analyst - Google Data Analytics Certificate Capstone

---

## Overview

Bellabeat is a health-tech company that manufactures wellness products for women. This case study analyses smart device usage data from 33 Fitbit users to uncover behavioural patterns in activity, sleep, and sedentary habits.

The core problem: Bellabeat needed data-driven evidence to guide product development and marketing strategy for its Time smartwatch - specifically, understanding how women actually move, sleep, and recover across the week.

This case study demonstrates how a structured SQL pipeline, from raw CSV profiling through to BI-ready views and window function analysis, can turn noisy fitness tracker data into actionable product and marketing intelligence.

---

## What Was Built

### SQL Pipeline
A 28-script T-SQL pipeline covering the full analytical workflow - data profiling, deduplication, date dimension, trend analysis, KPI queries, BI output views, and window function analysis.

The dataset covers 33 users across approximately 33 days (April–May 2016), with confirmed duplicates, inconsistent date formats, and a 9-user sleep data gap - all handled in the cleaning layer.

- [View SQL folder](./sql)

### Power BI Dashboard
Four visuals built from the SQL output views:
- Daily step patterns by weekday
- Sleep duration vs time in bed
- Sedentary minutes vs active time
- User movement segment distribution

- [Dashboard Export (PDF)](./bellabeat_dashboards_V1.pdf)

### Full Case Study Report
End-to-end written report covering methodology, findings, and product recommendations including two new product concepts derived from the data.

- [Read the Full Report (PDF)](./Bellabeat_Case_Study_V1.pdf)

---

## Key Findings

- Average daily steps ~7,600 - below the NHS-recommended 10,000
- Weekday vs weekend steps differ by only 0.7% - users are equally active every day of the week, driven by caregiving and domestic responsibilities rather than structured exercise
- ~40 minutes wasted in bed per night - sleep onset is consistently poor across the user base
- 22.9% of all activity days meet the low-movement threshold (under 5,000 steps and over 15 hours sedentary)
- Users sleeping under 6 hours still average higher daily steps than longer sleepers - persistent activity despite fatigue

---

## Product Recommendations

Three opportunities identified directly from the data:

**Bellabeat Smart Scale** - Body composition and hydration tracking synced with the app, providing cycle-aware insights beyond body weight.

**Bellabeat BlueShield Glasses** - Blue-light blocking eyewear targeting the ~40 minutes of wasted pre-sleep bed time identified in the data.

**Connected Wellness Platform** - Full ecosystem integration across all Bellabeat devices enabling cross-device adaptive insights.

---

## Skills Demonstrated

- **SQL:** data profiling, deduplication with ROW_NUMBER, recursive CTE date dimension, CTEs, multi-table JOINs, window functions (RANK, DENSE_RANK, SUM OVER, AVG OVER, LAG, islands technique)
- **Power BI:** dashboard design, KPI reporting, SQL view integration
- **Business analysis:** behavioural segmentation, KPI definition, product strategy, data-driven recommendations
- **Data quality:** duplicate detection and resolution, date casting, NULL handling, division-by-zero guards

---

*Dataset: FitBit Fitness Tracker Data (CC0: Public Domain) via Kaggle / Mobius - 33 users, April–May 2016.*  
*All SQL, modelling, and visualisation work designed and implemented by Silvio Serafin.*
