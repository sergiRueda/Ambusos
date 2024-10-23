<?php
require_once '../modelo/ambulancia_modelo.php';
require_once '../conexion.php';

$conexion = new Conexion();
$conn = $conexion->getConexion();

$modelo = new AmbulanciaModelo($conn);
$ambulancias = $modelo->obtenerAmbulancias();

// Obtener los conductores con el rol de conductor
$conductores = [];
$query = "SELECT id, CONCAT(nombre, ' ', apellido) AS nombre FROM personal WHERE id_rol = (SELECT id FROM roles WHERE nombre = 'Conductor')";
$stmt = $conn->prepare($query);
$stmt->execute();
$conductores = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Obtener los equipos de trabajo
$equipos = [];
$query = "SELECT id_equipo, equipo_de_trabajo FROM equipo_trabajo";
$stmt = $conn->prepare($query);
$stmt->execute();
$equipos = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Obtener las categorías de ambulancias
$categorias = [];
$query = "SELECT id_categoria, nombre_categoria FROM categorias_ambulancia";
$stmt = $conn->prepare($query);
$stmt->execute();
$categorias = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Información sobre los planes
$planes = [
    'Básico 1' => 'Plan Básico 1: Cobertura básica para emergencias estándar.',
    'Básico 2' => 'Plan Básico 2: Cobertura básica extendida con algunos extras.',
    'Básico 3' => 'Plan Básico 3: Cobertura básica con servicios adicionales.',
    'Avanzado 1' => 'Plan Avanzado 1: Cobertura avanzada con más características.',
    'Avanzado 2' => 'Plan Avanzado 2: Cobertura avanzada extendida.',
    'Avanzado 3' => 'Plan Avanzado 3: Cobertura avanzada con todos los servicios.',
    'Especializado 1' => 'Plan Especializado 1: Cobertura especializada para necesidades específicas.',
    'Especializado 2' => 'Plan Especializado 2: Cobertura especializada extendida.',
    'Especializado 3' => 'Plan Especializado 3: Cobertura especializada completa.',
];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Ambulancias</title>
    <link rel="stylesheet" href="../../css/tablas.css">
    <style>
         .table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .table th {
            background-color: #f4f4f4;
            color: #333;
            font-weight: bold;
        }
        .table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .table tr:hover {
            background-color: #f1f1f1;
        }
        /* Estilos para los botones dentro de la tabla */
        .table button {
            background-color: #4CAF50; /* Verde */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .table button:hover {
            background-color: #45a049; /* Verde oscuro */
        }
        form input[type="text"], form input[type="number"], form select {
            width: calc(100% - 22px); /* Ajuste para el padding */
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        form button {
            background-color: #007BFF; /* Azul */
            border: none;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        form button:hover {
            background-color: #0056b3; /* Azul oscuro */
        }
        /* Estilos para el modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-gestion {
    background-color: #007bff; /* Color de fondo azul */
    color: white; /* Color del texto blanco */
    border: none; /* Sin borde */
    border-radius: 5px; /* Bordes redondeados */
    padding: 10px 20px; /* Espaciado interno */
    font-size: 16px; /* Tamaño de fuente */
    cursor: pointer; /* Cursor en forma de mano */
    transition: background-color 0.3s; /* Transición suave al pasar el ratón */
}

.btn-gestion:hover {
    background-color: #0056b3; /* Color de fondo azul más oscuro en hover */
}

    </style>
</head>
<body>
<header class="header">
        <!-- Header -->
        <div class="topheader">
            <div class="wrapper"></div>
            <nav>
                <a href="../../tipo_de_persona.html"><i class="fa-regular fa-user"></i> Inicia sesión</a>
            </nav>
        </div>
        <div class="wrapper">
            <div class="logo">
                <a href="../../index.html"> <img src="../../img/logo_2.png" width="300px" alt="Logo"></a>
            </div>
            <nav>
                <a href="../../index.html">Inicio</a>
                <a href="../../mapa_de_usuario.html">Mapa</a>
                <a href="../../apartados_ambu.html">Otros</a>
            </nav>
        </div>
    </header>
   


    <section class="container">
        <h4>Agregar Ambulancia</h4>
        <button type="button" class="btn-gestion" onclick="window.location.href='../../gestion.html'">Ir a Gestión</button>
        <form action="../controlador/ambulancia_controlador.php" method="POST">
            <input type="hidden" name="accion" value="agregar">
            <label for="placa">Placa:</label>
            <input type="text" name="placa" id="placa" required>
            
            <label for="disponibilidad">Disponibilidad:</label>
            <select name="disponibilidad" id="disponibilidad" onchange="toggleConductorForm(this.value)">
                <option value="Disponible">Disponible</option>
                <option value="En servicio">En servicio</option>
                <option value="En mantenimiento">En mantenimiento</option>
            </select>
            
            <div id="conductor-container">
                <label for="conductor_id">Conductor:</label>
                <select name="conductor_id" id="conductor_id">
                    <option value="">Seleccione un conductor</option>
                    <?php foreach ($conductores as $conductor) : ?>
                        <option value="<?= $conductor['id'] ?>"><?= htmlspecialchars($conductor['nombre']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div id="equipo-container">
                <label for="equipo_trabajo">Equipo de Trabajo:</label>
                <select name="equipo_trabajo" id="equipo_trabajo">
                    <option value="">Seleccione un equipo de trabajo</option>
                    <?php foreach ($equipos as $equipo) : ?>
                        <option value="<?= $equipo['id_equipo'] ?>"><?= htmlspecialchars($equipo['equipo_de_trabajo']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div id="plan-container">
                <label for="plan">Plan:</label>
                <select name="plan" id="plan" onchange="showPlanInfo(this.value)">
                    <option value="">Seleccione un plan</option>
                    <?php foreach ($planes as $key => $value) : ?>
                        <option value="<?= $key ?>"><?= htmlspecialchars($key) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <label for="categoria_ambu">Categoría:</label>
            <select name="categoria_ambu" id="categoria_ambu">
                <option value="">Seleccione una categoría</option>
                <?php foreach ($categorias as $categoria) : ?>
                    <option value="<?= $categoria['id_categoria'] ?>"><?= htmlspecialchars($categoria['nombre_categoria']) ?></option>
                <?php endforeach; ?>
            </select>

            <button type="submit">Agregar Ambulancia</button>
        </form>
        
        <h4>Lista de Ambulancias</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Placa</th>
                    <th>Disponibilidad</th>
                    <th>Conductor</th>
                    <th>Equipo de Trabajo</th>
                    <th>Plan</th>
                    <th>Categoría</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($ambulancias as $ambulancia) : ?>
                    <tr>
                        <td><?= htmlspecialchars($ambulancia['id']) ?></td>
                        <td><?= htmlspecialchars($ambulancia['placa']) ?></td>
                        <td><?= htmlspecialchars($ambulancia['disponibilidad']) ?></td>
                        <td><?= htmlspecialchars($ambulancia['conductor_nombre']) ?></td>
                        <td><?= htmlspecialchars($ambulancia['equipo_trabajo_nombre']) ?></td>
                        <td><?= htmlspecialchars($ambulancia['plan']) ?></td>
                        <td><?= htmlspecialchars($ambulancia['categoria_nombre']) ?></td>
                        <td>
                            <form action="../controlador/ambulancia_controlador.php" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<?= htmlspecialchars($ambulancia['id']) ?>">
                                <select name="disponibilidad" data-id="<?= htmlspecialchars($ambulancia['id']) ?>" onchange="toggleFields(this.value, <?= htmlspecialchars($ambulancia['id']) ?>)">
                                    <option value="Disponible" <?= $ambulancia['disponibilidad'] == 'Disponible' ? 'selected' : '' ?>>Disponible</option>
                                    <option value="En servicio" <?= $ambulancia['disponibilidad'] == 'En servicio' ? 'selected' : '' ?>>En servicio</option>
                                    <option value="En mantenimiento" <?= $ambulancia['disponibilidad'] == 'En mantenimiento' ? 'selected' : '' ?>>En mantenimiento</option>
                                </select>
                                <button type="submit" name="accion" value="cambiarDisponibilidad">Cambiar Disponibilidad</button>
                            </form>

                            <button onclick="document.getElementById('editar-<?= htmlspecialchars($ambulancia['id']) ?>').style.display = 'block';">Editar</button>
                        </td>
                    </tr>
                    <tr id="editar-<?= htmlspecialchars($ambulancia['id']) ?>" style="display:none;">
                        <td colspan="8">
                            <form action="../controlador/ambulancia_controlador.php" method="POST">
                                <input type="hidden" name="id" value="<?= htmlspecialchars($ambulancia['id']) ?>">
                                <label for="placa-<?= htmlspecialchars($ambulancia['id']) ?>">Placa:</label>
                                <input type="text" name="placa" id="placa-<?= htmlspecialchars($ambulancia['id']) ?>" value="<?= htmlspecialchars($ambulancia['placa']) ?>" required>

                                <label for="disponibilidad-<?= htmlspecialchars($ambulancia['id']) ?>">Disponibilidad:</label>
                                <select name="disponibilidad" id="disponibilidad-<?= htmlspecialchars($ambulancia['id']) ?>" onchange="toggleFields(this.value, <?= htmlspecialchars($ambulancia['id']) ?>)">
                                    <option value="Disponible" <?= $ambulancia['disponibilidad'] == 'Disponible' ? 'selected' : '' ?>>Disponible</option>
                                    <option value="En servicio" <?= $ambulancia['disponibilidad'] == 'En servicio' ? 'selected' : '' ?>>En servicio</option>
                                    <option value="En mantenimiento" <?= $ambulancia['disponibilidad'] == 'En mantenimiento' ? 'selected' : '' ?>>En mantenimiento</option>
                                </select>

                                <div id="conductor-container-<?= htmlspecialchars($ambulancia['id']) ?>">
                                    <label for="conductor_id-<?= htmlspecialchars($ambulancia['id']) ?>">Conductor:</label>
                                    <select name="conductor_id" id="conductor_id-<?= htmlspecialchars($ambulancia['id']) ?>">
                                        <option value="">Seleccione un conductor</option>
                                        <?php foreach ($conductores as $conductor) : ?>
                                            <option value="<?= $conductor['id'] ?>" <?= $ambulancia['conductor_id'] == $conductor['id'] ? 'selected' : '' ?>><?= htmlspecialchars($conductor['nombre']) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div id="equipo-container-<?= htmlspecialchars($ambulancia['id']) ?>">
                                    <label for="equipo_trabajo-<?= htmlspecialchars($ambulancia['id']) ?>">Equipo de Trabajo:</label>
                                    <select name="equipo_trabajo" id="equipo_trabajo-<?= htmlspecialchars($ambulancia['id']) ?>">
                                        <option value="">Seleccione un equipo de trabajo</option>
                                        <?php foreach ($equipos as $equipo) : ?>
                                            <option value="<?= $equipo['id_equipo'] ?>" <?= $ambulancia['equipo_trabajo'] == $equipo['id_equipo'] ? 'selected' : '' ?>><?= htmlspecialchars($equipo['equipo_de_trabajo']) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <div id="plan-container-<?= htmlspecialchars($ambulancia['id']) ?>">
                                    <label for="plan-<?= htmlspecialchars($ambulancia['id']) ?>">Plan:</label>
                                    <select name="plan" id="plan-<?= htmlspecialchars($ambulancia['id']) ?>" onchange="showPlanInfo(this.value)">
                                        <option value="">Seleccione un plan</option>
                                        <?php foreach ($planes as $key => $value) : ?>
                                            <option value="<?= $key ?>" <?= $ambulancia['plan'] == $key ? 'selected' : '' ?>><?= htmlspecialchars($key) ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>

                                <label for="categoria_ambu-<?= htmlspecialchars($ambulancia['id']) ?>">Categoría:</label>
                                <select name="categoria_ambu" id="categoria_ambu-<?= htmlspecialchars($ambulancia['id']) ?>">
                                    <option value="">Seleccione una categoría</option>
                                    <?php foreach ($categorias as $categoria) : ?>
                                        <option value="<?= $categoria['id_categoria'] ?>" <?= $ambulancia['categoria_ambu'] == $categoria['id_categoria'] ? 'selected' : '' ?>><?= htmlspecialchars($categoria['nombre_categoria']) ?></option>
                                    <?php endforeach; ?>
                                </select>

                                <button type="submit" name="accion" value="editar">Guardar Cambios</button>
                                <button type="button" onclick="document.getElementById('editar-<?= htmlspecialchars($ambulancia['id']) ?>').style.display = 'none';">Cancelar</button>
                            </form>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </section>

    <!-- Modal para información del plan -->
    <div id="modal-plan-info" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="modal-content"></div>
        </div>
    </div>


    <footer class="pie-pagina">
        <div class="grupo-1">
            <div class="box">
                <span>
                    <a href="../../index.html">
                        <img src="../../img/logo.png" alt="Logo de Liber-Arte" width="100px">
                    </a>
                </span>
            </div>
            <div class="box">
                <h2>-SOBRE NOSOTROS</h2>
                <p>Ambusos: tu aliado en emergencias. Brindamos atención médica rápida y confiable cuando más lo necesitas </p>
            </div>
            </div>
        </div>
        <div class="grupo-2">
            <small>&copy; 2024 <b>AMBUSOS</b> - Todos los Derechos Reservados.</small>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const disponibilidadSelects = document.querySelectorAll('select[name="disponibilidad"]');
            
            disponibilidadSelects.forEach(select => {
                select.addEventListener('change', function() {
                    const id = this.dataset.id || '';
                    toggleFields(this.value, id);
                });
            });

            const initDispo = document.querySelectorAll('select[name="disponibilidad"]');
            initDispo.forEach(select => {
                const id = select.dataset.id || '';
                toggleFields(select.value, id);
            });
        });

        function toggleFields(value, id = '') {
            const prefix = id ? `-${id}` : '';
            const conductorContainer = document.getElementById(`conductor-container${prefix}`);
            const equipoContainer = document.getElementById(`equipo-container${prefix}`);
            const planContainer = document.getElementById(`plan-container${prefix}`);

            if (value === 'En mantenimiento') {
                if (conductorContainer) conductorContainer.style.display = 'none';
                if (equipoContainer) equipoContainer.style.display = 'none';
                if (planContainer) planContainer.style.display = 'none';
            } else {
                if (conductorContainer) conductorContainer.style.display = 'block';
                if (equipoContainer) equipoContainer.style.display = 'block';
                if (planContainer) planContainer.style.display = 'block';
            }
        }

        function toggleConductorForm(value) {
            const conductorContainer = document.getElementById('conductor-container');
            const equipoContainer = document.getElementById('equipo-container');
            const planContainer = document.getElementById('plan-container');

            if (value === 'En mantenimiento') {
                conductorContainer.style.display = 'none';
                equipoContainer.style.display = 'none';
                planContainer.style.display = 'none';
            } else {
                conductorContainer.style.display = 'block';
                equipoContainer.style.display = 'block';
                planContainer.style.display = 'block';
            }
        }

        function showPlanInfo(value) {
            const modal = document.getElementById('modal-plan-info');
            const modalContent = document.getElementById('modal-content');
            const closeModal = document.getElementsByClassName('close')[0];
            
            const planInfo = {
                'Básico 1': 'Plan Básico 1: Cobertura básica para emergencias estándar.',
                'Básico 2': 'Plan Básico 2: Cobertura básica extendida con algunos extras.',
                'Básico 3': 'Plan Básico 3: Cobertura básica con servicios adicionales.',
                'Avanzado 1': 'Plan Avanzado 1: Cobertura avanzada con más características.',
                'Avanzado 2': 'Plan Avanzado 2: Cobertura avanzada extendida.',
                'Avanzado 3': 'Plan Avanzado 3: Cobertura avanzada con todos los servicios.',
                'Especializado 1': 'Plan Especializado 1: Cobertura especializada para necesidades específicas.',
                'Especializado 2': 'Plan Especializado 2: Cobertura especializada extendida.',
                'Especializado 3': 'Plan Especializado 3: Cobertura especializada completa.'
            };

            if (value && planInfo[value]) {
                modalContent.innerHTML = `Información sobre el plan: ${planInfo[value]}`;
                modal.style.display = 'block';
            }

            closeModal.onclick = function() {
                modal.style.display = 'none';
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            }
        }
    </script>
</body>
</html>
