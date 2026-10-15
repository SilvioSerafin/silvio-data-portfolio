# FabriCo Solutions: Data-Driven Process Improvement

**Tools:** SQL (T-SQL, SQL Server) | Power BI | Excel | Draw.io

Built by Silvio Serafin, Quality Engineer (8 years, ISO 9001 implementation, corrective actions, continuous improvement) now working in sheet metal fabrication.

## Overview

FabriCo is a fictional sheet metal fabrication company. The business and all of its data are simulated. Findings show how the analysis works, not measured results from a real business.

**The business problem:** paper job cards, no cost visibility per job, and bottlenecks that are only noticed after they cause delays.

**The question:** how can job tracking, rework data and material costs give a manufacturing business visibility and better decisions?

## What was built

### SQL database

An 8-table production database in SQL Server covering the job lifecycle from sales order to dispatch: jobs, operators, departments, job scans, materials, job materials, stock and clients. The simulated dataset covers one year: 240 jobs and 1,380 scan events, with rework, drawing issues, missing parts and tool wait times included.

* [SQL analysis queries](https://github.com/SilvioSerafin/silvio-data-portfolio/tree/main/sql/fabrico)

### Power BI dashboards

* [Production Tracker (PDF)](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/company_production_tracker.pdf)
* [Dashboard screenshot](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/productiontracker_fabrico_ss.png)
* [Stakeholder dashboard (.pbix, needs Power BI Desktop)](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/dashboard_stakeholder.pbix)

### Process diagrams

* [Current vs future state](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/current_vs_future_diagram_v5.drawio.png)
* [Workflow diagram](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/worflow_diagram_v6.drawio.png)
* [Kanban replenishment](https://github.com/SilvioSerafin/silvio-data-portfolio/blob/main/case-study-fabrico/kanban_replenishment_flow_v2.drawio.png)

## What the analysis looks at

* Rework by drawing detail level and process stage
* Cycle time, planned against actual, by department
* Bottleneck identification across the production line
* Material cost per job and jobs over budget
* On-time delivery performance

## Status: rebuild in progress

This project is being rebuilt as a fuller quality analytics project:

* Schema and seed script so anyone can recreate the database
* More realistic simulated data, with natural variation
* Non-conformance (NCR) and corrective action tracking
* SPC charts and Pareto analysis
* A dashboard covering rework, overruns and on-time delivery
* A short, sourced business case with stated assumptions

## Skills demonstrated

* **SQL:** schema design, CTEs, multi-table joins, aggregation
* **Power BI:** dashboard design, DAX measures, KPI reporting
* **Business analysis:** workflow mapping, bottleneck identification, process improvement
* **Domain:** quality engineering, sheet metal fabrication, production flow
