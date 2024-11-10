show databases;
use concepts;
show tables;
drop table if exists housing;
create table housing (
	house_id int , 
    pincode int ,
    constraint chk_pincode check (length(pincode)=7),
    available boolean default True,
    city varchar(20),
    city_id int not null,
    primary key (house_id)
);

desc housing;

drop table if exists house_details;

create table house_details (
id int auto_increment,
primary key(id),
property_type VARCHAR(50) NOT NULL, 
num_bedrooms INT CHECK (num_bedrooms >= 0), 
num_bathrooms INT CHECK (num_bathrooms >= 0),
furnished BOOLEAN DEFAULT FALSE,
contact_email VARCHAR(100),
contact_phone VARCHAR(15),
house_id int,
foreign key (house_id) references housing (house_id)
);

desc house_details;

create table customers (
	cust_id int not null, 
    primary key (cust_id),
    id int ,
    foreign key (id) references house_details(id), 
    paying_per_month float not null, 
    customer_name varchar(50) not null,
    pincode int, 
	constraint chk_pin check (length(pincode)=7)

);

desc customers;

INSERT INTO housing (house_id, pincode, available, city, city_id) VALUES
(1, '4000010', TRUE, 'Mumbai', 101),
(2, '1100012', FALSE, 'Delhi', 102),
(3, '5600013', TRUE, 'Bangalore', 103),
(4, '5000814', TRUE, 'Hyderabad', 104),
(5, '3800015', FALSE, 'Ahmedabad', 105),
(6, '6000016', TRUE, 'Chennai', 106),
(7, '7000017', TRUE, 'Kolkata', 107),
(8, '3950018', FALSE, 'Surat', 108),
(9, '4110019', TRUE, 'Pune', 109),
(10, '3020010', FALSE, 'Jaipur', 110),
(11, '2260011', TRUE, 'Lucknow', 111),
(12, '2080012', TRUE, 'Kanpur', 112),
(13, '4400013', FALSE, 'Nagpur', 113),
(14, '4520014', TRUE, 'Indore', 114),
(15, '4006015', TRUE, 'Thane', 115),
(16, '4620016', FALSE, 'Bhopal', 116),
(17, '5300017', TRUE, 'Visakhapatnam', 117),
(18, '8000018', FALSE, 'Patna', 118),
(19, '3900019', TRUE, 'Vadodara', 119),
(20, '2010010', TRUE, 'Ghaziabad', 120),
(21, '1410011', FALSE, 'Ludhiana', 121),
(22, '2820012', TRUE, 'Agra', 122),
(23, '4220013', TRUE, 'Nashik', 123),
(24, '1210014', FALSE, 'Faridabad', 124),
(25, '2500015', TRUE, 'Meerut', 125);


INSERT INTO house_details (property_type, num_bedrooms, num_bathrooms, furnished, contact_email, contact_phone, house_id) VALUES
('Apartment', 2, 1, TRUE, 'arjun.singh@example.com', '1234567890', 1),
('Villa', 3, 2, FALSE, 'priya.kumar@example.com', '1234567891', 2),
('House', 4, 3, TRUE, 'rahul.sharma@example.com', '1234567892', 3),
('Studio', 1, 1, FALSE, 'aisha.verma@example.com', '1234567893', 4),
('Apartment', 2, 1, TRUE, 'vijay.patel@example.com', '1234567894', 5),
('Condo', 3, 2, FALSE, 'deepa.nair@example.com', '1234567895', 6),
('Apartment', 1, 1, TRUE, 'amit.joshi@example.com', '1234567896', 7),
('Penthouse', 5, 4, FALSE, 'meera.rao@example.com', '1234567897', 8),
('Villa', 4, 3, TRUE, 'sunil.gupta@example.com', '1234567898', 9),
('House', 3, 2, FALSE, 'rekha.iyer@example.com', '1234567899', 10),
('Apartment', 2, 1, TRUE, 'ajay.chopra@example.com', '1234567800', 11),
('Bungalow', 4, 3, FALSE, 'ritu.singh@example.com', '1234567801', 12),
('Studio', 1, 1, TRUE, 'neha.mehra@example.com', '1234567802', 13),
('Condo', 3, 2, FALSE, 'ravi.menon@example.com', '1234567803', 14),
('Apartment', 2, 1, TRUE, 'sonali.desai@example.com', '1234567804', 15),
('Villa', 4, 3, FALSE, 'mohan.kapoor@example.com', '1234567805', 16),
('House', 3, 2, TRUE, 'swati.bhatt@example.com', '1234567806', 17),
('Studio', 1, 1, FALSE, 'karan.shah@example.com', '1234567807', 18),
('Penthouse', 5, 4, TRUE, 'pallavi.jain@example.com', '1234567808', 19),
('Bungalow', 4, 3, FALSE, 'rajesh.agarwal@example.com', '1234567809', 20),
('Apartment', 2, 1, TRUE, 'suman.das@example.com', '1234567810', 21),
('Condo', 3, 2, FALSE, 'veer.prasad@example.com', '1234567811', 22),
('Studio', 1, 1, TRUE, 'poonam.mishra@example.com', '1234567812', 23),
('House', 4, 3, FALSE, 'nilesh.pandey@example.com', '1234567813', 24),
('Villa', 3, 2, TRUE, 'radhika.khan@example.com', '1234567814', 25);


INSERT INTO customers (cust_id, id, paying_per_month, customer_name, pincode) VALUES
(1, 1, 15000, 'Arjun Singh', 4000010),
(2, 2, 25000, 'Priya Kumar', 1100012),
(3, 3, 20000, 'Rahul Sharma', 5600013),
(4, 4, 12000, 'Aisha Verma', 5000814),
(5, 5, 18000, 'Vijay Patel', 3800015),
(6, 6, 22000, 'Deepa Nair', 6000016),
(7, 7, 15000, 'Amit Joshi', 7000017),
(8, 8, 35000, 'Meera Rao', 3950018),
(9, 9, 28000, 'Sunil Gupta', 4110019),
(10, 10, 14000, 'Rekha Iyer', 3020010),
(11, 11, 16000, 'Karan Shah', 4620016),
(12, 12, 21000, 'Ritu Singh', 4400013),
(13, 13, 19000, 'Neha Mehra', 4520014),
(14, 14, 17000, 'Ravi Menon', 1234567),
(15, 15, 25000, 'Sonali Desai', 3950020),
(16, 16, 22000, 'Mohan Kapoor', 1200001),
(17, 17, 24000, 'Swati Bhatt', 4400020),
(18, 18, 21000, 'Karan Joshi', 6000005),
(19, 19, 23000, 'Pallavi Jain', 4400030),
(20, 20, 26000, 'Rajesh Agarwal', 3020015);

select * from housing;
select * from house_details;
select * from customers;

-- 1 How many houses are available and unavailable across different cities (based on pincode) where no. of bedrooms are greater then 2? [House Availability Status]

select ho.city , ho.pincode , 
count(case when ho.available = 1 then 1 end)  as available_houses,
count(case when ho.available = 0 then 0 end) as unavailable_houses
from housing ho 
join house_details hd
on ho.house_id = hd.house_id
where hd.num_bedrooms > 4
group by ho.pincode ,ho.city;

-- 2 What are the most common property types in each pincode area?
 select ho.pincode, ho.city,hd.property_type , count(hd.property_type) as prop_count
 from housing ho
 join house_details hd
 on ho.house_id = hd.house_id
 group by ho.pincode, ho.city,hd.property_type
 order by ho.pincode, prop_count desc ;
 
 
 -- 3 Number of Bedrooms vs Rent city wise
 
 select hd.num_bedrooms , c.paying_per_month ,  h.city
 from house_details hd 
 join customers c on hd.id = c.id 
 join housing h on h.pincode = c.pincode
 order by 1 desc;
 
-- 4 How does the furnished status (True or False) affect the rent price?

select hd.furnished, count(hd.furnished) , avg(c.paying_per_month) as avg_rent
from house_details hd
join customers c 
on hd.id = c.id
group by 1; 


-- 5 Who are the top 5 customers by paying_per_month? What properties are they renting?
-- join hd and c 
select c.paying_per_month,c.customer_name , hd.property_type from customers c 
join house_details hd 
on c.id = hd.id
order by c.paying_per_month desc 
limit 5;
 
 
 -- 6 How do rents compare across different cities? Which city has the highest average customer rent?
 
 select h.city , c.paying_per_month, c.customer_name
 from housing h 
 join customers c 
 on h.pincode = c.pincode
 order by 2 desc; 
 
 -- 7 What is the percentage of furnished houses in each pincode area?
 
 select 
    ho.pincode, ho.city,
    count(case when hd.furnished = TRUE then 1 end) as furnished_houses,
    count(hd.house_id) AS total_houses,
    round((count(case when hd.furnished = TRUE then 1 end) * 100.0) / COUNT(hd.house_id)) as furnished_percentage
from housing ho
join house_details hd on ho.house_id = hd.house_id
group by  ho.pincode, ho.city
order by furnished_percentage desc;
 
 -- 8 All customers living in a penthouse in city having i in its spell
 
  select c.customer_name , hd.property_type , h.city  from customers c 
 join house_details hd on c.id = hd.id
 join housing h on h.pincode = c.pincode
 where h.city like '%i%';
 
 
 -- 9 Create a temporary table for storing the mail_id of tenants 
 drop temporary table if exists mailing;
 create temporary table  mailing (select hd.contact_email from house_details hd);
 
 
 -- 10 perform aggregrate functions on rental price 
 
  select max(c.paying_per_month) max_rental_price, 
		min(c.paying_per_month) min_rental_price,
        round(avg(c.paying_per_month),2) avg_rental_price
  from customers c 
  join house_details hd on c.id = hd.id
  group by hd.property_type
  order by 3 desc;
  
  
 
 
 
 
 
 
 
 
 