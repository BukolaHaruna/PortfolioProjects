---DATA CLEANING IN SQL

--Create a table called nashville_housing.
create table nashville_housing(
	unique_id bigint,
	parcel_id varchar,
	land_use varchar,
	property_address varchar,
	sale_date date,
	sale_price varchar,
	legal_reference varchar,
	sold_as_vacant varchar,
	owner_name varchar,
	owner_address varchar,
	acreage numeric,
	tax_district varchar,
	land_value bigint,
	building_value bigint,
	total_value bigint,
	year_built bigint,
	bedrooms int,
	full_Bath int,
	half_Bath int
);

select * from nashville_housing


--Populating the Property Address
select a.parcel_id, a.property_address, b.parcel_id, b.property_address, coalesce(a.property_address,b.property_address)
from nashville_housing a
join nashville_housing b
	on a.parcel_id = b.parcel_id
	and a.unique_id <> b.unique_id
where a.property_address is null
--Updating nashville_housing to input b.property_address into the column for a.property_address.
update nashville_housing
set property_address = coalesce(a.property_address,b.property_address)
from nashville_housing a
join nashville_housing b
	on a.parcel_id = b.parcel_id
	and a.unique_id <> b.unique_id
where a.property_address is null
--Confirm if there are any null values in property_address after join using either query 1 or 2 below.
query1
select unique_id, parcel_id, property_address
from nashville_housing
where property_address = null

query2
select * from nashville_housing
order by unique_id where property_address = null



--Breaking out the Address column into address and city.
select 
substring(property_address, 1, position(',' in property_address) -1) as property_split_address,
substring(property_address, position(',' in property_address) +1, length(property_address)) as property_split_city
from nashville_housing

alter table nashville_housing
add property_split_address varchar

update nashville_housing
set property_split_address = substring(property_address, 1, position(',' in property_address) -1)

alter table nashville_housing
add property_split_city varchar 

update nashville_housing
set property_split_city = substring(property_address, position(',' in property_address) +1, length(property_address))


--Now breaking the owner address into address, city and state.
select 
split_part(owner_address, ',', 1),
split_part(owner_address, ',', 2),
split_part(owner_address, ',', 3)
from nashville_housing

alter table nashville_housing
add owner_split_address varchar

update nashville_housing
set owner_split_address = split_part(owner_address, ',', 1)

alter table nashville_housing
add owner_split_city varchar 

update nashville_housing
set owner_split_city = split_part(owner_address, ',', 2)

alter table nashville_housing
add owner_split_state varchar

update nashville_housing
set owner_split_state = split_part(owner_address, ',', 3)


--Changing Y and N to Yes and No respectively in the sold_as_vacant column.
select sold_as_vacant,
case
	when sold_as_vacant = 'Y' then 'Yes'
	when sold_as_vacant = 'N' then 'No'
	else sold_as_vacant
end
from nashville_housing

update nashville_housing
set sold_as_vacant = case
	when sold_as_vacant = 'Y' then 'Yes'
	when sold_as_vacant = 'N' then 'No'
	else sold_as_vacant
end
--to confirm
select distinct(sold_as_vacant), count(sold_as_vacant)
from nashville_housing
group by sold_as_vacant
order by count(sold_as_vacant)


--Deleting unused colums
--i dont want to delete data from my main table so i created a temporary table as temp_table and carried out the deleting so it doesn't affect my main table.
create table temp_table as
select * from nashville_housing
--the below query now represents how to delete unused columns using my temp_table
alter table temp_table drop column owner_address
alter table temp_table drop column property_address
alter table temp_table drop column acreage
alter table temp_table drop column tax_district
--run the query below to ensure selected colums have been deleted.
select* from temp_table