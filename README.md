# Sql Analysis On The Covid 19 World Data


### Description

A lot has happened since the covid outbreak in 2020, and ever since the vaccinces were out, the pandemic itself has become a thing of the past. This project is aims to gather information on the severity of the pandemic across the globe and especially Nigeria. We'll figure out chances of dying if you contact covid, death percentages, cummulative sum of vaccinated people verses the population and lots more.


### Prerequisites

- PostgreSQL 15 installed and configured. pgAdmin 4.
- COVID-19 dataset (csv) gotten from ______.
- Microsoft Excel

### Getting Started

If you'd like to run my queries, you can download the datasets in the repository and perform your analysis on a Postgres server. After installing postgreSQL and pgAdmin, you'll have to create tables to house the datasets. The code for the table should look something like this
```sql
CREATE TABLE CovidDeaths (
	iso_code VARCHAR,
	continent VARCHAR,
    ....);
```
Check out this sql file(link:) for more info. 
NB: I changed the 'location' column to 'country' and the 'date' coloumn to 'event_date'.

After that, populate the table by importing the dataset into it. Easy pesy ;)

### SQL Queries

Provide a detailed explanation of the SQL queries you've written. Describe the purpose of each query, the tables it interacts with, and the expected output. Use code blocks to format your queries for clarity.
Now let's get into a few queries. But first, an overview of the covid deaths table;
```sql
SELECT * 
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 3,4
```

```picture of qurey result```

Total cases vs total deaths
This shows the chances of dying if you contact covid in Nigeria 
```sql
select country,event_date, total_cases, total_deaths, (total_deaths/total_cases)*100 death_percentage
FROM coviddeaths
WHERE country = 'Nigeria'
ORDER BY 1,2
```
![death percentages ng](https://github.com/niola-liberty/covid-sql-project/assets/82907562/4cb96eb0-f062-431a-a98d-18b1363d5759)


```sql
-- Example SQL Query 1: Calculate total COVID-19 cases by country
SELECT country, SUM(total_cases) AS total_cases
FROM covid_data
GROUP BY country;
```

```sql
-- Example SQL Query 2: Calculate the daily new cases
SELECT country, event_date, new_cases
FROM covid_data
WHERE country = 'United States'
ORDER BY event_date;
```

### Results

Share the results or insights you obtained from running your SQL queries. Use tables, charts, or visualizations to present the data effectively.


### Acknowledgments

Thank any sources of data, tools, or libraries you used in your analysis. Give credit to any individuals or organizations that inspired or supported your work.
datacamp and alex the analyst

### Contact Information

Provide contact information or a way for users to reach out to you for questions or feedback related to your project.

### Additional Sections (Optional)

Depending on the complexity and scope of your project, you can include additional sections such as:

- Troubleshooting: Common issues users might encounter and how to resolve them.
- FAQ: Frequently asked questions and their answers.
- Future Work: Mention any future improvements or extensions you plan to make to the project.


