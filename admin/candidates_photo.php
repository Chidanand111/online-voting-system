<?php
include 'db_connect.php';

if (isset($_POST['upload'])) {
    $id = $_POST['id'];
    $photo = null;

    // Handle file upload
    if (isset($_FILES['photo']) && $_FILES['photo']['error'] == 0) {
        $photo = file_get_contents($_FILES['photo']['tmp_name']);
    }

    $stmt = $conn->prepare("UPDATE candidates SET photo=? WHERE id=?");
    $stmt->bind_param("bi", $photo, $id);
    $stmt->send_long_data(0, $photo);

    if ($stmt->execute()) {
        header('location: admin_dashboard.php?success=Photo updated successfully');
    } else {
        header('location: admin_dashboard.php?error=Failed to update photo');
    }

    $stmt->close();
}
?>
