<?php
require_once '../modelo/ambulancia_modelo.php';
require_once '../conexion.php';

$conexion = new Conexion();
$conn = $conexion->getConexion();
$modelo = new AmbulanciaModelo($conn);

if (isset($_POST['accion'])) {
    $accion = $_POST['accion'];
    
    switch ($accion) {
        case 'agregar':
            $placa = $_POST['placa'];
            $disponibilidad = $_POST['disponibilidad'];
            $conductor_id = isset($_POST['conductor_id']) ? $_POST['conductor_id'] : null;
            $equipo_trabajo = isset($_POST['equipo_trabajo']) ? $_POST['equipo_trabajo'] : null;
            $plan = isset($_POST['plan']) ? $_POST['plan'] : null;
            $categoria_ambu = $_POST['categoria_ambu'];
            
            $modelo->agregarAmbulancia($placa, $disponibilidad, $conductor_id, $equipo_trabajo, $plan, $categoria_ambu);
            break;

        case 'editar':
            $id = $_POST['id'];
            $placa = $_POST['placa'];
            $disponibilidad = $_POST['disponibilidad'];
            $conductor_id = isset($_POST['conductor_id']) ? $_POST['conductor_id'] : null;
            $equipo_trabajo = isset($_POST['equipo_trabajo']) ? $_POST['equipo_trabajo'] : null;
            $plan = isset($_POST['plan']) ? $_POST['plan'] : null;
            $categoria_ambu = $_POST['categoria_ambu'];
            
            $modelo->editarAmbulancia($id, $placa, $disponibilidad, $conductor_id, $equipo_trabajo, $plan, $categoria_ambu);
            break;

        case 'cambiarDisponibilidad':
            $id = $_POST['id'];
            $disponibilidad = $_POST['disponibilidad'];
            $quitar_conductor = ($disponibilidad == 'En mantenimiento');
            $modelo->cambiarEstadoAmbulancia($id, $disponibilidad, $quitar_conductor);
            break;

        default:
            header('Location: ../vista/ambulancia_vista.php');
            exit;
    }

    header('Location: ../vista/ambulancia_vista.php');
    exit;
} else {
    header('Location: ../vista/ambulancia_vista.php');
    exit;
}
?>
