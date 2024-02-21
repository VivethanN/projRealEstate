--Data Cleaning Project

--Cleaning real estate and property sales data

select *
from Project..projRealtor 

--removing null values
select *
from Project..projRealtor 
where city is not null 
and state is not null
order by 5,6  

--Cities with highest prices 
select city, max(price) as Price
from Project..projRealtor
where city is not null 
and state is not null
Group by city
Order by price desc

--Cities with lowest prices 

select city, min(price) as Price
from Project..projRealtor
where city is not null 
and state is not null
Group by city
Order by price 

--setting date 

-- Assuming prevsolddate is an nvarchar column containing numeric values
SELECT city,CONVERT(DATE, DATEADD(DAY, CONVERT(INT,prev_sold_date), '19000101')) AS ConvertedDate
From Project..projRealtor

--Converting date from nvarchar to date 
Select*
From Project..projRealtor
Alter table Project..projRealtor 
Add ConvertedDate Date

Update Project..projRealtor
SET ConvertedDate =CONVERT(DATE, DATEADD(DAY, CONVERT(INT,prev_sold_date), '19000101'))
From Project..projRealtor

--arranging the plots by sold date
select *
from Project..projRealtor
where ConvertedDate is not null 
order by ConvertedDate desc



select *
From Project..projRealtor
Where city is null 

--checking status of all the estates
Select Distinct(status), count(status)
From Project..projRealtor
Group by status
order by 2


--removing duplicates 

with RowNumCTE  as (
Select *,
  ROW_NUMBER() OVER(
  Partition by acre_lot,
               city,
			   state,
			   zip_code,
			   house_size,
			   price,
			   ConvertedDate
			   Order by 
			   Price
			   ) row_num
From Project..projRealtor
--Order by ConvertedDate
)
Select *
From RowNumCTE
--WHERE row_num>1
Order by ConvertedDate

--removing unused col
select *
From Project..projRealtor

Alter table Project..projRealtor
Drop Column prev_sold_date

--removing all null values 
select*
From Project..projRealtor
Where bed is not null
and bath is not null
and acre_lot is not null
AND house_size is not null
AND  ConvertedDate is not null 
order by price 

-- makin a new table 
select*
INTO Project..projRealtorNew
From Project..projRealtor
Where bed is not null
and bath is not null
and acre_lot is not null
AND house_size is not null
AND  ConvertedDate is not null 
order by price 

-- new table 
select * 
From Project..projRealtorNew
