-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-12-2022 a las 23:50:45
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
  `imagen_producto` varchar(255) NOT NULL,
  `estado_producto` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_Tipo`, `nombre_producto`, `stock_producto`, `stock_critico_producto`, `precio_producto`, `imagen_producto`, `estado_producto`) VALUES
(55, 0, 'Edu', 20, 5, 2000, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668883290/jwnfjtompf4twl6tcxwl.png', 'Disponible'),
(58, 0, 'PUGA', 123, 2, 12, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1666041890/wyixyw4x5ewkqmrhp3gl.jpg', 'Agotado'),
(60, 0, 'vasto', 123, 2, 1, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1666132777/kscslkncmltv6b7mm1j3.jpg', 'Disponible'),
(66, 0, 'diego', 23, 23, 2, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1666045733/qnq1jh8o7sfgzf3mixhx.jpg', 'Disponible'),
(82, 534, 'TESTvariantes', 23, 2, 32, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668638596/t9rtysoyuz6tai0rtbhs.jpg', 'Disponible'),
(83, 263, 'Lucas234', 23, 23, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668639439/wrtqbof6tpl12lcwbhri.png', 'Disponible'),
(84, 446, 'adsadsa', 232, 23, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668639851/oedmxabjoqngqtlmtlx8.jpg', 'Disponible'),
(85, 586, '2334', 34, 3, 3, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668639948/wrgzlptpt0hmvi0rqsaz.jpg', 'Disponible'),
(86, 171, 'asdasdas', 23, 2, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668640059/fdyrn8iui3k7mchm2auh.png', 'Disponible'),
(87, 171, 'BF', 23, 2, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668640059/fdyrn8iui3k7mchm2auh.png', 'Disponible'),
(88, 109, 'tjsfw3j', 23, 2, 32, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668640532/njpeoszouawzhpboennt.jpg', 'Disponible'),
(90, 0, 'iopiop', 43, 3, 43, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668641005/xauunblrgxzi8k0bt9tt.jpg', 'Disponible'),
(91, 730, 'POLERA OSCAR', 32, 5, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668886115/kkmogpa5ybp8wtegmpqt.jpg', 'Disponible'),
(92, 730, 'POLERA OSCARa', 32, 5, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642177/topzpthmveycdjyfgrq1.jpg', 'Disponible'),
(93, 0, 'CTM', 324, 23, 2, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642231/q1lwb1czdtcnprij4iqu.png', 'Disponible'),
(94, 0, 'SDASD', 24, 2, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642322/qe9qkfzgcmsorted9p9j.jpg', 'Disponible'),
(95, 0, 'ADSADS', 23, 2, 2, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642363/pjh531rvowiynwgabiu6.jpg', 'Disponible'),
(96, 0, 'DASDS', 2423, 23, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642392/ubd8jtgejlcmgzp5pvzh.jpg', 'Disponible'),
(97, 0, 'DPOP,BNMG4', 45, 4, 45, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642522/e9fftyrm4vpwrstvoywu.jpg', 'Disponible'),
(98, 230, 'HOLAAAA', 34, 2, 34, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642695/dcpgzajocv4kknus0mzz.png', 'Disponible'),
(99, 0, 'ASDASDASDAS', 32, 2, 3, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642892/mykpjgdezoygw37dpuzt.png', 'Disponible'),
(100, 924, 'CMD', 200, 5, 2500, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668886330/mi6mfzvmojccm40olvk9.jpg', 'Disponible'),
(101, 0, 'CHAO', 23, 2, 2, ' ', 'No Disponible'),
(102, 0, 'baby otaku', 20, 2, 345, ' ', 'Disponible');

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
(75960, 99, 3, 3),
(110381, 55, 2, 2000),
(110381, 66, 3, 2),
(165223, 55, 2, 2000),
(165223, 98, 4, 34),
(171006, 55, 2, 2000),
(171006, 99, 3, 3),
(228970, 55, 3, 2000),
(228970, 99, 2, 3),
(267819, 55, 2, 2000),
(350646, 55, 6, 2000),
(356722, 55, 1, 2000),
(400392, 55, 1, 2000),
(403794, 55, 2, 2000),
(405924, 55, 1, 2000),
(405924, 60, 1, 1),
(412026, 55, 3, 2000),
(412026, 99, 2, 3),
(494393, 99, 5, 3),
(500743, 55, 1, 2000),
(513180, 55, 2, 2000),
(558017, 55, 3, 2000),
(558017, 99, 3, 3),
(575164, 66, 5, 2),
(661425, 55, 2, 2000),
(661425, 99, 6, 3),
(669410, 55, 1, 2000),
(683114, 55, 3, 2000),
(683114, 98, 2, 34),
(701345, 55, 2, 2000),
(724590, 55, 5, 2000),
(724590, 99, 6, 3),
(759981, 55, 2, 2000),
(767406, 55, 3, 2000),
(774468, 100, 1, 2500),
(774468, 101, 1, 2),
(890567, 66, 1, 2),
(890567, 89, 3, 0),
(920258, 55, 2, 2000),
(921798, 55, 6, 2000),
(921798, 99, 10, 3),
(961510, 55, 2, 2000),
(991597, 98, 5, 34),
(991597, 99, 6, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo`
--

CREATE TABLE `tipo` (
  `id_Tipo` int(5) NOT NULL,
  `descripcion_tipo` varchar(255) NOT NULL,
  `Cantidad` tinyint(3) NOT NULL,
  `precio` int(5) NOT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo`
--

INSERT INTO `tipo` (`id_Tipo`, `descripcion_tipo`, `Cantidad`, `precio`, `imagen`) VALUES
(230, 'xlll', 43, 43, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642708/tu2cfy9xyqtdxq3uqv1d.jpg'),
(730, 'CATOLICA', 23, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668642029/worqxciqc4ecsyeb0a1z.jpg'),
(924, 'powershell', 5, 258, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1668886365/jqsalcmzzq3nkgesifxj.png');

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
('104952968', '', '', '', '', '', '', 4000),
('106084173', '', '', '', '', '', '', 4000),
('1233123', 'hola', 'si', 'asd@gmail.com', 'xaxurro casa', '123', '123', 0),
('12345678', '', '', '', '', '', '', 3000),
('212790206', 'Lucas', 'Ossandón', 'lucasossandon1404@gmail.com', 'Del hierro 177, Limache', '$2y$10$rWQdrIS74yjQntiZswX1K.YcM4CVnW3qcdqhHdxGLFJt7ycwLYWwe', '945114144', 0),
('54252532', 'LOlo', 'manzanas', 'lolomanzanas@gmail.com', 'pasaje las rosas', '$2y$10$34I11iOZ7hdFdHx/REcS5ujhj9Tn2rimYzs9thHQl1gi8DBRrx/wW', '532843', 0),
('658472349', 'hoeasd', 'godfl', 'hoegod@gmail.com', 'asdgre', '$2y$10$rllLgelPhbH8JkesnP1DdOwD7OQB9CB7Ff357DTXrjzBHMaNZgMVq', '34543', 20),
('77777777', '', '', '', '', '', '', 1000);

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
(0, '212790206', 0, 'Pagado', '0000-00-00', ''),
(75960, '456731', 6009, 'Pagado', '0000-00-00', 'No tiene'),
(110381, '456', 4000, 'Pagado', '0000-00-00', 'No tiene'),
(165223, '212790206', 4000, 'Pagado', '0000-00-00', 'No tiene'),
(171006, '797897', 4000, 'Pagado', '0000-00-00', 'Y34534F'),
(215889, '212790206', 2, 'Pagado', '2022-11-23', ''),
(224570, '212790206', 23, 'Pagado', '2022-11-13', ''),
(228970, '456786', 6006, 'Pagado', '0000-00-00', 'No tiene'),
(231931, '212790206', 2000, 'Pagado', '2022-11-23', ''),
(267819, '', 4000, 'Pagado', '2022-11-29', ''),
(269569, '212790206', 2000, 'Pagado', '2022-11-13', ''),
(350646, '77777777', 12000, 'Pagado', '0000-00-00', 'No tiene'),
(356722, '212790206', 2000, 'Pagado', '2022-11-29', ''),
(400392, '212790206', 2000, 'Pagado', '2022-11-29', ''),
(403794, '454', 4000, 'Pagado', '0000-00-00', 'No tiene'),
(405924, '212790206', 2001, 'Pagado', '2022-11-27', ''),
(472965, '', 0, 'Pagado', '0000-00-00', ''),
(494393, '789', 15, 'Pagado', '0000-00-00', 'No tiene'),
(500743, '212790206', 2000, 'Pagado', '2022-11-29', ''),
(575164, '45687', 10, 'Pagado', '0000-00-00', 'No tiene'),
(616207, '212', 0, 'Pagado', '0000-00-00', 'No tiene'),
(661425, '456896', 4000, 'Pagado', '0000-00-00', 'No tiene'),
(669410, '212790206', 2000, 'Pagado', '2022-11-29', ''),
(682265, '23', 4000, 'Pagado', '0000-00-00', 'No tiene'),
(683114, '212790206', 6000, 'Pagado', '0000-00-00', 'No tiene'),
(699194, '212790206', 10201, 'Pagado', '2022-11-12', ''),
(700715, '5', 18, 'Pagado', '0000-00-00', 'No tiene'),
(701345, '77777777', 4000, 'Pendiente', '0000-00-00', 'No tiene'),
(724590, '666666', 10000, 'Pagado', '0000-00-00', 'No tiene'),
(759981, '212790206', 4000, 'Pagado', '0000-00-00', 'No tiene'),
(767406, '212790206', 6000, 'Pagado', '2022-11-29', ''),
(774468, '212790206', 2502, 'Pendiente', '0000-00-00', 'No tiene'),
(812686, '', 0, 'Pagado', '0000-00-00', 'No tiene'),
(886189, '', 0, 'Pagado', '0000-00-00', 'No tiene'),
(890567, '99999', 2, 'Pagado', '0000-00-00', 'No tiene'),
(921798, '464678', 12000, 'Pagado', '0000-00-00', 'No tiene'),
(991597, '4535', 170, 'Pagado', '0000-00-00', 'No tiene');

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
  MODIFY `id_producto` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
