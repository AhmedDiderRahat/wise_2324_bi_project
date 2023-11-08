CREATE OR REPLACE TABLE AOL_SCHEMA.TEAMDIM (
    ID Decimal(18) NOT NULL Primary Key,
    TEAM VARCHAR(256) NOT NULL,
    Rank Decimal(18) NOT NULL
);
IMPORT INTO AOL_SCHEMA.TEAMDIM
FROM LOCAL CSV FILE 'D:\Programmierung\wise_2324_bi_project\data\query_data\teamdim.csv';
