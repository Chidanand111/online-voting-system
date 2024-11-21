<?php
include 'includes/session.php';

if (isset($_POST['add'])) {
    // Fetch form data
    $firstname = $_POST['firstname'];  //Voter FirstName Required
    $lastname = $_POST['lastname'];    //Voter LastName Required
    $password = $_POST['password'];    //Password For Voter Login Required
    $filename = $_FILES['photo']['name'];  //Voter Photo file
    
    // Move uploaded photo to the server
    if (!empty($filename)) {
        move_uploaded_file($_FILES['photo']['tmp_name'], '../images/' . $filename);
    }

    // Call MySQL function to generate voter ID
    $sql = "SELECT generate_voter_id() AS voter_id";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    $voter_id = $row['voter_id'];  // Get the generated Voter ID

    // Insert data into the database (removed email-related column)
    $sql = "INSERT INTO voters (voters_id, password, firstname, lastname, photo) 
            VALUES ('$voter_id', '$password', '$firstname', '$lastname', '$filename')";
    
    if ($conn->query($sql)) {
        $_SESSION['success'] = 'Voter added successfully';
    } else {
        $_SESSION['error'] = $conn->error;  // Display error if query fails
    }
} else {
    $_SESSION['error'] = 'Fill up the add form first';
}

header('location: voters.php');
?>
