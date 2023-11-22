WITH 
	SINGLE_QUERIES AS (
		SELECT DISTINCT tdm."day of the month", tdm."month" 
		FROM AOL_SCHEMA.wc_querydim wqd 
		JOIN AOL_SCHEMA.facts f ON wqd.ID = f.QUERYID 
		JOIN AOL_SCHEMA.timedim tdm ON f.TIMEID = tdm.ID
) 
SELECT qd.QUERY query, COUNT(qd.ID) counts
	FROM AOL_SCHEMA.QUERYDIM qd
	JOIN AOL_SCHEMA.FACTS fct ON qd.ID = fct.QUERYID
	JOIN AOL_SCHEMA.TIMEDIM td ON fct.TIMEID = td.ID 
	JOIN SINGLE_QUERIES SQ ON SQ."month" = td."month" 
		AND SQ."day of the month" = td."day of the month"
WHERE NOT EXISTS (
    SELECT 1
    FROM AOL_SCHEMA.wc_querydim wq
    WHERE wq.ID = qd.ID 
)
AND qd.QUERY IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC