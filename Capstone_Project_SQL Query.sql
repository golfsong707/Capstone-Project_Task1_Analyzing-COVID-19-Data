
----DATABASE AND TABLE CREATION 
CREATE DATABASE covid_19_data;

USE covid_19_data;

CREATE TABLE covid_data (
    serial_number serial,
    observation_date varchar(15),
    province varchar(20),
    country varchar(20),
    last_update varchar(20),
    confirmed int,
    deaths int,
    recovered int
);

----Modify the data type of 'ObservationDate' to 'DATE' within the database, as opposed to its initial 'String' representation.
ALTER TABLE covid_19_data
ALTER COLUMN observationDate TYPE DATE
USING observationDate::DATE;


---A. the qurey code ws used to retrieve the cumulative counts of confirmed, deceased, and recovered cases

SELECT
  province,
  country,
  SUM(confirmed) AS confirmed,
  SUM(deaths) AS deaths,
  SUM(recovered) AS recovered
FROM
  covid_19_data
GROUP BY
  province,
  country

---B. Extract the aggregate counts of confirmed, deceased, and recovered cases for the first quarter of each observation year.

SELECT
    EXTRACT(YEAR FROM observationdate) AS observation_year,
    EXTRACT(QUARTER FROM observationdate) AS observation_quarter,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM covid_19_data
WHERE observationdate >= '2019-01-01' AND observationdate <= '2019-03-31'
GROUP BY observation_year, observation_quarter

UNION

SELECT
    EXTRACT(YEAR FROM observationdate) AS observation_year,
    EXTRACT(QUARTER FROM observationdate) AS observation_quarter,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM covid_19_data
WHERE observationdate >= '2020-01-01' AND observationdate <= '2020-03-31'
GROUP BY observation_year, observation_quarter

---C. Formulate a comprehensive summary encompassing the following for each country:Total confirmed cases,Total deaths,Total recoveries

SELECT
    country,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recoveries
FROM covid_19_data
GROUP BY country
ORDER BY country;

---D. Determine the percentage increase in the number of death cases from 2019 to 2020

SELECT
    (SUM(deaths_2020) - SUM(deaths_2019)) / SUM(deaths_2019) * 100 AS death_increase_percentage
FROM (
    SELECT
        SUM(CASE WHEN EXTRACT(YEAR FROM observationdate) = 2019 THEN deaths ELSE 0 END) AS deaths_2019,
        SUM(CASE WHEN EXTRACT(YEAR FROM observationdate) = 2020 THEN deaths ELSE 0 END) AS deaths_2020
    FROM covid_19_data
) subquery;

---E. Compile data for the top 5 countries with the highest confirmed cases.

SELECT
    country,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recoveries
FROM covid_19_data
GROUP BY country
ORDER BY total_confirmed DESC
LIMIT 5;


---F. Calculate the net change (increase or decrease) in confirmed cases on a monthly basis over the two-year period.

SELECT
    DATE_TRUNC('month', observationdate) AS month,
    SUM(confirmed) - LAG(SUM(confirmed), 1, 0) OVER (ORDER BY DATE_TRUNC('month', observationdate)) AS net_change_confirmed
FROM covid_19_data
GROUP BY month
ORDER BY month;

