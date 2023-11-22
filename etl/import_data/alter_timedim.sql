update AOL_SCHEMA.TIMEDIM t
    set t."month" = TRIM(t."month");

DELETE FROM AOL_SCHEMA.TIMEDIM
WHERE id > 6927038;