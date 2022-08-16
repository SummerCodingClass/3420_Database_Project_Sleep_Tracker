<?php
session_start();
require_once("config.php");
require("verifyLoggedIn.php");
?>

<!DOCTYPE html>
<html>
<body>

<h1>Become Premium User</h1>
    
<?php

BecomePremium($_SESSION["username"]);
$_SESSION["premChecked"] = false;


function BecomePremium($username) {
    $db = get_connection();
    $statement = $db->prepare("CALL `BecomePremium`(?)");
    $statement->bind_param('s', $username);
    $statement->execute();
    $result = $statement->get_result();
    $row = $result->fetch_assoc();
    $TF = $row['Result'];

    if($TF == "true")
    {
        $_SESSION["isPrem"] = true;
        echo "You are now a premium user!";
    }
    else
    {
        echo "You are already a premium user!";
    }
}
?>

<!-- <p style="color:grey">Close the page to return to Home.</p> -->
<br>
<br>
<br>
Want to opt out of being a premium user? <a href="optOutPremium.php">Click Here</a> <br> <br>
<a href="premHome.php">Return Home </a>



</html>