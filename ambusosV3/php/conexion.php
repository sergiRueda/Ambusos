<?php
class Conexion {
    private $conn;

    public function __construct() {
        $host = "localhost";
        $user = "root";
        $password = "";
        $db = "ambusos";

        $this->conn = new mysqli($host, $user, $password, $db);

        if ($this->conn->connect_error) {
            die("Conexión fallida: " . $this->conn->connect_error);
        }
    }

    public function getConexion() {
        return $this->conn;
    }

    public function cerrarConexion() {
        $this->conn->close();
    }
}
?>
