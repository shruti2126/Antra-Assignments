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
WITH emp_cte AS 
(
Select EmployeeID, FirstName, Title, ReportsTo, 1 lvl
from Employees
where ReportsTo IS NULL
UNION ALL
Select e.EmployeeID, e.FirstName, e.Title, e.ReportsTo, lvl + 1
from Employees e INNER JOIN emp_cte ON e.ReportsTo = emp_cte.EmployeeID
)
Select FirstName, ReportsTo, lvl, RANK() OVER (PARTITION BY ReportsTo ORDER BY COUNT(EmployeeID)) RNK
from emp_cte
group by FirstName, ReportsTo, lvl

--13. Display the customers and suppliers by city. The results should have the following columns

--City
--Name
--Contact Name,
--Type (Customer or Supplier)

Select c.City, c.CompanyName as [Customer Company], c.ContactName as [Customer Name], s.CompanyName as [Supplier Company], s.ContactName as [Supplier Name]
from Customers c, Suppliers s
group by c.City, c.CompanyName, s.CompanyName, s.ContactName, c.ContactName


--14. List all cities that have both Employees and Customers.
 
Select e.city as citiesWithBothEmployeesAndCustomers
from Employees e
JOIN Customers c on e.City = c.City
group by e.city


--15. List all cities that have Customers but no Employee.
--a. Use sub-query
--b. Do not use sub-query

--a.
Select c.city as CityWithCustomersButNoEmpl
from Customers c
where c.city NOT IN (Select city from Employees)
group by c.city

--b.
Select c.city as CityWithCustomersNotEmployees
from Customers c, Employees e
where c.city != e.city
group by c.city

--16. List all products and their total order quantities throughout all orders.
Select p.ProductName, SUM(od.Quantity) as [Total Quantity Throughout All Orders]
from Products p, [Order Details] Od,Orders o
where p.ProductID = od.ProductID and o.OrderID = od.OrderID
group by p.ProductName

--17. List all Customer Cities that have at least two customers.
--a. Use union
--b.Use no union

--a. 
Select c.city as Cities,COUNT(c.CustomerID) as [# of Customers]
from Customers c
group by c.city
having COUNT(c.customerID) = 2
UNION
Select c.city as Cities, COUNT(c.CustomerID) as [# of Customers]
from Customers c
group by c.city
having COUNT(c.customerID) > 2


--b.
Select c.city as Cities, COUNT(c.CustomerID) as [# of Customers]
from Customers c
group by c.city
having COUNT(c.customerID) >= 2


--18. List all Customer Cities that have ordered at least two different kinds of products.
 Select c.City as [Customer City], COUNT(p.CategoryID) as [# of types of products ordered]
 from Customers c, Products p, Orders o, [Order Details] od
 where c.CustomerID = o.CustomerID and p.ProductID = od.ProductID and od.OrderID = o.OrderID 
 group by c.City 
 having COUNT(p.CategoryID) >= 2


--19. List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
Select TOP 5 p.ReorderLevel as popularity, AVG(od.UnitPrice * od.Quantity) as AveragePrice, MostOrdered.maxQuantity
from Products p, Customers cu, orders o, [Order Details] od, 
(Select p.ProductID, MAX(od.Quantity) as maxQuantity 
from [Order Details] Od, Products p, Orders o
where p.ProductID = od.ProductID and o.OrderID = od.OrderID
group by p.ProductID) MostOrdered
where p.ProductID = od.ProductID and o.OrderID = od.OrderID and cu.CustomerID = o.CustomerID 
group by p.ReorderLevel, MostOrdered.maxQuantity
order by popularity DESC

--20. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, 
--and also the city of most total quantity of products ordered
--from. (tip: join  sub-query)


Select top 1 e.city, COUNT(o.OrderID) as [# of orders]
from Employees e, Orders o
where e.EmployeeID = o.EmployeeID
group by e.EmployeeID, e.City
order by COUNT(o.orderID) DESC

Select TOP 1 MaxQuantities.city as [City of most total quantity of products ordered], MAX(MaxQuantities.maxQuantity) as [most total quantity of products ordered]
from (Select c.city, MAX(od.Quantity) as maxQuantity 
from [Order Details] Od, Orders o, Customers c
where o.OrderID = od.OrderID and c.CustomerID = o.CustomerID
group by c.city) MaxQuantities
group by MaxQuantities.City
order by MAX(MaxQuantities.maxQuantity) DESC



--21. How do you remove the duplicates record of a table?

-- we can use group by to deduplicate records







