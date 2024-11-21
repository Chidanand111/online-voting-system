<?php
	$conn = new mysqli('localhost', 'root', 'Chida@06', 'votesystem');

	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	}
	
?>