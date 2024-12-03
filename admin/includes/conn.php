<?php
	$conn = new mysqli('localhost', 'root', 'your_mysql_password', 'votesystem');

	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	}
	
?>
