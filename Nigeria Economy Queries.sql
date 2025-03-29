create table nigeria_economy(
	year int,	
	inflation_rate numeric, 
	unemployment numeric,
	government_debt numeric,
	agriculture varchar,
	industry varchar,
	services varchar,
	gdp_at_2010_constant_basic_prices varchar,
	net_taxes_on_products varchar,	
	gdp_at_2010_constant_market_prices varchar
);

--Add other tables to be used for this analysis

create table obasanjo(
	year int,	
	inflation_rate numeric, 
	unemployment numeric,
	government_debt numeric,
	agriculture varchar,
	industry varchar,
	services varchar,
	gdp_at_2010_constant_basic_prices varchar,
	net_taxes_on_products varchar,	
	gdp_at_2010_constant_market_prices varchar
);


create table yar_adua(
	year int,	
	inflation_rate numeric, 
	unemployment numeric,
	government_debt numeric,
	agriculture varchar,
	industry varchar,
	services varchar,
	gdp_at_2010_constant_basic_prices varchar,
	net_taxes_on_products varchar,	
	gdp_at_2010_constant_market_prices varchar
);


create table goodluck_jonathan(
	year int,	
	inflation_rate numeric, 
	unemployment numeric,
	government_debt numeric,
	agriculture varchar,
	industry varchar,
	services varchar,
	gdp_at_2010_constant_basic_prices varchar,
	net_taxes_on_products varchar,	
	gdp_at_2010_constant_market_prices varchar
);


create table buhari(
	year int,	
	inflation_rate numeric, 
	unemployment numeric,
	government_debt numeric,
	agriculture varchar,
	industry varchar,
	services varchar,
	gdp_at_2010_constant_basic_prices varchar,
	net_taxes_on_products varchar,	
	gdp_at_2010_constant_market_prices varchar
);


select * from nigeria_economy


--1. What year was inflation at its highest? 
select year, (inflation_rate)*100||'%' as percentage_of_inflation_rate
from nigeria_economy
where year is not null
order by inflation_rate desc


--2. What year had the highest rate of unemployment?
select year, (unemployment)*100||'%' as unemployment_rate
from nigeria_economy
where year is not null
order by unemployment desc


--3. What year did agriculture fare best?
select year, concat('N ', agriculture) as agriculture
from nigeria_economy
where year is not null
order by agriculture desc


--4. What year was the total revenue from the 3 channels highest?
update nigeria_economy
set agriculture = replace(agriculture, ',', '')

update nigeria_economy
set industry = replace(industry, ',', '')

update nigeria_economy
set services = replace(services, ',', '')

select year, 'N'||sum(agriculture::numeric + industry::numeric + services::numeric)::text as total_sum
from nigeria_economy
where year is not null
group by year
order by total_sum desc

