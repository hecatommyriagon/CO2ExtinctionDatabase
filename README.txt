1. Team 10
	Mohamed Feituri 10913121
	Jacob Hulvey 10882625
	Noah Kreutz 10904022
	Cristian Madrazo 10924296
	Tyler Pina
2. We chose the CO2 Emissions per capita, child mortaility, GDP per capita, and life expectancy datasets from Gapminder. This dataset is interesting because ____. The first column contains the country (the country list is not exhastive). The second column contains the year (from 1800 to 2022). The third column contains the co2 per capita (tons). The third column contains inflation adjusted gdp per capita in 2017 US dollars. The fourth column contains the life expectancy at birth. The fifth column contains child mortality (number of deaths out of 1000 from ages 0 to 5).
	We transformed the data by converting the data in the 2D tables into a 1D array then append.

CREATE TABLE data (
   country TEXT,
   year NUMERIC(4,0),
   co2_pcap NUMERIC(5,3),
   gdp_pcap INT,
   life_expectancy NUMERIC(3,1),
   child_mortality NUMERIC(4,1)
);

 We used this command: psql \COPY jhulvey.data FROM data/actual_data.csv DELIMITER ';' NULL 'NULL'

And had to make this edit: UPDATE data SET country ='Afghanistan' WHERE country = '﻿Afghanistan';
