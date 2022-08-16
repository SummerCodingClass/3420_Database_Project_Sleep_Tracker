<?php
session_start();
// require_once("register.php");
// require_once("login.php");

?>




<!DOCTYPE html>

<html lang="en">

    <head>

        <meta charset="utf-8">

        <meta name="viewport" content="width=device-width,initial-scale=1">
    
        <title>Welcome to Sleep Tracker</title>

    </head>

    <body>

        <h1>Welcome to Sleep Tracker</h1>

        <form action="register.php" method="POST">
            <input type="text" name="username" value="<?=$_SESSION["inputUsername"]?>" placeholder="username"> <br> <br>
            <input type="password" name="password" placeholder="*****"> <br> <br>
            <input type="submit" name="login" value="Log In">
            <input type="submit" name="register" value="Register" style="margin: 10px">
            <!-- <input type="submit" name="login" value="Log In" action="< ?=$_SERVER['PHP_SELF']?>"> -->
            <!-- <input type="submit" name="register" value="Register" action="< ?=$_SERVER['PHP_SELF']?>/register.php" style="margin: 10px"> -->
            <!-- <input type="submit" name="register" value="Register" action="< ?=$_SERVER['PHP_SELF']?>" style="margin: 10px"> -->
        </form>

        <?php


            if (isset($_SESSION["result"]) || isset($_SESSION["error"]) || isset($_SESSION["error1"])) {
                if (isset($_SESSION["result"])) {
                    $result = $_SESSION['result'];
                    echo "<div style='color: green'>$result</div>";
                    unset($_SESSION["result"]);
                }
                if (isset($_SESSION["error"])) {
                    $error = $_SESSION['error'];
                    echo "<div style='color: red'>$error</div>";
                    unset($_SESSION["error"]);
                }
                if (isset($_SESSION["error1"])) {
                    $error1 = $_SESSION['error1'];
                    echo "<div style='color: red'>$error1</div>";
                    unset($_SESSION["error1"]);
                }
            }
            else {
                echo "<div style='color: blue'> Log in to use the full feature of the site! </div>";
            }

        ?>

    </body>

</html>