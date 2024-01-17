/* Problems for You to Solve
Below, I show you the request statement and the name of the solution query in the sample databases. If you want some practice, you can work out the SQL you need for each request and then check your answer with the query I saved in the samples. Don’t worry if your syntax doesn’t exactly match the syntax of the queries I saved—as long as your result set is the same.

Sales Orders Database
1. “List customers and the dates they placed an order, sorted in order date sequence.”
(Hint: The solution requires a JOIN of two tables.)
You can find the solution in CH08_Customers_And_OrderDates (944 rows).*/

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


/*2. “List employees and the customers for whom they booked an order.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Employees_And_Customers (211 rows).*/

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


/*3. “Display all orders, the products in each order, and the amount owed for each product, in order number sequence.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Orders_With_Products (3,973 rows).*/

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


/*4. “Show me the vendors and the products they supply to us for products that cost less than $100.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Vendors_And_Products_Less_Than_100 (66 rows).*/

/*5. “Show me customers and employees who have the same last name.”
(Hint: The solution requires a JOIN on matching values.)
You can find the solution in CH08_Customers_Employees_Same_LastName (16 rows).*/

/*6. “Show me customers and employees who live in the same city.”
(Hint: The solution requires a JOIN on matching values.)
You can find the solution in CH08_Customers_Employees_Same_City (10 rows).*/

/*Entertainment Agency Database
1. “Display agents and the engagement dates they booked, sorted by booking start date.”
(Hint: The solution requires a JOIN of two tables.)
You can find the solution in CH08_Agents_Booked_Dates (111 rows).*/

/*2. “List customers and the entertainers they booked.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Customers_Booked_Entertainers (75 rows).*/

/*3. “Find the agents and entertainers who live in the same postal code.”
(Hint: The solution requires a JOIN on matching values.)
You can find the solution in CH08_Agents_Entertainers_Same_Postal (10 rows).*/

/*School Scheduling Database
1. “Display buildings and all the classrooms in each building.”
(Hint: The solution requires a JOIN of two tables.)
You can find the solution in CH08_Buildings_Classrooms (47 rows).*/

/*2. “List students and all the classes in which they are currently enrolled.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Student_Enrollments (50 rows).*/

/*3. “List the faculty staff and the subject each teaches.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Staff_Subjects (110 rows).*/

/*4. “Show me the students who have a grade of 85 or better in art and who also have a grade of 85 or better in any computer course.”
(Hint: The solution requires a JOIN on matching values.)
You can find the solution in CH08_Good_Art_CS_Students (1 row).*/

/*Bowling League Database
1. “List the bowling teams and all the team members.”
(Hint: The solution requires a JOIN of two tables.)
You can find the solution in CH08_Teams_And_Bowlers (32 rows).*/

/*2. “Display the bowlers, the matches they played in, and the bowler game scores.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Bowler_Game_Scores (1,344 rows).*/

/*3. “Find the bowlers who live in the same ZIP Code.”
(Hint: The solution requires a JOIN on matching values, and be sure to not match bowlers with themselves.)
You can find the solution in CH08_Bowlers_Same_ZipCode (92 rows).*/

/*Recipes Database
1. “List all the recipes for salads.”
(Hint: The solution requires a JOIN of two tables.)
You can find the solution in CH08_Salads (1 row).*/

/*2. “List all recipes that contain a dairy ingredient.”
(Hint: The solution requires a JOIN of more than two tables.)
You can find the solution in CH08_Recipes_Containing_Dairy (2 rows).*/

/*3. “Find the ingredients that use the same default measurement amount.”
(Hint: The solution requires a JOIN on matching values.)
You can find the solution in CH08_Ingredients_Same_Measure (628 rows).*/

/*4. “Show me the recipes that have beef and garlic.”
(Hint: The solution requires a JOIN on matching values.)
You can find the solution in CH08_Beef_And_Garlic_Recipes (1 row). */