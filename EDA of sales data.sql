show databases;
use eda;
show tables;
-- Exploratory Data Analysis and answering some of the basic questions from the sales data

select * from eda;


-- altering table's name from eda to sales_data
alter table eda rename to sales_data;


-- getting the whole schema of the table
desc sales_data;
select * from sales_data;



-- Working on the date Datatypes


-- now, lets start eda by seeing what is the max day difference between the ship and the ordered data
select max(datediff(`Ship Date`,`Order Date`)) as max_diff
from sales_data
where `Ship Date` is not null AND `Order Date` is not null;
-- this will not work as the datatype of the ship and order date is not date or datetime and the below error will be shown
-- Error Code: 1292. Incorrect date value: '11-11-2017' for column 'Ship Date' at row 1

desc sales_data;
alter table sales_data modify `Ship Date` DATETIME;

-- addding two new column into the sales_data table 
alter table sales_data add column ship_date datetime;
alter table sales_data add column order_date datetime;

-- updating the datatype of both the ship and ordered date
update sales_data set ship_date = str_to_date(`Ship Date`,'%d-%m-%Y') where `Ship Date` is not null;
--  The above query will also not work and will show Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- To solve that change the setting 
set SQL_SAFE_UPDATES = 0;

-- Now updating the data types of newly created columns and dropping the previous Ship Date and Order Date Columns 
update sales_data set ship_date = str_to_date(`Ship Date`,'%d-%m-%Y') where `Ship Date` is not null and `Row ID` is not null;
alter table sales_data drop column `Ship Date`;

update sales_data set order_date = str_to_date(`Order Date`,'%d-%m-%Y') where `Order Date` is not null and `Row ID` is not null;
alter table sales_data drop column `Order Date`;

select * from sales_data;
--  Changing the date format
update sales_data set ship_date = str_to_date(ship_date,'%Y-%m-%d %H:%i:%s');
update sales_data set ship_date = str_to_date(order_date,'%Y-%m-%d %H:%i:%s');

-- Checking the difference between the two date column with datediff function
select datediff(DATE(ship_date),DATE(order_date)) as date_diff from sales_data where ship_date is not null and order_date is not null;

-- Verifying if the shipping  and ordering date is SAME
select COUNT(*) from sales_data where ship_date = order_date;

-- Creating a new column with the name of Same Day Delivery
SELECT 
    case 
        when DATEDIFF(DATE(ship_date), DATE(order_date)) = 0 then 'Same Day Delivery' else 'More than a day' 
    end as 'Delivery Day'
from sales_data where ship_date is not null AND order_date is not null;

alter table sales_data add column delivery_day varchar(30);

update sales_data set delivery_day = CASE 
        when DATEDIFF(DATE(ship_date), DATE(order_date)) = 0 then 'Same Day Delivery'
        else 'More than a day' 
		end
		where ship_date is not null and order_date is not null; 
select * from sales_data; 






-- For Checking the distint values from the particular column 
select count(distinct(`Customer Name`)) as count_of_customer_name from sales_data;

select count(distinct(`City`)) as count_of_city from sales_data;

select count(distinct(`State`)) as count_of_state from sales_data;

-- City wise categorical distribution of ordered stuff from table
select `Category`, count(`Category`) as no_of_order_by_category , `City` from sales_data group by `Category`, `City`;


-- Q1 City with max orders
select count(`Order ID`) as count_of_orders, city from sales_data group by city order by count_of_orders desc limit 1 ;

-- Q2 Top 5 City with min orders
select count(`Order ID`) as count_of_orders, city from sales_data group by city order by count_of_orders,city limit 5;

-- Q3 Most ordered item and in which category
select `Category`,`Sub-Category`, count(`Order ID`)as most_ordered from sales_data group by `Sub-Category`,`Category` order by most_ordered desc limit 1;
 
 
--  Q4 What are the different shipping modes
select distinct `Ship Mode` from sales_data;

-- Q5 Most ordered product where the state is new york
select `Product Name` , count(`Product Name`) from sales_data where `State` = 'New York' group by `Product Name`;


