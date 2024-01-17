-- W02 Review: SQL and DDL

/* Problems for You to Solve
Below, I show you the request statement and the name of the solution query in the sample databases. If you want some practice, you can work out the SQL you need for each request and then check your answer with the query I saved in the samples. Don’t worry if your syntax doesn’t exactly match the syntax of the queries I saved—as long as your result set is the same.
*/

-- Sales Orders Database

-- 1. “List customers and the dates they placed an order, sorted in order date sequence.”
-- (Hint: The solution requires a JOIN of two tables.)
-- You can find the solution in CH08_Customers_And_OrderDates (944 rows).

SELECT 
    C.[CustomerID],
    C.[CustFirstName],
    C.[CustLastName],
    O.[OrderNumber],
    O.[OrderDate]
FROM 
    [SalesOrdersExample].[dbo].[Customers] AS C
JOIN
    [SalesOrdersExample].[dbo].[Orders] AS O
ON
    C.[CustomerID] = O.[CustomerID]
ORDER BY
    O.[OrderDate];


-- 2. “List employees and the customers for whom they booked an order.”
-- (Hint: The solution requires a JOIN of more than two tables.)
-- You can find the solution in CH08_Employees_And_Customers (211 rows).

SELECT 
    E.[EmployeeID],
    E.[EmpFirstName],
	E.[EmpLastName],
    C.[CustomerID],
    C.[CustFirstName],
    C.[CustLastName],
    O.[OrderNumber],
    O.[ShipDate]
FROM 
    [SalesOrdersExample].[dbo].[Employees] AS E
JOIN
    [SalesOrdersExample].[dbo].[Orders] AS O
ON
    E.[EmployeeID] = O.[EmployeeID]
JOIN
    [SalesOrdersExample].[dbo].[Customers] AS C
ON
    O.[CustomerID] = C.[CustomerID]
ORDER BY
    E.[EmployeeID], O.[ShipDate];


-- 3. “Display all orders, the products in each order, and the amount owed for each product, in order number sequence.”
-- (Hint: The solution requires a JOIN of more than two tables.)
-- You can find the solution in CH08_Orders_With_Products (3,973 rows).

SELECT 
    O.[OrderNumber],
	O.[OrderDate],
    P.[ProductNumber],
    P.[ProductName],
    OD.[QuantityOrdered],
    OD.[QuotedPrice],
    (OD.[QuantityOrdered] * OD.[QuotedPrice]) AS AmountOwed
FROM 
    [SalesOrdersExample].[dbo].[Orders] AS O
JOIN
    [SalesOrdersExample].[dbo].[Order_Details] AS OD
ON
    O.[OrderNumber] = OD.[OrderNumber]
JOIN
    [SalesOrdersExample].[dbo].[Products] AS P
ON
    OD.[ProductNumber] = P.[ProductNumber]
ORDER BY
    O.[OrderNumber];


-- 4. “Show me the vendors and the products they supply to us for products that cost less than $100.”
-- (Hint: The solution requires a JOIN of more than two tables.)
-- You can find the solution in CH08_Vendors_And_Products_Less_Than_100 (66 rows).

SELECT 
    V.[VendName] AS 'Vendor',
    P.[ProductName] AS 'Product',
    PV.[WholesalePrice] AS 'Price'
FROM 
    [SalesOrdersExample].[dbo].[Product_Vendors] AS PV 
JOIN
    [SalesOrdersExample].[dbo].[Vendors] AS V
ON
    PV.[VendorID] = V.[VendorID]
JOIN
    [SalesOrdersExample].[dbo].[Products] AS P
ON
    P.[ProductNumber] = PV.[ProductNumber]
WHERE
    PV.[WholesalePrice] < 100
ORDER BY
    V.[VendName], PV.[WholesalePrice];


-- 5. “Show me customers and employees who have the same last name.”
-- (Hint: The solution requires a JOIN on matching values.)
-- You can find the solution in CH08_Customers_Employees_Same_LastName (16 rows).

SELECT 
    C.[CustomerID],
    C.[CustFirstName],
    C.[CustLastName],
    E.[EmployeeID],
    E.[EmpFirstName] AS EmployeeFirstName,
    E.[EmpLastName] AS EmployeeLastName
FROM 
    [SalesOrdersExample].[dbo].[Customers] AS C
JOIN
    [SalesOrdersExample].[dbo].[Employees] AS E
ON
    C.[CustLastName] = E.[EmpLastName]
ORDER BY
    C.[CustLastName];

-- 6. “Show me customers and employees who live in the same city.”
-- (Hint: The solution requires a JOIN on matching values.)
-- You can find the solution in CH08_Customers_Employees_Same_City (10 rows).

SELECT 
	C.[CustCity] as 'City',
    C.[CustomerID],
    C.[CustFirstName],
    C.[CustLastName],
    E.[EmployeeID],
    E.[EmpFirstName],
    E.[EmpLastName]
FROM 
    [SalesOrdersExample].[dbo].[Customers] AS C
JOIN
    [SalesOrdersExample].[dbo].[Employees] AS E
ON
    C.[CustCity] = E.[EmpCity]
ORDER BY
    C.[CustCity];

-- Entertainment Agency Database

-- 1. “Display agents and the engagement dates they booked, sorted by booking start date.”
-- (Hint: The solution requires a JOIN of two tables.)
-- You can find the solution in CH08_Agents_Booked_Dates (111 rows).

SELECT 
	A.[AgtFirstName],
    A.[AgtLastName],
	E.[StartDate]
FROM 
    [EntertainmentAgencyExample].[dbo].[Agents] AS A
JOIN
    [EntertainmentAgencyExample].[dbo].[Engagements] AS E
ON
    A.[AgentID] = E.[AgentID]
ORDER BY
    E.[StartDate];

-- 2. “List customers and the entertainers they booked.”
-- (Hint: The solution requires a JOIN of more than two tables.)
-- You can find the solution in CH08_Customers_Booked_Entertainers (75 rows).

SELECT 
	A.[AgtFirstName],
    A.[AgtLastName],
	E.[StartDate],
	Ent.[EntStageName]
FROM 
    [EntertainmentAgencyExample].[dbo].[Agents] AS A
JOIN
    [EntertainmentAgencyExample].[dbo].[Engagements] AS E
ON
    A.[AgentID] = E.[AgentID]

JOIN
    [EntertainmentAgencyExample].[dbo].[Entertainers] AS Ent
ON
    E.[EntertainerID] = Ent.[EntertainerID]
ORDER BY
    E.[StartDate];

-- 3. “Find the agents and entertainers who live in the same postal code.”
-- (Hint: The solution requires a JOIN on matching values.)
-- You can find the solution in CH08_Agents_Entertainers_Same_Postal (10 rows).

SELECT 
	Ent.[EntZipCode],
	A.[AgtFirstName],
    A.[AgtLastName],
	E.[StartDate],
	Ent.[EntStageName]
FROM 
    [EntertainmentAgencyExample].[dbo].[Agents] AS A
JOIN
    [EntertainmentAgencyExample].[dbo].[Engagements] AS E
ON
    A.[AgentID] = E.[AgentID]

JOIN
    [EntertainmentAgencyExample].[dbo].[Entertainers] AS Ent
ON
    A.[AgtZipCode] = Ent.[EntZipCode]
ORDER BY
    E.[StartDate];
