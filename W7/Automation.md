**W07 Scenario**:

Karl is encouraged by your efforts and wants to ramp up development efforts of the bowling system. He hires Ralph, who says he is a SQL Server DBA, to help you and support a small growing team of developers. It doesn't take you long to find out Ralph has a nasty habit… "Hey, as long as we are just developing things, l just add all new users to the sysadmin server role. That way I can go out for my deep dish pizza without getting a phone call about someone having insufficient privileges and halting development." You know this "natural man" attitude doesn't feel quite right, so you decide to take action.

**W07 Scenario Submission Guidelines**:

Be sure you submit all elements labeled by the bolded word, SHOW.

You realize you need to explain to Ralph and Karl why you think the overuse of the sysadmin role can cause trouble and should be avoided at all costs.

**SHOW 1**: Your understanding of security best practices by explaining this in your video.


1. **Excessive Privileges: The sysadmin role grants unrestricted access to all aspects of the SQL Server instance. Assigning this role to users who don't actually need such extensive permissions introduces unnecessary risk. It's like giving someone the keys to every door in your house when all they need is access to one room.**

2. **Increased Attack Surface: Granting sysadmin privileges to users increases the potential attack surface of your SQL Server instance. If one of these users' accounts is compromised or misused, an attacker could gain complete control over the database system, potentially leading to data breaches or other security incidents.**

3. **Lack of Principle of Least Privilege: The principle of least privilege dictates that users should only be given the minimum level of access required to perform their job functions. Assigning sysadmin privileges to users who only need limited access violates this principle and can lead to unintended data exposure or modification.**

4. **Difficulty in Auditing and Accountability: When multiple users have sysadmin privileges, it becomes challenging to track who performed which actions within the SQL Server environment. This lack of accountability makes it harder to investigate security incidents or enforce compliance with regulatory requirements.**

5. **Potential for Configuration Errors: Sysadmin users have the ability to make configuration changes that affect the entire SQL Server instance. Allowing multiple users to make such changes increases the likelihood of configuration errors or misconfigurations that could impact system stability or security.**

**Overall, while granting sysadmin privileges may seem convenient in the short term, it introduces significant security risks and goes against established security best practices. It's essential to follow the principle of least privilege and carefully restrict access to sensitive database resources to mitigate these risks and maintain a secure SQL Server environment.**


---

Implement a daily scheduled job to check for all logins with the sysadmin role to keep tabs on the extent of this issue and be able to revoke sysadmin when needed.
Create a SQL Authenticated login for Ralph and add it to the sysadmin server role.
Investigate system security catalog views, such as sys.server_principals or sys.server_role_members, to create a query to list the name of each account with sysadmin privileges and the last modified date of that login. HINT: Do a web search to find an example of such a query. It is a common security question!
Set up a custom audit job that runs daily and inserts the data from your query into a new table each time. The job should have two steps (refer to the stepping stone video). You do not need to make or use a stored procedure. Just use an INSERT INTO SELECT.
Log in as Ralph and simulate his behavior by creating four new logins and adding them all to the sysadmin role.
Run your custom audit job again to see if it captured Ralph’s behavior in step d.


**SHOW 2**:
A demonstration of you running the new job.
The job history showing all steps successful.
The contents of your custom table (step c) which should include the four new sysadmin logins that Ralph created in step d.

```sql
-- Step 1: Drop existing tables if they exist
IF OBJECT_ID('sysadmin_audit_table', 'U') IS NOT NULL
    DROP TABLE sysadmin_audit_table;

IF OBJECT_ID('custom_audit_table', 'U') IS NOT NULL
    DROP TABLE custom_audit_table;
GO

-- Step 2: Create a scheduled job to check for logins with the sysadmin role
USE msdb;
GO

-- If the job already exists, delete it to avoid duplicates
IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CheckSysadminLogins')
BEGIN
    EXEC msdb.dbo.sp_delete_job @job_name = 'CheckSysadminLogins';
END
GO

-- Create the scheduled job
EXEC msdb.dbo.sp_add_job @job_name = 'CheckSysadminLogins',
    @enabled = 1,
    @description = 'Daily check for logins with sysadmin role',
    @category_name = 'Database Maintenance';
GO

-- Step 3: Add the first step to the job to execute the check
EXEC msdb.dbo.sp_add_jobstep @job_name = 'CheckSysadminLogins',
    @step_name = 'Run Sysadmin Check',
    @subsystem = 'TSQL',
    @command = '
        INSERT INTO sysadmin_audit_table (login_name, last_modified_date)
        SELECT p.name, p.modify_date
        FROM sys.server_principals p
        JOIN sys.server_role_members rm ON p.principal_id = rm.member_principal_id
        JOIN sys.server_principals r ON rm.role_principal_id = r.principal_id
        WHERE rm.name = ''sysadmin'' AND p.name = ''sa''',
    @database_name = 'msdb';
GO

-- Step 4: Create the sysadmin_audit_table to store audit results
CREATE TABLE sysadmin_audit_table (
    login_name NVARCHAR(100),
    last_modified_date DATETIME
);
GO

-- Step 5: Create a custom job to insert audit data daily
USE msdb;
GO

-- If the job already exists, delete it to avoid duplicates
IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CustomSysadminAuditJob')
BEGIN
    EXEC msdb.dbo.sp_delete_job @job_name = 'CustomSysadminAuditJob';
END
GO

-- Create the custom job
EXEC msdb.dbo.sp_add_job @job_name = 'CustomSysadminAuditJob',
    @enabled = 1,
    @description = 'Daily audit of sysadmin logins',
    @category_name = 'Database Maintenance';
GO

-- Add the first step to the custom job to insert audit data
EXEC msdb.dbo.sp_add_jobstep @job_name = 'CustomSysadminAuditJob',
    @step_name = 'Insert Audit Data',
    @subsystem = 'TSQL',
    @command = '
        INSERT INTO custom_audit_table (login_name, last_modified_date)
        SELECT login_name, last_modified_date
        FROM sysadmin_audit_table',
    @database_name = 'msdb';
GO

-- Step 6: Create the custom_audit_table to store custom audit data
CREATE TABLE custom_audit_table (
    login_name NVARCHAR(100),
    last_modified_date DATETIME
);
GO

-- Execute the job daily at 2:00 AM
EXEC msdb.dbo.sp_add_schedule @schedule_name = 'DailySysadminAuditSchedule',
    @freq_type = 4, -- 4 indica ejecución diaria
    @freq_interval = 1, -- cada día
    @active_start_time = 20000; -- hora de inicio (en este caso, 2:00 AM)
GO

-- Assosiate the job with the schedule
EXEC msdb.dbo.sp_attach_schedule @job_name = 'CustomSysadminAuditJob',
    @schedule_name = 'DailySysadminAuditSchedule';
GO
```


