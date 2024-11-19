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
SELECT
(SELECT COUNT(*)
FROM data AS a, data AS b
WHERE a.life_expectancy IS NOT NULL AND
b.life_expectancy IS NOT NULL AND
a.country = b.country AND

a.country IN ('Antigua and Barbuda',
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
'USA') AND
a.year = (b.year +1) AND
a.co2_pcap <= b.co2_pcap AND
a.life_expectancy <= b.life_expectancy) AS "CO_2 d or e and lex d or e",

(SELECT COUNT(*)
FROM data AS c, data AS d
WHERE c.life_expectancy IS NOT NULL AND
d.life_expectancy IS NOT NULL AND
d.country = c.country AND

c.country IN ('Antigua and Barbuda',
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
'USA') AND
c.year = (d.year +1) AND
c.co2_pcap > d.co2_pcap AND
c.life_expectancy > d.life_expectancy) AS "CO_2 u and lex u",

(SELECT COUNT(*)
FROM data AS e, data AS f
WHERE e.life_expectancy IS NOT NULL AND
f.life_expectancy IS NOT NULL AND
f.country = e.country AND

e.country IN ('Antigua and Barbuda',
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
'USA') AND
e.year = (f.year +1) AND
e.co2_pcap <= f.co2_pcap AND
e.life_expectancy > f.life_expectancy) AS "CO_2 d or e and lex u",

(SELECT COUNT(*)
FROM data AS g, data AS h
WHERE g.life_expectancy IS NOT NULL AND
h.life_expectancy IS NOT NULL AND
h.country = g.country AND

g.country IN ('Antigua and Barbuda',
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
'USA') AND
g.year = (h.year +1) AND
g.co2_pcap > h.co2_pcap AND
g.life_expectancy <= h.life_expectancy) AS "CO_2 u and lex d or e"
FROM data
LIMIT 1;

Output of Query 1:
 CO_2 d or e and lex d or e | CO_2 u and lex u | CO_2 d or e and lex u | CO_2 u and lex d or e
----------------------------+------------------+-----------------------+-----------------------
                       1658 |             1211 |                   983 |                   954
(1 row)

To understand the output of the query some explanations are necessary. Each column title need to have "The number of times " and " across 1 year" added to them at the beginning and end respectively, CO_2 stands for CO_2 emissions per capita, lex stands for life expectancy, d stands for down (decreased), e stand for equal to (stayed the same), and u stands for up or increased so each column can be interpret as follows:
CO_2 d or e and lex d or e -> The number of times CO_2 emissions decreased or stayed the same and life expectancy decreased or stayed the same across 1 year.
CO_2 u and lex u -> The number of times CO_2 emissions increased and life expectancy increased across 1 year.
CO_2 d or e and lex u -> The number of times CO_2 emissions decreased or stayed the same and life expectancy increased across 1 year.
CO_2 u and lex d or e -> The number of times CO_2 emissions increased and life expectancy decreased or stayed the same across 1 year.

This question is interesting because intuition tells you that more CO_2 leads to decreased life expectancy, but as CO_2 increases generally technology improves leading to longer lives so the answer is ambiguous. The output of the query answers the question by demonstrating that only about a fourth of the time does life expectancy decrease with higher CO_2 levels.


Question 2: Do countries with longer names have higher infant mortality rates?

Query 2:

SELECT 
   country_name_len, 
   AVG(avg_child_mort) AS avg_child_mort
FROM (
   SELECT 
      country,
      LENGTH(country) AS country_name_len,
      AVG(child_mortality) AS avg_child_mort
   FROM data 
   GROUP BY country
) AS temp 
GROUP BY country_name_len 
ORDER BY country_name_len DESC;

Output of Query 2:

country_name_len |    avg_child_mort    
------------------+----------------------
               30 | 230.0269058295964126
               24 | 356.5605381165919283
               23 | 215.1520179372197309
               22 | 259.0905829596412556
               21 | 254.9681614349775785
               19 | 160.7062329790937199
               18 | 225.1986444703810635
               17 | 359.8681614349775785
               16 | 191.1690398673137171
               15 | 276.4065022421524664
               14 | 220.1529147982062780
               13 | 333.8307922272047833
               12 | 367.2949177877428998
               11 | 291.5096343877509797
               10 | 284.2703690927906175
                9 | 273.0811659192825112
                8 | 289.8338590395201073
                7 | 260.1538936142478938
                6 | 268.3915529209410897
                5 | 284.4588777463808178
                4 | 330.0448928749377180
                3 | 272.0527653213751868
                2 | 153.9327354260089686
(23 rows)
