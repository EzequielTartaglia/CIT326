**W08 Scenario Submission Guidelines**:

Be sure you submit all elements labeled by the bolded word, SHOW. You may choose to submit two videos this week or combine them into one.

**Scenario 1 Description (30 points) :**
Your company would like you to set up a maintenance plan to ensure overall health for a database of your choice. Watch the videos below and review the other resources to help you in this task.
- Getting Started with Maintenance Plans For Backups
- Additional Considerations for Maintenance Plan Backups
- The Maintenance Plan Wizard Section of Chapter 16 in our Textbook
- Microsoft Learn
- Microsoft Documentation
- MSSQL Tips tutorials:
- Check Integrity
- Rebuild Indexes
- Reorganize Indexes and Update Statistics
- Cleanup History (optional)

**SHOW 1:** 
That the following tasks are present in your maintenance plan and prove they are successful: 
    
```sql
    use SalesOrdersExample;

    -- Check Database Integrity
    DBCC CHECKDB (SalesOrdersExample) WITH NO_INFOMSGS;

    -- Rebuild Index
    ALTER INDEX ALL ON dbo.Order_Details REBUILD;

    -- Reorganize Indexes and Update Statistics
    ALTER INDEX ALL ON dbo.Order_Details REORGANIZE;
    UPDATE STATISTICS dbo.Order_Details;

    -- Backup Database (Full)
    BACKUP DATABASE [SalesOrdersExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SalesOrdersExample_backup.bak' WITH NOFORMAT, NOINIT,  NAME = N'SalesOrdersExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
    GO

    -- Cleanup History (optional)

    -- A schedule for each task to run (even if it is only a combined one-time schedule)

    -- Schedule for Backup Database (Full)
    EXEC sp_add_schedule @schedule_name = N'Backup_Database_Schedule', @freq_type = 4, @freq_interval = 1, @active_start_time = 010300;
    GO
    EXEC sp_attach_schedule @job_name = N'Backup_Database_Job', @schedule_name = N'Backup_Database_Schedule';
    GO

```

**HINT:**  As long as you can show a successful task for each of these, we will not worry about the scheduling order or dependencies. They can be separate jobs or steps within the same job.

---

**Scenario 2 Description (40 points):**

Your success in job automation last week has you wondering what else you can do to improve the quality of your environment. Take this opportunity to come up with a scenario for any one of your installed databases that requires job automation to manage. The scenario should be related to the topics covered in this course up to this point or related to the topic you explored during this week’s review and explore assignment.

**SHOW 2:** 
The concept you are implementing and explain why it will help the company. 
The job that will help your implementation and the code inside of each step in the job.
The results after the job runs successfully. 

```sql
    -- Step 1: Verify Transaction Log File Size

    -- Query to check the size of the transaction log file
    DECLARE @LogSizeMB FLOAT;
    SELECT @LogSizeMB = (size * 8.0) / 1024
    FROM sys.database_files
    WHERE type_desc = 'LOG';

    -- Check the transaction log file size against the predefined threshold
    DECLARE @ThresholdMB FLOAT = 100; -- Predefined threshold in megabytes
    IF @LogSizeMB > @ThresholdMB
    BEGIN
        PRINT 'The transaction log file size exceeds the predefined threshold of ' + CAST(@ThresholdMB AS VARCHAR(10)) + ' MB.';
        -- Perform additional actions here if necessary
    END
    ELSE
    BEGIN
        PRINT 'The transaction log file size is within the predefined threshold.';
    END

    -- Step 2: Backup Transaction Log File

    -- Query to perform a backup of the transaction log file
    BACKUP LOG [SalesOrdersExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\SalesOrdersExample_backup.bak' WITH NOFORMAT, NOINIT,  NAME = N'SalesOrdersExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
    GO
```
```bash
Result:

The transaction log file size is within the predefined threshold.
55 percent processed.
100 percent processed.
Processed 230 pages for database 'SalesOrdersExample', file 'SalesOrdersExample_log' on file 3.
BACKUP LOG successfully processed 230 pages in 0.180 seconds (9.982 MB/sec).

Completion time: 2024-02-24T21:11:57.5637671-03:00
```

**NOTE:** If you find a feature that doesn’t work well with job automation, you can still create a job to check that the feature is enabled and report on the status of the feature regularly (to verify it is still enabled each Monday, for example). If you have a different way to implement the feature (without a job), please explain and show in detail how you would implement the feature of your choice.

**HINTS:**
You are encouraged to do your own search related to something in the book or take a deeper dive into something we have already covered (as mentioned, it can be the same as the topic you chose for the explore assignment). But, if you are coming up empty, here are other interesting possibilities:
- Discuss Microsoft SQL Server best practices with ChatGPT!
- This link includes some SQL Server Best Practices, particularly the “Checklists.”
- Microsoft suggested best practices (scroll down to “SQL Server Features”).
- You could also browse through SQL Server Blogs, such as this one.


