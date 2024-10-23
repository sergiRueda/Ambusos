<?php
// Incluir la clase de conexión
include("Conexion.php");

// Instanciar la clase y obtener la conexión
$conexion = new Conexion();
$conn = $conexion->getConexion(); // Obtener el objeto de conexión

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $correo = $_POST['Correo'];
    $contraseña = $_POST['Contraseña'];

    if (!$conn) {
        die("<h2>No se encuentra el servidor</h2>");
    }

    // Verificar si el correo existe
    $query = $conn->prepare("SELECT * FROM usuarios WHERE correo_electronico = ?");
    $query->bind_param("s", $correo);
    $query->execute();
    $result = $query->get_result();

    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        // Verificar si la contraseña es correcta
        if (password_verify($contraseña, $user['contraseña'])) {
            // Redireccionar a la página de inicio si las credenciales son correctas
            header("Location: ../index.html");
            exit;
        } else {
            echo '<script type="text/javascript"> alert("Contraseña incorrecta"); window.location.href="../inicio_sesion.html"; </script>';
        }
    } else {
        echo '<script type="text/javascript"> alert("Correo no registrado"); window.location.href="../inicio_sesion.html"; </script>';
    }
}

// Cerrar la conexión
$conexion->cerrarConexion();
?>
