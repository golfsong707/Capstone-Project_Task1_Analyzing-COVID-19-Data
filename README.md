# ANALYZING COVID-19 DATA

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

This table provides a clear overview of the columns present in the `covid_data` table along with their descriptions and corresponding data types.

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
   - Data type of 'LastUpdate' changed to 'datetime' data type.
4. **Data Loading:**
   - Data was loaded using Python with the help of Psycopg2 and SQLAlchemy libraries to interact with PostgreSQL databases.
   - The DataFrame was written to a table named 'covid_19_data' using the 'to_sql' function.
5. **Running SQL Queries with PostgreSQL PG4 Admin:**
   - SQL queries were executed with the PostgreSQL PG4 Admin query tool.

## Requirements
- Python 3.x
- Pandas
- SQLAlchemy
- PostgreSQL

## SQL Queries Result Explanation


## Conclusion
In conclusion, the COVID-19 dataset was provided, extracted using the Pandas library, and stored in a DataFrame. A PostgreSQL database was created to serve as a centralized repository for easy access and analysis.

## Contribution and Feedback
Contributions are welcome to enhance and extend this ETL pipeline further. Feel free to submit pull requests, raise issues, or provide feedback to help us improve the project.
