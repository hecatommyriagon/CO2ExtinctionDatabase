/*
   This script answers the question

   Do countries with longer names have higher infant mortality rates?
 */
  
/*SELECT life_expectancy, co2_pcap, country, year 
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
ORDER BY life_expectancy;*/



/*SELECT count(a.year) AS "CO_2 d or e and lex d or e",
count(c.year) AS "CO_2 u and lex u",
count(e.year) AS "CO_2 d or e and lex u",
count(g.year) AS "CO_2 u and lex d or e"
FROM data AS a, data AS b, data AS c, data AS d, data AS e, data AS f, data AS g, data AS h
WHERE a.life_expectancy IS NOT NULL AND
b.life_expectancy IS NOT NULL AND
c.life_expectancy IS NOT NULL AND
d.life_expectancy IS NOT NULL AND
e.life_expectancy IS NOT NULL AND
f.life_expectancy IS NOT NULL AND
g.life_expectancy IS NOT NULL AND
h.life_expectancy IS NOT NULL AND

a.country = b.country AND
d.country = c.country AND
f.country = e.country AND
h.country = g.country AND

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

a.year = (b.year +1) AND
a.co2_pcap >= b.co2_pcap AND
a.life_expectancy >= b.life_expectancy AND

c.year = (d.year +1) AND
c.co2_pcap < d.co2_pcap AND
c.life_expectancy < d.life_expectancy AND

e.year = (f.year +1) AND
e.co2_pcap >= f.co2_pcap AND
e.life_expectancy < f.life_expectancy AND

g.year = (h.year +1) AND
g.co2_pcap < h.co2_pcap AND
g.life_expectancy >= h.life_expectancy;*/
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