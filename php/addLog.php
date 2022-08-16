<?php
session_start();
require("config.php");

require("verifyLoggedIn.php");




// for POST
$username;

$startDate1;
$startTime1;
$endDate1;
$endTime1;

$startDate2;
$startTime2;
$endDate2;
$endTime2;

$startDate3;
$startTime3;
$endDate3;
$endTime3;

$isEnd;

// for calling the procedure
$unameInput;
$pidInput;
$isstartInput1;

$stimeInput1;
$etimeInput1;
$isendInput1;

$stimeInput2;
$etimeInput2;
$isendInput2;
$isstartInput2;

$stimeInput3;
$etimeInput3;
$isendInput3;
$isstartInput3;


if (isset($_POST["addLog"])) {
    unset($_POST["addLog"]);
    $username = $_SESSION["username"];

    $startDate1 = $_POST["startDate1"];
    $startTime1 = $_POST["startTime1"];
    $endDate1 = $_POST["endDate1"];
    $endTime1 = $_POST["endTime1"];
    
    $startDate2 = $_POST["startDate2"];
    $startTime2 = $_POST["startTime2"];
    $endDate2 = $_POST["endDate2"];
    $endTime2 = $_POST["endTime2"];
    
    $startDate3 = $_POST["startDate3"];
    $startTime3 = $_POST["startTime3"];
    $endDate3 = $_POST["endDate3"];
    $endTime3 = $_POST["endTime3"];

    $valid = false;
    
    $isEnd = $_POST["isEnd"];

    $startDate1 = htmlspecialchars($startDate1);
    $startTime1 = htmlspecialchars($startTime1);
    $endDate1 = htmlspecialchars($endDate1);
    $endTime1 = htmlspecialchars($endTime1);
    
    $startDate2 = htmlspecialchars($startDate2);
    $startTime2 = htmlspecialchars($startTime2);
    $endDate2 = htmlspecialchars($endDate2);
    $endTime2 = htmlspecialchars($endTime2);
    
    $startDate3 = htmlspecialchars($startDate3);
    $startTime3 = htmlspecialchars($startTime3);
    $endDate3 = htmlspecialchars($endDate3);
    $endTime3 = htmlspecialchars($endTime3);
    
 
    $isEnd = htmlspecialchars($isEnd);

    if ($isEnd == "Entry_1" || $isEnd == "Entry_2" || $isEnd == "Entry_3") {
        $valid = true;
    }
    
    $unameInput = $username;
    $stimeInput1 = combingingDateTime($startDate1, $startTime1);
    $etimeInput1 = combingingDateTime($endDate1, $endTime1);
    $pidInput = "NULL";
    $isstartInput1 = "1";
  
    if($valid)
    {
        if ($isEnd == "Entry_1" && $stimeInput1 <= $etimeInput1) {
            $isendInput1 = "1";
            echo "stimeInput: $stimeInput1 <br>";
            echo "etimeInput: $etimeInput1 <br>";
            echo "pid: $pidInput <br>";
            echo "isStart: $isstartInput1 <br>";
            echo "isend: $isendInput1 <br>";
            callProcedureAddLog($unameInput, $stimeInput1, $etimeInput1, $pidInput, $isstartInput1, $isendInput1);
            
        } 
        elseif ($isEnd == "Entry_2" && $stimeInput1 <= $etimeInput1 && $stimeInput2 <= $etimeInput2)
        {
            $stimeInput2 = combingingDateTime($startDate2, $startTime2);
            $etimeInput2 = combingingDateTime($endDate2, $endTime2);
            $isstartInput2 = "0";
            $isendInput1 = "0";
            $isendInput2 = "1";

            $pidInput = callProcedureAddLog($unameInput, $stimeInput1, $etimeInput1, $pidInput, $isstartInput1, $isendInput1);

            
                callProcedureAddLog($unameInput, $stimeInput2, $etimeInput2, $pidInput, $isstartInput2, $isendInput2);

                echo "stimeInput1: $stimeInput1 <br>";
                echo "etimeInput1: $etimeInput1 <br>";
                echo "pid: $pidInput <br>";
                echo "isStart1: $isstartInput1 <br>";
                echo "isend1: $isendInput1 <br>";

                echo "stimeInput2: $stimeInput2 <br>";
                echo "etimeInput2: $etimeInput2 <br>";
                echo "pid: $pidInput <br>";
                echo "isStart2: $isstartInput2 <br>";
                echo "isend2: $isendInput2 <br>";
            

        }
        elseif ($isEnd == "Entry_3"  && $stimeInput1 <= $etimeInput1 && $stimeInput2 <= $etimeInput2 && $stimeInput3 <= $etimeInput3)
        {
            $stimeInput2 = combingingDateTime($startDate2, $startTime2);
            $etimeInput2 = combingingDateTime($endDate2, $endTime2);
            $stimeInput3 = combingingDateTime($startDate3, $startTime3);
            $etimeInput3 = combingingDateTime($endDate3, $endTime3);

            $isstartInput2 = "0";
            $isstartInput3 = "0";
            $isendInput1 = "0";
            $isendInput2 = "0";
            $isendInput3 = "1";

            $pidInput = callProcedureAddLog($unameInput, $stimeInput1, $etimeInput1, $pidInput, $isstartInput1, $isendInput1);
            callProcedureAddLog($unameInput, $stimeInput2, $etimeInput2, $pidInput, $isstartInput2, $isendInput2);
            callProcedureAddLog($unameInput, $stimeInput3, $etimeInput3, $pidInput, $isstartInput3, $isendInput3);

            echo "stimeInput: $stimeInput1 <br>";
            echo "etimeInput: $etimeInput1 <br>";
            echo "pid: $pidInput <br>";
            echo "isStart: $isstartInput1 <br>";
            echo "isend: $isendInput1 <br>";

            echo "stimeInput: $stimeInput2 <br>";
            echo "etimeInput: $etimeInput2 <br>";
            echo "pid: $pidInput <br>";
            echo "isStart: $isstartInput2 <br>";
            echo "isend: $isendInput2 <br>";

            echo "stimeInput: $stimeInput3 <br>";
            echo "etimeInput: $etimeInput3 <br>";
            echo "pid: $pidInput <br>";
            echo "isStart: $isstartInput3 <br>";
            echo "isend: $isendInput3 <br>";
        }
        else
        {
            echo "You cannot wake up before you fall asleep";
            echo "<br> <br>";
            echo "<a href=\"javascript:history.go(-1)\">CLICK HERE TO GO BACK TO HOME SCREEN</a>";
        }
    }
    else
    {
        echo "Please select which entry marks the overall END of this sleep cycle.";
        echo "<br> <br>";
        echo "<a href=\"javascript:history.go(-1)\">CLICK HERE TO GO BACK TO HOME SCREEN</a>";
    }


    header("Location: home.php");

}



function combingingDateTime($date, $time) {
    $combined = $date . " " . $time;

    return $combined;
}

function getMaxEndTime($username)
{
    $db = get_connection();
   
    $statement = $db->prepare("CALL MostRecentUserLog(?)");
    $statement->bind_param('s', $username);
    $statement->execute();
    $result = $statement->get_result();
    $row = $result->fetch_assoc();
    return $row['max(etime)'];
}

function callProcedureAddLog($username, $stime, $etime, $pid, $isstart, $isend) {


    $db = get_connection();
   
    $statement = $db->prepare("CALL AddLog(?, ?, ?, ?, ?, ?)");
    $statement->bind_param('sissss', $username, $pid, $stime, $isstart, $etime, $isend);

    if ($statement->execute()) {
        mysqli_stmt_bind_result($statement, $res_newPID, $res_PID, $res_result, $res_error);

        $statement->fetch();

        if ($res_result == "false") {
            $_SESSION["error"] = $res_error;
        }
        else {
            echo $res_PID;
        }
    }
    else {
        echo "Error getting result: " . mysqli_error($db);
        die();
    }

    return $res_PID;
}


?>