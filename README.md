# 3420_Database_Group_Project

## Summary

This repository hosts a backup of our 3420 group project: The Sleep Tracker.

The database is implemented via mariaDB / mySQL. 

The UI will be implemented via php and javascript.


## Group Members

Jennifer Kuo

Jeff Hicks

Jesse Arzate

Salvatore Vargas


## Instructor

Nick Toothman


## Instruction

For the project to work, one must create a "config.php" file in the same directory as the rest of the php. It should contain the following function, with **a**, **b**, **c**, **d** replaced with your version of **server address**, **mysql username**, **mysql password**, and **database name** respectively.

<pre>
&lt;?php
function get_connection() {
    static $connection;
    
    if (!isset($connection)) {
        $connection = mysqli_connect('a', 'b', 'c', 'd') or die(mysqli_connect_error());
    }
    if ($connection === false) {
        echo "Unable to connect to database &lt;br&gt;";
        echo mysqli_connect_error();
    }
  
    return $connection;
}
?&gt;
</pre>
