<?php

// function get_connection() {
//     //server address, username, password, database name


//     return mysqli_connect('localhost', 'sleep_tracker', 'rekcart_peels3420S22', 'sleep_tracker');
//         or die(mysqli_connect_error());
//         // the or die part was causing it to return a boolean instead of a database object a bit before @34:50
// }

function get_connection() {
    static $connection;
    
    if (!isset($connection)) {
        $connection = mysqli_connect('localhost', 's_t', 'rekcart_peels3420S22', 
            'sleep_tracker') or die(mysqli_connect_error());
    }
    if ($connection === false) {
        echo "Unable to connect to database<br>";
        echo mysqli_connect_error();
    }
  
    return $connection;
}

// source: /home/fac/nick/public_html/useraccounts/config.php

?>