1. Team 10
	Mohamed Feituri 10913121
	Jacob Hulvey 10882625
	Noah Kreutz
	Cristian Madrazo
	Tyler Pina
2. We chose the CO2 Emissions per capita, child mortality, GDP per capita, and life expectancy datasets from Gapminder. These datasets are interesting because there is extensive data specifying both year and country for most of the countries of the world back to 1800. This allows global and local trends to be calculated. The first column contains the country (the country list is not exhaustive). The second column contains the year (from 1800 to 2022). The third column contains the co2 emissions per capita in tons, consumption based (source: http://gapm.io/dco2_consumption_historic). The fourth column contains inflation adjusted gdp per capita in 2017 US dollars (source: http://gapm.io/dgdpcap_cppp). The fifth column contains the life expectancy at birth (source: http://gapm.io/dlex). The sixth column contains child mortality specifically the number of deaths out of 1000 children from ages 0 to 5 (source: http://gapm.io/du5mr).

First 10 rows:
       country       | year | co2_pcap | gdp_pcap | life_expectancy | child_mortality
---------------------+------+----------+----------+-----------------+-----------------
 Angola              | 1800 |    0.009 |      373 |            27.0 |           486.0
 Albania             | 1800 |    0.001 |      469 |            35.4 |           375.0
 Andorra             | 1800 |    0.333 |     1370 |                 |
 UAE                 | 1800 |    0.063 |     1140 |            30.7 |           434.0
 Argentina           | 1800 |    0.119 |     1700 |            33.2 |           402.0
 Armenia             | 1800 |    0.000 |      588 |            34.0 |           371.0
 Antigua and Barbuda | 1800 |    0.018 |      867 |            33.5 |           474.0
 Australia           | 1800 |    0.076 |      821 |            34.0 |           391.0
 Austria             | 1800 |    0.051 |     1940 |            34.4 |           387.0
 Azerbaijan          | 1800 |    0.000 |      725 |            29.2 |           384.0
(10 rows)

We transformed the data by converting the 2D tables in the four CSVs into a single 1D array using excel. The process involved first copying all the difference CSVs into a single excel file on different sheets. Then using the ROW, ADDRESS, INDIRECT, MOD, LEN, ROWNDOWN, and IF functions in excel to convert a four 2D tables into a 1D array with five columns and 43,039 rows.

Create table statement and other commands needed to create and fill the data table:
CREATE TABLE data (
   country TEXT,
   year NUMERIC(4,0),
   co2_pcap NUMERIC(5,3),
   gdp_pcap INT,
   life_expectancy NUMERIC(3,1),
   child_mortality NUMERIC(4,1)
);

We used this command to fill in the table: psql \COPY username.data FROM data/actual_data.csv DELIMITER ';' NULL 'NULL'

And had to make this edit (because there was a strange character at the very beginning of the CSV): UPDATE data SET country ='Afghanistan' WHERE country = '﻿Afghanistan';

3. 