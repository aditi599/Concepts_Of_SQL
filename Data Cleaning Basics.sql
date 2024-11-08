use airbnb;
show tables;
select * from airbnb_open_data;
alter table airbnb_open_data rename to airbnb;
desc airbnb;
select * from airbnb;

select count(*) from airbnb where `NAME` = '';
select count(*) from airbnb where `host id` = '';
select count(*) from airbnb where `host_identity_verified` = '';
select count(*) from airbnb where `price` = '';
select count(*) from airbnb where `service fee` = '';

-- *****Filtering out those rows that do that have any price mentioned
delete from airbnb where `price` = '';
-- verify
select count(*) from airbnb where `price` = '';


-- in the host_identity_verified column filling the null spaces with unconfirmed

select case when host_identity_verified  = '' then 'unconfirmed' else host_identity_verified end from airbnb;

-- but this will not update the column in place , for permanently doing that we need to update that particular column
update airbnb set host_identity_verified = 'unconfirmed' where host_identity_verified = '';


-- similarly  filling up the blank value in the Name column with 'info not given'

update airbnb set `NAME` = 'Info Not Given' where `NAME` = ''; 
update airbnb set `host name` = 'Info Not Given' where `host name` = ''; 
update airbnb set `neighbourhood group` = 'Info Not Given' where `neighbourhood group` = ''; 

select * from airbnb;

-- categorizing the property with new or old on the basis of construction year
-- Adding a new column 
alter table airbnb add column property_condition varchar(30);

update airbnb set property_condition = case when `Construction year` in (2000,2001,2002,2003,2004,2005,2006,2007,2008) then 'Old'
											when `Construction year` in (2009,2010,2011,2012,2013,2014,2015,2016,2017) then 'Recently Constructed'
                                            when `Construction year` in (2018,2019,2020,2021,2022,2023,2024,2025,2026,2027) then 'Newly Constructed'
                                            else 'No Info Given'
                                            end;

-- here the values with no country is deleted from the database and the country code column is updated for blank values;
update airbnb set `country code`= case when `country code` = 'No country' then 'No country codegiven' else `country code` end;
delete from airbnb where country = '';


-- Changing the datetype of the date field from text to date time 
alter table airbnb modify `last review` datetime;
update airbnb set `last review` = str_to_date(`last review`, '%d%m%Y')
where `last review` is not null;

-- Changing the date format 
SELECT 
    CASE
        WHEN `last review` LIKE '%/%/%' THEN STR_TO_DATE(`last review`, '%m/%d/%Y')
        ELSE `last review`
    END AS standardized_date
FROM airbnb;


-- Handling further missing info, by replacing the blank space with appropriate response
update airbnb set `reviews per month` = case when `reviews per month` = '' then 'No Reviews yet' else `reviews per month` end;
update airbnb set `house_rules` = case when `house_rules` = '' then 'No Rules' else `house_rules` end;

