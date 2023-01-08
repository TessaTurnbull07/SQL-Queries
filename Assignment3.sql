
--1 
SELECT ProductCode, ProductName, ListPrice, DiscountPercent
FROM Products
ORDER BY ListPrice DESC

--2 
SELECT ProductName AS [The ProductName column], ListPrice AS [The ListPrice column], DateAdded AS [The DateAdded column]
FROM Products
WHERE ListPrice > 500 AND ListPrice < 2000
ORDER BY DateAdded DESC

--3 
SELECT OrderID AS [The OrderID column], OrderDate AS [The OrderDate column], ShipDate AS [The ShipDate column]
FROM Orders
WHERE ShipDate IS NULL

--4 
SELECT DISTINCT Customers.FirstName, Customers.LastName, Addresses.Line1, Addresses.City, Addresses.State, Addresses.ZipCode
FROM Customers
INNER JOIN Addresses ON Customers.CustomerID = Addresses.CustomerID
AND Customers.ShippingAddressID = Addresses.AddressID

--5 
SELECT DISTINCT A.ListPrice, A.ProductName, A.ProductID
FROM Products AS A
INNER JOIN Products AS B ON A.ProductID = B.ProductID
WHERE A.ProductID <> B.ProductID
AND A.ListPrice = B.ListPrice
ORDER BY A.ProductName

--6 
SELECT Categories.CategoryName AS [The CategoryName column from the Categories table], Products.ProductID AS [The ProductID column from the Products table]
FROM Categories
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.ProductID IS NULL

--7 
SELECT 'SHIPPED' As ShipStatus, OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NOT NULL
UNION
SELECT 'NOT SHIPPED', OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NULL
ORDER BY OrderDate

