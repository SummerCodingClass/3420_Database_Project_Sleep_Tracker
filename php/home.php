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
            header("Location:premHome.php");
    
        }    
    }
    else {
        header("Location:index.php");
    }
}
else {
    header("Location:index.php");
}


?>


<?php

require_once("homeContent.php");

?>