<?php
session_start();
require_once("config.php");
require_once("checkLogIn.php");

function register($username, $password) {

    
    
    $db = get_connection(); 

    // var_dump($db);
    echo a;


    $hashed = password_hash($password, PASSWORD_DEFAULT);
    
    echo b;

    $statement = $db->prepare("Call RegisterUser (?, ?)");
    
    echo c;

    $statement->bind_param('ss', $username, $hashed);

    echo d;

    // $var_dump($statement);

    
    if (!$statement->execute()) {
        echo "die called";

        die(mysqli_error($db) . "<br>");
    }

    echo e;

    $result = $statement->get_result();

    echo f;

    
    // $validity = false;

    while ($row = $result->fetch_assoc()) {
        echo g;
        // var_dump($row);
        
        echo 'in while loop';

        $output = $row["Result"];
        $error = $row["Error"];
        // if (password_verify($userInput, $valid_passwords)) {
        //     $validity = true;
        // }
        if ($output == "true") {
            // $validity = true;
            $_SESSION["result"] = "Registration Successful";
        } 
        else {
            $_SESSION["error"] = $error;
        }
    }

    // return $validity;
}


// function isBlank($textfield) {
//     if ((strlen($textfield) == 0) || ($textfield == "") || $textfield == null) {
//         return true;
//     } 
//     return false;
// }

// function nameInvalid($username) {
//     if (strlen($username) < 4 || strlen($username) > 100) {
//         return true;
//     }
//     return false;
// }

// function passInvalid($password) {
//     if (strlen($password) < 6 || strlen($password) > 100) {
//         return true;
//     }
//     return false;
// }



if (isset($_POST["register"])) {

    if (isset($_POST["username"]) && isset($_POST["password"])) {
        $username = $_POST["username"];
        $password = $_POST["password"];

        $username = htmlspecialchars($username);
        $password = htmlspecialchars($password);

        $_SESSION["inputUsername"] = $username;
        $_SESSION["inputPassword"] = $password;

        echo 0;
        echo "<br>";

        $nameBlank = isBlank($username);
        $passBlank = isBlank($password);
       
        if ($nameBlank && $passBlank) {
            echo 1;
            echo "<br>";

            $_SESSION["error"] = "both username and password are required";
            echo $_SESSION["error"];
            unset($_POST["register"]);
            header("Location: index.php");
        }
       
        else {
            echo 2;
            echo "<br>";

            $nameInvalid = nameInvalid($username);
            $passInvalid = passInvalid($password);

            if ($nameInvalid && $passInvalid) {
                echo "neither valid";
                echo "<br>";

                $_SESSION["error"] = "username must be between 4-100 characters long <br>";
                unset($_POST["username"]);

                $_SESSION["error1"] = "password must be between 6-100 characters long <br>";
                unset($_POST["password"]);
            }

            else if ($nameInvalid) {
                echo "name invalid";
                echo "<br>";

                $_SESSION["error"] = "username must be between 4-100 characters long <br>";
                unset($_POST["username"]);

                $_SESSION["error1"] = "password ok<br>";
                unset($_POST["password"]);
            }

            else if ($passInvalid) {
                echo "pass invalid";
                echo "<br>";

                $_SESSION["error"] = "username ok<br>";
                unset($_POST["username"]);

                $_SESSION["error1"] = "password must be between 6-100 characters long <br>";
                unset($_POST["password"]);
            }
                
            else {
                echo 3;
                echo "<br>";

                register($username, $password);

                echo 3.5;
                echo "<br>";
                
                unset($_POST["username"]);
                unset($_POST["password"]);
                // unset($_POST["register"]);
            }
             
            // header("Location: index.php");
        }
    }
    
    else {
        echo 4;
        echo "<br>";

        $_SESSION["error"] = "unauthorized form submission";
        unset($_SESSION["error"]);
    }
 
    unset($_POST["register"]);
    header("Location: index.php");
}

?>