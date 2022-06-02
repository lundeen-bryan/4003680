USE [NORTHWND]
GO

/* #1
     SELECT *
       FROM [NORTHWND].[dbo].[Shippers]
      WHERE 1=1
   ORDER BY [ShipperID]
--*/

/* #2
SELECT
 [CategoryName]
 , [Description]
FROM
 [dbo].[Categories] AS A
WHERE 1=1
;
--*/

/* #3
     SELECT [FirstName]
          , [LastName]
          , [HireDate]
       FROM [dbo].[Employees]
      WHERE 1=1
        AND [Title] = 'Sales Representative'
;
--*/

/* #4
     SELECT [FirstName]
          , [LastName]
          , [HireDate]
       FROM [dbo].[Employees]
      WHERE 1=1
        AND [Title] = 'Sales Representative'
        AND [Country] = 'USA'
;
--*/

/* #5
     SELECT *
       FROM [dbo].[Orders]
      WHERE 1=1
        AND [EmployeeID] = 5
;
--*/

/* #6
     SELECT [SupplierID]
          , [ContactName]
          , [ContactTitle]
       FROM [dbo].[Suppliers]
      WHERE 1=1
        AND [ContactTitle] != 'Marketing Manager'
;
--*/

/* #7
     SELECT [ProductID]
          , [ProductName]
       FROM [dbo].[Products]
      WHERE 1=1
        AND [ProductName] LIKE '%queso%'
;
--*/

/* #8
     SELECT [OrderID]
          , [CustomerID]
          , [ShipCountry]
       FROM [dbo].[Orders]
      WHERE 1=1
        AND [ShipCountry] IN('France', 'Belgium')
;
--*/

/* #9
     SELECT [OrderID]
          , [CustomerID]
          , [ShipCountry]
       FROM [dbo].[Orders]
      WHERE 1=1
        AND [ShipCountry] IN('Brazil', 'Mexico', 'Argentina', 'Venezuela')
   ORDER BY [ShipCountry]
;
--*/

/* #10
     SELECT [FirstName]
          , [LastName]
          , [Title]
          , [BirthDate]
       FROM [dbo].[Employees]
      WHERE 1=1
   ORDER BY [BirthDate]
;
--*/

/* #11
     SELECT [FirstName]
          , [LastName]
          , [Title]
          , [dob] = CAST([BirthDate] AS date)
       FROM [dbo].[Employees]
      WHERE 1=1
   ORDER BY [BirthDate]
;
--*/

/* #12
     SELECT [Firstname]
          , [LastName]
          , [FullName] = C.[FirstName] + ' ' + C.[LastName]
       FROM [dbo].[Employees] AS C
      WHERE 1=1
;
--*/

/* #13
     SELECT D.[UnitPrice]
          , D.[Quantity]
          , [TotalPrice] = D.[UnitPrice] * D.[Quantity]
       FROM [dbo].[Order Details] AS D
      WHERE 1=1
;
--*/



/*
    Filename: ...: Untitled-1
    Date ........: 01-Jun-2022
    Time ........: 19:58
    Desc ........: Questions
    Notes........:
        14.
        13. In the OrderDetails table, we have the fields UnitPrice and Quanitity. Create a new field, TotalPrice, that multiplies these two together. We'll ignore the discount field for now.
        12. Show the FirstName and LastName columns from the Employees table, and then create a new column called FullName, showing FirstName and LastName joined together in one column, with a space in-between.
        11. In the output of the previous query, showing the Employees in order of BirthDate, we see the time of the BirthDate field, which we don't want. Show only the date portion of the BirthDate field.
        10. For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.
        9. From the previous query, now we just want to show all the orders from any Latin American Country. Use this as the list: Brazil, Mexico, Argentina, Venezuela.
        8. Write a query that shows the OrderID, CustomerID and ShipCountry for the orders where the ShipCountry is either France or Belgium.
        7. In the products table, we'd like to see the ProductID and ProductName for those products where the ProductName includes the string 'queso.'
        6. In the suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whos Contact Title is not Marketing Manager.
        5. Show all the orders placed by a specific employee. The EmployeeID for this Employee is 5.
        4. In the previous query we'd lke to see the same columns as before, but only for those employees that both have the title of Sales Representative, and also are in the United States.
        3. Show just the FirstName, LastName and HireDate of all the Employees with the title of Sales Representative. Write a SQL query that returns only those employees.
        2. In the categories table, selecting all the fileds using this sql query SELECT * FROM Categories ... will return 4 columns. We only want to see two columns, Category name, and Description.
        1. We have a table called Shippers. Return all the fields from the table shippers.
*/



GO