-- select correlation between goals and overall searches for category = -0.6551315195249424 = moderate to strong correlation
SELECT CORR(PLAYER_EVENTS, SEARCHES) FROM (
	...
) WHERE PLAYER_NAME IS NULL;

-- select correlation between goals and player searches = -0.0254602413913784 = no correlation
SELECT CORR(PLAYER_EVENTS, SEARCHES) FROM (
	...
) WHERE PLAYER_NAME IS NOT NULL;