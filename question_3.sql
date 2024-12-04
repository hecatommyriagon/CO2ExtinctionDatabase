/*
   This script answers the question

   Has the GDP of South Korea increased at a faster rate than the US's over the past 20 years?
 */

SELECT 
    country, 
    year, 
    gdp_per_capita
FROM data
WHERE country IN ('South Korea', 'United States')
  AND year >= (SELECT MAX(year) - 20 FROM data)
ORDER BY country, year;


