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

Select od.OrderID, p.ProductName,o.OrderDate
from Products p
JOIN [Order Details] od on od.ProductID = p.ProductID 
JOIN Orders o on o.OrderID = od.OrderID 
where YEAR(o.OrderDate) = YEAR(CURRENT_TIMESTAMP) - 25

--4. List top 5 locations (Zip Code) where the products sold most in last 25 years.
Select TOP 5 o.ShipPostalCode, p.ProductName
from Products p
JOIN [Order Details] od on od.ProductID = p.ProductID 
JOIN Orders o on o.OrderID = od.OrderID 
where YEAR(o.OrderDate) = YEAR(CURRENT_TIMESTAMP) - 25

--5. List all city names and number of customers in that city.  
Select c.City, COUNT(c.CustomerID) as NumberOfCustomers
from Customers c
group by c.City

--6. List city names which have more than 2 customers, and number of customers in that city
Select c.City, COUNT(c.CustomerID) as NumberOfCustomers
from Customers c
group by c.City
having COUNT(c.CustomerID) > 2

--7. Display the names of all customers  along with the  count of products they bought
Select c.ContactName as [Customer Names], COUNT(od.Quantity) as [Product Count]
from [Order Details] od, Orders o, Customers c
where od.OrderID = o.OrderID
and c.CustomerID = o.CustomerID
group by c.ContactName

--8. Display the customer ids who bought more than 100 Products with count of products.
Select c.ContactName as [Customer Names], COUNT(od.Quantity) as [Product Count]
from [Order Details] od, Orders o, Customers c
where od.OrderID = o.OrderID
and c.CustomerID = o.CustomerID
group by c.ContactName
having COUNT(od.Quantity) > 100

--9. List all of the possible ways that suppliers can ship their products. 
--Display the results as below

--    Supplier Company Name                Shipping Company Name
Select sup.CompanyName as [Supplier Company Name], sh.CompanyName [Shipping Company Name]
from Suppliers sup, Shippers sh, Products p, [Order Details] od, Orders o
where od.OrderID = o.OrderID
and p.ProductID = od.ProductID
and p.SupplierID = sup.SupplierID 
and sh.ShipperID = o.ShipVia
group by sup.CompanyName, sh.CompanyName

--10. Display the products order each day. Show Order date and Product Name.
Select DAY(o.OrderDate) as #Day, o.OrderDate as Date, p.ProductName as [Product Name]
from Products p
JOIN [Order Details] od on p.ProductID = od.ProductID
JOIN Orders o on o.OrderID = od.OrderID
group by DAY(o.orderDate), p.ProductName, o.OrderDate

--11. Displays pairs of employees who have the same job title.
Select e1.FirstName as #Emp1, e2.FirstName as #Emp2, e1.Title 
from Employees e1, Employees e2
where e1.Title = e2.Title
and e1.FirstName < e2.FirstName

--12. Display all the Managers who have more than 2 employees reporting to them.







