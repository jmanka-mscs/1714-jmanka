--#1 building name and location 
SELECT BuildingName, Address, City + N', ' + State + N' ' + Zip AS Location
FROM   Building
WHERE  (City = N'winona') AND (State = N'mn')


--#2 apt estimated rent
SELECT Building.BuildingName, Apartment.ApartmentNum, Apartment.SquareFeet * .9 + Apartment.Bathrooms * 100.0 AS [Estimated Rent]
FROM   Apartment INNER JOIN
          Building ON Apartment.BuildingId = Building.BuildingId
WHERE  (Building.City = N'Red Wing')


--#3 est vs actual rent
SELECT Building.BuildingName, Apartment.ApartmentNum, Apartment.Rent, Apartment.SquareFeet * .9 + Apartment.Bathrooms * 100.0 AS [Estimated Rent], Rent - Apartment.SquareFeet * .9 + Apartment.Bathrooms * 100.0 AS Difference
FROM   Apartment INNER JOIN
          Building ON Apartment.BuildingId = Building.BuildingId
WHERE  (Building.City = N'Red Wing')


--#4 invoice total
SELECT Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Name, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total]
FROM   Building INNER JOIN
          Apartment ON Building.BuildingId = Apartment.BuildingId INNER JOIN
          Person ON Apartment.TenantId = Person.PersonId INNER JOIN
          Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
          LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
GROUP BY Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.InvoiceDate


--#5 invoice total and receipt
SELECT Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Name, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total], Receipt.Amount
FROM   Building INNER JOIN
          Apartment ON Building.BuildingId = Apartment.BuildingId INNER JOIN
          Person ON Apartment.TenantId = Person.PersonId INNER JOIN
          Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
          LineItem ON Invoice.InvoiceId = LineItem.InvoiceId INNER JOIN
          Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
GROUP BY Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.InvoiceDate, Receipt.Amount


--#6 invoice total vs received
SELECT Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Name, Invoice.InvoiceDate, SUM(LineItem.Amount) AS [Invoice Total], Receipt.Amount, SUM(LineItem.Amount) - Receipt.Amount AS Difference
FROM   Building INNER JOIN
          Apartment ON Building.BuildingId = Apartment.BuildingId INNER JOIN
          Person ON Apartment.TenantId = Person.PersonId INNER JOIN
          Invoice ON Apartment.ApartmentId = Invoice.ApartmentId INNER JOIN
          LineItem ON Invoice.InvoiceId = LineItem.InvoiceId INNER JOIN
          Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
GROUP BY Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.InvoiceDate, Receipt.Amount
HAVING (SUM(LineItem.Amount) - Receipt.Amount > 0)


--#7 late payments
SELECT Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName AS Tenant, Invoice.DueDate, Receipt.ReceiptDate, DATEDIFF(day, Invoice.DueDate, Receipt.ReceiptDate) AS [Days Late]
FROM   Invoice INNER JOIN
          Receipt ON Invoice.InvoiceId = Receipt.InvoiceId INNER JOIN
          Apartment ON Invoice.ApartmentId = Apartment.ApartmentId INNER JOIN
          Building ON Apartment.BuildingId = Building.BuildingId INNER JOIN
          Person ON Apartment.TenantId = Person.PersonId
GROUP BY Building.BuildingId, Apartment.ApartmentNum, Person.FirstName + N' ' + Person.LastName, Invoice.DueDate, Receipt.ReceiptDate, DATEDIFF(day, Invoice.DueDate, Receipt.ReceiptDate)
HAVING (DATEDIFF(day, Invoice.DueDate, Receipt.ReceiptDate) > 0)

--#8 next invoice date
SELECT Person.PersonId, Person.FirstName + N' ' + Person.LastName AS Tenant, MAX(Invoice.InvoiceDate) AS [Recent Invoice], DATEADD(month, 1, MAX(Invoice.InvoiceDate)) AS [Next Invoice]
FROM   Person INNER JOIN
          Apartment ON Person.PersonId = Apartment.TenantId INNER JOIN
          Invoice ON Apartment.ApartmentId = Invoice.ApartmentId
GROUP BY Person.PersonId, Person.FirstName + N' ' + Person.LastName