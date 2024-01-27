**W04 Scenario:**

You are starting to get the sense that the previous "Jack of all trades" IT guy spent more time bowling than caring for his systems. You feel this way because there doesn't seem to be a test server, which means all development was done on the live (production) system. This is a risky way to conduct business and you are determined to change it. You also wonder if the database has ever been backed up!

**W04 Scenario Submission Guidelines:**

Be sure you submit all elements labeled by the bolded word, SHOW.

**NOTE**: All steps should be done on your own instance of SQL Server and only on the class server when specified (such as in step 3b).

1. Use the data dictionary to write a query to find out when the last time all of your databases were backed up. Hint: use msdb.dbo.backupset and the example at the bottom of that page (or come up with your own).
 
	**SHOW 1**: Your query and the results.


    ```sql
	USE msdb;
	GO

	SELECT
		database_name AS 'Database',
		MAX(backup_finish_date) AS 'LastBackupDate'
	FROM
		dbo.backupset
	WHERE
		type = 'D' -- 'D' denotes a full database backup
	GROUP BY
		database_name;
    ```
---

2. Make new backups for ALL of your user databases (not system databases).

	**SHOW 2**: 
	The method you used to backup the databases. 
	Re-run the query from step one, proving that you now have recent backups.

    ```sql
	-- Full backup for BowlingLeagueExample
	BACKUP DATABASE [BowlingLeagueExample] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample.bak' WITH INIT;

	-- Full backup for EntertainmentAgencyExample
	BACKUP DATABASE [EntertainmentAgencyExample] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\EntertainmentAgencyExample_backup.bak' WITH INIT;

	-- Full backup for EntertainmentAgencyModify
	BACKUP DATABASE [EntertainmentAgencyModify] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\EntertainmentAgencyModify_backup.bak' WITH INIT;

	-- Full backup for RecipesExample
	BACKUP DATABASE [RecipesExample] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\RecipesExample_backup.bak' WITH INIT;

	-- Full backup for SalesOrdersExample
	BACKUP DATABASE [SalesOrdersExample] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SalesOrdersExample_backup.bak' WITH INIT;

	-- Full backup for SalesOrdersModify
	BACKUP DATABASE [SalesOrdersModify] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SalesOrdersModify_backup.bak' WITH INIT;

	-- Full backup for sample
	BACKUP DATABASE [sample] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\sample_backup.bak' WITH INIT;

	-- Full backup for SchoolSchedulingExample
	BACKUP DATABASE [SchoolSchedulingExample] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SchoolSchedulingExample_backup.bak' WITH INIT;

	-- Full backup for SchoolSchedulingModify
	BACKUP DATABASE [SchoolSchedulingModify] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SchoolSchedulingModify_backup.bak' WITH INIT;

	-- Full backup for WideWorldImporters
	BACKUP DATABASE [WideWorldImporters] TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\WideWorldImporters.bak' WITH INIT;
	```
---

3. You decide to make copies of the bowling database for test purposes:

	Restore the bowling database using your backup from step 2. However, you should restore it within your instance with the new name, "bowling_TEST." Be sure the internal database file names are also changed as part of the restore.
	Use the videos this week to login to the class server in the cloud and restore it there also. You will consider this copy to be a development version. Change the name of the bowling database to start with your last name such as "jones_bowling_development." Again be sure to change your file names.

	**NOTE**: If your SSH connection errors and you are sure you are logged in to GCP correctly (with your BYUI account), you may contact your instructor to restart the server and/or upload your backup file to the appropriate Teams channel and ask a classmate to upload and copy your backup file for you. You can then restore it through Management Studio. Alternatively, if you are comfortable trying to set up your own SSH connection instead, you can do so by following this optional document (skip step 4).

	**SHOW 3 (screenshot examples)**: 
	The process you used to copy the database as a “test” version. Show that the new copy exists.
	The process you used to copy the database as a “development” version. Show that this copy exists in the cloud.

	```sql
	-- Restore locally with a new name "bowling_TEST"
	RESTORE DATABASE [bowling_TEST]
	FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample.bak'
	WITH 
		MOVE 'BowlingLeagueExample' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\bowling_TEST.mdf',
		MOVE 'BowlingLeagueExample_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\bowling_TEST_log.ldf',
		REPLACE;
	```

---

4. Now that you have a local test database, we need to be prepared to refresh certain tables after the live data changes in production (we will say production is your local laptop). You will need to practice backing up and reloading individual tables (instead of whole databases). For this, we will not use backup/restore. We will use the BCP utility outlined in this week's preparation page (and chapter 15 of the book) or in the video in step 2 below.

	Make sure you have a recent backup of your bowling database (you should have this from the above steps).
	Use this student example to run a bcp export on the Bowler_scores and Bowlers tables from your original (production) bowling database on your laptop.
	
	**HINT**: Be sure to change your bcp commands to match your own schema names and folder path on your laptop, as they will likely differ from what the video uses (you will probably have something other than the bowlingadmin schema).
	Validate your export files from step b exist. Run two deletes to wipe out all data in the Bowler_scores and Bowlers tables on your laptop. NOTE: You will need to delete the rows from the Bowler_scores table first due to foreign key dependencies.
	Run a bcp import to reload both tables using your export files created in step b.

	**SHOW 4**:
	Your bcp export files created in step b for the Bowler_scores and Bowlers tables.
	You have deleted all rows in the Bowler_scores and Bowlers tables.
	Successful import messages from step d and that you once again have data in those two tables.

