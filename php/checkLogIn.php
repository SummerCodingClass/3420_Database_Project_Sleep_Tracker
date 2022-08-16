<?php

function isBlank($textfield) {
    if ((strlen($textfield) == 0) || ($textfield == "") || $textfield == null) {
        return true;
    } 
    return false;
}

function nameInvalid($username) {
    if (strlen($username) < 4 || strlen($username) > 100) {
        return true;
    }
    return false;
}

function passInvalid($password) {
    if (strlen($password) < 6 || strlen($password) > 100) {
        return true;
    }
    return false;
}


?>