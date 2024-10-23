<?php
// Incluir la clase de conexión
include("conexion.php");

// Instanciar la clase y obtener la conexión
$conexion = new Conexion();
$conn = $conexion->getConexion(); // Obtener el objeto de conexión

// Verificar conexión
if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error());
}

// Procesar el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recoger los datos del formulario
    $nombre_usuario = $_POST["username"];
    $correo_electronico = $_POST["email"];
    $contraseña = $_POST["password"];

    // Encriptar la contraseña
    $contraseña_hash = password_hash($contraseña, PASSWORD_DEFAULT);

    // El valor de rol siempre será 6 (usuario)
    $rol = 6;

    // Preparar la consulta SQL
    $query = $conn->prepare("INSERT INTO usuarios (nombre_usuario, correo_electronico, contraseña, id_rol) VALUES (?, ?, ?, ?)");
    $query->bind_param("sssi", $nombre_usuario, $correo_electronico, $contraseña_hash, $rol);

    // Ejecutar la consulta
    if ($query->execute()) {
        echo "Registro exitoso";
        header("Location: ../inicio_sesion.html");
    } else {
        echo "Error al registrar el usuario: " . $query->error;
    }
}

// Cerrar la conexión
$conexion->cerrarConexion();
