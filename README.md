# Sql Analysis On The Covid 19 World Data


### Description

A lot has happened since the COVID outbreak in 2020, and ever since the vaccines were out, the pandemic itself has become a thing of the past. This project aims to gather information on the severity of the pandemic across the globe, especially in Nigeria. We'll figure out the chances of dying if you contact COVID, death percentages, the cumulative sum of vaccinated people versus the population and lots more.


### Prerequisites

- PostgreSQL 15 installed and configured. pgAdmin 4.
- COVID-19 dataset (csv) gotten from [Our World Data](https://ourworldindata.org/coronavirus).
- Microsoft Excel

### Getting Started

If you'd like to run my queries, you can download the datasets in the repository and perform your analysis on a Postgres server. After installing postgreSQL and pgAdmin, you'll have to create tables to house the datasets. The code for the table should look something like this
```sql
CREATE TABLE CovidDeaths (
	iso_code VARCHAR,
	continent VARCHAR,
    ....);
```
Check out this sql [file](https://github.com/niola-liberty/covid-sql-project/blob/main/tables%20import%20queries.sql) for more info. 
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

![select all covid deaths](https://github.com/niola-liberty/covid-sql-project/assets/82907562/ba5ff080-31ee-483a-b223-11569415039c)


#### Total cases vs total deaths
This shows the chances of dying if you contact covid in Nigeria 
```sql
select country,event_date, total_cases, total_deaths, (total_deaths/total_cases)*100 death_percentage
FROM coviddeaths
WHERE country = 'Nigeria'
ORDER BY 1,2
```
![death percentages ng](https://github.com/niola-liberty/covid-sql-project/assets/82907562/4cb96eb0-f062-431a-a98d-18b1363d5759)

<u>This shows that the average rate of dying if you contact covid in Nigeria is 3%.</u>

#### Global Numbers
Now let's check out the death percentage globally
```sql
SELECT event_date, SUM(new_cases) global_total_cases, SUM(new_deaths) global_total_deaths, sum(new_deaths)/sum(new_cases)*100 global_deaths_precentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY event_date
ORDER BY 1,2
```
![global death percent](https://github.com/niola-liberty/covid-sql-project/assets/82907562/35d90684-2a51-40a1-8c2b-ab4cc02c6187)

The average covid deaths globally appears to be 4%.

#### Covid Vaccinations
Let's take a look at the vaccination table.
```sql
SELECT * 
FROM CovidVaccinations 

```
![select all vaccine](https://github.com/niola-liberty/covid-sql-project/assets/82907562/81e08752-71fd-4394-bae0-618f8fcc8198)

#### Joining the COVID deaths table with the covid vaccination table
Let's add both tables together to further our analysis.
```sql
SELECT *
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
	  
```
![death vaccince join](https://github.com/niola-liberty/covid-sql-project/assets/82907562/34c8e163-6177-4b9d-8d4f-839d98eecb2e)

#### Cummulative sum of vaccinated people in Nigeria
```sql
SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) cummulative_vaccinated_sum
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
WHERE dea.country= 'Nigeria'	
ORDER BY 1,2	
```
#### Total Population vs Vaccinations
Let's find the total populations vs vaccinations.To do this we'd have to use a CTE as the cummulative_vaccinated_sum column doesn't exist in the table

```sql
WITH PopVsVac (Continent, Country, Date, Population, New_vaccinations, Total_Vaccinated)
AS
(
    SELECT 
        dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations,
        SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) AS cummulative_vaccinated_sum
    FROM coviddeaths dea
    JOIN covidVaccinations vac
    ON dea.country = vac.country
    AND dea.event_date = vac.event_date
)
SELECT *
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 3, 4;

```
![pop vs vac cte](https://github.com/niola-liberty/covid-sql-project/assets/82907562/ed94ffd9-d538-405f-baa7-a2495cb6a8d0)

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


