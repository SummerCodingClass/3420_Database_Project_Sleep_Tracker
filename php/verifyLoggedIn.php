<?php

//-----------------------------------------
if (isset($_SESSION["authorized"])) {

    $authorized = $_SESSION["authorized"];

    if ($authorized) {


        // echo $isPrem;

    
    }
    else {
        header("Location: index.php");
    }
}
else {
    header("Location: index.php");
}

//------------------------------------------


?>