/*
RFM Analysis in SQL
Created by  : Satkar Karki
Description : This query extracts customer information from the AdventureWorks database 
              for Recency, Frequency, and Monetary (RFM) analysis. It returns a list of 
              customers from France along with their personal and geographic details, 
              number of orders placed, total money spent, and the date of their most 
              recent purchase.
Created on : 03/23/2025
*/


-- List of Tables containing the relevant data

/* 
Sales.Customer (CustomerID)
Person.Person (FirstName, LastName)
Person.Address (AddressLn, City, PO)
Person.StateProvince (ProvinceName)
Person.CountryRegion (Country)
Sales.SalesOrderHeader (SalesOrderID, TotalMoneySpent, OrderDate)
*/

-- Step 1: Load the database
use AdventureWorks2022

-- Step 2: List of customers living in France
select 
	c.CustomerID,
	p.FirstName, p.LastName,
	a.AddressLine1, a.City, a.PostalCode,
	sp.Name as Province,
	cr.Name as Country
from Sales.Customer c
	left join Person.Person as p on c.PersonID = p.BusinessEntityID
	left join Person.BusinessEntityAddress as bea on p.BusinessEntityID = bea.BusinessEntityID
	left join Person.Address as a on bea.AddressID = a.AddressID
	left join Person.StateProvince as sp on a.StateProvinceID = sp.StateProvinceID
	left join Person.CountryRegion as cr on sp.CountryRegionCode = cr.CountryRegionCode
where cr.Name = 'France';

-- Step 3: List of customers with Number of Orders placed and Dollars spent
select 
	soh.CustomerID,
	count(soh.SalesOrderID) as NumberOfOrders,  -- Frequency
	sum(soh.TotalDue) as TotalMoneySpent  -- Monetary Value
from Sales.SalesOrderHeader as soh
	join Sales.Customer as c on soh.CustomerID = c.CustomerID
	join Person.BusinessEntityAddress as bea on c.PersonID = bea.BusinessEntityID
	join Person.Address as a on bea.AddressID = a.AddressID
	join Person.StateProvince as sp on a.StateProvinceID = sp.StateProvinceID
	join Person.CountryRegion as cr on sp.CountryRegionCode = cr.CountryRegionCode
where cr.Name = 'France'
group by soh.CustomerID
order by TotalMoneySpent desc;

-- Step 5: List of customers with last order date (Recency)
select 
	soh.CustomerID,
	max(soh.OrderDate) as LastOrderDate  -- Recency
from Sales.SalesOrderHeader as soh
	join Sales.Customer as c on soh.CustomerID = c.CustomerID
	join Person.BusinessEntityAddress as bea on c.PersonID = bea.BusinessEntityID
	join Person.Address as a on bea.AddressID = a.AddressID
	join Person.StateProvince as sp on a.StateProvinceID = sp.StateProvinceID
	join Person.CountryRegion as cr on sp.CountryRegionCode = cr.CountryRegionCode
where cr.Name = 'France'
group by soh.CustomerID
order by LastOrderDate desc;


-- Step 6: Complete RFM dataset for customers in France
select 
	c.CustomerID as 'Customer ID',
	p.FirstName as 'First Name', p.LastName as 'Last Name',
	a.City, cr.Name as Country,
	count(soh.SalesOrderID) as 'Number Of Orders',  -- Frequency
	sum(soh.TotalDue) as 'Total Money Spent',  -- Monetary Value
	max(soh.OrderDate) as 'Last Order Date'  -- Recency
from Sales.Customer as c
	join Person.Person as p on c.PersonID = p.BusinessEntityID
	join Person.BusinessEntityAddress as bea on p.BusinessEntityID = bea.BusinessEntityID
	join Person.Address as a on bea.AddressID = a.AddressID
	join Person.StateProvince as sp on a.StateProvinceID = sp.StateProvinceID
	join Person.CountryRegion as cr on sp.CountryRegionCode = cr.CountryRegionCode
	join Sales.SalesOrderHeader as soh on c.CustomerID = soh.CustomerID
where cr.Name = 'France'
group by c.CustomerID, p.FirstName, p.LastName, a.City, cr.Name
order by sum(soh.TotalDue) desc;

