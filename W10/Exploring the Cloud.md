**W10 Scenario**:

Now that you have learned to set up virtual machines and docker containers in the cloud, it is time to move them to the cloud. As you are starting to realize that moving databases is a consistent part of database administration, you should look for ways to do it more efficiently.

**W10 Scenario Submission Guidelines**:

Be sure you submit all elements labeled by the bolded word, **SHOW**.

As shown in this week’s stepping stone: If you have not already done so, apply your Google Cloud (GCP) coupon from your instructor according to these instructions. Please read the entire instructions carefully and do **NOT** enter a personal credit card. You should have your VM ready to go.

Create a second VM following the same steps from the stepping stone.

**SHOW 1**: You should now have two VMs in the cloud. Both should have settings matching the video in the stepping stone.

--- 

Move three of your databases to the first VM. Choose from Bowling, EntertainmentAgency, Recipes, SalesOrders, sample, SchoolScheduling (WideWorldImporters should NOT be moved - it is too large).

After this tutorial, you again backup your databases and copy them to the VM. This is similar to what you did here in week 4, but you will *use your IP address and related info for your new VM instead*. You then have to issue copy commands (docker cp) to move the files into the running container. After which, you will connect and restore each database again.

Verify your SQL Server container is running as shown in this video.

**HELP**: Refer to this help document and these supplemental videos as needed.

Move the three remaining databases to the second VM.
Prepare to connect to these new database servers by following this video to create a firewall rule.

**SHOW 2**: 
Using the considerations in video one or video two, connect to both cloud servers (steps 3 and 4) from management studio (or Azure Data Studio) on your laptop. For the server, you should enter the external ip address of your vm then a comma and 49433 (or whichever port you used when you created your container). Be sure to demonstrate this connection in your video.

The databases are now running inside your cloud docker instances as well as your local instance. Show that three databases are running on one cloud database server and the other three are running on the second.

