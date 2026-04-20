# Bellabeat Case Study – SQL Analytics Pipeline

End-to-end SQL Server analysis of smart-device wellness data, built as the capstone project for the Google Data Analytics Professional Certificate.

The project demonstrates a full analytical pipeline: raw CSV ingestion, data profiling and cleaning, dimensional modelling, window function analysis, KPI development, and Power BI visualisation — all applied to a real-world business brief.

---

## Business Brief

**Client:** Bellabeat — a health-tech company focused on women's wellness  
**Product focus:** The Time smartwatch  
**Objective:** Identify behavioural patterns in smart-device usage data and translate them into product and marketing recommendations

**Business questions:**
1. What are the main trends in smart-device usage?
2. How do these trends apply to Bellabeat's target customers?
3. How can these insights inform Bellabeat's marketing and product strategy?

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Microsoft SQL Server (T-SQL) | Data profiling, cleaning, transformation, analysis |
| Power BI | Interactive dashboard and KPI visualisation |
| Excel / CSV | Source data management |
| GitHub | Version control and portfolio documentation |

---

## Dataset

**Source:** FitBit Fitness Tracker Data (CC0: Public Domain) via Kaggle / Mobius  
**Coverage:** 33 users, approximately 33 days (April–May 2016)  
**Key tables used:** `dailyActivity_merged2`, `dailySteps_merged2`, `sleepDay_merged2`, `dailyIntensities_merged2`, `hourlySteps_merged2`, `weightLogInfo_merged2`

**Limitations:**
- 33 users is a small sample and may not represent Bellabeat's full audience
- Only 24 of 33 users logged sleep data
- Only 8 of 33 users logged weight data — weight analysis is exploratory only
- Single data collection period limits seasonality conclusions

---

## Repository Structure

Scripts are numbered sequentially (01–28) in pipeline execution order. Each file is self-contained with a header describing its purpose, business question, key findings, and upstream dependencies.

### Setup and Profiling

| File | Description |
|------|-------------|
| `01_setup_database.sql` | Creates and activates the BellaBeat database |
| `02_profiling_counts.sql` | Row counts and distinct user validation per table |
| `03_validate_date_ranges.sql` | Date range consistency checks across tables |
| `04_duplicate_checks.sql` | Identifies duplicate (Id, Date) pairs before cleaning |

### Base Cleaning Views

| File | Description |
|------|-------------|
| `05_view_v_daily_activity.sql` | Deduplicates and casts dates for the daily activity table |
| `06_view_v_daily_steps.sql` | Deduplicates and casts dates for the daily steps table |
| `07_view_v_sleep.sql` | Deduplicates 3 confirmed duplicates and casts datetime to date for sleep table |
| `08_view_v_dim_date.sql` | Recursive CTE date dimension — weekday name, number, and month |

### Analytical Queries

| File | Description |
|------|-------------|
| `09_analysis_daily_trends.sql` | Average steps and calories by date across the study period |
| `10_analysis_weekday_patterns.sql` | Steps, sedentary minutes, and calories aggregated by day of week |
| `11_analysis_user_segments.sql` | User movement segmentation — low, moderate, and high movers |
| `12_analysis_sleep_vs_activity.sql` | Population-level sleep duration, efficiency, and activity summary |

### KPI Queries

| File | Description |
|------|-------------|
| `13_kpi_weekday_vs_weekend.sql` | Average steps comparison — weekday vs weekend |
| `14_kpi_sleep_efficiency.sql` | Average sleep efficiency and minutes awake in bed |
| `15_kpi_low_movement_rate.sql` | Percentage of days meeting the low-movement threshold |

### BI Output Views

| File | Description |
|------|-------------|
| `16_view_v_fact_daily.sql` | Consolidated daily fact view — primary Power BI data source |
| `17_view_v_daily_user_summary.sql` | Per-user daily summary joining activity and sleep |
| `18_view_v_user_segments.sql` | User movement segment classification view |

### Window Function Analysis

| File | Function | Business Question |
|------|----------|-------------------|
| `19_window_rank_users_by_avg_steps.sql` | `DENSE_RANK` | Which users rank highest for average daily steps? |
| `20_window_rank_users_by_sleep_quality.sql` | `RANK` | Who sleeps most efficiently across the study period? |
| `21_window_running_total_steps.sql` | `SUM OVER` | How do users accumulate steps over the study period? |
| `22_window_7day_rolling_avg_steps.sql` | `AVG OVER` | What does each user's 7-day rolling activity trend look like? |
| `23_window_lag_daily_step_change.sql` | `LAG` | How much does step count change day to day per user? |
| `24_window_lag_sleep_vs_next_day_activity.sql` | `LAG` | Does poor sleep predict lower activity the following day? |
| `25_window_consecutive_low_activity_days.sql` | `ROW_NUMBER` islands | Which users had the longest consecutive low-activity streaks? |
| `26_window_peak_activity_hour.sql` | `RANK` | At what hour of the day are users most active? |
| `27_window_activity_intensity_breakdown.sql` | `SUM OVER` | What percentage of active time is spent at each intensity level? |
| `28_window_weight_change_vs_activity.sql` | `LAG` | Is there a relationship between activity output and weight change? |

---

## Key Findings

| Metric | Finding |
|--------|---------|
| Average daily steps | ~7,600 — below the NHS-recommended 10,000 |
| Sedentary time | ~16 hours/day consistently across weekdays and weekends |
| Sleep efficiency | ~92% average, with ~40 minutes spent awake in bed per night |
| Low-movement days | 22.9% of all activity days fall below the low-movement threshold |
| High movers (10k+ steps) | 18% of users |
| Weekday vs weekend steps | 7,608 vs 7,550 — a negligible 0.7% difference |

The near-identical weekday and weekend activity levels suggest Bellabeat users maintain continuous activity driven by caregiving, domestic, and professional responsibilities rather than structured exercise. This "triple workload" pattern — consistent activity without adequate recovery — is the central behavioural finding of this study.

---

## Product Recommendations

Three innovation opportunities were identified from the data:

**Bellabeat Smart Scale** — Body composition tracking synced with the app. Provides context beyond body weight, with cycle-aware hydration and nutrition recommendations.

**Bellabeat BlueShield Glasses** — Blue-light blocking eyewear integrated with the app. Targets the ~40 minutes of wasted bed time identified in the sleep data by reducing pre-sleep alertness.

**Connected Wellness Platform** — Ecosystem integration across all Bellabeat devices, enabling adaptive cross-device insights.

---

## Reproducibility

1. Run `01_setup_database.sql` to create the database
2. Import CSV source files into the `BellaBeat` schema
3. Execute scripts sequentially from `02` through to `18`
4. Run window function scripts `19` through `28`
5. Connect Power BI to `v_fact_daily`, `v_dim_date`, and `v_user_segments`
6. Refresh the dataset — dashboards update automatically

---

## Author

**Silvio Serafin**  
📍 Widnes, United Kingdom  
🎓 BSc (Hons) Computing Science | Google Data Analytics Certificate  
💼 12+ years in manufacturing and quality engineering — transitioning into data analytics and BI  
🔗 [LinkedIn](https://www.linkedin.com/in/silvioserafin) | [Portfolio](https://github.com/SilvioSerafin/silvio-data-portfolio)

---

*Certificate reference: Google Data Analytics Professional Certificate (Coursera). All SQL, modelling, and visualisation work designed and implemented by Silvio Serafin.*
