**W03 Scenario - Database Security**

Your new manager has many concerns about database security. After reading about a recent data breach in the news, it is one of the things that keeps him up at night. Help calm your manager’s nerves by investigating how to control database security more precisely.

**W03 Scenario Submission Guidelines:**

Be sure you submit all elements labeled by the bolded word, SHOW.

**NOTE**: 
If you have doubts about these security tasks, the best approach is to experiment. **TRY** it, **GRANT** it, **LOGIN** (with the new account), and **TEST** it.

1. The owner of the company has some security questions for you…

    What is Windows authentication in SQL Server? What is one benefit to Windows Authentication over SQL Authentication? 

    **Windows authentication in SQL Server is a mechanism that allows users to connect to a SQL Server instance using their Windows credentials. This means that the user's Windows account is used for authentication without requiring a separate set of credentials within SQL Server.(https://learn.microsoft.com/es-es/windows-server/security/windows-authentication/windows-authentication-overview)**

    **A key benefit of Windows Authentication is that it leverages the existing security infrastructure of the Windows operating system. Users don't need to remember additional credentials for SQL Server, and administrators can manage access centrally through Active Directory, enhancing security and simplifying user management. (https://learn.microsoft.com/es-es/windows-server/security/windows-authentication/windows-authentication-overview)**

    Explain the difference between authentication and authorization. Give an example of authorization in the database.

    **Authentication: Process of verifying the identity of a user, system, or application. It ensures that the entity trying to access a system is who it claims to be. Authentication is typically achieved through the presentation of credentials, such as usernames and passwords, biometric data, or security tokens.**

    **Authorization: Process of granting or denying access to specific resources or actions based on the authenticated entity's permissions. Once a user or system is authenticated, authorization determines what actions or data that authenticated entity is allowed to access or modify.**

    ```sql
    USE [SalesOrdersExample];

    -- Create User "BYU_student_user"
    CREATE USER [BYU_student_user] FOR LOGIN [BYU_student_user];

    -- Assign to Data Reader Role ("db_datareader")
    ALTER ROLE [db_datareader] ADD MEMBER [BYU_student_user];

    -- Create Schema "BYU_student"
    CREATE SCHEMA [BYU_student];

    -- Transfer Tables to Schema "BYU_student"
    ALTER SCHEMA [BYU_student] TRANSFER Categories;
    ALTER SCHEMA [BYU_student] TRANSFER Customers;
    ALTER SCHEMA [BYU_student] TRANSFER Employees;
    ALTER SCHEMA [BYU_student] TRANSFER Vendors;

    -- Grant SELECT Permissions on Schema "BYU_student"
    GRANT SELECT ON SCHEMA::[BYU_student] TO [BYU_student_user];
    ```

    Verify your SQL Server installation is in mixed authorization mode and can accept both Windows and SQL Server Authentication.

    ```sql
    DECLARE @AuthenticationMode INT  

    -- Determine the authentication mode
    EXEC master.dbo.xp_instance_regread 
        N'HKEY_LOCAL_MACHINE', 
        N'Software\Microsoft\MSSQLServer\MSSQLServer',   
        N'LoginMode', 
        @AuthenticationMode OUTPUT  

    -- Retreive the result
    SELECT CASE @AuthenticationMode    
        WHEN 1 THEN 'Windows Authentication'   
        WHEN 2 THEN 'Windows and SQL Server Authentication'   
        ELSE 'Unknown'  
    END as [Authentication Mode]  
    ```

    What would happen if you grant SELECT permission on a table to the fixed database role called ‘public?’ Would this granted permission apply to future users also (users that are not created yet)? Why could this be dangerous? HINT: Look under ‘Fixed Database Roles’ in Chapter 12 or here in the Microsoft documentation.
 
    **Granting SELECT permission on a table to the 'public' role means that all users in the database, including future users, will have SELECT permission on that table. This is because every user is a member of the 'public' role by default. If a new user is added to the database, they will also inherit the SELECT permission on the specified table through their membership in the 'public' role.**

     **This approach may be dangerous for the following reasons:**

    **Security Risks: If sensitive data is involved, granting broad permissions to the 'public' role could lead to unauthorized access.**

    **Lack of Granularity: The 'public' role is an all-or-nothing proposition. Permissions granted to 'public' apply universally to all users, limiting the granularity of access control.**

    **Maintenance Challenges: Managing and auditing permissions become challenging when granted through 'public,' as it may not be clear which users have access to specific objects.**

    **Unintended Privilege Escalation: Granting permissions to 'public' may inadvertently elevate the privileges of users who should not have had those permissions.**

    **(https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver15)**

    **SHOW 1:** Your understanding by answering these questions confidently. Use the textbook or Microsoft documentation to verify your answers.

---

2. You have heard that using ‘schemas’ can give you added flexibility and control in database security. You decide to test this by doing the following:
Create two new schemas for the Bowling database and two more for an additional database of your choice. You will be creating four schemas total.
Transfer the tables in the bowling database and your chosen database out of the dbo (database owner) schema and into the four new schemas. How you choose to separate the tables into these schemas is completely up to you (you will not be graded on that choice). **NOTE**: Tables can only belong to one schema.

    Create four new logins and map them to each database (two for each database). Issue a grant command that will give SELECT rights on an entire schema (one for each user). Do this for each of the four logins. Test this authorization by logging in with these new users.

    **HINT**: Remember that a “login” is on the instance/server level and is used for authentication. Each login can map to one or more users in each of the databases in the instance. Logins receive instance/server level authorizations. Users receive database/schema/table/etc level authorizations. Consider users to be under the umbrella of a login.


    **SHOW 2:**
    The four new schemas you created and the process you used to do so.
    The process you used to transfer the tables into the four new schemas.
    Proof that each of the four logins can access the schema intended and no other schemas.

    ```sql
    -- For the Bowling database
    USE [BowlingLeagueExample];
    -- Create Two New Schemas
    CREATE SCHEMA [Marketing];
    CREATE SCHEMA [Technology];,

    -- Transfer Tables to New Schemas
    ALTER SCHEMA [Marketing] TRANSFER dbo.Teams;
    ALTER SCHEMA [Marketing] TRANSFER dbo.Bowlers;
    ALTER SCHEMA [Technology] TRANSFER dbo.Tournaments;
    ALTER SCHEMA [Technology] TRANSFER dbo.Bowler_Scores;


    -- Create Four New Logins and Map to Databases
    CREATE LOGIN [User_Marketing] WITH PASSWORD = 'password';
    CREATE USER [User_Marketing] FOR LOGIN [User_Marketing];
    ALTER ROLE [db_datareader] ADD MEMBER [User_Marketing];

    CREATE LOGIN [User_HR] WITH PASSWORD = 'password';
    CREATE USER [User_HR] FOR LOGIN [User_HR];
    ALTER ROLE [db_datareader] ADD MEMBER [User_HR];

    CREATE LOGIN [User_Sales] WITH PASSWORD = 'password';
    CREATE USER [User_Sales] FOR LOGIN [User_Sales];
    ALTER ROLE [db_datareader] ADD MEMBER [User_Sales];

    CREATE LOGIN [User_Tech] WITH PASSWORD = 'password';
    CREATE USER [User_Tech] FOR LOGIN [User_Tech];
    ALTER ROLE [db_datareader] ADD MEMBER [User_Tech];

    -- Issuing Grant Commands for SELECT Rights on Entire Schemas
    GRANT SELECT ON SCHEMA::[Marketing] TO [User_Marketing];
    GRANT SELECT ON SCHEMA::[Marketing] TO [User_HR];
    GRANT SELECT ON SCHEMA::[Technology] TO [User_Sales];
    GRANT SELECT ON SCHEMA::[Technology] TO [User_Tech];

    -- Test Authorization by Logging in with New Users
    USE BowlingLeagueExample; 
    SELECT * FROM [Marketing].Teams;
    SELECT * FROM [Marketing].Bowlers;
    SELECT * FROM [Technology].Tournaments;
    SELECT * FROM [Technology].Bowler_Scores;
    ```
---


3. With “user-defined roles,” determine a common level of authorization privileges new users should have in one database of your choice. This may be different for each business model (database) according to your discretion.
First, you decide to create a list of DCL (Data Control Language or “GRANT commands”) to assign to every future entry-level user of a given database. You can choose whatever you would like for the users to be authorized to do.
**HINT**: Here is a student example of practicing DCL for two test users.

    Then, you get smarter and realize you can use a user-defined role as explained in chapter 12 instead of issuing so many separate GRANTS for each individual user. Create a role for new employees and grant the permissions you listed in ‘3a’ directly to the new role instead.		
    **HINT**: Here is the student example from this week’s preparation post on how to use a fixed role for permissions. In your case, you will instead add users to the custom role you create.

    Create two new database logins/users and add them as members to the new role from ‘3b’ instead of granting the permissions one by one directly to the users. In this manner, you save time and are less error prone.

    **SHOW 3:** 
    All DCL code (“GRANT” statements) from step ‘a’ above.
    The process you used to create a role with the needed DCL authorization commands instead.
    Proof that the new role works as it should for your two new logins/users.

    ```sql
    -- Define the permissions for entry-level users
    CREATE SCHEMA [Salesman];
    GRANT SELECT ON SCHEMA::[Salesman] TO [BYU_student_user];
    GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[Salesman] TO [BYU_student_user];

    -- Create a user-defined role and grant permissions to the role
    CREATE ROLE [Super_user];

    -- Grant the permissions directly to the new role
    GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::[Salesman] TO [Super_user];

    -- Create two new database logins/users
    CREATE LOGIN [EzequielW3] WITH PASSWORD = 'password';
    CREATE USER [EzequielW3] FOR LOGIN [EzequielW3];
    ALTER ROLE [Super_user] ADD MEMBER [EzequielW3]; -- Add EzequielW3 to the role

    CREATE LOGIN [MatiasW3] WITH PASSWORD = 'password';
    CREATE USER [MatiasW3] FOR LOGIN [MatiasW3];
    ALTER ROLE [Super_user] ADD MEMBER [MatiasW3]; -- Add MatiasW3 to the role

    -- Test the new role's permissions with the two new logins
    USE [SalesOrdersExample];

    -- Verify SELECT permission for EzequielW3
    EXECUTE AS USER = 'EzequielW3';
    SELECT * FROM Salesman.Orders; -- Adjust object names based on your actual schema and table names
    REVERT;

    -- Verify INSERT permission for MatiasW3
    EXECUTE AS USER = 'MatiasW3';
    INSERT INTO Salesman.Orders (OrderDate, ShipDate,CustomerID,EmployeeID) VALUES (now(), now(),1,3); 
    REVERT;
    ```

---

4. Investigate these security related data dictionary entries (or others you may find) to see where you can see evidence of the new schemas, logins, users, or role from this assignment in the data dictionary. 

    **SHOW 4:**

    A query and results that include data dictionary information showing evidence of something you did in this assignment (perhaps a query that shows a new schema, login, or user-defined role you created in steps 1, 2, or 3).

   ```sql
    -- Retreive new schemas
    SELECT schema_name
    FROM information_schema.schemata
    WHERE schema_name IN ('Marketing', 'Technology', 'Salesman');

    -- Retreive new logins
    SELECT name
    FROM sys.sql_logins
    WHERE name IN ('EzequielW3', 'MatiasW3', 'User_Marketing', 'User_HR', 'User_Sales', 'User_Tech');

    -- Retreive new roles
    SELECT name
    FROM sys.database_principals
    WHERE type_desc = 'DATABASE_ROLE' AND name = 'Super_user';
    ```

    One additional data dictionary query regarding anything in database security that might be useful to the business going forward. Include the query, the results, and your explanation for why it would be a useful security report.


    ```sql
    -- Retrieve permitions's users
    SELECT 
        princ.name AS [User_Name],
        princ.type_desc AS [User_Type],
        role.name AS [Role_Name],
        role.type_desc AS [Role_Type],
        role.is_fixed_role AS [Is_Fixed_Role]
    FROM sys.database_role_members role_members
    JOIN sys.database_principals princ ON role_members.member_principal_id = princ.principal_id
    JOIN sys.database_principals role ON role_members.role_principal_id = role.principal_id
    ORDER BY [User_Name], [Role_Name];
    ```
