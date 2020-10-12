--Jessi Manka
--Exercise 2A: 2-table queries
--PropertyManager db

--2A.1) Building, Apartment tables. Sort by BuildingId, ApartmentNum
SELECT Building.BuildingId, Building.BuildingName, Apartment.ApartmentNum, Apartment.Rent
FROM   Apartment INNER JOIN
          Building ON Apartment.BuildingId = Building.BuildingId
ORDER BY Building.BuildingId, Apartment.ApartmentNum

--2A.2) Building, Apartment tables. Sort by BuildingId, Rent
SELECT Apartment.BuildingId, Building.City, Building.BuildingName, Apartment.ApartmentNum, Apartment.Rent
FROM   Apartment INNER JOIN
          Building ON Apartment.BuildingId = Building.BuildingId
WHERE  (Building.City = N'Winona')
ORDER BY Apartment.BuildingId, Apartment.Rent DESC

--2A.3) Apartment, Invoice tables. Sort by ApartmentNum, InvoiceDate
SELECT Apartment.ApartmentId, Apartment.ApartmentNum, Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.DueDate
FROM   Apartment INNER JOIN
          Invoice ON Apartment.ApartmentId = Invoice.ApartmentId
WHERE  (Apartment.BuildingId = 1)
ORDER BY Apartment.ApartmentNum, Invoice.InvoiceDate DESC

--2A.4) Apartment, Invoice tables. Sort by BuildingId, ApartmentNum, InvoiceDate
SELECT Apartment.BuildingId, Apartment.ApartmentNum, Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.DueDate
FROM   Apartment INNER JOIN
          Invoice ON Apartment.ApartmentId = Invoice.ApartmentId
ORDER BY Apartment.BuildingId, Apartment.ApartmentNum, Invoice.InvoiceDate

--2A.5) Apartment, Person tables.(Admin) Sort by BuildingId, ApartmentNum
SELECT Apartment.BuildingId, Apartment.ApartmentNum, Apartment.Rent, Person.LastName AS Admin
FROM   Apartment INNER JOIN
          Person ON Apartment.AdminId = Person.PersonId
ORDER BY Apartment.BuildingId, Apartment.ApartmentNum

--2A.6) Apartment, Person tables.(TenantLastName, TenantFirstName) Sort by BuildingId, TenantLastName, TenantFirstName
SELECT Apartment.BuildingId, Apartment.ApartmentNum, Person.LastName AS TenantLastName, Person.FirstName AS TenantFirstName
FROM   Apartment INNER JOIN
          Person ON Apartment.TenantId = Person.PersonId
ORDER BY Apartment.BuildingId, TenantLastName, TenantFirstName

--2A.7) Invoice, Line Item tables. Sort by ApartmentId, InvoiceDate
SELECT Invoice.ApartmentId, Invoice.InvoiceId, Invoice.InvoiceDate, LineItem.Description, LineItem.Amount
FROM   Invoice INNER JOIN
          LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
ORDER BY Invoice.ApartmentId, Invoice.InvoiceDate DESC

--2A.8) Invoice, Line Item tables. Sort by ApartmentId, InvoiceDate
SELECT Invoice.ApartmentId, Invoice.InvoiceId, Invoice.InvoiceDate, LineItem.Description, LineItem.Amount
FROM   Invoice INNER JOIN
          LineItem ON Invoice.InvoiceId = LineItem.InvoiceId
WHERE  (LineItem.Description LIKE N'rent%') OR
          (LineItem.Description = N'garage')
ORDER BY Invoice.ApartmentId, Invoice.InvoiceDate DESC

--2A.9) Invoice, Receipt tables. Sort by ApartmentId, InvoiceDate
SELECT Invoice.ApartmentId, Invoice.InvoiceId, Invoice.DueDate, Receipt.ReceiptDate, Receipt.Amount
FROM   Invoice INNER JOIN
          Receipt ON Invoice.InvoiceId = Receipt.InvoiceId
ORDER BY Invoice.ApartmentId, Invoice.InvoiceId DESC