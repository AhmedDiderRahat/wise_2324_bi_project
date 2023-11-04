FUNCTION CHECK_WORDS_EXIST (input_string VARCHAR(1000), words_to_check VARCHAR(1000)) 
	RETURN BOOLEAN
	IS
		res BOOLEAN;
		pos INT;
		word VARCHAR(1000);
	BEGIN
    	res := TRUE;
    	pos := POSITION(' ' IN input_string);
    
    	WHILE pos > 0 
    	DO
        	word := SUBSTRING(input_string FROM 1 FOR pos - 1);

        	IF POSITION(word IN words_to_check) = 0 THEN
            	res := FALSE;
             	RETURN res;
        	END IF;

        	input_string := SUBSTRING(input_string FROM pos + 1);
        	pos := POSITION(' ' IN input_string);
    	END WHILE;

    	IF LENGTH(input_string) > 0 THEN
        	IF POSITION(input_string IN words_to_check) = 0 THEN
            	res := FALSE;
        	END IF;
    	END IF;
    
    	RETURN res;
	END CHECK_WORDS_EXIST;
/

CREATE OR REPLACE TABLE AOL_SCHEMA.WC_QUERYDIM AS (
    SELECT qd.QUERY, qd.ID
    FROM AOL_SCHEMA.QUERYDIM AS qd
         LEFT JOIN AOL_SCHEMA.WC_SEARCH_TERMS AS wc ON (
           CHECK_WORDS_EXIST(wc.TERM, qd.QUERY)
         )
);
