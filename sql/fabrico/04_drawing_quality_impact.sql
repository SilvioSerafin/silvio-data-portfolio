/* Business Question:
The manager wants to understand the impact of drawing quality on cycle time. 
Show the average planned minutes vs average actual minutes grouped by drawing_detail_level, 
and calculate the average overrun. Order by highest overrun first.
*/



SELECT  j.drawing_detail_level,
        ROUND(AVG(js.planned_duration_mins) ,2) AS average_duration,
        ROUND(AVG(js.actual_duration_mins) , 2) AS actual_average_duration,
        ROUND(AVG(js.actual_duration_mins) - AVG(js.planned_duration_mins) ,2) AS average_overrun
FROM job_scans js
INNER JOIN jobs j
ON js.job_id = j.job_id
GROUP BY j.drawing_detail_level
ORDER BY average_overrun DESC;

        
        
/*
============================================================
Findings:
Every single job in the dataset carries the same drawing
detail level: basic layout only. This is not a data issue,
it reflects the reality of the shop floor. Clients send a
layout, not a fabrication drawing. No weld symbols, no bend
allowances, no part callouts.

The result is an average overrun of 65 minutes per department
scan. On a job that passes through 6 departments, that is
potentially 390 minutes of unplanned time per job. Across
240 jobs in the year that adds up to thousands of hours of
time spent interpreting, questioning, and second-guessing
drawings that should have been clear from the start.

For experienced welders this means slowing down to work it
out. For new welders it means stopping work entirely and
finding a senior to ask. That dependency on tribal knowledge
is invisible in a paper-based system but shows up clearly
in the data as overrun.

Recommendation:
Engineering should develop internal fabrication drawings from
the client layouts before jobs are released to the shop floor.
Even a basic sketch with key dimensions and weld callouts
would reduce the back and forth significantly. This single
change would likely have the biggest impact on cycle time
of anything in the improvement plan.
============================================================
*/