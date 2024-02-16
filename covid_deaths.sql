select * from covid_deaths

--THIS DATASET STARTS FROM 2020 AND ENDS IN 2021. THEREFORE, ALL QUERIES ARE DONE WITH RESPECT TO THE AFOREMENTIONED YEAR.

--Death Percentage in Nigeria.
select locations, dates, total_cases, total_deaths, (total_deaths::numeric/total_cases::numeric)*100||'%' as death_percentage 
from covid_deaths
where locations = 'Nigeria'

--Death Percentage by Location.
select locations, dates, total_cases, total_deaths, sum(total_deaths::numeric)/sum(total_cases::numeric)*100||'%' as death_percentage 
from covid_deaths
group by locations, dates, total_cases, total_deaths
order by 1

--Total Death per Cases.
select continent, sum(total_cases)total_cases, sum(total_deaths)total_deaths
from covid_deaths
group by continent, total_cases, total_deaths
order by 1

--Creating a Temporary View to aid certain analysis
create view location_analysis as
select continent, locations, total_cases, total_deaths
from covid_deaths

--Total Cases in Africa.
select continent, sum(total_cases)total_cases
from location_analysis
where continent = ('Africa')
group by continent
order by 1

--Total Cases in Nigeria as at 2021.
select locations, sum(total_cases)total_cases
from location_analysis
where locations = 'Nigeria'
group by locations
order by 1

--Total Cases to Total Deaths in Nigeria as at 2021.
select locations, sum(total_cases)total_cases, sum(total_deaths)total_deaths
from location_analysis
where locations = 'Nigeria'
group by locations
order by 1

--Total Cases and Total Deaths by Continents.
select continent, concat(sum(total_cases))total_cases, concat(sum(total_deaths))total_deaths
from location_analysis
group by continent
order by 1, 2

--update covid_deaths
--set continent = antarctica
--where continent = NULL

--select replace(continent, '[null]', 'Antarctica')
--from covid_deaths

--Death Percentage by Continent.
select continent, sum(total_deaths::numeric)/sum(total_cases::numeric)*100||'%' as death_percentage_by_continent
from location_analysis
group by continent
order by death_percentage_by_continent desc

--Death Percentage by Locations.
select locations, sum(total_deaths::numeric)/sum(total_cases::numeric)*100||'%' as death_percentage_by_locations
from location_analysis
group by locations
order by 1

--Percentage of Total Cases by Nigerian Population.
select locations, (sum(total_cases::numeric)/sum(population::numeric))*100||'%' as percentage_of_total_cases_by_population
from covid_deaths
where locations = 'Nigeria'
group by locations
order by percentage_of_total_cases_by_population desc

--Countries with Highest Infection Rate by Population.
select locations, population, max(total_cases)highest_infection_count, max(total_cases::numeric/population::numeric)*100 as percentage_of_affected_population
from covid_deaths
group by locations, population
order by percentage_of_affected_population desc

--Percntage of Deaths per Population.
select locations, population, max(total_deaths)highest_death_count, max(total_deaths::numeric/population::numeric)*100 as percentage_of_death_by_population
from covid_deaths
group by locations, population
order by percentage_of_death_by_population desc

--Countries with Highest Deaths by Population.
select locations, population, max(total_deaths)highest_death_count
from covid_deaths
where continent is not null 
group by locations, population
order by highest_death_count desc 

--Continents with Highest Death Count.
select locations, max(total_deaths)highest_death_count
from covid_deaths
where continent is null 
group by locations
order by highest_death_count desc 


--GLOBAL NUMBERS

--Total Sum of New Cases on Each Day Across the World.
select dates, sum(new_cases)total_new_cases
from covid_deaths
where continent is not null
group by dates
order by 1

--World Death Percentage.
select dates, sum(new_cases)total_cases, sum(new_deaths)new_deaths, sum(new_deaths::int)/sum(new_cases)*100 as world_death_percentage
from covid_deaths
where continent is not null
group by dates
order by 1

--To Calculate the Total Cases in the world
select sum(new_cases)total_cases, sum(new_deaths)new_deaths, sum(new_deaths::int)/sum(new_cases)*100 as world_death_percentage
from covid_deaths
where continent is not null

