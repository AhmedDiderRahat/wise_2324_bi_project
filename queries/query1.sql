-- select how many times users searched for world cup related queries, which doesnt include players
WITH
    SINGLE_QUERIES AS (
    	SELECT
    		ANONID,
    		QUERYID,
    		MIN(URLID) AS URLID,
    		TIMEID
		FROM AOL_SCHEMA.FACTS
		GROUP BY ANONID, TIMEID, QUERYID
    )
SELECT t."day of the month", t."month", COUNT(*)
FROM AOL_SCHEMA.WC_QUERYDIM wq JOIN SINGLE_QUERIES s ON wq.ID = s.QUERYID
JOIN AOL_SCHEMA.TIMEDIM t ON s.TIMEID = t.ID
WHERE
s.TIMEID is not null AND
t."month" IN ('april','march','may')
GROUP BY ROLLUP(t."month", t."day of the month")
ORDER BY t."month", t."day of the month";