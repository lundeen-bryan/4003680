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

--/* #4
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



/*
  Filename: ...: northwind_challenges_intermediate_level.sql
  Date ........: 04-Jun-2022
  Time ........: 09:34
  Desc ........: The intermediate section of the course
  Notes........:
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