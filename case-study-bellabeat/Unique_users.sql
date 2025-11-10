SELECT 
    Id,
    ROUND(AVG(TotalMinutesAsleep) / 60.0, 2) AS AvgSleepHours,
    ROUND(AVG(TotalTimeInBed) / 60.0, 2) AS AvgTimeInBedHours
FROM dbo.sleepDay_merged2
GROUP BY Id
ORDER BY AvgSleepHours DESC;