**W07 Scenario**:

Karl is encouraged by your efforts and wants to ramp up development efforts of the bowling system. He hires Ralph, who says he is a SQL Server DBA, to help you and support a small growing team of developers. It doesn't take you long to find out Ralph has a nasty habit… "Hey, as long as we are just developing things, l just add all new users to the sysadmin server role. That way I can go out for my deep dish pizza without getting a phone call about someone having insufficient privileges and halting development." You know this "natural man" attitude doesn't feel quite right, so you decide to take action.

**W07 Scenario Submission Guidelines**:

Be sure you submit all elements labeled by the bolded word, SHOW.

You realize you need to explain to Ralph and Karl why you think the overuse of the sysadmin role can cause trouble and should be avoided at all costs.

**SHOW 1**: Your understanding of security best practices by explaining this in your video.

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


