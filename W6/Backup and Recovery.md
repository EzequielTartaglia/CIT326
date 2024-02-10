**W06 Scenario Submission Guidelines:**

Be sure you submit all elements labeled by the bolded word, SHOW.

**Scenario 1 Description:**

The owner of the bowling league, Karl, recently had a scare when a Chicago ice storm knocked the power out and the database server went down. Luckily, everything powered back on and came online. This was enough for him to ask you, "What could we have done if the server was corrupted and the data was no longer readable?"

You ask a few more questions and find out that he would be totally satisfied if he knew he could at least get back to the information at the end of each night, after all of the leagues and players are finished. He isn't worried about up to the minute changes or data loss during the day. Though he would like to have peace of mind, he is also worried about incurring extra server and disk space costs for his bowling alley that is barely turning a profit (even with insane margins on cheap food). In other words, he wants to have a nightly recovery plan with the lowest possible amount of disk space usage.

**SHOW 1:** 
Tell what recovery model you chose and explain why.
Your suggested implementation plan for this scenario. 
Demonstrate your implementation plan by making various backup(s), transaction(s) (inserts, updates, or deletes) and a restore (or restores) for Karl using your plan.

```sql
USE [BowlingLeagueExample];
ALTER DATABASE [BowlingLeagueExample] SET RECOVERY SIMPLE;

BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExampletlog.trl' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

SELECT * FROM ztbWeeks;

INSERT INTO ztbWeeks VALUES('2024-02-10', '2024-03-01')
SELECT GETDATE();
-- 2024-02-10 17:07:14.907


BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExampletlog.trl' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

INSERT INTO ztbWeeks VALUES('2024-03-10', '2024-04-01')
SELECT GETDATE();
-- 2024-02-10 17:10:51.270


BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExampletlog.trl' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- Choosen 6 hours interval
USE [master]
ALTER DATABASE [BowlingLeagueExample] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [BowlingLeagueExample] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\BowlingLeagueExample_backup.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [BowlingLeagueExample] SET MULTI_USER

GO
```
	
----

**Scenario 2 Description:**

The CIO (Chief Information Officer) of Wide World Importers is concerned about data loss. The company is growing fast and has extra budget to spare to cover needs. He says he can't afford to lose sleep worrying about whether the company's IT needs are keeping up with the growth. He asks you to do whatever it takes to come up with the most complete and constant coverage possible.

**SHOW 2:** 
Tell what recovery model you chose and explain why.
Your suggested implementation plan for this scenario. 
Demonstrate your implementation plan by making various backup(s), transaction(s) (inserts, updates, or deletes) and a restore (or restores) for the CIO using your plan.

**HINTS:**
This video from the weekly preparation post (please remember to go through the preparation material each week) could help you with your plan and demonstration.
Check Chapter 16 on how to display and change database recovery models.
Would the executive feel comfortable with your recovery solution? If you are not giving the executive thorough examples of data being deleted and then recovered, how can he/she feel good about it? (This should be a longer video than average.)
If you are looking to do some havoc with DELETES, you will need to find tables that do not have other tables depending on them that prevent DELETES. You can run this data dictionary query in each database to find such tables:
Be sure to ‘USE’ the database you want first:
SELECT t.NAME AS TableName
FROM sys.Tables t
LEFT JOIN sys.sql_expression_dependencies d ON d.referenced_id = t.object_id
WHERE d.referenced_id IS NULL;

```sql
USE [WideWorldImporters];
ALTER DATABASE [WideWorldImporters] SET RECOVERY FULL;

BACKUP DATABASE [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\WideWorldImportersFull_bak' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP LOG [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\WideWorldImportersFull_bak' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


-- Choosen a hour interval
USE [master]
ALTER DATABASE [WideWorldImporters] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [WideWorldImporters] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\WideWorldImportersFull_bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE [WideWorldImporters] SET MULTI_USER
GO
```
