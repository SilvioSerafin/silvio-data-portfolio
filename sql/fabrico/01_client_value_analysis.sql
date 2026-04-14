
/* Business Question:
The FabriCo manager wants to know how many jobs each client sent in during 2025, 
and what the total quoted value was for each one. Order it from the highest value client down to the lowest.
Tables you need: jobs, clients
Columns you need: client_name, count of jobs, sum of quoted_value */



SELECT c.client_name,
       COUNT(j.job_id) AS total_jobs,
       ROUND(SUM(j.quoted_value),2) AS total_quoted_value
FROM clients c 
INNER JOIN jobs j
ON c.client_id = j.client_id
WHERE dispatch_date BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY c.client_name
ORDER BY total_quoted_value DESC;

/*
============================================================
Findings:
LMX Infrastructure Ltd is the dominant client by both volume
and value  with 73 jobs worth £528k, nearly double Brigen Ltd
in second place at £353k. The remaining 7 clients combined
account for less than £455k.

This level of dependency on a single client is a business risk.
If LMX reduces orders, delays payment, or moves to a different
supplier, the impact on revenue would be immediate and significant.

Recommendation: the sales team should develop a targeted plan
to grow revenue from mid-tier clients like MWH Treatment,
Balfour Beatty, and Amex Utilities. A healthier client spread
reduces exposure and creates more stable forecasting.
============================================================
*/