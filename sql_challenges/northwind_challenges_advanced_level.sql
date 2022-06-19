USE [NORTHWND]
GO


/* #1a
SELECT
    C.[CompanyName]
  , B.[OrderID]
  , A.[OrderDate]
  , [total_purchase] = SUM(B.[UnitPrice] * B.[Quantity])
FROM [dbo].[Orders] AS A
    LEFT JOIN [dbo].[Order Details] AS B
    ON A.[OrderID] = B.[OrderID]
    LEFT JOIN [dbo].[Customers] AS C
    ON A.[CustomerID] = C.[CustomerID]
WHERE
    1 = 1
    AND YEAR(A.[OrderDate]) = 1998
    AND B.[UnitPrice] * B.[Quantity] >= 10000
GROUP BY
    B.[OrderID]
  , C.[CompanyName]
  , A.[OrderDate]
ORDER BY C.[CompanyName]
;
--*/

/* #1b
SELECT
    A.[CustomerID]
  , A.[CompanyName]
  , B.[OrderID]
  , B.[OrderDate]
  , [total_purchase] = SUM(C.[UnitPrice] * C.[Quantity])
FROM [dbo].[Customers] AS A
    LEFT OUTER JOIN [dbo].[Orders] AS B
    ON A.[CustomerID] = B.[CustomerID]
    LEFT OUTER JOIN [dbo].[Order Details] AS C
    ON B.[OrderID] = C.[OrderID]
WHERE 1 = 1 AND YEAR(B.[OrderDate]) = 1998
GROUP BY
    B.[OrderID]
  , A.[CompanyName]
  , A.[CustomerID]
  , B.[OrderDate]
HAVING SUM(C.[Quantity] * C.[UnitPrice]) >= 10000
;
--*/

/* #2
SELECT
    A.[CustomerID]
  , A.[CompanyName]
  , [total_purchase] = SUM(C.[UnitPrice] * C.[Quantity])
FROM [dbo].[Customers] AS A
    LEFT OUTER JOIN [dbo].[Orders] AS B
    ON A.[CustomerID] = B.[CustomerID]
    LEFT OUTER JOIN [dbo].[Order Details] AS C
    ON B.[OrderID] = C.[OrderID]
WHERE 1 = 1 AND YEAR(B.[OrderDate]) = 1998
GROUP BY
   A.[CompanyName]
  , A.[CustomerID]
HAVING SUM(C.[Quantity] * C.[UnitPrice]) >= 15000
;
--*/

--/* #3
SELECT
    A.[CustomerID]
  , A.[CompanyName]
  , [before] = SUM(C.[UnitPrice] * C.[Quantity])
  , [total_purchase] = SUM(C.[UnitPrice] * C.[Quantity] * (1 - C.[Discount]))
FROM [dbo].[Customers] AS A
    LEFT OUTER JOIN [dbo].[Orders] AS B
    ON A.[CustomerID] = B.[CustomerID]
    LEFT OUTER JOIN [dbo].[Order Details] AS C
    ON B.[OrderID] = C.[OrderID]
WHERE 1 = 1 AND YEAR(B.[OrderDate]) = 1998
GROUP BY
   A.[CustomerID]
   ,A.[CompanyName]
HAVING SUM(C.[Quantity] * C.[UnitPrice] * (1 - C.[Discount])) >= 15000
ORDER BY [total_purchase] DESC
;
--*/

/*
  Filename: ...: northwind_challenges_advanced_level.sql
  Date ........: 06-Jun-2022
  Time ........: 13:04
  Desc ........: Advanced sql challenges
  Notes........:
    3. Change the previous query to use the discount when calculating high-value customers. Order by the total amount which includes the discount.
    2. Find all the high-valued customers. That is find those customers who have made orders totalling $15,000 or more in 1998. If you group by multiple columns those will be factored into your final result, so removed the orderID and OrderDate.
    1. Find all the high-valued customers. That is find those customers who have made at least 1 order within a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 1998.
    In 1a I only returned 3-results. Maybe this is because my query summed each row, instead of summing each company when they are gruoped. In 1b the real answer reveals 6-rows. This is because the WHERE clause cannot be used with aggregate functions even with a GROUP BY. Ifyou filter data by groups, then you have to add the HAVING clause.
*/

--Sweaty(SELECT) Feet(FROM) Will(WHERE) Give(GROUP BY) Horrible(HAVING) Oder(ORDER BY)
--SELECT
--FROM
--WHERE
--GROUP BY
--HAVING
--ORDER BY
--
----Limitations of CTEs
--1. CTEs can only be used in the current query scope, meaning they cannot be referenced after the final SELECT
--2. This can be a problem if you need to reuse your virtual tables multi times for diff purposes
--3. cannot be referenced individually, making degugging more difficult
--4. certain optimization techniques are not available to CTEs
--SQL Join Types PDF



GO