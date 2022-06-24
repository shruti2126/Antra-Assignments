use AdventureWorks2019
Go

--1. Write a query that lists the country and province names from person.CountryRegion and person.StateProvince 
--tables. Join them and produce a result set similar to the following.

--Country                        Province
Select c.Name as Country, s.Name as Province
from Person.CountryRegion c 
JOIN Person.StateProvince s on c.CountryRegionCode = s.CountryRegionCode

--2. Write a query that lists the country and province names from person. CountryRegion and person.StateProvince tables 
--and list the countries filter them by Germany and Canada.
--Join them and produce a result set similar to the following.

--    Country                        Province

Select c.Name as Country, s.Name as Province
from person.CountryRegion c, person.StateProvince s
where c.CountryRegionCode = 'Germany' or c.CountryRegionCode = 'Canada'
and C.CountryRegionCode = s.CountryRegionCode

--3. List all Products that has been sold at least once in last 25 years.

use Northwind Go

--DECLARE @timestamp as TIMESTAMP
--SET @timestamp = CURRENT_TIMESTAMP
--PRINT (CONVERT( VARCHAR(24), CURRENT_TIMESTAMP))

Select p.ProductID, od.OrderID, p.ProductName,o.OrderDate
from Products p
JOIN [Order Details] od on od.ProductID = p.ProductID 
JOIN Orders o on o.OrderID = od.OrderID 
where YEAR(o.OrderDate) = YEAR(CURRENT_TIMESTAMP) - 25

--4. List top 5 locations (Zip Code) where the products sold most in last 25 years.