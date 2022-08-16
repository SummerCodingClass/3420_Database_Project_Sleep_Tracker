<?php


if(isset($_POST["logUpdateRequest"])) {
    $username = $_SESSION["username"];
    $logID = $_POST["logIDUpdate"];
    $isEnd = $_POST["logIsEndUpdate"];

    $username = htmlspecialchars($username);
    $logID = htmlspecialchars($logID);
    $isEnd = htmlspecialchars($isEnd);

    $_SESSION["logIDUpdate"] = $logID;

    if ((is_numeric($logID)) == false) {
        echo "<span style='color: red' id=\"tempMsg\"> Invalid logID. Please do not modify the form. </span>";
        return;
    }

    if ($isEnd != "1" && $isEnd != "0") {
        echo "<span style='color: red' id=\"tempMsg\"> Invalid input. Please do not modify the form. </span>";
        return;
    }

    updateLog($username, $logID, $isEnd);

    if (isset($_SESSION["logUpdateTrue"])) {
        unset($_SESSION["logIDUpdate"]);
        unset($_SESSION["logUpdateTrue"]);
    }
    
   

    echo "<script>";
    echo "document.getElementById(\"updateLogDiv\").scrollIntoView();";
    // echo "targetDiv.scrollIntoView();";
    echo "</script>";


    unset($_POST["logIDUpdate"]);
    unset($_POST["logIsEndUpdate"]);
    unset($_POST["logUpdateRequest"]);

}

function updateLog($username, $logID, $isEnd) {
    $db = get_connection();

    $statement = $db->prepare("CALL `EditIsDone`(?,?,?)");

    $statement->bind_param('sss', $username, $logID, $isEnd);

    if ($statement->execute()) {
    
        $result = $statement->get_result();

        while ($row = $result->fetch_assoc()) {
        
            $output = $row["Result"];
            $error = $row["Error"];

            if($output == "true") {
                echo "<span style='color: green' id=\"tempMsg\"> successfully updated the item of logID: '$logID' </span>";
                $_SESSION["logUpdateTrue"] = true;;
            }

            else {
                echo "<span style='color: red' id=\"tempMsg\"> $error </span>";
            }
            return;
        }
    }
    else {
        echo "Error getting result: " . mysqli_error($db);
        die();

        return;
    }
    return;
}

?>