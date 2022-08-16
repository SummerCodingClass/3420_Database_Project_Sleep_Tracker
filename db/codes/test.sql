    SELECT log.uname, log.stime, log.etime 
    from log inner join buddies natural join user
    on log.uname = buddies.pname 
    where buddies.uname = unameInput; 


    SELECT log.uname, log.stime, log.etime 
    from log inner join buddies natural join user
    on log.uname = buddies.pname 
    where buddies.uname = "jpicot7";


    SELECT log.*
    from log inner join buddies natural join user
    on log.uname = buddies.pname 
    where buddies.uname = "jpicot7";