create table international_breweries(
	sales_id int,
	sales_rep varchar,
	emails varchar,
	brands varchar, 
	plant_cost numeric,
	unit_price numeric,
	quantity numeric,
	cost numeric,
	profit numeric,
	countries varchar,
	region varchar,
	months varchar,
	years int,
	territories varchar
);

select * from international_breweries


--SECTION A 
--PROFIT ANALYSIS 
--1. Within the space of the last three years, what was the profit worth of the breweries, inclusive of the anglophone and the francophone territories? 
select sum(profit)total_profit from international_breweries


--2. Compare the total profit between these two territories in order for the territory manager, Mr. Stone to make a strategic decision that will aid profit maximization in 2020. 
select territories, sum(profit)total_profit
from international_breweries
group by territories
order by total_profit desc


--3. What country generated the highest profit in 2019 
select years, countries, sum(profit)highest_profit
from international_breweries
where years = '2019'
group by countries, years
order by highest_profit desc limit 1


--4. Help him find the year with the highest profit. 
select years, sum(profit)highest_profit
from international_breweries
group by years
order by highest_profit desc limit 1


--5. Which month in the three years was the least profit generated? 
select years, months, sum(profit)least_profit
from international_breweries
group by years, months
order by least_profit asc limit 1


--6. What was the minimum profit in the month of December 2018? 
select years, months, min(profit)min_profit
from international_breweries
where months = 'December' and years = '2018'
group by years, months


--7. Compare the profit for each of the months in 2019 
select years, months, sum(profit)profit
from international_breweries
where years = '2019'
group by years, months
order by profit desc


--8. Which particular brand generated the highest profit in Senegal?
select countries, brands, sum(profit)highest_profit
from international_breweries
where countries = 'Senegal'
group by countries, brands
order by highest_profit desc limit 1


--SECTION B 
--BRAND ANALYSIS 
--1. Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries.
select brands as top_brands, sum(quantity)quantity_consumed
from international_breweries
where years in ('2018', '2019') and territories in ('Francophone')
group by brands
order by quantity_consumed desc limit 3


--2. Find out the top two choice of consumer brands in Ghana.
select brands as top_choice, sum(quantity)quantity_consumed
from international_breweries
where countries in ('Ghana')
group by brands
order by quantity_consumed desc limit 2


--3. Find out the details of beers consumed in the past three years in the most oil rich country in West Africa. 
select brands, sum(quantity)quantity_consumed, sum(cost)total_cost, sum(profit)total_profit
from international_breweries
where brands not in ('grand malt', 'beta malt') and countries in ('Nigeria')
group by brands
order by brands asc


--4. Favorite malt brand in Anglophone region between 2018 and 2019.
select brands as favorite_malt_brand, sum(quantity)quantity_consumed
from international_breweries
where years in ('2018', '2019') and territories in ('Anglophone') and brands in ('grand malt', 'beta malt')
group by brands
order by quantity_consumed desc limit 1


--5. Which brands sold the highest in 2019 in Nigeria?
select brands, sum(quantity)quantity_sold
from international_breweries
where years in ('2019') and countries in ('Nigeria')
group by brands
order by quantity_sold desc limit 1


--6. Favorite brand in South South region in Nigeria.
select brands as favorite_brand, sum(quantity)quantity_consumed
from international_breweries
where countries in ('Nigeria') and region in ('southsouth')
group by brands
order by quantity_consumed desc limit 1


--7. Bear consumption in Nigeria.
select sum(quantity)quantity_consumed
from international_breweries
where brands not in ('grand malt', 'beta malt') and countries in ('Nigeria')
order by quantity_consumed


--8. Level of consumption of Budweiser in the regions in Nigeria 
select brands, region, sum(quantity)quantity_consumed
from international_breweries
where countries in ('Nigeria') and brands in ('budweiser')
group by brands, region
order by quantity_consumed desc


--9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
select brands, region, sum(quantity)quantity_consumed
from international_breweries
where years in ('2019') and countries in ('Nigeria') and brands in ('budweiser')
group by brands, region
order by quantity_consumed desc


--SECTION C
--COUNTRIES ANALYSIS
--1. Country with the highest consumption of beer.
select countries, sum(quantity)quantity_consumed
from international_breweries
where brands not in ('grand malt', 'beta malt')
group by countries
order by quantity_consumed desc limit 1


--2. Highest sales personnel of Budweiser in Senegal.
select sales_rep, sum(quantity)quantity_sold
from international_breweries
where brands in ('budweiser') and countries in ('Senegal')
group by sales_rep
order by quantity_sold desc limit 1


--3. Country with the highest profit of the fourth quarter in 2019.
select countries, sum(profit)highest_profit
from international_breweries
where years in ('2019') and months in ('October', 'November', 'December')
group by countries
order by highest_profit desc limit 1
