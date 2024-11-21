<<<<<<< HEAD
<?php
include 'includes/session.php';
include 'includes/slugify.php';

if (isset($_POST['vote'])) {
    // Check if no candidates are selected
    if (count($_POST) == 1) {
        $_SESSION['error'][] = 'Please vote for at least one candidate.';
    } else {
        $_SESSION['post'] = $_POST;

        // Check if the voter has already voted
        $check_vote_sql = "SELECT * FROM votes WHERE voters_id = '".$voter['id']."'";
        $check_vote_query = $conn->query($check_vote_sql);

        if ($check_vote_query->num_rows > 0) {
            $_SESSION['error'][] = 'You have already voted in this election.';
            header('location: home.php');
            exit();
        }

        // Fetch all positions
        $positions_sql = "SELECT * FROM positions";
        $positions_query = $conn->query($positions_sql);

        $error = false;
        $sql_array = array();

        // Loop through each position and process votes
        while ($row = $positions_query->fetch_assoc()) {
            $position = slugify($row['description']);
            $pos_id = $row['id'];

            if (isset($_POST[$position])) {
                // Handle multiple votes for a position
                if ($row['max_vote'] > 1) {
                    if (count($_POST[$position]) > $row['max_vote']) {
                        $error = true;
                        $_SESSION['error'][] = 'You can only choose up to ' . $row['max_vote'] . ' candidates for ' . $row['description'];
                    } else {
                        // Insert multiple votes for the position
                        foreach ($_POST[$position] as $candidate_id) {
                            $candidate_id = $conn->real_escape_string($candidate_id);
                            $sql_array[] = "INSERT INTO votes (voters_id, candidate_id, position_id) VALUES ('" . $voter['id'] . "', '$candidate_id', '$pos_id')";
                        }
                    }
                } else {
                    // Handle single vote for a position
                    $candidate_id = $conn->real_escape_string($_POST[$position]);
                    $sql_array[] = "INSERT INTO votes (voters_id, candidate_id, position_id) VALUES ('" . $voter['id'] . "', '$candidate_id', '$pos_id')";
                }
            }
        }

        // If there are no errors, insert the votes into the database
        if (!$error) {
            foreach ($sql_array as $sql_row) {
                if (!$conn->query($sql_row)) {
                    $_SESSION['error'][] = 'Error submitting your vote. Please try again.';
                    header('location: home.php');
                    exit();
                }
            }

            unset($_SESSION['post']);
            $_SESSION['success'] = 'Your ballot has been successfully submitted.';
        }
    }
} else {
    $_SESSION['error'][] = 'Please select candidates before submitting your vote.';
}

header('location: home.php');
exit();
?>
=======
<?php
include 'includes/session.php';
include 'includes/slugify.php';

if (isset($_POST['vote'])) {
    // Check if no candidates are selected
    if (count($_POST) == 1) {
        $_SESSION['error'][] = 'Please vote for at least one candidate.';
    } else {
        $_SESSION['post'] = $_POST;

        // Check if the voter has already voted
        $check_vote_sql = "SELECT * FROM votes WHERE voters_id = '".$voter['id']."'";
        $check_vote_query = $conn->query($check_vote_sql);

        if ($check_vote_query->num_rows > 0) {
            $_SESSION['error'][] = 'You have already voted in this election.';
            header('location: home.php');
            exit();
        }

        // Fetch all positions
        $positions_sql = "SELECT * FROM positions";
        $positions_query = $conn->query($positions_sql);

        $error = false;
        $sql_array = array();

        // Loop through each position and process votes
        while ($row = $positions_query->fetch_assoc()) {
            $position = slugify($row['description']);
            $pos_id = $row['id'];

            if (isset($_POST[$position])) {
                // Handle multiple votes for a position
                if ($row['max_vote'] > 1) {
                    if (count($_POST[$position]) > $row['max_vote']) {
                        $error = true;
                        $_SESSION['error'][] = 'You can only choose up to ' . $row['max_vote'] . ' candidates for ' . $row['description'];
                    } else {
                        // Insert multiple votes for the position
                        foreach ($_POST[$position] as $candidate_id) {
                            $candidate_id = $conn->real_escape_string($candidate_id);
                            $sql_array[] = "INSERT INTO votes (voters_id, candidate_id, position_id) VALUES ('" . $voter['id'] . "', '$candidate_id', '$pos_id')";
                        }
                    }
                } else {
                    // Handle single vote for a position
                    $candidate_id = $conn->real_escape_string($_POST[$position]);
                    $sql_array[] = "INSERT INTO votes (voters_id, candidate_id, position_id) VALUES ('" . $voter['id'] . "', '$candidate_id', '$pos_id')";
                }
            }
        }

        // If there are no errors, insert the votes into the database
        if (!$error) {
            foreach ($sql_array as $sql_row) {
                if (!$conn->query($sql_row)) {
                    $_SESSION['error'][] = 'Error submitting your vote. Please try again.';
                    header('location: home.php');
                    exit();
                }
            }

            unset($_SESSION['post']);
            $_SESSION['success'] = 'Your ballot has been successfully submitted.';
        }
    }
} else {
    $_SESSION['error'][] = 'Please select candidates before submitting your vote.';
}

header('location: home.php');
exit();
?>
>>>>>>> 3b8bb10338254d03e72f56c7e86ded2d29187fbd
