--1
CREATE VIEW CustomerAddresses AS
SELECT c.CustomerID, EmailAddress, LastName, FirstName, addr.Line1 AS BillLine1, addr.Line2 AS BillLine2, addr.City AS BillCity, addr.State AS BillState, addr.ZipCode AS BillZip, addrb.Line1 AS ShipLine1, addrb.Line2 AS ShipLine2, addrb.City AS ShipCity, addrb.State AS ShipState, addrb.ZipCode AS ShipZip
FROM Customers c
     JOIN Addresses addr ON c.CustomerID = addr.CustomerID AND c.BillingAddressID = addr.AddressID
     JOIN Addresses addrb ON c.CustomerID = addrb.CustomerID AND c.ShippingAddressID = addrb.AddressID;

--2
SELECT CustomerID, LastName, FirstName, BillLine1
FROM CustomerAddresses;

--3
UPDATE CustomerAddresses
SET ShipLine1 = '1990 Westwood Blvd'
WHERE CustomerID = 8;

--4
CREATE VIEW OrderItemProducts AS
SELECT o.OrderID, OrderDate, TaxAmount, ShipDate, ItemPrice, DiscountAmount, (ItemPrice - DiscountAmount) AS FinalPrice, Quantity, (ItemPrice - DiscountAmount) * Quantity AS ItemTotal, ProductName
FROM Orders o
     JOIN OrderItems oi ON o.OrderID = oi.OrderID
     JOIN Products p ON oi.ProductID = p.ProductID;
		 
--5
CREATE VIEW ProductSummary AS
SELECT ProductName, SUM(Quantity) AS OrderCount, SUM(ItemTotal) AS OrderTotal
FROM OrderItemProducts
GROUP BY ProductName;

--last part of #5
SELECT TOP 5 OrderTotal, ProductName
FROM ProductSummary
ORDER BY OrderTotal DESC;
