**W02 Scenario Submission Guidelines**:

*Be sure you submit all elements labeled by the bolded word, **SHOW**.*

**NOTE**: 
Some of these steps refer to a database of your choice. In addition to the databases requested, you will choose to examine one additional database from the Mere Mortals book (EntertainmentAgency, Recipes, SalesOrder, or SchoolScheduling).
For all of these steps, you do NOT need to show the information requested within one complex query. It might be easier for you to address things in smaller pieces by writing multiple queries (one for each database). If you need to refresh your SQL first, please look at the W2 SQL Review assignment.

-------------

1. In your new job, you need to be aware of how many tables you must manage in each database. One way to do this is:
Run a query using "sys.tables" within each database to discover all user tables (type = ‘U’) in the three databases (WideWorldImporters, Bowling, and your chosen DB).

    **HINT**: Notice at the top of the sys.tables documentation that some data dictionary columns, such as ‘type,’ are inherited from sys.objects. You do not need to join to this table, but it is something to be aware of. All database ‘objects’ share these inherited attributes.
 
    **SHOW 1**: Your queries and query results. The results should include the names of all user tables in each database, when each was created, and last modified date.

    ```sql
    -- Identify and lists throughout all tables in your database

    -- For WideWorldImporters
    SELECT name AS TableName, create_date AS CreatedDate, modify_date AS LastModifiedDate
    FROM WideWorldImporters.sys.tables
    WHERE type = 'U';

    -- For Bowling
    SELECT name AS TableName, create_date AS CreatedDate, modify_date AS LastModifiedDate
    FROM BowlingLeagueExample.sys.tables
    WHERE type = 'U';

    -- For choosen DB (SalesOrdersExample)
    SELECT name AS TableName, create_date AS CreatedDate, modify_date AS LastModifiedDate
    FROM SalesOrdersExample.sys.tables
    WHERE type = 'U';
    ```
-------------

2. During the job interview, you were told that the company recently ran into a customer whose name length exceeded the defined column size. You want to make sure this never happens again. Start by identifying all columns that contain any type of name data. One way to do this is:
Run a query using “sys.columns” and "sys.tables" in the same three databases (one query for each) to identify all columns which include the string "name" within the column name. We should also show the currently configured maximum length for these columns. You should also display the tables each column belongs to.

    **HINT**: In your SQL, you will need to use the LIKE operator and wildcards to see all relevant columns (such as first_name, customerName, etc.). The wildcards should also consider “name” may be in the middle or at the beginning of the column name.  
    **HINT**: You will need to perform a two table JOIN (video review on joins). Keep in mind, many thousands of developers and administrators worldwide are using the data dictionary to answer these types of questions. You can easily do web searches on how to use and join these system catalog views. These data dictionary tables and views are similar for all installations of SQL Server. Try 
searches such as ‘sql server sys.columns join sys.tables list all columns for each table.’ Also, go read the documentation for sys.columns to see what ‘object_ID’ is!

    **SHOW 2**: Your queries and query results for each of the three databases. The results should include: the name of the column, the name of the table the column belongs to, and the current maximum length for that column.

    ```sql

    -- Identify which columns have "name" in the column's name throughout all tables in your database

    -- For WideWorldImporters
    SELECT c.name AS columnName, t.name AS tableName, c.max_length AS maxLength
    FROM WideWorldImporters.sys.columns c
    JOIN WideWorldImporters.sys.tables t ON c.object_id = t.object_id
    WHERE c.name LIKE '%name%';

    -- For Bowling
    SELECT c.name AS columnName, t.name AS tableName, c.max_length AS maxLength
    FROM BowlingLeagueExample.sys.columns c
    JOIN BowlingLeagueExample.sys.tables t ON c.object_id = t.object_id
    WHERE c.name LIKE '%name%';

    -- For choosen DB (SalesOrdersExample)
    SELECT c.name AS columnName, t.name AS tableName, c.max_length AS maxLength
    FROM SalesOrdersExample.sys.columns c
    JOIN SalesOrdersExample.sys.tables t ON c.object_id = t.object_id
    WHERE c.name LIKE '%name%';
    ```
-------------

3. It is also important to know which databases are your “heavy hitters” in terms of space and resource consumption. 
Run queries using the same three databases you previously explored to find out how large each database is and where the largest files are stored. We should also convert the file sizes shown in the data dictionary to MB.

    **HINT**: Take a look at the system catalog views regarding databases and files. Try querying them or reading the documentation to determine which to use. You will have to do some conversion, because the “size” column lists a different type of measurement in the documentation. Read it carefully as well as this page for database storage measurements.

    **SHOW 3**: 
Queries and results which list the file name, file location, and file size (as listed in the database_files catalog view without conversion) of any file greater than or equal to size 1024.
Queries and results which list the full size of each database in MB. You will have to add the size for each database file using the SUM function and then include the calculations from the hint above. (Video review on using math in your SQL.)
Show the screen in your Windows explorer where you navigate to the folder which holds the files (listed in your query from part i). Identify them and compare them to your results from steps i and ii. Your calculations from step ii should match what you see in Windows!

    ```sql
    -- Identify which files inside the columns have have more than 1024 pixls of size throughout all tables in your database
    
    -- For WideWorldImporters
    SELECT 
        t.name AS TableName,
        mf.name AS FileName,
        mf.physical_name AS FileLocation,
        mf.size AS FileSize
    FROM 
        WideWorldImporters.sys.master_files mf
    JOIN 
        WideWorldImporters.sys.tables t ON mf.database_id = DB_ID()
    WHERE 
        mf.size >= 1024;


    -- For Bowling
    SELECT 
        t.name AS TableName,
        bl.name AS FileName,
        bl.physical_name AS FileLocation,
        bl.size AS FileSize
    FROM 
        BowlingLeagueModify.sys.master_files bl
    JOIN 
        BowlingLeagueModify.sys.tables t ON bl.database_id = DB_ID()
    WHERE 
        bl.size >= 1024;


    -- For choosen DB (SalesOrdersExample)
    SELECT 
        t.name AS TableName,
        so.name AS FileName,
        so.physical_name AS FileLocation,
        so.size AS FileSize
    FROM 
        SalesOrdersExample.sys.master_files so
    JOIN 
        SalesOrdersExample.sys.tables t ON so.database_id = DB_ID()
    WHERE 
        so.size >= 1024;
    ```
-------------

4. Take a closer look at any of the catalog tables/views mentioned in the week 2 preparation post (Always read the preparation posts!). Read through the official Microsoft documentation or the book to find out what the columns mean. Find two more items that could be of interest to you in administering these databases. 

    **SHOW 4**: The two items you discovered in the data dictionary and the corresponding query results. Explain why you believe these would be important to keep an eye on.
