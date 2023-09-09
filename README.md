# ANALYZING COVID-19 DATA

![image](https://github.com/golfsong707/Capstone-Project_Task1_Analyzing-COVID-19-Data/assets/131208083/f4520c61-246b-4f7a-8665-bf82c11544b2)



## Table of Contents
- [Introduction/Project Overview](#introductionproject-overview)
- [Data Summary](#data-summary)
- [Instructions](#instructions)
- [How It Works](#how-it-works)
- [Requirements](#requirements)
- [SQL Queries Result Explanation](#sql-queries-result-explanation)
- [Conclusion](#conclusion)
- [Contribution and Feedback](#contribution-and-feedback)

## Introduction/Project Overview
The COVID-19 pandemic has had far-reaching consequences, causing significant loss of lives and disruptions to societies. This project delves into the analysis of sample data pertaining to COVID-19 cases recorded between January 2019 and December 2020. The dataset is provided in CSV format.

## Data Summary

| Column Name     | Description                                                      | Data Type      |
|-----------------|------------------------------------------------------------------|----------------|
| serialnumber    | A unique serial number for each record.                          | serial         |
| observationdate | The date of observation in the format varchar(15).              | varchar(15)    |
| province        | The province where the observation was made.                    | varchar(20)    |
| country         | The country where the observation was made.                     | varchar(20)    |
| last update     | The date and time of the last update for the record.            | varchar(20)    |
| confirmed       | The number of confirmed COVID-19 cases.                         | int            |
| deaths          | The number of deaths due to COVID-19.                           | int            |
| recovered       | The number of recovered COVID-19 cases.                         | int            |


## Instructions
It is essential to utilize PostgreSQL as the chosen database tool.
1. Establish a database named 'covid_19_data' and create a table within it named 'covid_19_data' to house the dataset.
2. Modify the data type of 'ObservationDate' to 'DATE' within the database, as opposed to its initial 'String' representation.
3. Utilize a Python script to procure the 'Covid_19_data.csv' file and subsequently load it into the PostgreSQL database.
4. Employ PostgreSQL PG4 Admin for the creation and execution of SQL queries.
5. Present all queries within a singular SQL file.

## How It Works
1. **Database Creation:** Postgres Database is used to create the Project database named 'covid_19_data' to house the COVID-19 dataset.
2. **Data Extraction:** Raw data, given in CSV file extension. The 'Covid_19_data.csv' file was read using the Pandas library in Python and stored in a Pandas DataFrame named 'covid_19_dataset'.
3. **Modification:**
   - Data type of 'ObservationDate' was changed to 'DATE' within the DataFrame.
4. **Data Loading:**
   - Data was loaded using Python with the help of SQLAlchemy libraries to interact with PostgreSQL databases.
   - The DataFrame was written to a table named 'covid_19_data' using the 'to_sql' function.
5. **Running SQL Queries with PostgreSQL PG4 Admin:**
   - SQL queries were executed with the PostgreSQL PG4 Admin query tool.

## Requirements
- Python 3.x
- Pandas
- SQLAlchemy
- PostgreSQL

## SQL Queries result Explanation

| **Query** | **Query Explanation** | **Screenshot** |
| --- | --- | --- |
| **A.** |
| ```SELECT province, country, SUM(confirmed) AS confirmed, SUM(deaths) AS deaths, SUM(recovered) AS recovered FROM covid_19_data GROUP BY province, country; ``` | The query retrieves cumulative counts of confirmed, deceased, and recovered cases. It groups the data by province and country, then calculates the sums of confirmed, deaths, and recovered cases for each group. | See attached "Query_Output_Screenshot" folder. |
| **B.** |
| ```SELECT EXTRACT(YEAR FROM observationdate) AS observation_year, EXTRACT(QUARTER FROM observationdate) AS observation_quarter, SUM(confirmed) AS total_confirmed, SUM(deaths) AS total_deaths, SUM(recovered) AS total_recovered FROM covid_19_data WHERE observationdate >= '2019-01-01' AND observationdate <= '2019-03-31' GROUP BY observation_year, observation_quarter UNION SELECT EXTRACT(YEAR FROM observationdate) AS observation_year, EXTRACT(QUARTER FROM observationdate) AS observation_quarter, SUM(confirmed) AS total_confirmed, SUM(deaths) AS total_deaths, SUM(recovered) AS total_recovered FROM covid_19_data WHERE observationdate >= '2020-01-01' AND observationdate <= '2020-03-31' GROUP BY observation_year, observation_quarter; ``` | This query extracts aggregate counts of confirmed, deceased, and recovered cases for the first quarter of each observation year. It uses the `EXTRACT` function to get the year and quarter from the observation date, then sums the cases for each group. It combines data for Q1 2019 and Q1 2020 using `UNION`. | See attached "Query_Output_Screenshot" folder. |
| **C.** |
| ```SELECT country, SUM(confirmed) AS total_confirmed, SUM(deaths) AS total_deaths, SUM(recovered) AS total_recoveries FROM covid_19_data GROUP BY country ORDER BY country; ``` | The query forms a comprehensive summary for each country, including the total confirmed cases, total deaths, and total recoveries. It groups the data by country and calculates the sums for each group. The results are ordered by country. | See attached "Query_Output_Screenshot" folder. |
| **D.** |
| ```SELECT (SUM(deaths_2020) - SUM(deaths_2019)) / SUM(deaths_2019) * 100 AS death_increase_percentage FROM ( SELECT SUM(CASE WHEN EXTRACT(YEAR FROM observationdate) = 2019 THEN deaths ELSE 0 END) AS deaths_2019, SUM(CASE WHEN EXTRACT(YEAR FROM observationdate) = 2020 THEN deaths ELSE 0 END) AS deaths_2020 FROM covid_19_data ) subquery; ``` | This query determines the percentage increase in the number of death cases from 2019 to 2020. It calculates the percentage by comparing the sum of deaths in 2020 with the sum of deaths in 2019, and then dividing by the sum of deaths in 2019. | See attached "Query_Output_Screenshot" folder. |
| **E.** |
| ```SELECT country, SUM(confirmed) AS total_confirmed, SUM(deaths) AS total_deaths, SUM(recovered) AS total_recoveries FROM covid_19_data GROUP BY country ORDER BY total_confirmed DESC LIMIT 5; ``` | The query compiles data for the top 5 countries with the highest confirmed cases. It groups the data by country, calculates the sums for confirmed, deaths, and recoveries, and orders the results by total confirmed cases in descending order. | See attached "Query_Output_Screenshot" folder. |
| **F.** |
| ```SELECT DATE_TRUNC('month', observationdate) AS month, SUM(confirmed) - LAG(SUM(confirmed), 1, 0) OVER (ORDER BY DATE_TRUNC('month', observationdate)) AS net_change_confirmed FROM covid_19_data GROUP BY month ORDER BY month; ``` | This query calculates the net change (increase or decrease) in confirmed cases on a monthly basis over the two-year period. It uses the `DATE_TRUNC` function to group data by month, then calculates the difference between the current month's confirmed cases and the previous month's confirmed cases using the `LAG` window function. | See attached "Query_Output_Screenshot" folder. |


## Conclusion
In conclusion, the COVID-19 dataset was provided, extracted using the Pandas library, and stored in a DataFrame. A PostgreSQL database was created to serve as a centralized repository for easy access and analysis.

## Contribution and Feedback
Contributions are welcome to enhance and extend this ETL pipeline further. Feel free to submit pull requests, raise issues, or provide feedback to help us improve the project.
