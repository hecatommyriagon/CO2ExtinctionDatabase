1. Team 10
	Mohamed Feituri 10913121
	Jacob Hulvey 10882625
	Noah Kreutz 10904022
	Cristian Madrazo 10924296
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
Question 1: Do increased CO2 levels lead to decreased life expectancy in North America?

Query 1:
SELECT life_expectancy, co2_pcap, country, year 
FROM data
WHERE country IN
('Antigua and Barbuda',
'Bahamas',
'Barbados',
'Belize',
'Canada',
'Costa Rica',
'Cuba',
'Dominica',
'Dominican Republic',
'El Salvador',
'Grenada',
'Guatemala',
'Haiti',
'Honduras',
'Jamaica',
'Mexico',
'Nicaragua',
'Panama',
'St. Kitts and Nevis',
'St. Lucia',
'St. Vincent and the Grenadines',
'Trinidad and Tobago',
'USA')
AND life_expectancy IS NOT NULL
ORDER BY life_expectancy;

Output of Query 1 (from middle of query):
 life_expectancy | co2_pcap |            country             | year
-----------------+----------+--------------------------------+------
            52.0 |    0.138 | Haiti                          | 1982
            52.1 |    0.225 | El Salvador                    | 1959
            52.2 |    7.380 | Canada                         | 1910
            52.3 |    0.147 | Haiti                          | 1983
            52.3 |    0.131 | St. Lucia                      | 1951
            52.3 |    0.321 | Honduras                       | 1963
            52.3 |    0.015 | Barbados                       | 1943
            52.3 |    0.260 | Nicaragua                      | 1955
            52.4 |   20.700 | Trinidad and Tobago            | 1942
            52.4 |    0.179 | Jamaica                        | 1948
            52.6 |    8.430 | Canada                         | 1911
            52.6 |    0.234 | Belize                         | 1947
            52.7 |    0.016 | Cuba                           | 1939
            52.7 |    0.053 | St. Vincent and the Grenadines | 1949
            52.7 |    0.527 | Bahamas                        | 1943
            52.7 |    0.146 | Haiti                          | 1984
            52.7 |    0.239 | Costa Rica                     | 1945
            52.7 |    0.073 | Grenada                        | 1941
            52.8 |    1.160 | Mexico                         | 1954
            52.9 |   12.400 | USA                            | 1909


