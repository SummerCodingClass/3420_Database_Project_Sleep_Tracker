<?php
session_start();

require_once("config.php");
require_once("verifyLoggedIn.php");



?>


<?php
session_start();
require_once("config.php");

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}



function logout() {
    session_unset();
    session_destroy();
}

if (isset($_GET["logout"])) {
    logout();
}

?>
<?php


if (isset($_SESSION["authorized"])) {

    $authorized = $_SESSION["authorized"];

    if ($authorized) {
        $isPrem = $_SESSION["isPrem"];

        // echo $isPrem;
        
        if ($isPrem) {    
        }
        else {
            header("Location: home.php");            
        }
    
    }
    else {
        header("Location: index.php");
    }
}
else {
    header("Location: index.php");
}


?>


<?php

    function printBuddies($premName) {
        
        $db = get_connection();

        $statement = $db->prepare("CALL BuddiesWith(?)");

        $statement->bind_param('s', $premName);
    
        if ($statement->execute()) {
           
            $result = $statement->get_result();

            // $allBuddies = [];
    
            while ($row = $result->fetch_assoc()) {
                // var_dump($row);
            
                $buddieName = $row["uname"];
                $buddieName = htmlspecialchars($buddieName);
        
                // $allBuddies []= $buddieName;
                echo "<div class='buddies'><h3>" . $buddieName . "</h3></div>";
            }
            
            // var_dump($allBuddies);
        }
        else {
            echo "Error getting result: " . mysqli_error($db);
            die();
        }
    
        return;

    }

?>
<style>

    .buddies {
        color: green;
        padding: 0;
    }

</style>


<div style="display: flex; gap: 20px;">
    <!-- <div style="background-color:#EFF2F4"> -->
    <div style="border: 5px solid black; background-color:#DAF2E9;">
        <?php
        
        require_once("homeContent.php");
        
        // do checks to make sure they are premium
        // we need logic in the login.php to differentiate isPremium
        // if premium, we can redirect them to here instead of home.php 
        
        ?>
    
    </div>
    
    
    <div style="border: 5px solid black; padding: 50px; text-align: center; background-color: #DCE9F3;"> 

        <!-- <a href="searchBuddyView.php" target="_blank"> Add Buddies </a> -->
        <a href="searchBuddyView.php"> Add Buddies </a> <br><br>
        <a href="deleteBuddy.php"> Delete Buddies </a>


        <h2>Buddies Added:</h2>

        <?php
            $premUser = $_SESSION["username"];

            printBuddies($premUser);

        ?>
    
    </div>

</div>