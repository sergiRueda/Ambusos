-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-09-2024 a las 18:49:18
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ambusos3`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ambulancias`
--

CREATE TABLE `ambulancias` (
  `id` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `disponibilidad` enum('Disponible','En servicio','En mantenimiento') NOT NULL DEFAULT 'Disponible',
  `conductor_id` int(11) DEFAULT NULL,
  `equipo_trabajo` int(11) DEFAULT NULL,
  `plan` enum('Básico 1','Básico 2','Básico 3','Avanzado 1','Avanzado 2','Avanzado 3','Especializado 1','Especializado 2','Especializado 3') DEFAULT NULL,
  `categoria_ambu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ambulancias`
--

INSERT INTO `ambulancias` (`id`, `placa`, `disponibilidad`, `conductor_id`, `equipo_trabajo`, `plan`, `categoria_ambu`) VALUES
(1, 'ABC-999', 'En servicio', NULL, NULL, NULL, NULL),
(2, 'DEF-111', 'En servicio', 2, NULL, NULL, NULL),
(3, 'GHI-222', 'Disponible', 3, NULL, NULL, NULL),
(4, 'JKL-333', 'En servicio', 4, NULL, NULL, NULL),
(5, 'MNO-444', 'Disponible', 5, 10, 'Avanzado 3', 2),
(6, 'PQR-555', 'En servicio', 6, NULL, NULL, NULL),
(7, 'STU-666', 'Disponible', 7, NULL, NULL, NULL),
(8, 'VWX-777', 'En servicio', 8, NULL, NULL, NULL),
(9, 'YZA-888', 'Disponible', 9, NULL, NULL, NULL),
(10, 'BCD-999', 'En servicio', 10, NULL, NULL, NULL),
(11, 'EFG-000', 'Disponible', 11, NULL, NULL, NULL),
(12, 'HIJ-111', 'En servicio', 12, NULL, NULL, NULL),
(13, 'KLM-222', 'Disponible', 13, NULL, NULL, NULL),
(14, 'NOP-333', 'En servicio', 14, NULL, NULL, NULL),
(15, 'QRS-444', 'Disponible', 15, NULL, NULL, NULL),
(16, 'TUV-555', 'En servicio', 16, NULL, NULL, NULL),
(17, 'WXY-666', 'Disponible', 17, NULL, NULL, NULL),
(18, 'ZAB-777', 'En servicio', 18, NULL, NULL, NULL),
(19, 'CDE-888', 'Disponible', 19, NULL, NULL, NULL),
(20, 'FGH-999', 'En servicio', 20, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_ambulancia`
--

CREATE TABLE `categorias_ambulancia` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_ambulancia`
--

INSERT INTO `categorias_ambulancia` (`id_categoria`, `nombre_categoria`) VALUES
(1, 'Soporte vital básico'),
(2, 'Soporte vital avanzado'),
(3, 'Transporte asistencial'),
(4, 'Ambulancia especializada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo_trabajo`
--

CREATE TABLE `equipo_trabajo` (
  `id_equipo` int(11) NOT NULL,
  `equipo_de_trabajo` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipo_trabajo`
--

INSERT INTO `equipo_trabajo` (`id_equipo`, `equipo_de_trabajo`) VALUES
(1, 'Equipo_basico_1'),
(2, 'Equipo_basico_2'),
(3, 'Equipo_basico_3'),
(4, 'Equipo_basico_4'),
(5, 'Equipo_basico_5'),
(6, 'Equipo_avanzado_1'),
(7, 'Equipo_avanzado_2'),
(8, 'Equipo_avanzado_3'),
(9, 'Equipo_avanzado_4'),
(10, 'Equipo_avanzado_5'),
(11, 'Equipo_especializado_1'),
(12, 'Equipo_especializado_2'),
(13, 'Equipo_especializado_3'),
(14, 'Equipo_especializado_4'),
(15, 'Equipo_especializado_5'),
(16, 'Equipo_asistencial_1'),
(17, 'Equipo_asistencial_2'),
(18, 'Equipo_asistencial_3'),
(19, 'Equipo_asistencial_4'),
(20, 'Equipo_asistencial_5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formulario_ambulancias`
--

CREATE TABLE `formulario_ambulancias` (
  `id` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `ambulancia_id` int(11) NOT NULL,
  `paciente_id` int(11) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `personal_responsable_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `formulario_ambulancias`
--

INSERT INTO `formulario_ambulancias` (`id`, `fecha`, `ambulancia_id`, `paciente_id`, `hospital_id`, `personal_responsable_id`) VALUES
(1, '2024-01-01 00:00:00', 1, 1, 1, 1),
(2, '2024-01-02 00:00:00', 2, 2, 2, 2),
(3, '2024-01-03 00:00:00', 3, 3, 3, 3),
(4, '2024-01-04 00:00:00', 4, 4, 4, 4),
(5, '2024-01-05 00:00:00', 5, 5, 5, 5),
(6, '2024-01-06 00:00:00', 6, 6, 6, 6),
(7, '2024-01-07 00:00:00', 7, 7, 7, 7),
(8, '2024-01-08 00:00:00', 8, 8, 8, 8),
(9, '2024-01-09 00:00:00', 9, 9, 9, 9),
(10, '2024-01-10 00:00:00', 10, 10, 10, 10),
(11, '2024-01-11 00:00:00', 1, 11, 11, 11),
(12, '2024-01-12 00:00:00', 2, 12, 12, 12),
(13, '2024-01-13 00:00:00', 3, 13, 13, 13),
(14, '2024-01-14 00:00:00', 4, 14, 14, 14),
(15, '2024-01-15 00:00:00', 5, 15, 15, 15),
(16, '2024-01-16 00:00:00', 6, 16, 16, 16),
(17, '2024-01-17 00:00:00', 7, 17, 17, 17),
(18, '2024-01-18 00:00:00', 8, 18, 18, 18),
(19, '2024-01-19 00:00:00', 9, 19, 19, 19),
(20, '2024-01-20 00:00:00', 10, 20, 20, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_ambulancia`
--

CREATE TABLE `historial_ambulancia` (
  `id_historial` int(11) NOT NULL,
  `ambulancia_asignada` int(11) NOT NULL,
  `tiempo` time NOT NULL,
  `nombre_ubicacion` varchar(30) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `punto_i` varchar(30) NOT NULL,
  `punto_f` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hospitales`
--

CREATE TABLE `hospitales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `capacidad_atencion` int(11) DEFAULT NULL,
  `categoria` enum('Hospital General Básico','Hospital Regional','Hospital Universitario','Hospital de Investigación Avanzada','Centro de Trauma y Emergencias') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hospitales`
--

INSERT INTO `hospitales` (`id`, `nombre`, `direccion`, `capacidad_atencion`, `categoria`) VALUES
(1, 'Hospital Central', 'Av. Principal 123', 200, 'Hospital General Básico'),
(2, 'Hospital del Norte', 'Calle Secundaria 456', 150, 'Hospital General Básico'),
(3, 'Hospital Sur', 'Avenida de la Salud 789', 100, 'Hospital General Básico'),
(4, 'Hospital Este', 'Calle de la Esperanza 101', 250, 'Hospital General Básico'),
(5, 'Hospital Oeste', 'Calle del Progreso 202', 180, 'Hospital General Básico'),
(6, 'Hospital de la Costa', 'Avenida del Mar 678', 90, 'Hospital General Básico'),
(7, 'Centro de Salud del Norte', 'Calle Norte 901', 85, 'Hospital General Básico'),
(8, 'Hospital del Futuro', 'Avenida Innovación 234', 60, 'Hospital General Básico'),
(9, 'Clínica San Miguel', 'Calle de la Salud 567', 30, 'Hospital General Básico'),
(10, 'Hospital Central', 'Av. Central 890', 110, 'Hospital General Básico'),
(11, 'Clínica del Sur', 'Calle del Sur 123', 70, 'Hospital General Básico'),
(12, 'Centro Médico del Este', 'Avenida Este 456', 95, 'Hospital General Básico'),
(13, 'Hospital de la Ciudad', 'Calle de la Ciudad 789', 80, 'Hospital General Básico'),
(14, 'Clínica Nueva Esperanza', 'Avenida Esperanza 012', 50, 'Hospital General Básico'),
(15, 'Hospital San Juan', 'Calle de San Juan 345', 115, 'Hospital General Básico'),
(16, 'Clínica San Pedro', 'Avenida San Pedro 678', 45, 'Hospital General Básico'),
(17, 'Centro de Atención Médica', 'Calle Médica 901', 100, 'Hospital General Básico'),
(18, 'Hospital del Centro', 'Av. del Centro 234', 130, 'Hospital General Básico'),
(19, 'Clínica de la Familia', 'Calle Familiar 567', 55, 'Hospital General Básico'),
(20, 'Hospital Nacional', 'Calle Nacional 890', 105, 'Centro de Trauma y Emergencias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inicio_sesion`
--

CREATE TABLE `inicio_sesion` (
  `id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contraseña` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `hospital_id` int(11) DEFAULT NULL,
  `ambulancia_id` int(11) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `genero` enum('Masculino','Femenino','Otro') NOT NULL,
  `seguro_medico` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `nombre`, `apellido`, `numero_documento`, `hospital_id`, `ambulancia_id`, `estado`, `genero`, `seguro_medico`) VALUES
(1, 'María', 'García', '67890123', 1, 1, 'Activo', 'Femenino', 'Seguro A'),
(2, 'Luis', 'Fernández', '78901234', 2, NULL, 'Activo', 'Masculino', 'Seguro B'),
(3, 'Claudia', 'Ramírez', '89012345', 3, NULL, 'Activo', 'Femenino', 'Seguro C'),
(4, 'Andrés', 'Cruz', '90123456', 4, NULL, 'Inactivo', 'Masculino', 'Seguro D'),
(5, 'Gabriela', 'Sánchez', '01234567', 5, NULL, 'Activo', 'Femenino', 'Seguro E'),
(6, 'Jorge', 'García', '67550123', 6, 6, 'Activo', 'Femenino', 'EPS Salud'),
(7, 'Sofía', 'Cano', '78661234', 7, 7, 'Activo', 'Masculino', 'Famisanar'),
(8, 'Pedro', 'Álvarez', '89014445', 8, 8, 'Activo', 'Otro', 'Medimás'),
(9, 'Valeria', 'Torres', '90223456', 9, 9, 'Activo', 'Otro', 'Savia Salud'),
(10, 'Andrés', 'Suárez', '03334567', 10, 10, 'Activo', 'Masculino', 'Saludcoop'),
(11, 'Gabriela', 'Mora', '11223344', 11, 11, 'Activo', 'Femenino', 'Nueva EPS'),
(12, 'Felipe', 'Muñoz', '22334455', 12, 12, 'Activo', 'Femenino', 'Sanitas'),
(13, 'Isabel', 'Córdoba', '33445566', 13, 13, 'Activo', 'Otro', 'EPS Sanitas'),
(14, 'Santiago', 'Vargas', '44556677', 14, 14, 'Activo', 'Femenino', 'Salud Total'),
(15, 'Catalina', 'Ospina', '55667788', 15, 15, 'Activo', 'Masculino', 'Coomeva'),
(16, 'Felipe', 'Rodríguez', '66778899', 16, 16, 'Activo', 'Masculino', 'Sura'),
(17, 'Alejandra', 'Castro', '77889900', 17, 17, 'Activo', 'Femenino', 'Compensar'),
(18, 'Sebastián', 'Paredes', '88990011', 18, 18, 'Activo', 'Femenino', 'EPS Salud'),
(19, 'Diana', 'Jiménez', '99001122', 19, 19, 'Activo', 'Femenino', 'Famisanar'),
(20, 'Daniel', 'Morales', '00112233', 20, 20, 'Activo', 'Femenino', 'Medimás');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `equipo_trabajo` varchar(30) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`id`, `nombre`, `apellido`, `numero_documento`, `id_rol`, `equipo_trabajo`, `estado`) VALUES
(1, 'Juan', 'Pérez', '12345678', 1, NULL, 'Activo'),
(2, 'Ana', 'Gómez', '23456789', 2, NULL, 'Activo'),
(3, 'Carlos', 'López', '34567890', 3, NULL, 'Activo'),
(4, 'Laura', 'Martínez', '45678901', 4, NULL, 'Activo'),
(5, 'Pedro', 'Rodríguez', '56789012', 1, NULL, 'Activo'),
(6, 'Sofía', 'Morales', '67890123', 2, NULL, 'Activo'),
(7, 'Diego', 'Jiménez', '78901234', 3, NULL, 'Activo'),
(8, 'Valeria', 'Hernández', '89012345', 4, NULL, 'Activo'),
(9, 'Miguel', 'Santos', '90123456', 1, NULL, 'Activo'),
(10, 'Lucía', 'Castro', '01234567', 2, NULL, 'Activo'),
(11, 'Andrés', 'Ortiz', '12345679', 3, NULL, 'Activo'),
(12, 'Camila', 'Reyes', '23456780', 4, NULL, 'Activo'),
(13, 'Tomás', 'García', '34567891', 1, NULL, 'Activo'),
(14, 'Natalia', 'Ruiz', '45678902', 2, NULL, 'Activo'),
(15, 'Felipe', 'Moreno', '56789023', 3, NULL, 'Activo'),
(16, 'María', 'Álvarez', '67890134', 4, NULL, 'Activo'),
(17, 'Mateo', 'Vega', '78901245', 1, NULL, 'Activo'),
(18, 'Isabella', 'García', '89012356', 2, NULL, 'Activo'),
(19, 'Juan Pablo', 'Martínez', '90123467', 3, NULL, 'Activo'),
(20, 'Marta', 'Gómez', '01234578', 4, NULL, 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'Conductor'),
(2, 'Enfermera'),
(3, 'Paramédico'),
(4, 'Médico'),
(5, 'Auxiliar'),
(6, 'Usuario'),
(7, 'Administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `correo_electronico`, `contraseña`, `id_rol`) VALUES
(7, 'admin1', 'admin1@example.com', '4b971cafd7903d148bda8f8aa7faa57b769cded513ecb31e124d1e010a80555f', 1),
(8, 'admin2', 'admin2@example.com', 'ddc7ce475d6d6c9473ccdfa8c978982ace8b8aa1a18fb7cfc26cf2c96ea6d07f', 1),
(9, 'usuario1', 'usuario1@example.com', '3d421182253d10b0c1184f7be9500b1fd3eaa33edb1cf705e93eee88e42f2e71', 6),
(10, 'usuario2', 'usuario2@example.com', '9edd2447c1c611531f5f590f1e1df353100217edef292423d57ae147b1e7fa8f', 6),
(11, 'user3', 'user3@example.com', 'be91377754347a8f756bf8e38cb896698ba9d9a7388698defda7487e19334e31', 6),
(12, 'user4', 'user4@example.com', '7c67eb4a48ed008cd4174f5902bb91af1384731ef3ddc7d417e729ec066739cc', 6),
(13, 'user5', 'user5@example.com', '18cc3b19fff545029351480b4bb72fa9c7c605722e788016e72a3f1a0f1fc298', 6),
(14, 'user6', 'user6@example.com', 'fbef90cd3e9d9e0f1f7c7629fb29ea3a715c4af5d7cdfbc4cd88e4882f52c35a', 6),
(15, 'user7', 'user7@example.com', 'e8c6e479be9c58112a38f9baaa1fcb3ca8e0984a85b70386f8dbc6d57fee77cd', 6),
(16, 'user8', 'user8@example.com', 'a66e662763cf5406a3e2fd5768e41b8a1d7eef63089ff869b33f2e9b0b6b2491', 6),
(17, 'user9', 'user9@example.com', '6a32ce91d3a6e981b5dede71b770d229a1b09e7b993f317ee0b42fb3e1758bc2', 6),
(18, 'user10', 'user10@example.com', '2424d1f7bc547e79d292d34a2ebe828dbfb780a318b1728127e10c5442e8e077', 6),
(19, 'user11', 'user11@example.com', '2663e3f92a2153564657bc9e2f2c670df099faea465fa225bc5bbdcc0d650964', 6),
(20, 'user12', 'user12@example.com', '8b6b5798b3f91f5e35ea28584c9973a185565182f48a67fb77e102c37c0a6b6f', 6),
(21, 'user13', 'user13@example.com', '2424d1f7bc547e79d292d34a2ebe828dbfb780a318b1728127e10c5442e8e077', 6),
(22, 'user14', 'user14@example.com', '2663e3f92a2153564657bc9e2f2c670df099faea465fa225bc5bbdcc0d650964', 6),
(23, 'user15', 'user15@example.com', '8b6b5798b3f91f5e35ea28584c9973a185565182f48a67fb77e102c37c0a6b6f', 6),
(24, 'user16', 'user16@example.com', '2424d1f7bc547e79d292d34a2ebe828dbfb780a318b1728127e10c5442e8e077', 6),
(25, 'user17', 'user17@example.com', '2663e3f92a2153564657bc9e2f2c670df099faea465fa225bc5bbdcc0d650964', 6),
(26, 'user18', 'user18@example.com', '8b6b5798b3f91f5e35ea28584c9973a185565182f48a67fb77e102c37c0a6b6f', 6),
(27, 'user19', 'user19@example.com', '2424d1f7bc547e79d292d34a2ebe828dbfb780a318b1728127e10c5442e8e077', 6),
(28, 'user20', 'user20@example.com', '2663e3f92a2153564657bc9e2f2c670df099faea465fa225bc5bbdcc0d650964', 6);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ambulancias`
--
ALTER TABLE `ambulancias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `conductor_id` (`conductor_id`),
  ADD KEY `fk_equipo_trabajo` (`equipo_trabajo`),
  ADD KEY `fk_categoria` (`categoria_ambu`);

--
-- Indices de la tabla `categorias_ambulancia`
--
ALTER TABLE `categorias_ambulancia`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `equipo_trabajo`
--
ALTER TABLE `equipo_trabajo`
  ADD PRIMARY KEY (`id_equipo`);

--
-- Indices de la tabla `formulario_ambulancias`
--
ALTER TABLE `formulario_ambulancias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ambulancia_id` (`ambulancia_id`),
  ADD KEY `paciente_id` (`paciente_id`),
  ADD KEY `hospital_id` (`hospital_id`),
  ADD KEY `personal_responsable_id` (`personal_responsable_id`);

--
-- Indices de la tabla `historial_ambulancia`
--
ALTER TABLE `historial_ambulancia`
  ADD PRIMARY KEY (`id_historial`);

--
-- Indices de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inicio_sesion`
--
ALTER TABLE `inicio_sesion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD KEY `hospital_id` (`hospital_id`),
  ADD KEY `ambulancia_id` (`ambulancia_id`);

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_documento` (`numero_documento`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `correo_electronico` (`correo_electronico`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ambulancias`
--
ALTER TABLE `ambulancias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `categorias_ambulancia`
--
ALTER TABLE `categorias_ambulancia`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `equipo_trabajo`
--
ALTER TABLE `equipo_trabajo`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `formulario_ambulancias`
--
ALTER TABLE `formulario_ambulancias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `historial_ambulancia`
--
ALTER TABLE `historial_ambulancia`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `inicio_sesion`
--
ALTER TABLE `inicio_sesion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ambulancias`
--
ALTER TABLE `ambulancias`
  ADD CONSTRAINT `ambulancias_ibfk_1` FOREIGN KEY (`conductor_id`) REFERENCES `personal` (`id`),
  ADD CONSTRAINT `fk_categoria` FOREIGN KEY (`categoria_ambu`) REFERENCES `categorias_ambulancia` (`id_categoria`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_equipo_trabajo` FOREIGN KEY (`equipo_trabajo`) REFERENCES `equipo_trabajo` (`id_equipo`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `formulario_ambulancias`
--
ALTER TABLE `formulario_ambulancias`
  ADD CONSTRAINT `formulario_ambulancias_ibfk_1` FOREIGN KEY (`ambulancia_id`) REFERENCES `ambulancias` (`id`),
  ADD CONSTRAINT `formulario_ambulancias_ibfk_2` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`),
  ADD CONSTRAINT `formulario_ambulancias_ibfk_3` FOREIGN KEY (`hospital_id`) REFERENCES `hospitales` (`id`),
  ADD CONSTRAINT `formulario_ambulancias_ibfk_4` FOREIGN KEY (`personal_responsable_id`) REFERENCES `personal` (`id`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_ibfk_1` FOREIGN KEY (`hospital_id`) REFERENCES `hospitales` (`id`),
  ADD CONSTRAINT `pacientes_ibfk_2` FOREIGN KEY (`ambulancia_id`) REFERENCES `ambulancias` (`id`);

--
-- Filtros para la tabla `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `personal_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
