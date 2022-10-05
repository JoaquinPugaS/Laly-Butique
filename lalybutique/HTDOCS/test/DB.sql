-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-10-2022 a las 05:26:05
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `productos`
--

-- --------------------------------------------------------

CREATE DATABASE LalyBoutique;
USE LalyBoutique;
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
-- Estructura de tabla para la tabla `categoria_producto`
--

CREATE TABLE `categoria_producto` (
  `id_producto` int(9) NOT NULL,
  `talla_producto` varchar(5) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `color_producto` varchar(10) COLLATE utf8mb4_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(8) NOT NULL,
  `rut_usuario` varchar(15) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `total_a_pagar_orden` int(10) NOT NULL,
  `estado_de_orden` varchar(15) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `fecha_pedido` date NOT NULL,
  `codigo_seguimiento` varchar(40) COLLATE utf8mb4_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(5) NOT NULL,
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

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `stock_producto`, `stock_critico_producto`, `precio_producto`, `imagen_producto`, `estado_producto`) VALUES
(54, 'lucas ossandon', 123, 1, 23, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1664839441/t30rtkx3wrorlpd0jk9o.png', 'No disponible'),
(55, 'Edu', 20, 5, 2000, 'http://res.cloudinary.com/dcmca9cgi/image/upload/v1664839600/epkjd3mgyoifgzy50yaa.png', 'Disponible'),
(58, 'PUGA', 123, 2, 12, ' ', 'Agotado'),
(60, 'vasto', 123, 2, 1, ' ', 'Disponible'),
(61, '123123', 123, 1, 123, ' ', 'Disponible'),
(62, '12', 123, 2, 1, ' ', 'Disponible'),
(63, '123', 12, 12, 123, ' ', 'Seleccione uno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_pedido`
--

CREATE TABLE `producto_pedido` (
  `id_pedido` int(8) NOT NULL,
  `id_producto` int(8) NOT NULL,
  `cantidad_producto` tinyint(3) NOT NULL,
  `precio_unitario` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

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
('1233123', 'hola', 'si', 'asd@gmail.com', 'xaxurro casa', 'vichito', '123', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--

--
-- Indices de la tabla `productos`
--
ALTER TABLE `admin`
  ADD CONSTRAINT PRIMARY KEY (`id_admin`);
ALTER TABLE `productos`
  ADD CONSTRAINT PRIMARY KEY (`id_producto`);
ALTER TABLE `producto_pedido`
  ADD CONSTRAINT PRIMARY KEY (`id_pedido`,`id_producto`);
ALTER TABLE `pedido`
  ADD CONSTRAINT PRIMARY KEY (`id_pedido`);
ALTER TABLE `usuarios`
  ADD CONSTRAINT PRIMARY KEY (`rut_usuario`);
ALTER TABLE `categoria_producto`
  ADD CONSTRAINT PRIMARY KEY (`id_producto`);

-- ALTER TABLE `producto_pedido`
--   ADD CONSTRAINT FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id_pedido`),
--   ADD CONSTRAINT FOREIGN KEY (`id_producto`) REFERENCES `productos`(`id_producto`);

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
