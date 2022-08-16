<?php


//-----------------------------------------
if (isset($_SESSION["authorized"])) {

    $authorized = $_SESSION["authorized"];

    if ($authorized) {
        $isPrem = $_SESSION["isPrem"];

        // echo $isPrem;
        
        if ($isPrem) {    
            //let them stay
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