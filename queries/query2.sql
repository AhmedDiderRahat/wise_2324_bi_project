-- select the sites with the highest click rates and determine the percentage of times they are clicked from all wc queries.
SELECT u.URL, u.THISDOMAIN,
		count(*) AS CLICKS,
		dense_rank() OVER (ORDER BY count(u.URL) DESC) AS URL_RANK,
		ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()),2) AS CLICK_PERCENTAGE
FROM AOL_SCHEMA.WC_QUERYDIM wq JOIN AOL_SCHEMA.FACTS f ON wq.ID = f.QUERYID 
JOIN AOL_SCHEMA.URLDIM u ON f.URLID = u.ID
WHERE u.THISDOMAIN IS NOT NULL 
GROUP BY u.THISDOMAIN, u.URL
ORDER BY url_rank, u.THISDOMAIN;

-- select highest clicked domains and urls
-- parition domains and normal urls + domains into two different groups
SELECT u.URL, u.THISDOMAIN,
		count(*) AS CLICKS,
		dense_rank() OVER (PARTITION BY CASE
        WHEN u.URL is null
            THEN 1
            ELSE 0
        END  
		ORDER BY count(u.URL) DESC) AS URL_RANK,
		ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()),2) AS CLICK_PERCENTAGE
FROM AOL_SCHEMA.WC_QUERYDIM wq JOIN AOL_SCHEMA.FACTS f ON wq.ID = f.QUERYID 
JOIN AOL_SCHEMA.URLDIM u ON f.URLID = u.ID
WHERE u.THISDOMAIN IS NOT NULL 
GROUP BY GROUPING SETS ((u."THISDOMAIN"), (u."THISDOMAIN", u."URL"))
ORDER BY url_rank, u.THISDOMAIN;
