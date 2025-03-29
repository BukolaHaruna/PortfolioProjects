--World Death Percentage.
select sum(new_cases)total_cases, sum(new_deaths)total_deaths, sum(new_deaths::int)/sum(new_cases)*100 as death_percentage
from covid_deaths
where continent is not null
order by 1


--Total Death Count.
select locations, sum(new_deaths)total_death_count
from covid_deaths
where continent is null and locations not in ('World', 'European Union', 'International')
group by locations
order by total_death_count desc


--Countries with Highest Infection Rate by Population.
select locations, population, max(total_cases::numeric)highest_infection_count, max(total_cases::numeric/population::numeric)*100 as percentage_of_infected_population
from covid_deaths
group by locations, population
order by percentage_of_infected_population desc


--Countries with Highest Infection Rate by Date.
select locations, population, dates, max(total_cases::numeric)highest_infection_count, max(total_cases::numeric/population::numeric)*100 as percentage_of_infected_population
from covid_deaths
group by locations, population, dates
order by percentage_of_infected_population desc
