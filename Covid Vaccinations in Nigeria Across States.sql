create table covid_vaccination_in_nigeria(
	states varchar,	
	population varchar,
	total_vaccinated_population bigint,
	first_dose varchar,
	second_dose_fully_vaccinated varchar
);
	
select * from covid_vaccination_in_nigeria

--1.	State with the highest number of vaccinated people.
--I had to update my table to remove the commas so that it can carry out aggregate functions smoothly.
update covid_vaccination_in_nigeria
set population = replace(population, ',', '')

update covid_vaccination_in_nigeria
set first_dose = replace(first_dose, ',', '')

update covid_vaccination_in_nigeria
set second_dose_fully_vaccinated = replace(second_dose_fully_vaccinated, ',', '')

select states, second_dose_fully_vaccinated::numeric
from covid_vaccination_in_nigeria
order by second_dose_fully_vaccinated desc limit 1


--2.	Population vs fully vaccinated people.
select states, population::numeric, second_dose_fully_vaccinated::numeric
from covid_vaccination_in_nigeria
order by population desc


--3.	How many people did not go back for the second dose?
select states, population::numeric, ((first_dose::numeric) - (second_dose_fully_vaccinated::numeric))population_not_fully_vaccinated
from covid_vaccination_in_nigeria
order by population desc


--4.	How many states had same number of people for first dose and second dose?
select states, population::numeric, first_dose::numeric, second_dose_fully_vaccinated::numeric
from covid_vaccination_in_nigeria
where first_dose = second_dose_fully_vaccinated
order by second_dose_fully_vaccinated, first_dose