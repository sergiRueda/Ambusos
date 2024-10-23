<?php
class AmbulanciaModelo {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function obtenerAmbulancias() {
        $query = "SELECT a.id, a.placa, a.disponibilidad, a.conductor_id, a.equipo_trabajo, a.plan, a.categoria_ambu,
                         p.nombre AS conductor_nombre,
                         et.equipo_de_trabajo AS equipo_trabajo_nombre,
                         c.nombre_categoria AS categoria_nombre
                  FROM ambulancias a
                  LEFT JOIN personal p ON a.conductor_id = p.id
                  LEFT JOIN equipo_trabajo et ON a.equipo_trabajo = et.id_equipo
                  LEFT JOIN categorias_ambulancia c ON a.categoria_ambu = c.id_categoria";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function agregarAmbulancia($placa, $disponibilidad, $conductor_id, $equipo_trabajo, $plan, $categoria_ambu) {
        $query = "INSERT INTO ambulancias (placa, disponibilidad, conductor_id, equipo_trabajo, plan, categoria_ambu) 
                  VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("sssssi", $placa, $disponibilidad, $conductor_id, $equipo_trabajo, $plan, $categoria_ambu);
        return $stmt->execute();
    }

    public function editarAmbulancia($id, $placa, $disponibilidad, $conductor_id, $equipo_trabajo, $plan, $categoria_ambu) {
        $query = "UPDATE ambulancias SET placa = ?, disponibilidad = ?, conductor_id = ?, equipo_trabajo = ?, plan = ?, categoria_ambu = ? 
                  WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssssi", $placa, $disponibilidad, $conductor_id, $equipo_trabajo, $plan, $categoria_ambu, $id);
        return $stmt->execute();
    }

    public function cambiarEstadoAmbulancia($id, $disponibilidad, $quitar_conductor = false) {
        if ($quitar_conductor) {
            $query = "UPDATE ambulancias SET disponibilidad = ?, conductor_id = NULL, equipo_trabajo = NULL, plan = NULL WHERE id = ?";
        } else {
            $query = "UPDATE ambulancias SET disponibilidad = ? WHERE id = ?";
        }
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("si", $disponibilidad, $id);
        return $stmt->execute();
    }
}

?>
