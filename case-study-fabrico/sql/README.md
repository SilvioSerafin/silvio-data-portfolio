# FabriCo — SQL Analysis

T-SQL queries analysing production data for FabriCo Solutions,
a fictional sheet metal fabrication company modelled on real
shop floor experience.

## Schema

8 tables covering the full job lifecycle:
jobs, operators, departments, job_scans,
materials, job_materials, stock, clients.

Full year of 2025 production data: 240 jobs, 1,380 scan events.

## Problems Being Investigated

- Rework rates by operator and drawing quality
- Cycle time planned vs actual by department
- Bottleneck identification across the production line
- Material cost per job
- On-time delivery performance
- New vs experienced operator performance gap

## Files

Each file is a standalone analysis with a business question,
the query, and a short commentary on what the data shows.
