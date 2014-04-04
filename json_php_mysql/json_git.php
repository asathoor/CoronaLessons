<?php 
/*
PHP JSON ENCODE MYSQL
Eksempel - resultatet kan bruges i Lua.
*/

// CONNECT TO THE DATABASE
	$DB_NAME = 'DATABASE_NAME';
	$DB_HOST = 'DATABASE_HOST';
	$DB_USER = 'DATABASE_USER';
	$DB_PASS = 'DATABASE_PASSWORD';
	
	$mysqli = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
	
	if (mysqli_connect_errno()) {
		printf("Connect failed: %s\n", mysqli_connect_error());
		exit();
	}

// A QUICK QUERY ON A FAKE USER TABLE
	$query = "SELECT * FROM `users` WHERE `status`='bonkers'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

/*
Ikke noedvendig i denne oevelse

// GOING THROUGH THE DATA
	if($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
			echo stripslashes($row['username']);	
		}
	}
	else {
		echo 'NO RESULTS';	
	}
*/	

// JSON CODE
$json = array(); 

if(mysql_num_rows($result))
	{
		while($row=mysql_fetch_row($result))
			{ 
				$json[]=$row; 
			} 
	} 

print( json_encode($json) ); 

// CLOSE CONNECTION
	mysqli_close($mysqli);


?>
