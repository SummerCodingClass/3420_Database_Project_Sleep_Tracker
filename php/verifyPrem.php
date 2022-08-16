<?php


function checkPremiumDatabase($username)
{
    $db = get_connection();
   
    $statement = $db->prepare("CALL IsPremium(?)");
    $statement->bind_param('s', $username);
    $statement->execute();
    $result = $statement->get_result();
    $row = $result->fetch_assoc();
    return $row['Result'];
}




function checkPremiumPHP() 
{
    $username = $_SESSION["username"];
    $isPremString = checkPremiumDatabase($username);
    $isPrem;

    if ($isPremString == "true") {
        return true;
    }
    else {
        return false;
    }

}



?>