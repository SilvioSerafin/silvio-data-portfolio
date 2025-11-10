# Bellabeat SQL Analysis
All SQL scripts used for data profiling, cleaning, transformation, and analytical queries in the Bellabeat case study.

## How to use
1. Run `00_setup_database.sql`
2. Execute each script in numeric order to recreate the environment.
3. Views (`v_*`) feed Power BI visuals directly.

## Schema
`BellaBeat.dbo`

Source tables:
- dailyActivity_merged2
- dailySteps_merged2
- dailyIntensities_merged2
- sleepDay_merged2
- weightLogInfo_merged2

## Sections
| Code | Purpose |
|------|----------|
| 01–03 | Profiling & Validation |
| 10–12 | Clean base views |
| 20 | Date dimension |
| 30–33 | Analysis queries |
| 40–42 | KPI calculations |
| 50–52 | Power BI views |

## Environment
- Microsoft SQL Server (T-SQL)
- Power BI for visualization
- All outputs reproducible