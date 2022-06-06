USE [NORTHWND]
GO

/* #1
     SELECT
           [product_count] = COUNT(A.[ProductID])
           , [category] = B.[CategoryName]
       FROM [dbo].[Products] AS A
       JOIN [dbo].[Categories] AS B
         ON A.[CategoryID] = B.[CategoryID]
      WHERE 1=1
   GROUP BY B.[CategoryName]
   ORDER BY [product_count] DESC
;
--*/

/* #2
     SELECT [total_customers] = COUNT(A.[CustomerID])
          , [location] = A.[City] + ', ' + A.[Country]
       FROM [dbo].[Customers] AS A
      WHERE 1=1
   GROUP BY A.[Country]
          , A.[City]
   ORDER BY A.[Country]
          , A.[City]
;
--*/

/* #3
     SELECT [id] = A.[ProductID]
          , [product_name] = A.[ProductName]
          , [order_now] = CASE WHEN A.[ReorderLevel] - A.[UnitsInStock] >=1
                               THEN 'Yes'
                               WHEN A.[UnitsInStock] = 0 THEN 'Yes'
                               ELSE 'No'
                          END
       FROM [dbo].[Products] AS A
      WHERE 1=1
        AND A.[UnitsOnOrder] = 0
        AND A.[Discontinued] = 0
   ORDER BY A.[ProductID]
;
--*/

/* #4
     SELECT [product_name] = A.[ProductName]
          , [order_now] = CASE WHEN A.[ReorderLevel] - A.[UnitsInStock] >=1
                               THEN 'Yes'
                               WHEN A.[UnitsInStock] = 0 THEN 'Yes'
                               ELSE 'No'
                          END
       FROM [dbo].[Products] AS A
      WHERE 1=1
        AND A.[UnitsInStock] + A.[UnitsOnOrder] <= A.[ReorderLevel]
        AND A.[Discontinued] = 0
   ORDER BY A.[ProductID]
;
--*/

/* #5a
WITH
     Step1 AS (SELECT [Region]
                    , [CompanyName]
                    , [CustomerID]
                 FROM [dbo].[Customers])
         ,
     Step2 AS (SELECT *
                    , [customer_row_num] = ROW_NUMBER() OVER (PARTITION BY [Region]
                                                             ORDER BY [CompanyName])
                    , [region_located] = IIF([Region] IS NULL, 1, 0)
                 FROM Step1)
     SELECT  A.[CustomerID]
          , A.[Region]
          , A.[CompanyName]
       FROM Step1 AS A
       JOIN Step2 AS B
         ON A.[CustomerID] = B.[CustomerID]
   ORDER BY B.[region_located]
          , A.[Region]
          , B.[customer_row_num]
          , A.[CompanyName]
--*/

/* #5b
     SELECT [CustomerID]
          , [CompanyName]
          , [Region]
       FROM [dbo].[Customers]
      WHERE 1=1
   ORDER BY CASE WHEN [Region] IS NULL THEN 1
                ELSE 0
           END
          , [Region]
          , [CustomerID]
;
--*/

/* #6
     SELECT TOP 3 [country] = A.[ShipCountry]
          , [freight_avg] = AVG(A.[Freight])
       FROM [dbo].[Orders] AS A
      WHERE 1=1
   GROUP BY A.[ShipCountry]
   ORDER BY [freight_avg] DESC
;
--*/

/* #7
     SELECT TOP 3 [country] = A.[ShipCountry]
          , [freight_avg] = AVG(A.[Freight])
       FROM [dbo].[Orders] AS A
      WHERE 1=1
      AND YEAR(A.[OrderDate]) = '1996'
   GROUP BY A.[ShipCountry]
   ORDER BY [freight_avg] DESC
;
--*/

/* #8
     SELECT B.[EmployeeID]
          , B.[LastName]
          , A.[OrderID]
          , D.[ProductName]
          , C.[Quantity]
       FROM [dbo].[Orders] AS A
  LEFT JOIN [dbo].[Employees] AS B
         ON A.[EmployeeID] = B.[EmployeeID]
  LEFT JOIN [dbo].[Order Details] AS C
         ON A.[OrderID] = C.[OrderID]
  LEFT JOIN [dbo].[Products] AS D
         ON C.[ProductID] = D.[ProductID]
      WHERE 1=1
   ORDER BY A.[OrderID]
          , D.[ProductID]
;
--*/

/* SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE 1=1 AND COLUMN_NAME LIKE '%customerid%' ORDER BY TABLE_NAME */
/* #9
     SELECT A.[CustomerID]
       FROM [dbo].[Customers] AS A
  FULL JOIN [dbo].[Orders] AS B
         ON A.[CustomerID] = B.[CustomerID]
      WHERE 1=1
        AND B.[CustomerID] IS NULL
;
--*/
/* --use this subquery if you don't use the IS NULL approach
AND A.[CustomerID] NOT IN(
SELECT [CustomerID] FROM [dbo].[Orders]
)
*/ --next line returns exact same result

/* #10a
     SELECT DISTINCT A.[CompanyName]
       FROM [dbo].[Customers] AS A
  LEFT JOIN [dbo].[Orders] AS B
         ON A.[CustomerID] = B.[CustomerID]
      WHERE 1=1
        AND B.[EmployeeID] != '4'
        ORDER BY A.[CompanyName]
;
--*/

/* #10b
SELECT
 [nam] = A.[CompanyName]
FROM
 [dbo].[Customers] AS A
WHERE 1=1
AND A.[CustomerID] NOT IN (
     SELECT [CustomerID] FROM [dbo].[Orders] WHERE [EmployeeID] = '4'
)
;
--*/


/*
  Filename: ...: northwind_challenges_intermediate_level.sql
  Date ........: 04-Jun-2022
  Time ........: 09:34
  Desc ........: The intermediate section of the course
  Notes........:
    10. One employee Margaret Peacock, EmployeeID 4 has placed the most orders. However, thera rea customers who've never placed an order with her. Show only those customers who have never placed an order with her.
    --SELECT [EmployeeID], [full_name] = [FirstName] + ' ' + [LastName] FROM [dbo].[Employees]
    I failed #10 because I returned 88 results. In 10b the results are 16 which means that only those customers have never ordered from Margaret. Wherease, 10a shows only the orders not placed by Margaret.
    9. Find the customer who have never actually placed any orders. Find the list of those customers.
    8. Show EmployeeID, LastName, OrderID, ProductName, Quantity for all orders and sort them by OrderID and ProductID.
    Note that it says "for all orders" so this should be the first table and left join all others. The productid can be joined by using the orderdetails table. returns 2155 rows.
    7. Find top 3 ship countries with highest average freight overall only for order from year 1996, in descending order by avearage freight.
    6. Find top 3 ship countries with highest average frieght overall, in descendingorder by average freight.
    5. Get list of all customers, sorted by region, alphabetically. But keep the customers with no region (null Region) to be at the end, instead of at the top. Within the same region companies should be sorted by CustomerID.
    4. Find the products which need re-rodering with criteria: UnitsInStock + UnitsOnOrder <= ReorderLevel and which are not discontinued.
    3. Find the products which need to be reordered, i.e., UnitsInStock less than ReorderLevel, ignoring fields UnitsOnOrder and Discontinued, and order the results by ProductID.
    Assumptions: include when the unitsInStock are =< the ReorderLevel.
    Normally I prefer not to use a case statement if it is only one condition, so I used IIF for this.
    Note that the requirement is asking to see the products that "need to be reordered" which means we would not include products that have been ordered and just waiting for the shipment and we would not include products that were discontinued because we can't reorder those products.
    2. Find total number of customers per country and city.
    Note this doesn't ask for order by total customers, but it makes more sense to order by country then city and make that a dirived column as location.
    1. Find the total number of products in each category and sort the results by the total number of products in descending order.
    I used group by but this failed because I used too many columns. If simplified to show only categoryname and the county of products it works.
*/


GO