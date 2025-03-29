select * from covid_deaths

--THIS DATASET STARTS FROM 2020 AND ENDS IN 2021. THEREFORE, ALL QUERIES ARE DONE WITH RESPECT TO THE AFOREMENTIONED YEAR.

--Death Percentage in Nigeria.
select locations, (sum(new_deaths::numeric)/sum(new_cases::numeric)*100||'%') as death_percentage 
from covid_deaths
where locations = 'Nigeria'
group by locations


--Death Percentage by Location.
select locations, (max(total_deaths::numeric)/max(total_cases::numeric)*100) as death_percentage 
from covid_deaths
where total_deaths is not null
group by locations
order by death_percentage desc


--Death Count by Location.
select locations, max(total_deaths)total_death_count
from covid_deaths
where total_deaths is not null
group by locations
order by total_death_count desc


--Total Death vs Cases in Continents.
select continent, sum(new_cases)total_cases, sum(new_deaths)total_deaths
from covid_deaths
where continent is not null
group by continent
order by total_cases desc


--Creating a Temporary View to aid certain analysis
create view location_analysis as
select continent, locations, total_cases, total_deaths, new_cases, new_deaths
from covid_deaths

--Total Cases in Africa.
select continent, sum(new_cases)total_cases
from location_analysis
where continent = ('Africa')
group by continent
order by 1 

--Total Cases in Nigeria.
select locations, sum(new_cases)total_cases
from location_analysis
where locations = 'Nigeria'
group by locations
order by 1


--Total Cases to Total Deaths in Nigeria.
select locations, sum(new_cases)total_cases, sum(new_deaths)total_deaths
from location_analysis
where locations = 'Nigeria'
group by locations
order by 1


--Total Cases and Total Deaths by Continents.
select continent, sum(new_cases)total_cases, sum(new_deaths)total_deaths
from location_analysis
where continent is not null
group by continent
order by total_cases desc


--Death Percentage by Continent.
select continent, sum(new_deaths::numeric)/sum(new_cases::numeric)*100||'%' as death_percentage_by_continent
from location_analysis
group by continent
order by death_percentage_by_continent desc


--Death Percentage by Locations.
select locations, sum(new_deaths::numeric)/sum(new_cases::numeric)*100||'%' as death_percentage_by_locations
from location_analysis
where new_cases is not null and new_deaths is not null
group by locations
order by death_percentage_by_locations desc


--Percentage of Total Cases by Nigerian Population.
select locations, (sum(new_cases::numeric)/(population::numeric))*100||'%' as percentage_of_total_cases_by_population
from covid_deaths
where locations = 'Nigeria'
group by locations, population
order by percentage_of_total_cases_by_population desc


--Countries with Highest Infection Rate by Population.
select locations, (max(total_cases::numeric)/population::numeric)*100 as percentage_of_infected_population
from covid_deaths
where population is not null and total_cases is not null
group by locations, population
order by percentage_of_infected_population desc


--Percentage of Deaths by Population.
select locations, population, sum(new_deaths)highest_death_count, (sum(new_deaths::numeric)/(population::numeric))*100 as percentage_of_death_by_population
from covid_deaths
where population is not null and new_deaths is not null
group by locations, population
order by percentage_of_death_by_population desc


--Countries with Highest Deaths by Population.
select locations, population, max(total_deaths)highest_death_count
from covid_deaths
where continent is not null and total_deaths is not null
group by locations, population
order by highest_death_count desc 


--Continents with Highest Death Count.
select continent, sum(new_deaths)highest_death_count
from covid_deaths
where continent is not null 
group by continent
order by highest_death_count desc 


--GLOBAL NUMBERS

--Total Cases on Each Day Across the World.
select dates, sum(new_cases)total_cases
from covid_deaths
where new_cases is not null
group by dates
order by total_cases desc


--World Death Percentage.
select sum(new_cases)total_cases, sum(new_deaths)total_deaths, (sum(new_deaths::int)/sum(new_cases::numeric))*100 as death_percentage
from covid_deaths
where continent is not null
order by 1


--To Calculate the Total Cases in the world
select sum(new_cases)total_cases
from covid_deaths
where continent is not null

