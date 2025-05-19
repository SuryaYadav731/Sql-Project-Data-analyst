--Monday coffee database
select * from city
select * from products
select * from customers
select * from sales


-- Reports and data analysis
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

select city_name, Round((population * 0.25)/ 1000000,2) as coffee_consume_in_millon, city_rank from city
order by 2 desc

--02 Toatl Revenue from coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023
select 
    ci.city_name,
    sum(total) as total_revenue
from sales as s
join customers as c
on s.customer_id = c.customer_id
join city as ci
on ci.city_id = c.city_id
where 
    EXTRACT(Year from sale_date)= 2023
	AND
	EXTRACT(quarter from sale_date)= 4
group by 1
order by 2 desc

--03 
--Sales Count for Each Product
--How many units of each coffee product have been sold?

 select p.product_name,
 count(s.sale_id) as total_orders
 from products as p
 left join
 sales as s
 on s.product_id = p.product_id
 group by 1
 order by 2


 --04
 --Average Sales Amount per City
 --What is the average sales amount per customer in each city?

--city and total sale
--number customer in each these city
select ci.city_name,
    sum(total) as total_revenue,
	count(DISTINCT s.customer_id) as total_cust,
	Round(sum(total)::numeric/count(DISTINCT s.customer_id)::numeric,2) as average_sale_customer
from sales as s
join customers as c
on s.customer_id = c.customer_id
join city as ci
on ci.city_id = c.city_id
group by 1
order by 2 desc

--05
--City Population and coffee consumerss
--provide a list of cities along with their populations and estimated coffee consumers.
--return city_name, total current customer, estimated coffee consumer(25%)

With city_table as
(select city_name,
      ROUND((population * 0.25)/1000000,2) as coffee_consumers
	  from city
),
customers_table
as
(select 
  ci.city_name,
  count(distinct c.customer_id) as unique_cust
from sales as s
join customers as c
on c.customer_id = s.customer_id
join city  as ci
on ci.city_id = c.city_id
group by 1)

select ct.city_name,
       ct.coffee_consumers as coff_cust_in_mill,
	   cit.unique_cust
from city_table as ct
join
customers_table as cit
on cit.city_name = ct.city_name
	   

--06 
--Top Selling Products by city
-- What are the top 3 selling product in each city based on sales volume
select * from
(
select ci.city_name,
        p.product_name,
		Count(s.sale_id) as total_orders,
		dense_rank() over(partition by ci.city_name order by count(s.sale_id) desc) as rank
from sales as s
join products as p
on s.product_id = p.product_id
join customers as c
on c.customer_id = s.customer_id
join city as ci
on ci.city_id = c.city_id
group by 1,2 
) as t1
where rank <=3


--07 
--Customer segmentation by city
--How many unique customers are there in each city who have purchased coffee products?

select ci.city_name,
      count(distinct c.customer_id) as unique_cust
      from city as ci
left join 
customers as c
on c.city_id = ci.city_id
join sales as s
on s.customer_id = c.customer_id
where s.product_id in (1,2,3,4,5,6,7,8,9,10,11,12,13,14)
group by 1

--08
--Average sale vs rent
--find each city and their average sale per customer and average rent per customer
select *
      from city as ci
left join 
customers as c
on c.city_id = ci.city_id
join sales as s
on s.customer_id = c.customer_id



