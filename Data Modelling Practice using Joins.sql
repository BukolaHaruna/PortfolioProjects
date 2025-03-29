select sales.customer_id as customer_id, 
	customers.name as name, 
	customers.location as location, 
	sum(amount) total_amount
from sales
join customers on sales.customer_id = customers.customer_id
group by sales.customer_id, customers.name, customers.location
order by customer_id
;