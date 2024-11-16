/*
    Lab 5 - ERD to SQL conversion script
    
    Name:
 */
 
-- Set your search path to include your username and public, 
-- but *not* in this script.

-- Windows psql needs the following line uncommented
-- \encoding utf-8

-- Add other environment changes here (pager, etc.)

-- Add the SQL for each step that needs SQL after the appropriate comment 
-- below. You may not need to do every single step, depending on your
-- model.

DROP TABLE IF EXISTS data;

CREATE TABLE data (
   country TEXT,
   year NUMERIC(4,0),
   co2_pcap NUMERIC(5,3),
   gdp_pcap INT,
   life_expectancy NUMERIC(3,1),
   child_mortality NUMERIC(4,1)
);

-- UPDATE data SET country ='Afghanistan' WHERE country = '﻿Afghanistan';