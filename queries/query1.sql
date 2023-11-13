-- select the number of times users searched for wc related queries (excluding those related to players).
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
SELECT t."day of the month", t."month", COUNT(*) AS searches
FROM AOL_SCHEMA.WC_QUERYDIM wq JOIN SINGLE_QUERIES s ON wq.ID = s.QUERYID
JOIN AOL_SCHEMA.TIMEDIM t ON s.TIMEID = t.ID
WHERE t."month" IN ('april','march','may')
GROUP BY ROLLUP(t."month", t."day of the month")
ORDER BY t."month", t."day of the month";