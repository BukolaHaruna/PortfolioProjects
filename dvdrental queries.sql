--Queries showing the use of basic commands/aggregations in SQL.
select last_name, last_update from actor 
select count (first_name) as count_of_first_names from actor
select * from payment
select sum (amount) as total_amount from payment
select max (amount) as max_amount_paid from payment
select avg (amount) as avg_amount_paid from payment
select * from actor where actor_id >2 and actor_id <5
select * from actor where actor_id <5 or actor_id >2
select * from actor where actor_id != 5


--I.Total amount paid by customers that paid above $5.
select sum (amount) as total_amount from payment where amount >5

--II.Total number of customers in the payment table.
select count (customer_id) as total_no_of_customers from payment

--III.Number of distinct staff id in the payment table.
select count (distinct staff_id) as distinct_staff_id from payment

--A query showing the use of IN and BETWEEN operators.
select * from actor where actor_id in (2,3,4,5)
select * from actor where actor_id between 5 and 10


--An example showing how to use the CASE clause.
select actor_id,
case
	when actor_id = 2 then 'actor 2'
	when actor_id = 3 then 'actor 3'
	else 'not actor 2 or 3'
end as actor_name from actor


--Movies with rating as PG.
select film_id, title, rating from film
where rating = 'PG'


--Movies with rating as PG, PG-13 and NC-17.
select film_id, title, rating from film
where rating in ('PG', 'PG-13', 'NC-17')
order by film_id, rating


--An example showing how to use the ORDER BY command.
select film_id, title, rating from film
order by film_id, rating


--Creating a view 
create view customers_payment as
select first_name, last_name, amount
from customer, payment





