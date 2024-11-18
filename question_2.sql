/*
   This script answers the question

   Do countries with longer names have higher infant mortality rates?
 */
  
SELECT 
   country_name_len, 
   AVG(avg_child_mort) AS avg_child_mort
FROM (
   -- Gets the average annual child mortality per country and the length of the country name
   SELECT 
      country,
      LENGTH(country) AS country_name_len,
      AVG(child_mortality) AS avg_child_mort
   FROM data 
   GROUP BY country
) AS temp 
GROUP BY country_name_len 
ORDER BY country_name_len DESC;


-- This one gives us the country names too for debugging

-- SELECT 
--    country,
--    LENGTH(country) AS country_name_len,
--    AVG(child_mortality) AS avg_child_mort
-- FROM data 
-- GROUP BY country
-- ORDER BY country DESC;
