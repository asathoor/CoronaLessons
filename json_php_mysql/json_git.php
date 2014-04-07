<?php 

/*
PHP JSON ENCODE MYSQL
Eksempel - resultatet kan bruges i Lua.
*/

// CONNECT TO THE DATABASE
	$DB_NAME = 'XXXX';
	$DB_HOST = 'localhost';
	$DB_USER = 'XXXX';
	$DB_PASS = 'XXXX';
	
	$mysqli = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
	
	if (mysqli_connect_errno()) {
		printf("Connect failed: %s\n", mysqli_connect_error());
		exit();
	}

// utf-8
mysqli_query($mysqli, 'SET CHARACTER SET utf8');

// A QUICK QUERY
	$query = "SELECT * FROM `Albums`";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

// JSON CODE
$json = array(); 

if(mysqli_num_rows($result))
	{
		while($row=mysqli_fetch_row($result))
			{ 
				$json[]=$row; 
			} 
	} 

print( json_encode($json) ); 

// CLOSE CONNECTION
	mysqli_close($mysqli);

?>
