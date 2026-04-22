# Highways & Engineering KPI Dashboard
**Tool:** Microsoft Excel | **Type:** Operational Analytics | **Domain:** Local Government / Public Sector

---

## Overview

This project simulates a real-world KPI reporting dashboard for a Highways and Engineering Division, modelled on the type of performance monitoring used by UK local authorities.

The dashboard tracks six key performance indicators across 12 months, providing operational managers with a clear, accurate view of service delivery against targets. 
All data flows dynamically updating the Raw Data sheet automatically recalculates every figure, chart, and RAG status across the workbook.

---

## Dashboard Preview

![KPI Dashboard](images/KPI%20Dashboard%20tab.png)

![Trend Analysis](images/Trend%20Analysis%20tab.png)

---

## KPIs Tracked

| KPI | Description | Target |
|-----|-------------|--------|
| Pothole Repairs Completed | Monthly repairs completed vs target | 150 per month |
| Average Response Time | Days from report to repair | ≤ 5 days |
| Planned vs Reactive Maintenance | Ratio of planned to reactive jobs | ≥ 0.35 : 1 |
| Inspection Completion Rate | Monthly inspections vs target | 30 per month |
| Complaints Resolved within SLA | % of complaints resolved on time | ≥ 90% |

---

## Workbook Structure

| Sheet | Purpose |
|-------|---------|
| **Raw Data** | Monthly data entry — all input figures entered here |
| **KPI Dashboard** | Summary cards with RAG status + full monthly breakdown table |
| **Trend Analysis** | Three charts visualising performance trends across the year |

---

## Key Findings

### Seasonal Performance Pattern
Repair completions peak in spring and early summer (May: 173, June: 168) and decline significantly in winter months (December: 128). This reflects increased road damage from frost cycles combined with reduced operational capacity in cold weather.

### Response Time Deterioration in Q4
Average response time worsens progressively from September onwards, reaching 5.4 days in December — breaching the 5-day target. This suggests a resource capacity issue in Q4 rather than a demand problem.

### Reactive vs Planned Maintenance Imbalance
Reactive maintenance jobs consistently run at 2.5–3x the volume of planned maintenance. The division is operating largely reactively, which is less efficient and more costly long term.

### Inspection and SLA Performance
Inspection completions fall below the 30-job monthly target in August, November, and December. Complaints resolved within SLA drops to 79% in December — directly linked to slower response times.

---

## Recommendations

1. **Increase planned maintenance in Q3** to reduce reactive workload in Q4 when capacity is lower.
2. **Pre-emptive resource planning for winter** — November and December consistently underperform across all KPIs.
3. **Set an early warning threshold** at 4.5 days response time to flag SLA breach risk before it occurs.

---

## Skills Demonstrated

- Excel formula construction (AVERAGE, SUM, IF, cross-sheet references)
- KPI dashboard design and RAG status logic
- Chart creation and trend visualisation
- Operational analytics and performance reporting
- Written analysis with findings and actionable recommendations

---

*This is a portfolio project. Data is simulated for demonstration purposes.*
