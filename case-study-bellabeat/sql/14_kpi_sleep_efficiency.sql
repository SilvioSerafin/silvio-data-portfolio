/*
================================================================
  FILE    : 14_kpi_sleep_efficiency.sql
  PURPOSE : Calculates population-level sleep efficiency and
            average minutes spent awake in bed per night.
            Feeds directly into the executive summary KPI table.

  BUSINESS QUESTION:
  How efficiently are users sleeping? Time wasted in bed
  before falling asleep is a direct indicator of sleep
  quality issues and a measurable target for Bellabeat's
  wind-down and recovery features.

  KEY FINDING:
  Average sleep efficiency ~92%. Average minutes awake in
  bed ~40 minutes per night. Users spend roughly 9% of
  total time in bed not sleeping -- a consistent signal
  across the study period.

  FORMULA NOTE:
  AVG(1.0 * TotalMinutesAsleep / TotalTimeInBed)
  This calculates efficiency at the individual record level
  before averaging -- the statistically correct approach.
  Dividing AVG(asleep) / AVG(in_bed) would produce a
  different (and less accurate) result.

  DEPENDENCY: 05_view_v_daily_activity.sql, 07_view_v_sleep.sql
================================================================
*/

USE BellaBeat;
GO

WITH sleep_data AS (
    SELECT
        a.activity_date,
        s.TotalMinutesAsleep,
        s.TotalTimeInBed
    FROM dbo.v_daily_activity a
    LEFT JOIN dbo.v_sleep s
        ON  a.Id            = s.Id
        AND a.activity_date = s.sleep_date
    WHERE s.TotalTimeInBed > 0
)
SELECT
    CONVERT(DECIMAL(4,2),
        AVG(1.0 * TotalMinutesAsleep / TotalTimeInBed)
    )                                               AS avg_sleep_efficiency,
    CONVERT(DECIMAL(10,1),
        AVG(1.0 * (TotalTimeInBed - TotalMinutesAsleep))
    )                                               AS avg_minutes_awake_in_bed
FROM sleep_data;
