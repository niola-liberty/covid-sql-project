SELECT * 
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 3,4


select country,event_date, total_cases, new_cases, total_deaths, 
FROM coviddeaths
ORDER BY 1,2


-- Total cases vs total deaths
-- This shows the chances of dying if you contact covid in Nigeria 

select country,event_date, total_cases, total_deaths, (total_deaths/total_cases)*100 death_percentage
FROM coviddeaths
WHERE country = 'Nigeria'
ORDER BY 1,2

-- Total cases vs Population
-- This shows the percentage of Nigerians that got covid

select country,event_date, population, total_cases,  (total_cases/population)*100 infected_percentage
FROM coviddeaths
WHERE country = 'Nigeria'
ORDER BY 1,2

-- Countries with the highest infection rate compared to population

select country, population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS infected_percentage 
FROM coviddeaths  
GROUP BY country, population
ORDER BY infected_percentage DESC

-- This show the countries with the highest death count per population


select country, MAX(total_deaths) AS TotalDeathsCount
FROM coviddeaths  
WHERE continent IS NOT NULL
GROUP BY country
ORDER BY TotalDeathsCount DESC

-- Now let's check out the continents

select continent, MAX(total_deaths) AS TotalDeathsCount
FROM coviddeaths  
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

--This shows continents with the highest death counts per population

select continent, MAX(total_deaths) AS TotalDeathsCount
FROM coviddeaths  
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

-- Global Numbers
SELECT event_date, SUM(new_cases) global_total_cases, SUM(new_deaths) global_total_deaths, sum(new_deaths)/sum(new_cases)*100 global_deaths_precentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY event_date
ORDER BY 1,2

-- Total global numbers without date
SELECT  SUM(new_cases) global_total_cases, SUM(new_deaths) global_total_deaths, sum(new_deaths)/sum(new_cases)*100 global_deaths_precentage 
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2
-- From this query, out of over a 150 million people that got infect with covid, only 2.11% percent died (3180206)

--Let's take a look at the covid vaccination table

SELECT * 
FROM CovidVaccinations 

--Now let's join it with the covid deaths table

SELECT *
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
	  
-- Let's find out the cummulative sum of people that have been vaccinated in each country 

SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) cummulative_vaccinated_sum 
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
ORDER BY 1,2	

-- Now let's specify for Nigeria

SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) cummulative_vaccinated_sum
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
WHERE dea.country= 'Nigeria'	
ORDER BY 1,2	





-- Total cases vs total deaths
-- This shows the chances of dying if you contact covid in Nigeria 

select country,event_date, total_cases, total_deaths, (total_deaths/total_cases)*100 death_percentage
FROM coviddeaths
WHERE country = 'Nigeria'
ORDER BY 1,2

-- Total cases vs Population
-- This shows the percentage of Nigerians that got covid

select country,event_date, population, total_cases,  (total_cases/population)*100 infected_percentage
FROM coviddeaths
WHERE country = 'Nigeria'
ORDER BY 1,2

-- Countries with the highest infection rate compared to population

select country, population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS infected_percentage 
FROM coviddeaths  
GROUP BY country, population
ORDER BY infected_percentage DESC

-- This show the countries with the highest death count per population


select country, MAX(total_deaths) AS TotalDeathsCount
FROM coviddeaths  
WHERE continent IS NOT NULL
GROUP BY country
ORDER BY TotalDeathsCount DESC

-- Now let's check out the continents

select continent, MAX(total_deaths) AS TotalDeathsCount
FROM coviddeaths  
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

--This shows continents with the highest death counts per population

select continent, MAX(total_deaths) AS TotalDeathsCount
FROM coviddeaths  
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC

-- Global Numbers
SELECT event_date, SUM(new_cases) global_total_cases, SUM(new_deaths) global_total_deaths, sum(new_deaths)/sum(new_cases)*100 global_deaths_precentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY event_date
ORDER BY 1,2

-- Total global numbers without date
SELECT  SUM(new_cases) global_total_cases, SUM(new_deaths) global_total_deaths, sum(new_deaths)/sum(new_cases)*100 global_deaths_precentage 
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2
-- From this query, out of over a 150 million people that got infect with covid, only 2.11% percent died (3180206)

--Let's take a look at the covid vaccination table

SELECT * 
FROM CovidVaccinations 

--Now let's join it with the covid deaths table

SELECT *
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
	  
-- Let's find out the cummulative sum of people that have been vaccinated in each country 

SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) cummulative_vaccinated_sum 
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
ORDER BY 1,2	

-- Now let's specify for Nigeria

SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) cummulative_vaccinated_sum
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date
WHERE dea.country= 'Nigeria'	
ORDER BY 1,2	

-- Let's find the total populations vs vaccinations. 
-- To do this we'd have to use a temp table as the cummulative_vaccinated_sum column doesn't exist in the table
-- using CTE

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

SELECT country, event_date, total_cases, new_cases, total_deaths
FROM coviddeaths
ORDER BY 1, 2;

		   
--Temp Table
CREATE TABLE PercentPopulationsVaccinated
(
    continent varchar,
    country  varchar,
    event_date date,
    population numeric,
    new_vaccinations numeric,
    cummulative_vaccinated_sum numeric
);

INSERT INTO PercentPopulationsVaccinated
SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) as cummulative_vaccinated_sum 
FROM coviddeaths dea
JOIN covidVaccinations vac
    ON dea.country = vac.country
    AND dea.event_date = vac.event_date;

SELECT *, (cummulative_vaccinated_sum/population)*100
FROM PercentPopulationsVaccinated;

		   
-- Creating Views
		   
CREATE VIEW percentPopulationVaccinated as
SELECT dea.continent, dea.country, dea.event_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY dea.country ORDER BY dea.country, dea.event_date) as cummulative_vaccinated_sum 
FROM coviddeaths dea
JOIN covidVaccinations vac
	ON dea.country = vac.country
	AND dea.event_date = vac.event_date		   
		   
SELECT *, (cummulative_vaccinated_sum/percentpopulationvaccinated.population)*100 percentPopulationVaccinated
FROM percentPopulationVaccinated
		   
-- And that ends the analysis :)