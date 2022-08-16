<?php
session_start();
require_once("config.php");
require("verifyPremLoggedIn.php");
?>

<!DOCTYPE html>
<html>
<body>

<h1>Opting Out of Premium User</h1>
    
<?php

optOutPremium($_SESSION["username"]);
$_SESSION["premChecked"] = false;


function optOutPremium($username) {
    $db = get_connection();
    $statement = $db->prepare("CALL `optOutPremium`(?)");
    $statement->bind_param('s', $username);
    $statement->execute();
    $result = $statement->get_result();
    $row = $result->fetch_assoc();
    $TF = $row['Result'];

    if($TF == "true")
    {
        $_SESSION["isPrem"] = false;
        echo "Successfully opted out! You are no longer a premium user.";
    }
    else
    {
        echo "You already opted out!";
    }
}
?>

<!-- <p style="color:grey">Close the page to return to Home.</p> -->
<br>
<br>
<br>
Want to become a premium user again? <a href="becomePremium.php">Click Here</a> <br> <br>
<a href="home.php">Return Home </a>



</html>