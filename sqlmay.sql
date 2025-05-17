--SQL Retail Sales Analysis 

--Create Table

Create Table Sales(
  transaction_id  INT PRIMARY KEY,
  sale_date DATE,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(15),
  age INT,
  category VARCHAR(15),
  quantity INT,
  price_per_unit FLOAT,
  cogs FLOAT,
  total_sale FLOAT
  
)

select * from Sales
limit 10

select count(*) from Sales


select * from Sales
where transaction_id is null


select * from Sales
where sale_date is null


select * from Sales
where sale_time is null


select * from Sales
where customer_id is null

select * from Sales
where gender is null

select * from Sales
where 
  age is null
  or
  category is null
  or
  quantity is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null

delete from Sales
  
  where 
  age is null
  or
  category is null
  or
  quantity is null
  or
  price_per_unit is null
  or
  cogs is null
  or
  total_sale is null

select count(*) from Sales

--Data Exploration
-- How many sales we have

select count(*) as total_saless from Sales

-- How many customer we have?
select count(distinct customer_id) as total_saless from sales

select distinct category from sales

-- DATA Analysis  and bussiness problem
--write  a sql query to retrive all column for sales  made on "2022-11-05"

select * from Sales
where sale_date = '2022-11-05'

--02 Write  a sql query to retrive all transaction where the category is cleaning and the quantity sold is more than 10 in the month of nov-2022

select * from Sales
where category  = 'Clothing' and To_CHAR(sale_date,'YYYY-MM')='2022-11'
and  quantity  >= 4

--03 write a sql query to calculate the total sales  for each category
select category, sum(total_sale) as cate_sum,  count(*) as Total_order from Sales
group by 1

--04  write  as sql query to find the average age of customer  who purchased items the "beauty " category
select Round(Avg(age),2) as Avg_age from Sales
where category = 'Beauty'


--05 write a sql query to find all transaction where the total_ sale is greater than 1000

select  * from Sales
where total_sale >1000

--06 write  a sql query to find the total number of transaction (transaction_id ) made by each gender in each category

select category, gender, count(*) as total_trans from sales
group by category, gender
order by 1

--07 write  a sql query to calculate the average sale for each month. find out best selling month in each year
select extract(year from sale_date) as year,
extract(month from sale_date) as month, 
avg(total_sale) from Sales
group by 1, 2
order by 1, 2