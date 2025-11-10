# 💚 Bellabeat SQL Case Study
**Author:** Silvio Serafin Filho  
**Certificate:** [Google Data Analytics Professional Certificate](https://coursera.org/verify/professional-cert/6O0W4OOF3QBD)  
**Tools:** SQL Server, Power BI, Excel  

---

## 📘 Project Overview
This project analyzes **Fitbit user data** to uncover behavioral patterns and guide **Bellabeat’s product strategy** , a wellness technology company that builds smart devices for women.

Using **SQL Server** for cleaning, transformation, and analysis, and **Power BI** for visualization, this study identifies insights about activity, sleep, and sedentary behavior.  
The outcomes informed two innovative product ideas aligned with Bellabeat’s mission of holistic well-being.

---

## 🎯 Objectives
- Analyze daily **activity**, **sleep**, and **sedentary behavior** patterns.  
- Identify **movement segments** (low, moderate, high movers).  
- Explore **weekday vs weekend** trends and **sleep efficiency**.  
- Build a **Power BI dashboard** showing key patterns and KPIs.  
- Propose **data-driven product ideas** for wellness improvement.

---

## ⚙️ Data & Tools
| Category | Description |
|-----------|-------------|
| **Dataset** | Fitbit Fitness Tracker Data (Mobius, Kaggle, 2016, CC0 License) |
| **Database** | Microsoft SQL Server |
| **Visualization** | Power BI |
| **Other Tools** | Excel (validation & cleaning), GitHub (documentation) |

---

## 🧠 Analysis Process
1. **Data Import & Profiling**  
   - Checked row counts, user coverage, and duplicates.  
   - Verified date ranges for alignment across datasets.

2. **Cleaning & Transformation**  
   - Created SQL views (`v_daily_activity`, `v_sleep`, `v_dim_date`) for consistent structure.  
   - Removed duplicates using `ROW_NUMBER()` window function.  
   - Converted text dates to `DATE` type.

3. **Exploratory Analysis**  
   - Grouped by weekday to find activity consistency.  
   - Compared total steps, sedentary minutes, and sleep time.  
   - Calculated low-movement rate (<5k steps + >900 sedentary minutes).  

4. **KPI Queries**  
   - Weekday vs weekend average steps → 7,608 vs 7,550  
   - Sleep efficiency → ~40 minutes awake in bed  
   - Low-movement day rate → 22.9% of total days  

5. **Visualization in Power BI**  
   - Built four main visuals:  
     - Average Steps by Weekday  
     - Sleep vs Time in Bed  
     - Sedentary vs Active Minutes  
     - Movement Segments Distribution  

---

## 📊 Dashboard Preview
![Bellabeat Dashboard Overview](./powerbi/bellabeat_dashboard.png)

**Figure:** Power BI dashboard visualizing user activity, sleep efficiency, and movement segments.

---

## 🔍 Key Insights
- **Consistent daily activity:** 7,608 steps on weekdays vs 7,550 on weekends — a negligible difference.  
- **Sedentary time:** Constantly high (~980–1,000 minutes daily).  
- **Sleep efficiency:** Users spend ~40 minutes awake in bed nightly.  
- **Behavioral insight:** Bellabeat’s female audience maintains steady activity across the week due to overlapping roles (work, caregiving, domestic), known as the *“triple workload journey.”*

---

## 💡 Strategic Recommendations
### 1️⃣ Bellabeat Smart Scale
A connected smart scale tracking body composition and hydration. Syncs with the Bellabeat app and the Spring smart bottle to provide adaptive hydration reminders and hormone-aware recommendations.

### 2️⃣ Bellabeat BlueShield Glasses
App-connected eyewear reducing blue-light exposure and improving sleep hygiene. Integrated with the Bellabeat app to track nighttime screen use and trigger relaxation reminders.

### 3️⃣ Ecosystem Integration
A connected wellness platform where all Bellabeat devices (Leaf, Time, Spring, Smart Scale, BlueShield) share data for real-time wellness insights.

---

## 🧾 Technical Appendix (SQL Summary)
- **Views Created:** `v_daily_activity`, `v_sleep`, `v_dim_date`, `v_fact_daily`, `v_user_segments`  
- **Techniques:**  
  - Data deduplication via `ROW_NUMBER()`  
  - Aggregation with `AVG()` and `CASE WHEN`  
  - KPI calculations (sleep efficiency, low-movement %, daily trends)  
- **All queries:** [View SQL Files](./sql)

---

## 🧩 Deliverables
| File | Description |
|------|-------------|
| `Bellabeat_SQL_Case_Study_Silvio_Serafin.pdf` | Full written report (includes business context & recommendations) |
| `bellabeat_dashboard.pbix` | Power BI dashboard file |
| `sql/*.sql` | All SQL cleaning and analysis queries |
| `certificate_google_data_analytics.png` | Proof of certification |

---

## 🧾 Data Source
Fitbit Fitness Tracker Data (CC0 Public Domain)  
By Mobius – [Kaggle Dataset](https://www.kaggle.com/datasets/arashnic/fitbit)

---

## ✍️ Author Note
This project was completed as part of the **Google Data Analytics Professional Certificate** and expanded with advanced SQL and Power BI modeling.  
It reflects end-to-end data analysis — from raw data to actionable business recommendations.

---

⭐ *“Data becomes powerful when it transforms behavior into insight and insight into action.”*  

