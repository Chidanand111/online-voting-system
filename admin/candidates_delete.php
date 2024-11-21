<?php
include 'includes/session.php';

if (isset($_POST['delete'])) {
    $id = $_POST['id'];

    // Sanitize the input to prevent SQL injection
    $id = $conn->real_escape_string($id);

    // First, delete related votes
    $deleteVotesSql = "DELETE FROM votes WHERE candidate_id = '$id'";
    
    // Execute the votes deletion
    if ($conn->query($deleteVotesSql) === TRUE) {
        // Now delete the candidate
        $sql = "DELETE FROM candidates WHERE id = '$id'";
        if ($conn->query($sql) === TRUE) {
            $_SESSION['success'] = 'Candidate and related votes deleted successfully';
        } else {
            $_SESSION['error'] = 'Error deleting candidate: ' . $conn->error;
        }
    } else {
        $_SESSION['error'] = 'Error deleting related votes: ' . $conn->error;
    }
} else {
    $_SESSION['error'] = 'Select item to delete first';
}

header('location: candidates.php');
?>
