
<style>
    div {
        padding: 20px;
    }
    
    html {
        background-color: #E3F3E0;
    }

    table {
        background-color: #F3F2EB;
        text-align: center;
    }
    th, td {
        padding: 3px;
    }

</style>

<form action=<?=$_SERVER['PHP_SELF']?> method="GET">
    <input type="submit" name="logout" value="Log out">
</form>


<!-- if(logged in person is not premium, show this code. Otherwise, do not show this code -->

<?php 

$isPrem = $_SESSION["isPrem"];

if ($isPrem) {

    echo "<h2> Want to Opt out from being a Premium User? <a href=\"optOutPremium.php\"> Click Here to Opt Out</a> </h2> ";
}

else {

    echo "<h2> Want to Become a Premium User? <a href=\"becomePremium.php\"> Click Here To Become A Premium User</a> </h2> ";

    

}

?>
<!-- <h2> Want to Become a Premium User? <a href="becomePremium.php"> Click Here To Become A Premium User</a> </h2> 
<h2> Already a Premium User? Use the <a href="premHome.php"> Premium Home</a> </h2>  -->
<h2> Had other users shared logs with you? <a href="viewBuddy.php"> Click Here To View Buddies </a> </h2> 




<!-- Create procedure `AddLog` (unameInput varchar(100), pidInput int(11), stimeInput datetime, isstartInput tinyint(1), etimeInput datetime, isendInput tinyint(1)) -->

<!-- <h2> Logs Shared With You By Other Buddies</h2> -->
<div style="background-color:lightgrey;">

<h2>Add a Sleep Cycle for <span style="color: blue"> <?=$_SESSION["username"]?></span></h2> 

<form action="addLog.php" method="POST">
    <input type="hidden" name="username" value="<?=$_SESSION["username"]?>">

    Entry 1 marks the overall start of this sleep cycle. <br> <br>
    <b>Entry 1 (Overall Start):</b> <br>
    Start Time:
    <input type="date" name="startDate1" value=<?=date("Y-m-d");?>>
    <input type="time" name="startTime1" value=<?=date("H:i");?>> <br>
    EndTime:
    <input type="date" name="endDate1" value=<?=date("Y-m-d");?>>
    <input type="time" name="endTime1" value=<?=date("H:i");?>> <br><br>

    <b>Entry 2:</b> <br>
    Start Time:
    <input type="date" name="startDate2">
    <input type="time" name="startTime2"> <br>
    EndTime:
    <input type="date" name="endDate2">
    <input type="time" name="endTime2"> <br><br>

    <b>Entry 3:</b> <br>
    Start Time:
    <input type="date" name="startDate3">
    <input type="time" name="startTime3"> <br>
    EndTime:
    <input type="date" name="endDate3">
    <input type="time" name="endTime3"> <br><br>
    
    
    <br>
    Which entry marks the overall END of this sleep cycle? <br>
    <input required type="radio" name="isEnd" value="Entry_1"> Entry 1<br>
    <input required type="radio" name="isEnd" value="Entry_2"> Entry 2<br>
    <input required type="radio" name="isEnd" value="Entry_3"> Entry 3<br>
    <br>    

    <input type="submit" name="addLog" value="Add Log">
</form>


</div>






<!-- <div style="background-color:#F0DDF5;"> -->
<div style="background-color:#EFDCF5;">
<h2> Summary </h2>

<?php

function fetchSummary($pid) {

        $db = get_connection();
        $statement = $db->prepare("CALL TotalSleepPerSession(?)");
        $statement->bind_param('i', $pid);
        if ($statement->execute()) {
            $result = $statement->get_result();
            while ($row = $result->fetch_assoc()) {
                $hours = $row["duration"];
                $_SESSION["error"] = $row["Error"];
                return $hours;
            }        
        }
        else {
            echo "Error getting result: " . mysqli_error($db);
            die();
        }
    
        return;
}



// //////////////////change this to display summary. restructure this.
function setUpSummary($username)
{
    $db = get_connection(); 
    $query = $db->prepare("Call OneUserAllTheirLogs (?)");
    $query->bind_param('s', $username);
    $query->execute();
    $result = $query->get_result();
    
    $allDates = [];

    while($row = $result->fetch_assoc())
    {
    
    //  $logid = $row['logid'];
    //  $uname = $row['uname'];
    //  $pid = $row['pid'];
    //  $stime = $row['stime'];
    //  $isstart = $row['isstart'];
    //  $etime = $row['etime'];
    //  $isend = $row['isend'];
    // $allDates = [];
    
        if ($row["isstart"] == true) {

            $day = $row["stime"];
            $date = explode(" ", $day);
            $date = $date[0];
            $pid = $row["pid"];
            

            $allDates []= array($date => $pid);         
            
            // $hoursOfSleep = fetchSummary($pid);

            // echo "$day: $hoursOfSleep hrs <br>";


        }

    }
    
    
    return $allDates;
}

// echo 1;

$allDates = setUpSummary($_SESSION["username"]);
// echo 2;

// var_dump($allDates);

foreach ($allDates as $date) {
    foreach ($date as $day => $pid) {
        // var_dump($date);
        // echo is_array($day);
        // var_dump($day);

        // var_dump($day);
        // // var_dump($allDates);
        // // echo $day;
        // $date = explode(" ", $day);
        // // var_dump($day);
        // // echo $date;
        // // var_dump($date);
        // $day = $date[0];
        
        // echo $day;

        // echo $pid;

        $hoursOfSleep = fetchSummary($pid);

        // echo $hoursOfSleep;

            //fetch all the pid's that belongs to a user
            //call on total sleep per session using the pid
            //save the hours of sleep
        $time = explode(":", $hoursOfSleep);

        $hrs = $time[0];
        $min = $time[1];
        
        // echo "<table border='1'>
        // <tr>
        // <th>Start Date for Sleep Cycle</th>
        // <th>Length of Sleep (hrs: minutes)</th>
        // </tr>";
        echo "<table border='1'>
        <tr>
        <th>Log's Parent ID </th>
        <th>Start Date of Sleep Cycle</th>
        <th>Length of Sleep</th>
        </tr>";


        echo "<tr>";
        echo "<td>" . htmlspecialchars($pid) . "</td>";
        echo "<td>" . htmlspecialchars($day) . "</td>";
        echo "<td>" . htmlspecialchars($hrs) . " hrs " . htmlspecialchars($min) . " min" . "</td>";
    
        // echo "$day: $hoursOfSleep hrs <br>";


        echo "</table>";
        
    }
}

?>

</div>








<div style="background-color:lightyellow;">

<h2 id="updateLogDiv">Update the Is-Overall-End Status of a Log</h2> 

<?php 
    require_once("logUpdate.php");
?>

<form action=<?=$_SERVER['PHP_SELF']?> method="POST">

    The LOG ID (first column) of the log that you want to update: <br>
    <input required type="number" name="logIDUpdate" value=<?=$_SESSION["logIDUpdate"]?>> <br> <br>

    Does this log mark the overall end of its sleep cycle? <br>
    <input required type="radio" name="logIsEndUpdate" value="1"> Yes <br>
    <input required type="radio" name="logIsEndUpdate" value="0"> No <br>
    <br>    
    <input type="submit" name="logUpdateRequest" value="Update">
</form>


</div>

<div style="background-color:#C8CDF5;">


<?php

function deleteLog($username, $logToDelete) {

    $db = get_connection();

    $statement = $db->prepare("CALL `deleteLog`(?,?)");

    $statement->bind_param('ss', $username, $logToDelete);

    if ($statement->execute()) {
       
        $result = $statement->get_result();

        // $allBuddies = [];

        while ($row = $result->fetch_assoc()) {
            // var_dump($row);
        
            $output = $row["Result"];
            $error = $row["Error"];

            // echo $result;
            // echo $error;
            // echo 3;
    
            if($output == "true") {
                // echo 4;
                $_SESSION["msg"] = "Successfully deleted logs with Parent ID: $logToDelete.";
                // echo $_SESSION["msg"];
            }

            else {
                // echo 5;
                $_SESSION["error"] = $error;
            }
            // echo 'b';
            return;
        }
        
        // echo 'c';
        // var_dump($allBuddies);
    }
    else {
        echo "Error getting result: " . mysqli_error($db);
        die();

        return;
    }

    // echo 'd';
    return;
}




?>



<h4 id="deleteLogInstructions">How To Delete A Log</h4>
Enter a parent ID to delete the group of logs with that parent ID. <br>
You cannot delete individual logs within a group of logs if multiple logs share that same parent ID. <br>
This ensures the summary section keeping accurate hours of your sleep in that session. <br>
Please reenter all logs from that group again if needed. <br> <br> <br>







<form action="<?=$_SERVER['PHP_SELF']?>" method="post" id="deleteLogForm">
<input id="Search" type="text" placeholder="Parent ID to Delete" value = "" name = "logToDelete">
<input id="submit" type="submit" value="Delete Logs" name = "deleteLog">
</form>
<br>






<script>
function scroll() {
       // https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView
       let targetDiv = document.getElementById("deleteLogForm");
       targetDiv.scrollIntoView();
}
// scroll();
</script>


<?php

// can only be run after the element with the id is rendered otherwise targetDiv will be null
if(isset($_POST["deleteLog"])) {
    echo "<script> scroll(); </script>";
}
?>






<?php



if (isset($_POST["deleteLog"])) {
    // echo 'a';

    $logToDelete = $_POST["logToDelete"];
    $username = $_SESSION["username"];

    if (strlen($logToDelete) < 1) {
        echo "<span style='color: red'> Error. Please enter a parent ID </span>";

        // without a pid entered, the page wouldn't render the logs.
        echo "<h2> Your Logs </h2>";

        DisplayAllLogs($_SESSION["username"]);        

        return;
    }

    deleteLog($username, $logToDelete);


    // echo 6;
    // echo $_SESSION["msg"];

    // echo "<script> scroll(); </script>";
    echo "<span style='color: green'>" .  $_SESSION["msg"] . "</span>";
    echo "<span style='color: red'>" .  $_SESSION["error"] . "</span>";

    // echo "<div> test </div>";

    // echo "<script> scroll(); </script>";

    unset($_SESSION['msg']);
    unset($_SESSION['error']);

    unset($_POST["deleteLog"]);
    unset($_POST["logToDelete"]);
    // echo "<meta http-equiv='refresh' content='0'>"; refreshes page

    
}

else {
    // echo 8;
}

?>



<h2> Your Logs </h2>


<?php

function DisplayAllLogs($username)
{
    $db = get_connection(); 
    //$query = $db->prepare("Call OneUserAllTheirLogs (?)");
    $query = $db->prepare("Call OneUserAllTheirLogs (?)");
    $query->bind_param('s', $username);
    $query->execute();
    $result = $query->get_result();
    /*if (!$query->execute()) {
        echo "die called";

        die(mysqli_error($db) . "<br>");
    }*/
    
    echo "<table border='1'>
    <tr>
    <th>Your Log ID</th>
    <th>Your Username</th>
    <th>Log's Parent ID</th>
    <th>Start Time</th>
    <th>Overall Start?</th>
    <th>End Time</th>
    <th>Overall End?</th>
    </tr>";

    // $allDates = [];

    while($row = $result->fetch_assoc())
    {

        if ($row['isstart'] == true) {
            $isstart = "yes";
        }
        else {
            $isstart = "no";
        }
        
        
        if ($row['isend'] == true) {
            $isend = "yes";
        }
        else {
            $isend = "no";
        }
        
    echo "<tr>";
    echo "<td>" . htmlspecialchars($row['logid']) . "</td>";
    echo "<td>" . htmlspecialchars($row['uname']) . "</td>";
    echo "<td>" . htmlspecialchars($row['pid']) . "</td>";
    echo "<td>" . htmlspecialchars($row['stime']) . "</td>";
    // echo "<td>" . $row['isstart'] . "</td>";
    echo "<td>" . htmlspecialchars($isstart) . "</td>";
    echo "<td>" . htmlspecialchars($row['etime']) . "</td>";
    // echo "<td>" . $row['isend'] . "</td>";
    echo "<td>" . htmlspecialchars($isend) . "</td>";
    echo "</tr>";

        // $day = $row["stime"];
        // $date = explode(" ", $day);
        // $date = $date[0];
        // // echo $row["pid"];
        // // echo $date;
        // // $allDates []= array($row['stime'], $row['pid']);
        // $allDates []= array($date, $row['pid']);
        // // var_dump($allDates);

    }
    echo "</table>";
    
    return;
    // return $allDates;
}




DisplayAllLogs($_SESSION["username"]);
// $allDates = DisplayAllLogs($_SESSION["username"]);
// var_dump($allDates);


?>

</div>
