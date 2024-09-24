create database project_1;
USE project_1;
create table retail_sales(
transactions_id int primary key, 
sale_date DATE,
sale_time Time ,
customer_id int,
gender varchar(15),
age int,
category varchar(20),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);
drop Table retail_sales;
select *from retail_sales;
select *from retail_sales where age is null;


-- how many sales we have?
select count(*) as total_sale from retail_sales;

-- how many unique customers we have

select count(distinct customer_id) from retail_sales;

-- data analysis

-- Q1 write a SQL query to retrive all colums for sales made on '2022-22-05

select*from retail_sales where sale_date='2022-11-05';

-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select *from retail_sales
where category = 'clothing' and  
format(sale_date,'YYYY-MM') = '2022-11'
and quantiy>=4;

-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.:
select sum(total_sale),category from retail_sales
group by category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select round(avg(age),2)from retail_sales
where category = 'Beauty';

-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select*from retail_sales where total_sale > 1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select category,count(transactions_id) from retail_sales
group by gender , category;

-- Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select year,month,avg_sale from (
select 
extract(year from sale_date) as year,
extract(month from sale_date ) as month,
avg(total_sale) as avg_sale
from retail_sales
group by year,month
order by avg_sale desc)
as t1;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id, sum(total_sale) as total_sales
from retail_sales 
group by customer_id
order by total_sales desc
limit 5;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.:

select category, count(distinct customer_id) from retail_sales
group by category;

-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


SELECT 
  shifts,
  COUNT(*) as no_of_orders
FROM (
  SELECT
    EXTRACT(hour FROM sale_time) AS hours,
    CASE 
      WHEN EXTRACT(hour FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(hour FROM sale_time) >= 12 AND EXTRACT(hour FROM sale_time) < 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shifts
  FROM retail_sales
) AS subquery
GROUP BY shifts;



