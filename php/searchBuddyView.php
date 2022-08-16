<?php
session_start();
// require_once("config.php");
require_once("config.php");
require_once("verifyPrem.php");
require("verifyPremLoggedIn.php");
// if (!$globalIsPrem) {
//     header("Location: home.php");
// }

?>

<!DOCTYPE html>
<html>
<body>

<h1>Search for Buddy to Add</h1>

<form action="<?=$_SERVER['PHP_SELF']?>" method="post">
<input id="Search" type="text" placeholder="Input Buddy Username" value = "" name = "searchedItem">
<input id="submit" type="submit" value="Add Buddy" name = "addBuddy">
</form>
</body>
</html>

<?php

function addBuddy($premName, $buddyToAdd) {

    $db = get_connection();

    $statement = $db->prepare("CALL `AddBuddy`(?,?)");

    $statement->bind_param('ss', $premName, $buddyToAdd);

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
                $_SESSION["msg"] = "successfully added $buddyToAdd as a buddy";
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


if (isset($_POST["addBuddy"])) {
    // echo 'a';

    $buddyToAdd = $_POST["searchedItem"];
    $premName = $_SESSION["username"];

    $buddyToAdd = htmlspecialchars($buddyToAdd);
    $premName = htmlspecialchars($premName);

    // echo 'b';

    // echo $premName;
    // echo $buddyToAdd;
    addBuddy($premName, $buddyToAdd);


    // echo 6;
    // echo $_SESSION["msg"];

    echo "<span style='color: green'>" .  $_SESSION["msg"] . "</span>";
    echo "<span style='color: red'>" .  $_SESSION["error"] . "</span>";

    // echo 7;

    unset($_SESSION['msg']);
    unset($_SESSION['error']);

    unset($_POST["addBuddy"]);
    unset($_POST["searchedItem"]);
}

else {
    // echo 8;
}

?>

<!-- <p style="color:grey">Close the page to return to Home.</p> -->
<br>
<br>
<br>
<a href="premHome.php">Return Home </a>



</html>
