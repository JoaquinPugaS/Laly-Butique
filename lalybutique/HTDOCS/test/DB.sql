-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-12-2022 a las 04:31:48
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lalyboutique`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id_admin` varchar(24) NOT NULL,
  `contrasenia_admin` varchar(255) NOT NULL,
  `email_admin` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id_admin`, `contrasenia_admin`, `email_admin`) VALUES
('admin', '$2y$10$HUCOTO1VAwh3i2iadjyEB.ReFWMqx5NZ97ZH5AUUlGSirkB5d7Tdu', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(5) NOT NULL,
  `id_Tipo` int(5) NOT NULL,
  `nombre_producto` varchar(50) NOT NULL,
  `stock_producto` int(4) NOT NULL,
  `stock_critico_producto` tinyint(2) NOT NULL,
  `precio_producto` int(9) NOT NULL,
  `talla_producto` varchar(4) NOT NULL,
  `imagen_producto` varchar(255) NOT NULL,
  `estado_producto` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_Tipo`, `nombre_producto`, `stock_producto`, `stock_critico_producto`, `precio_producto`, `talla_producto`, `imagen_producto`, `estado_producto`) VALUES
(106, 1, 'ola', 2, 5, 2000, '', ' ', 'Disponible'),
(107, 2, 'ola1', -1, 3, 2000, '', ' ', 'Disponible'),
(111, 1, 'Polera Nike', 20, 5, 2000, 'L', ' ', 'Disponible'),
(113, 2, 'Chaqueta naik', 20, 5, 6000, 'XXL', ' ', 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_pedido`
--

CREATE TABLE `producto_pedido` (
  `id_venta` int(8) NOT NULL,
  `id_producto` int(8) NOT NULL,
  `cantidad_producto` tinyint(3) NOT NULL,
  `precio_unitario` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto_pedido`
--

INSERT INTO `producto_pedido` (`id_venta`, `id_producto`, `cantidad_producto`, `precio_unitario`) VALUES
(3294, 55, 1, 2000),
(3294, 91, 1, 23),
(7592, 106, 1, 2000),
(62992, 91, 1, 23),
(75960, 99, 3, 3),
(82997, 107, 3, 2000),
(87663, 55, 1, 2000),
(96965, 55, 2, 2000),
(110381, 55, 2, 2000),
(110381, 66, 3, 2),
(112326, 66, 1, 60000),
(117675, 106, 1, 2000),
(122970, 91, 1, 23),
(136649, 55, 2, 2000),
(165223, 55, 2, 2000),
(165223, 98, 4, 34),
(171006, 55, 2, 2000),
(171006, 99, 3, 3),
(174619, 55, 2, 2000),
(189905, 55, 2, 2000),
(226202, 55, 1, 2000),
(228970, 55, 3, 2000),
(228970, 99, 2, 3),
(267819, 55, 2, 2000),
(330570, 105, 2, 200000),
(350646, 55, 6, 2000),
(356722, 55, 1, 2000),
(362682, 55, 1, 2000),
(373743, 105, 2, 200000),
(386745, 55, 14, 2000),
(387874, 106, 1, 2000),
(396871, 55, 1, 2000),
(400392, 55, 1, 2000),
(403794, 55, 2, 2000),
(405924, 55, 1, 2000),
(405924, 60, 1, 1),
(412026, 55, 3, 2000),
(412026, 99, 2, 3),
(418081, 105, 1, 200000),
(423544, 55, 1, 2000),
(441080, 55, 2, 2000),
(483809, 55, 2, 2000),
(491853, 106, 1, 2000),
(494393, 99, 5, 3),
(500743, 55, 1, 2000),
(502805, 60, 1, 22990),
(502805, 66, 1, 60000),
(513180, 55, 2, 2000),
(534341, 55, 2, 2000),
(536071, 66, 4, 2),
(543476, 55, 2, 2000),
(556150, 55, 1, 2000),
(558017, 55, 3, 2000),
(558017, 99, 3, 3),
(567437, 105, 1, 200000),
(575164, 66, 5, 2),
(617834, 55, 2, 2000),
(642188, 107, 4, 2000),
(643234, 55, 1, 2000),
(661425, 55, 2, 2000),
(661425, 99, 6, 3),
(665877, 66, 2, 60000),
(667494, 55, 2, 2000),
(669410, 55, 1, 2000),
(683114, 55, 3, 2000),
(683114, 98, 2, 34),
(684389, 60, 1, 1),
(688446, 55, 1, 2000),
(695750, 55, 2, 2000),
(701345, 55, 2, 2000),
(716619, 106, 1, 2000),
(724590, 55, 5, 2000),
(724590, 99, 6, 3),
(731326, 55, 1, 2000),
(733677, 55, 2, 2000),
(741254, 55, 2, 2000),
(759981, 55, 2, 2000),
(763570, 55, 2, 2000),
(767406, 55, 3, 2000),
(774468, 100, 1, 2500),
(774468, 101, 1, 2),
(890483, 55, 2, 2000),
(890567, 66, 1, 2),
(890567, 89, 3, 0),
(912851, 55, 2, 2000),
(920258, 55, 2, 2000),
(921798, 55, 6, 2000),
(921798, 99, 10, 3),
(926254, 106, 1, 2000),
(930204, 55, 2, 2000),
(936846, 60, 1, 22990),
(937668, 55, 2, 2000),
(961510, 55, 2, 2000),
(975563, 55, 2, 2000),
(980783, 55, 2, 2000),
(989076, 55, 1, 2000),
(991597, 98, 5, 34),
(991597, 99, 6, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id_Tipo` int(5) NOT NULL,
  `nombre_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id_Tipo`, `nombre_tipo`) VALUES
(1, 'Poleras'),
(2, 'Chaquetas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `rut_usuario` varchar(15) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `nombre_usuario` varchar(30) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `apellido_usuario` varchar(30) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `email_usuario` varchar(255) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `direccion_usuario` varchar(100) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `contrasenia_usuario` varchar(100) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `telefono_usuario` varchar(9) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `deuda_usuario` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`rut_usuario`, `nombre_usuario`, `apellido_usuario`, `email_usuario`, `direccion_usuario`, `contrasenia_usuario`, `telefono_usuario`, `deuda_usuario`) VALUES
('1233123', 'hola', 'si', 'asd@gmail.com', 'xaxurro casa', '123', '123', 0),
('212315591', 'Joaquin', 'Puga', '', 'los gladiolos 032', '', '932605683', 3500),
('212790206', 'Lucas', 'Ossandón', 'lucasossandon1404@gmail.com', 'Del hierro 177, Limache', '$2y$10$rWQdrIS74yjQntiZswX1K.YcM4CVnW3qcdqhHdxGLFJt7ycwLYWwe', '945114144', 6500),
('37246026', 'Vicente', 'Lopez', '', '123 casa 2', '', '123 casa ', 3500),
('54252532', 'LOlo', 'manzanas', 'lolomanzanas@gmail.com', 'pasaje las rosas', '$2y$10$34I11iOZ7hdFdHx/REcS5ujhj9Tn2rimYzs9thHQl1gi8DBRrx/wW', '532843', 0),
('658472349', 'hoeasd', 'godfl', 'hoegod@gmail.com', 'asdgre', '$2y$10$rllLgelPhbH8JkesnP1DdOwD7OQB9CB7Ff357DTXrjzBHMaNZgMVq', '34543', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(8) NOT NULL,
  `rut_usuario` varchar(15) NOT NULL,
  `total_a_pagar_orden` int(10) NOT NULL,
  `estado_de_orden` varchar(15) NOT NULL,
  `fecha_pedido` date NOT NULL,
  `codigo_seguimiento` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `rut_usuario`, `total_a_pagar_orden`, `estado_de_orden`, `fecha_pedido`, `codigo_seguimiento`) VALUES
(330570, '212790206', 400000, 'Pagado', '0000-00-00', 'No tiene'),
(502805, '212790206', 82990, 'Pagado', '2022-12-08', ''),
(642188, '212790206', 8000, 'Pagado', '2022-12-11', ''),
(936846, '212790206', 22990, 'Pagado', '2022-12-08', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `producto_pedido`
--
ALTER TABLE `producto_pedido`
  ADD PRIMARY KEY (`id_venta`,`id_producto`);

--
-- Indices de la tabla `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`id_Tipo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`rut_usuario`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `tipo`
--
ALTER TABLE `tipo`
  MODIFY `id_Tipo` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
