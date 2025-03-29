--DATA EXPLORATION WITH SQL

select * from covid_vaccinations


--Total Vaccination vs Population.
--Create a joint table to achieve this.
select *
from covid_deaths a
join covid_vaccinations b
	on a.locations = b.locations
	and a.dates = b.dates
	
	
--we can now extract the data for new vaccinations by locations.
select a.continent, a.locations, a.dates, a.population, b.new_vaccinations
from covid_deaths a
join covid_vaccinations b
	on a.locations = b.locations
	and a.dates = b.dates
where a.continent is not null
order by 2,3


--then, we can also extract the data for total new vaccinations by date.
select a.continent, a.locations, a.dates, a.population, b.new_vaccinations, sum(b.new_vaccinations::numeric)
over (partition by a.locations order by a.locations, a.dates) as rolling_people_vaccinated
from covid_deaths a
join covid_vaccinations b
	on a.locations = b.locations
	and a.dates = b.dates
where a.continent is not null
order by 2,3


--Percentage of Rolling People Vaccinated by Population.
--use CTE
with PopvsVac (continent, locations, dates, population, new_vaccinations, rolling_people_vaccinated)
as
(
select a.continent, a.locations, a.dates, a.population, b.new_vaccinations, sum(b.new_vaccinations::numeric) 
over (partition by a.locations order by a.locations, a.dates) as rolling_people_vaccinated
from covid_deaths a
join covid_vaccinations b
	on a.locations = b.locations
	and a.dates = b.dates
where a.continent is not null
group by a.continent, a.locations, a.dates, a.population, b.new_vaccinations
)
select locations, dates, population, new_vaccinations, rolling_people_vaccinated, (rolling_people_vaccinated/population)*100 as percentage_of_rolling_people_vaccinated 
from PopvsVac


--To find the Percentage of maximum rolling people vaccinated by location.
with PopvsVac (continent, locations, dates, population, new_vaccinations, rolling_people_vaccinated)
as
(
select a.continent, a.locations, a.dates, a.population, b.new_vaccinations, sum(b.new_vaccinations::numeric) 
over (partition by a.locations order by a.locations, a.dates) as rolling_people_vaccinated
from covid_deaths a
join covid_vaccinations b
	on a.locations = b.locations
	and a.dates = b.dates
where a.continent is not null
group by a.continent, a.locations, a.dates, a.population, b.new_vaccinations
)
select locations, population, max(rolling_people_vaccinated)max_rolling_people_vaccinated,
max((rolling_people_vaccinated/population)*100) as percentage_of_max_rolling_people_vaccinated 
from PopvsVac
where rolling_people_vaccinated is not null
group by locations, population
order by percentage_of_max_rolling_people_vaccinated desc

