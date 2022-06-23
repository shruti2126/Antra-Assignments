USE AdventureWorks2019
GO

--1. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
Select p.ProductID, p.Name, p.ListPrice
from Production.Product p

--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice 
--from the Production.Product table, excluding the rows that ListPrice is 0.
Select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p
where p.ListPrice != 0

--3. Write a query that retrieves the columns ProductID, Name,
--Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
Select p.ProductID, p.Name, p.Color, p.ListPrice
from Production.Product p
where p.Color IS NOT NULL

--5. Write a query that concatenates the columns Name and Color
--from the Production.Product table by excluding the rows that are null for color.
Select p.Name + ', ' + p.Color AS ProductDetails
from Production.Product p
where p.Color IS NOT NULL

--6. Write a query that generates the following result set from
--Production.Product:
--NAME: LL Crankarm  --  COLOR: Black
--NAME: ML Crankarm  --  COLOR: Black
--NAME: HL Crankarm  --  COLOR: Black
--NAME: Chainring Bolts  --  COLOR: Silver
--NAME: Chainring Nut  --  COLOR: Silver
--NAME: Chainring  --  COLOR: Black
Select 'NAME: ' + p.Name + '  --  ' + 'COLOR: ' + p.Color AS ProductDetails
from Production.Product p
where p.Color IS NOT NULL

--7.Write a query to retrieve the to the columns ProductID and Name from the 
--Production.Product table filtered by ProductID from 400 to 500 using between
Select p.ProductID, p.Name
from Production.Product p
where p.ProductID Between 400 and 500

--8. Write a query to retrieve the to the columns  ProductID,
--Name and color from the Production.Product table restricted to the colors black and blue
Select p.ProductID, p.Name, p.Color
from Production.Product p
where p.Color = 'black' or p.Color = 'blue'

--9. Write a query to get a result set on products that begins
--with the letter S. 
Select p.ProductID, p.Name
from Production.Product p
where p.Name LIKE 'S%'


--10. Write a query that retrieves the columns Name and ListPrice
--from the Production.Product table. Your result set should look something like the following. Order the result set
--by the Name column. The products name should start with either 'A' or 'S'
--Name                                            ListPrice
--Adjustable Race                                   0,00
--All-Purpose Bike Stand                            159,00
--AWC Logo Cap                                      8,99
--Seat Lug                                          0,00
--Seat Post                                         0,00
Select p.Name, P.ListPrice
from Production.Product p
where p.Name LIKE 'A%' or p.Name LIKE 'S%'
order by p.Name

--11. Write a query so you retrieve rows
--that have a Name that begins with the letters SPO, but is then not followed by the letter K. 
--After this zero or more letters can exists. Order the result set by the Name column.
Select p.Name
from Production.Product p
where p.Name LIKE 'SPO[^K]%'
order by p.Name

--12. Write a query that retrieves the unique combination of
--columns ProductSubcategoryID and Color from the Production.Product table.
--We do not want any rows that are NULL.in any of the two columns in the result. (Hint: Use IsNull)
select DISTINCT ISNULL(p.ProductSubcategoryID, 0) as ProductSubcategoryID, ISNULL(p.Color, 0)  as Color
from Production.Product p
