USE [NORTHWND]
GO

/* #10
     SELECT [employee_id] = A.[EmployeeID]
          , [name] = B.[FirstName] + ' ' + B.[LastName]
          , [total_orders_late] = COUNT(*)
       FROM [dbo].[Orders] AS A
       JOIN [dbo].[Employees] AS B
         ON A.[EmployeeID] = B.[EmployeeID]
      WHERE 1 = 1
        AND A.[ShippedDate] > A.[RequiredDate]
   GROUP BY A.[EmployeeID]
          , B.[FirstName]
          , B.[LastName]
   ORDER BY [total_orders_late] DESC
;
--*/

--/* #11
     SELECT [employee_id] = A.[EmployeeID]
          , [name] = B.[FirstName] + ' ' + B.[LastName]
          , [total_orders_late] = COUNT(*)
       FROM [dbo].[Orders] AS A
       JOIN [dbo].[Employees] AS B
         ON A.[EmployeeID] = B.[EmployeeID]
      WHERE 1 = 1
        AND A.[ShippedDate] > A.[RequiredDate]
   GROUP BY A.[EmployeeID]
          , B.[FirstName]
          , B.[LastName]
   ORDER BY [total_orders_late] DESC



;
--*/


/*
  Filename: ...: northwind_challenges_advanced_level part2.sql
  Date ........: 11-Jun-2022
  Time ........: 17:29
  Desc ........: Part 2 of the advanced
  Notes........:
   11. In the previous query add one more column TotalOrders placed for
       each Employee, to compare it against TotalOrdersLate.
   10. Some of the salespeople have more orders arriving late than
       others. Maybe they're not following up on the order process, and
       need more training. Which sales people have the most orders
       arriving late?
    */



GO