CREATE OR REPLACE TABLE AOL_SCHEMA.WC_SEARCH_TERMS (
    TERM VARCHAR(512) NOT NULL
);
IMPORT INTO AOL_SCHEMA.WC_SEARCH_TERMS
FROM LOCAL CSV FILE 'D:\Programmierung\wise_2324_bi_project\data\materialized_view_data\wc_search_terms.csv';

CREATE OR REPLACE TABLE AOL_SCHEMA.PLAYER_SEARCH_TERMS (
    TERM VARCHAR(512) NOT NULL
);
IMPORT INTO AOL_SCHEMA.PLAYER_SEARCH_TERMS
FROM LOCAL CSV FILE 'D:\Programmierung\wise_2324_bi_project\data\materialized_view_data\player_search_terms.csv';