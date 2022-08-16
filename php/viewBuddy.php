<?php
session_start();
require_once("config.php");
require("verifyLoggedIn.php");
?>


<?php


function fetchPremBuddies($username) {

    $db = get_connection();

    $statement = $db->prepare("CALL `fetchAllPremBuddies`(?)");

    

    $statement->bind_param('s', $username);

    if ($statement->execute()) {
       
        $result = $statement->get_result();

        $allPremBuddies = [];

        while ($row = $result->fetch_assoc()) {
            // var_dump($row);
        
            $allPremBuddies []= $row["Result"];
            $error = $row["Error"];           
        }

        if($result != NULL) {
            return $allPremBuddies;
        }

        else {
            $_SESSION["error"] = $error;
        }
    }
    else {
        echo "Error getting result: " . mysqli_error($db);
        die();

        return [];
    }

    return [];

}
function fetchAllSharedLogs($username) {

    
    $db = get_connection();

    $statement = $db->prepare("CALL `LogSharedWithBuddy`(?)");

    $statement->bind_param('s', $username);

    if ($statement->execute()) {
       
        $result = $statement->get_result();

        $allSharedLogs = [];

        while ($row = $result->fetch_assoc()) {
            // var_dump($row);
        
            $allSharedLogs []= $row;           
        }

        if($result != NULL) {
            return $allSharedLogs;
        }

        else {
            $_SESSION["error"] = $error;
        }
    }
    else {
        echo "Error getting result: " . mysqli_error($db);
        die();

        return [];
    }

    return [];


}


?>


<style>
    .list {
        padding: 5px;
    }

    table{
        padding: 15px;
    } 
    
    th, td {
        padding: 5px;    
    }

</style>


<!-- differentiate btwn premHome and home later -->
<!-- that or just have logic in premHome.php that redirects to home.php if not prem -->
<h3><a href="premHome.php">Return Home</a></h3>



<h2 style="text-align: center">Buddies and Shared Logs</h2>



<div class="outerBox" style="display:flex; gap: 20px; justify-content: space-around;" >

    <div class="innerBox">
        <h3>Users that have shared logs with you:</h3>

        <?php

        $username = $_SESSION["username"];


        $allPremBuddies = [];

        $allPremBuddies = fetchPremBuddies($username);

        foreach ($allPremBuddies as $premBuddy) {
            echo "<div class='list'>" . $premBuddy . "</div>";
        }

        ?>

    </div>

    <div class="innerBox">

        <table>
            <tr>
                <th>Log Owner</th>
                <th>Log Start Time</th>
                <th>Log End Time</th>
            </tr>
       
       <?php 
        
        $allSharedLogs = [];

        $allSharedLogs = fetchAllSharedLogs($username);

        
        foreach($allSharedLogs as $log) {
            
            $uname = $log["uname"];
            $stime = $log["stime"];
            $etime = $log["etime"];

            $uname = htmlspecialchars($uname);
            $stime = htmlspecialchars($stime);
            $etime = htmlspecialchars($etime);            

            echo "<tr>";

            echo "<td>";
            echo $uname;
            echo "</td>";

            echo "<td>";
            echo $stime;
            echo "</td>";

            echo "<td>";
            echo $etime;
            echo "</td>";

            echo "</tr>";
        }


        ?>


        </table>

    </div>

</div>


