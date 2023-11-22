-- which stadium got maximum goal

SELECT loc.STADIUM, 
	COUNT(DISTINCT mf.MATCH_ID) AS number_of_match, 
	SUM(pmd.GOALS) AS number_of_goal,
	ROUND(SUM(pmd.GOALS) / COUNT(DISTINCT mf.MATCH_ID), 2) AS goal_per_match
FROM AOL_SCHEMA.MATCH_FACTS mf
JOIN AOL_SCHEMA.LOCATIONDIM loc ON loc.ID = mf.LOCATION_ID 
JOIN AOL_SCHEMA.PLAYER_MATCHDIM pmd ON pmd.ID = mf.PLAYER_MATCH_ID
GROUP BY 1
ORDER BY 4 DESC

-- team with heighest goal
