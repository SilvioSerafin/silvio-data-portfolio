# FabriCo Solutions — Data-Driven Process Improvement

**Tools:** SQL (T-SQL) · Power BI · Excel · Draw.io
**Role:** Welder · Ex-Quality Engineer · 12+ years in manufacturing

---

## Overview

FabriCo is a fictional sheet metal fabrication company modelled on
real shop floor experience. The business produces electrical panels
and enclosures for utility infrastructure clients.

The core problem: no live job tracking, paper-based job cards,
no cost visibility per job, and bottlenecks only spotted after
they cause delays.

This case study demonstrates how a data strategy built around
job tracking, operator performance, and material costs can
transform visibility and decision-making in a manufacturing business.

---

## What Was Built

**SQL Database**

An 8-table production database built in SQL Server covering the
full job lifecycle from sales order to dispatch. The schema includes
jobs, operators, departments, job scans, materials, stock, and clients.
The dataset covers a full year of production (240 jobs, 1,380 scan
events) with real manufacturing problems baked in — rework, drawing
issues, parts missing, tool wait times, and operator experience gaps.

- [View SQL folder](https://github.com/SilvioSerafin/silvio-data-portfolio/tree/main/sql)

**Power BI Dashboards**

- [Production Tracker (PDF)](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/company_production_tracker.pdf)
- [Dashboard Screenshot](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/productiontracker_fabrico_ss.png)
- [Stakeholder Dashboard (.pbix)](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/dashboard_stakeholder.pbix)

**Business Report**

- [Business Report](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/Business_report_v3.pdf)
- [Roadmap and Barcode Costs](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/roadmap_barcode_costs.pdf)

**Process Diagrams**

- [Current vs Future State](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/current_vs_future_diagram_v5.drawio.png)
- [Workflow Diagram](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/worflow_diagram_v6.drawio.png)
- [Kanban Replenishment](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/kanban_replenishment_flow_v2.drawio.png)
- [Roadmap Gantt Chart](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/Project_timeline_gantt_v1.png)

---

## Key Findings

- £90k+/year in potential value identified through workflow tracking and cost analysis
- Newer welders produce significantly more rework on jobs where drawings are basic layout only
- Drawing detail level is the single biggest driver of cycle time overrun across all departments
- Welding is the primary bottleneck department

---

## Skills Demonstrated

- SQL: schema design, CTEs, window functions, multi-table JOINs
- Power BI: dashboard design, DAX measures, KPI reporting
- Business analysis: workflow mapping, bottleneck identification, ROI calculation, process improvement strategy
- Domain knowledge: sheet metal fabrication, QA, production flow

---

⚡ SQL analysis is in progress and being added to the sql/ folder regularly. Power BI interactive links will be added once published to the Power BI Service.
