-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 25-03-2019 a las 01:45:52
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `proyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE IF NOT EXISTS `agenda` (
  `idAgenda` int(11) NOT NULL AUTO_INCREMENT,
  `fechaReserva` date NOT NULL,
  `fechaEntrega` datetime NOT NULL,
  `fechaDevolución` datetime NOT NULL,
  PRIMARY KEY (`idAgenda`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `agenda`
--

INSERT INTO `agenda` (`idAgenda`, `fechaReserva`, `fechaEntrega`, `fechaDevolución`) VALUES
(1, '2018-09-08', '2018-09-12 03:20:15', '2018-10-22 00:00:00'),
(2, '2018-12-10', '2018-12-10 00:00:00', '2019-01-15 00:00:00'),
(3, '2019-01-15', '2019-01-18 05:30:00', '2019-02-18 04:10:00'),
(4, '2018-06-16', '2018-06-17 00:00:00', '2018-08-22 00:00:00'),
(5, '2018-02-20', '2018-02-20 00:00:00', '2018-02-23 00:00:00'),
(6, '2019-02-03', '2019-02-03 00:00:00', '2019-03-03 00:00:00'),
(7, '2019-01-01', '2019-01-01 00:00:00', '2019-02-01 00:00:00'),
(8, '2019-03-22', '2019-03-22 00:00:00', '0000-00-00 00:00:00'),
(9, '2019-03-05', '2019-03-06 00:00:00', '0000-00-00 00:00:00'),
(10, '2019-03-07', '2019-03-08 00:00:00', '2019-03-10 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE IF NOT EXISTS `cargo` (
  `idCargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`idCargo`, `descripcion`) VALUES
(1, 'Gerente General'),
(2, 'Gerente de Sucursal'),
(3, 'Asesor de Ventas'),
(4, 'Mecanico'),
(5, 'Conductor'),
(6, 'Guardia de seguridad'),
(7, 'Conserge'),
(8, 'Contador'),
(9, 'Publicista'),
(10, 'Cajero');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cilindraje`
--

CREATE TABLE IF NOT EXISTS `cilindraje` (
  `idCilindraje` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(10) NOT NULL,
  PRIMARY KEY (`idCilindraje`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `cilindraje`
--

INSERT INTO `cilindraje` (`idCilindraje`, `descripcion`) VALUES
(1, '4'),
(2, '6'),
(3, '8'),
(4, '10'),
(5, '12'),
(6, '14'),
(7, '16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `FK_CLIENTE_PERSONA` (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `idPersona`) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 15),
(9, 17),
(10, 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control`
--

CREATE TABLE IF NOT EXISTS `control` (
  `idControl` int(11) NOT NULL AUTO_INCREMENT,
  `idInventario` int(11) NOT NULL,
  `idSalida` int(11) DEFAULT NULL,
  `idEntrada` int(11) DEFAULT NULL,
  `idEmpleado` int(11) NOT NULL,
  PRIMARY KEY (`idControl`),
  KEY `FK_CONTROL_INVENTARIO` (`idInventario`),
  KEY `FK_CONTROL_SALIDA` (`idSalida`),
  KEY `FK_CONTROL_ENTRADA` (`idEntrada`),
  KEY `FK_CONTROL_EMPLEADO` (`idEmpleado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `control`
--

INSERT INTO `control` (`idControl`, `idInventario`, `idSalida`, `idEntrada`, `idEmpleado`) VALUES
(1, 2, 4, NULL, 1),
(2, 1, 3, NULL, 2),
(3, 3, NULL, 2, 3),
(4, 5, 5, NULL, 4),
(5, 4, NULL, 3, 5),
(6, 7, 3, NULL, 6),
(7, 6, 1, NULL, 7),
(8, 8, 2, NULL, 8),
(9, 9, 5, NULL, 9),
(10, 1, NULL, 2, 10),
(11, 4, NULL, 3, 1),
(12, 7, 5, NULL, 2),
(13, 8, 3, NULL, 3),
(14, 9, 2, NULL, 4),
(15, 1, NULL, 2, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `descuento`
--

CREATE TABLE IF NOT EXISTS `descuento` (
  `idDescuento` int(11) NOT NULL AUTO_INCREMENT,
  `porcentaje` decimal(10,0) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `estado` varchar(1) NOT NULL,
  PRIMARY KEY (`idDescuento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `descuento`
--

INSERT INTO `descuento` (`idDescuento`, `porcentaje`, `descripcion`, `estado`) VALUES
(1, '15', 'General', 'I'),
(2, '30', 'Tercera edad', 'A'),
(3, '50', 'Black friday', 'I'),
(4, '20', 'Navideño', 'I'),
(5, '20', 'Año nuevo', 'I'),
(6, '20', 'Verano', 'I'),
(7, '10', 'Familiares y amigos', 'A'),
(8, '0', 'Ninguno', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `fechaInicio` date NOT NULL,
  `fechaFin` date DEFAULT NULL,
  `idPersona` int(11) NOT NULL,
  `idCargo` int(11) NOT NULL,
  `contraseña` varchar(45) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `FK_EMPLEADO_PERSONA` (`idPersona`),
  KEY `FK_EMPLEADO_CARGO` (`idCargo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `fechaInicio`, `fechaFin`, `idPersona`, `idCargo`, `contraseña`) VALUES
(1, '2018-10-01', NULL, 2, 3, '123456'),
(2, '2019-02-15', NULL, 4, 3, '123456'),
(3, '2016-12-25', NULL, 6, 4, '123456'),
(4, '2017-10-05', NULL, 10, 6, '13456'),
(5, '2016-05-15', NULL, 12, 5, '123456'),
(6, '2019-01-20', NULL, 14, 2, '123456'),
(7, '2017-05-30', NULL, 16, 1, '123456'),
(8, '2018-06-10', NULL, 18, 6, '123456'),
(9, '2015-09-19', NULL, 20, 6, '123456'),
(10, '2015-10-05', '2018-05-30', 8, 2, '123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE IF NOT EXISTS `entrada` (
  `idEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `fechaEntrada` varchar(45) NOT NULL,
  PRIMARY KEY (`idEntrada`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `entrada`
--

INSERT INTO `entrada` (`idEntrada`, `descripcion`, `fechaEntrada`) VALUES
(1, 'Devolución de Venta', '2015-12-12'),
(2, 'Entrada de Sucursal', '2018-12-05'),
(3, 'compra', '2018-12-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE IF NOT EXISTS `factura` (
  `idFactura` int(11) NOT NULL AUTO_INCREMENT,
  `fechaEmision` date NOT NULL,
  `Total` decimal(10,0) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idEmpleado` int(11) DEFAULT NULL,
  `idFormaPago` int(11) NOT NULL,
  `idImpuesto` int(11) NOT NULL,
  `idFacturaMantenimiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `FK_FACTURA_CLIENTE` (`idCliente`),
  KEY `FK_FACTURA_EMPLEADO` (`idEmpleado`),
  KEY `FK_FACTURA_FORMAPAGO` (`idFormaPago`),
  KEY `FK_FACTURA_IMPUESTO` (`idImpuesto`),
  KEY `FK_FACTURA_FACTURAMANTENIMIENTO` (`idFacturaMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`idFactura`, `fechaEmision`, `Total`, `idCliente`, `idEmpleado`, `idFormaPago`, `idImpuesto`, `idFacturaMantenimiento`) VALUES
(1, '2017-06-01', '1500', 1, 1, 1, 1, 9),
(2, '2017-06-01', '1500', 2, 10, 5, 1, NULL),
(3, '2017-06-01', '1500', 3, 9, 4, 1, NULL),
(4, '2017-06-01', '1500', 4, 8, 3, 1, NULL),
(5, '2017-06-01', '1500', 5, 7, 3, 1, NULL),
(6, '2017-06-01', '1500', 6, 6, 2, 1, NULL),
(7, '2017-06-01', '1500', 7, 5, 1, 1, 3),
(8, '2017-06-01', '1500', 8, 4, 5, 1, NULL),
(9, '2017-06-01', '1500', 8, 3, 4, 1, 14),
(10, '2017-06-01', '1500', 9, 3, 3, 1, 6),
(11, '2017-06-01', '1500', 10, 2, 2, 1, 13),
(12, '2017-06-01', '1500', 1, 1, 3, 1, 17),
(13, '2017-06-01', '1500', 2, 10, 5, 1, NULL),
(14, '2017-06-01', '1500', 3, 8, 3, 1, NULL),
(15, '2017-06-01', '1500', 4, 7, 5, 1, NULL),
(16, '0000-00-00', '1500', 2, 9, 5, 1, NULL),
(17, '0000-00-00', '2500', 4, 8, 4, 1, 5),
(18, '0000-00-00', '3500', 5, 5, 3, 1, 10),
(19, '0000-00-00', '4500', 6, 4, 2, 1, NULL),
(20, '0000-00-00', '5500', 7, 2, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturapormantenimiento`
--

CREATE TABLE IF NOT EXISTS `facturapormantenimiento` (
  `idFacturaMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFacturaMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `facturapormantenimiento`
--

INSERT INTO `facturapormantenimiento` (`idFacturaMantenimiento`, `descripcion`) VALUES
(1, 'Reparacion taller 1'),
(2, 'Reparacion taller 1'),
(3, 'Reparacion taller 1'),
(4, 'Reparacion taller 1'),
(5, 'Reparacion taller 1'),
(6, 'Reparacion taller 2'),
(7, 'Reparacion taller 2'),
(8, 'Reparacion taller 2'),
(9, 'Reparacion taller 1'),
(10, 'Reparacion taller 1'),
(11, 'Reparacion taller 2'),
(12, 'Reparacion taller 2'),
(13, 'Reparacion taller 2'),
(14, 'Reparacion taller 2'),
(15, 'Reparacion taller 2'),
(16, 'Reparacion taller 2'),
(17, 'Reparacion taller 2'),
(18, 'Reparacion taller 1'),
(19, 'Reparacion taller 1'),
(20, 'Reparacion taller 3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_descuento`
--

CREATE TABLE IF NOT EXISTS `factura_descuento` (
  `idFactura` int(11) NOT NULL,
  `idDescuento` int(11) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`idFactura`,`idDescuento`),
  KEY `FK_FACTURADESCUENTO_DESCUENTO` (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `factura_descuento`
--

INSERT INTO `factura_descuento` (`idFactura`, `idDescuento`, `fecha`) VALUES
(1, 2, '0000-00-00'),
(2, 2, '0000-00-00'),
(3, 2, '0000-00-00'),
(4, 2, '0000-00-00'),
(5, 7, '0000-00-00'),
(6, 2, '0000-00-00'),
(7, 2, '0000-00-00'),
(8, 2, '0000-00-00'),
(9, 2, '0000-00-00'),
(10, 2, '0000-00-00'),
(11, 7, '0000-00-00'),
(12, 2, '0000-00-00'),
(13, 2, '0000-00-00'),
(14, 2, '0000-00-00'),
(15, 2, '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formapago`
--

CREATE TABLE IF NOT EXISTS `formapago` (
  `idFormaPago` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFormaPago`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `formapago`
--

INSERT INTO `formapago` (`idFormaPago`, `descripcion`) VALUES
(1, 'Crédito'),
(2, 'Débito'),
(3, 'Cheque'),
(4, 'Financiamiento'),
(5, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE IF NOT EXISTS `fotos` (
  `idFotos` int(11) NOT NULL AUTO_INCREMENT,
  `direccionEnDisco` varchar(45) NOT NULL,
  `Vehiculo_idVehiculo` int(11) NOT NULL,
  PRIMARY KEY (`idFotos`),
  KEY `FK_FOTOS_VEHICULO` (`Vehiculo_idVehiculo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `fotos`
--

INSERT INTO `fotos` (`idFotos`, `direccionEnDisco`, `Vehiculo_idVehiculo`) VALUES
(1, 'C:wampwwwProyectoimg autosv1.1', 1),
(2, 'C:wampwwwProyectoimg autosv2.1', 2),
(3, 'C:wampwwwProyectoimg autosv3.1', 3),
(4, 'C:wampwwwProyectoimg autosv4.1', 4),
(5, 'C:wampwwwProyectoimg autosv5.1', 5),
(6, 'C:wampwwwProyectoimg autosv6.1', 6),
(7, 'C:wampwwwProyectoimg autosv7.1', 7),
(8, 'C:wampwwwProyectoimg autosv8.1', 8),
(9, 'C:wampwwwProyectoimg autosv9.1', 9),
(10, 'C:wampwwwProyectoimg autosv10.1', 10),
(11, 'C:wampwwwProyectoimg autosv11.1', 11),
(12, 'C:wampwwwProyectoimg autosv12.1', 12),
(13, 'C:wampwwwProyectoimg autosv13.1', 13),
(14, 'C:wampwwwProyectoimg autosv14.1', 14),
(15, 'C:wampwwwProyectoimg autosv15.1', 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuesto`
--

CREATE TABLE IF NOT EXISTS `impuesto` (
  `idImpuesto` int(11) NOT NULL AUTO_INCREMENT,
  `porcentaje` decimal(10,0) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idImpuesto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `impuesto`
--

INSERT INTO `impuesto` (`idImpuesto`, `porcentaje`, `descripcion`) VALUES
(1, '15', 'ISR ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE IF NOT EXISTS `inventario` (
  `idInventario` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idInventario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idInventario`, `descripcion`) VALUES
(1, 'Motocicletas'),
(2, 'Automovil'),
(3, 'Camión'),
(4, 'Grua'),
(5, 'Yate'),
(6, 'Repuestos'),
(7, 'Bus'),
(8, 'Excavadora'),
(9, 'Tractor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimiento`
--

CREATE TABLE IF NOT EXISTS `mantenimiento` (
  `idMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpleado` int(11) NOT NULL,
  `idTaller` int(11) NOT NULL,
  `descripcionReparaciones` varchar(45) NOT NULL,
  `costo` decimal(10,0) NOT NULL,
  `idFacturaMantenimiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMantenimiento`),
  KEY `FK_MANTENIMIENTO_EMPLEADO` (`idEmpleado`),
  KEY `FK_MANTENIMIENTO_TALLER` (`idTaller`),
  KEY `FK_MANTENIMIENTO_FACTURAMANTENIMIENTO` (`idFacturaMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `mantenimiento`
--

INSERT INTO `mantenimiento` (`idMantenimiento`, `idEmpleado`, `idTaller`, `descripcionReparaciones`, `costo`, `idFacturaMantenimiento`) VALUES
(1, 1, 2, 'Cambio de aceite', '1500', 1),
(2, 3, 4, 'Llantas', '1500', NULL),
(3, 3, 4, 'Cambio de bujías', '1500', NULL),
(4, 10, 14, 'Alineamiento', '1500', NULL),
(5, 2, 8, 'Cambio de fricciones', '1500', 3),
(6, 8, 11, 'Cambio de bujes', '1500', NULL),
(7, 1, 7, 'Cambio de tijeras', '1500', 15),
(8, 8, 9, 'Cambio de filtro de aire', '1500', NULL),
(9, 4, 5, 'Cambio de barras estabilizadoras', '1500', NULL),
(10, 8, 2, 'Cambio de rótulas', '1500', NULL),
(11, 10, 10, 'Cambio de suspensión', '1500', 2),
(12, 10, 15, 'Cambio de batería', '1500', NULL),
(13, 2, 13, 'Cambio de coolant', '1500', 5),
(14, 1, 4, 'Cambio de soporte', '1500', 10),
(15, 4, 7, 'Polarizado', '1500', NULL),
(16, 8, 4, 'Liquido de Frenos', '1500', 11),
(17, 5, 15, 'Liquido Hidraulico', '1500', 19),
(18, 6, 7, 'Cadena de tiempo', '1500', 10),
(19, 9, 11, 'Soporte de Amortiuacion', '1500', 11),
(20, 3, 9, 'Direccion completa', '1500', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE IF NOT EXISTS `marca` (
  `idMarca` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`idMarca`, `descripcion`) VALUES
(1, 'Isuzu'),
(2, 'Mazda'),
(3, 'Porsche'),
(4, 'BMW'),
(5, 'Honda'),
(6, 'Nissan'),
(7, 'Ferrari'),
(8, 'Jaguar'),
(9, 'Hummer'),
(10, 'Lamborghini'),
(11, 'Mercedes-Benz'),
(12, 'Toyota'),
(13, 'Cadillac'),
(14, 'Hyundai'),
(15, 'Jeep'),
(16, 'Maserati'),
(17, 'Volkswagen'),
(18, 'Ford'),
(19, 'KIA'),
(20, 'Mitsubishi'),
(21, 'CATERPILLAR'),
(22, 'HITACHI'),
(23, 'JOHN DEERE'),
(24, 'KOMATSU'),
(25, 'VOLVO'),
(26, 'DINA'),
(27, 'YAMAHA'),
(28, 'Ducati'),
(30, 'FERRETI YATCHS'),
(31, 'Bavaria Yatchs'),
(32, 'Azimut'),
(33, 'Suzuki');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcarepuesto`
--

CREATE TABLE IF NOT EXISTS `marcarepuesto` (
  `idMarcaRepuesto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMarcaRepuesto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `marcarepuesto`
--

INSERT INTO `marcarepuesto` (`idMarcaRepuesto`, `descripcion`) VALUES
(1, 'YKS'),
(2, '777 Five'),
(3, 'OEM'),
(4, 'Falcon'),
(5, 'Dunlop'),
(6, 'Castrol'),
(7, 'Chevron'),
(8, 'NGK'),
(9, 'YKS taiwanesa'),
(10, 'OM Brand'),
(11, 'Mobil'),
(12, 'original yukita'),
(13, 'Tokito'),
(14, 'Monroe'),
(15, 'KYB');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo`
--

CREATE TABLE IF NOT EXISTS `modelo` (
  `idModelo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `idMarca` int(11) NOT NULL,
  PRIMARY KEY (`idModelo`),
  KEY `FK_MODELO_MARCA` (`idMarca`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `modelo`
--

INSERT INTO `modelo` (`idModelo`, `descripcion`, `idMarca`) VALUES
(1, 'Mazda Cx-3', 2),
(2, 'Mazda Rx-8', 2),
(3, 'Porsche cayenne-platinum-edition', 3),
(4, 'BMW X5', 4),
(5, 'Honda Civic', 5),
(6, 'Nissan Navara', 6),
(7, 'Ferrari 458 Italia', 7),
(8, 'Jaguar E-Pace', 8),
(9, 'Hummer H3', 9),
(10, 'Lamborghini Gallardo', 10),
(11, 'Mercedez Benz Clase-G', 11),
(12, 'Toyota Hilux', 12),
(13, 'Hyundai H-1', 14),
(14, 'Volkswagen New Beetle', 17),
(15, 'Jeep Compass', 15),
(16, 'C 400 GT', 4),
(17, 'C 650 sport', 4),
(18, 'Panigale V4', 28),
(19, 'CB 100R', 5),
(20, 'X-MAX 400', 27),
(21, 'Buller', 26),
(22, '9800 2017', 25),
(23, 'Turiclass', 11),
(24, 'ELF 600 Bus', 1),
(25, 'Wildleder - Shovel 966K', 21),
(26, 'CS 56', 21),
(27, 'Graafmachine ZX135US-3', 22),
(28, '6920', 23),
(29, 'PC110R ', 24),
(30, '430', 30),
(31, '27', 31),
(32, '43 fly', 32);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `noIdentidad` varchar(45) NOT NULL,
  `pnombre` varchar(45) NOT NULL,
  `snombre` varchar(45) DEFAULT NULL,
  `papellido` varchar(45) NOT NULL,
  `sapellido` varchar(45) DEFAULT NULL,
  `correo` varchar(45) NOT NULL,
  `direccion` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `noIdentidad`, `pnombre`, `snombre`, `papellido`, `sapellido`, `correo`, `direccion`) VALUES
(1, '0801-1980-9802', 'Zephania', 'George', 'Robles', 'Hernandez', 'gHer@gmail.com', 'col.la esperanza'),
(2, '0801-1990-6406', 'Hakeem', 'Flynn', 'Compton', 'Ortega', 'H.flynn@gmail.com', 'col. Centro America'),
(3, '0801-1996-1194', 'Tucker', 'Simon', 'Walker', 'Craig', 'T-simon@gmail.com', 'col.El Hato '),
(4, '0801-1965-7887', 'Ali', 'Jarrod', 'Murphy', 'Hansen', 'Ali.j@gmail.com', 'col.Kennedy'),
(5, '0801-1962-4092', 'Buckminster', 'Valentine', 'Oneal', 'Strickland', 'on_val@gmail.com', 'col.21 de Febrero'),
(6, '0801-1985-5370', 'Zeus', 'Elmo', 'Dickson', 'Meyer', 'ElDick@gmail.com', 'col.Centro America'),
(7, '0801-1987-5237', 'Omar', 'Rolando', 'Lee', 'Pollard', 'om_ro@gmail.com', 'col.la esperanza'),
(8, '0801-1987-6751', 'Addison', 'Xenos', 'Harrington', 'Bradford', 'harri.1@gmail.com', 'col.la esperanza'),
(9, '0801-1969-5125', 'Ignacio', 'Lucius', 'Henderson', 'McAdams', 'ig.adams@gmail.com', 'col.Kennedy'),
(10, '0801-1992-9752', 'Leonard', 'Bruce', 'Potter', 'McAboy', 'potter@gmail.com', 'col.Las Americas'),
(11, '0801-1991-2251', 'Jack', 'Vincent', 'Clarke', 'Guerrero', 'vin.15@gmail.com', 'col.La union'),
(12, '0801-1965-4747', 'Joseph', 'Armando', 'Campos', 'Lomas', 'c.lomas55@gmail.com', 'col.Prados Universitarios'),
(13, '0801-1978-4068', 'Roger', 'Rabbbit', 'Dodson', 'Hammond', 'zanahorias@gmail.com', 'col.la Alianza'),
(14, '0801-1986-7478', 'Peter', 'Oliver', 'Quill', 'Velez', 'starLord@gmail.com', 'col.Xandar'),
(15, '0801-1962-2584', 'Dante', 'Eugenio', 'Harrington', 'Hernandez', 'eug@gmail.com', 'col. Miramontes'),
(16, '0801-1989-2762', 'Sara', 'Eugenia', 'Douglas', 'Vasquez', 'vasquez8890gmail.com', 'col. Divina Providencia'),
(17, '0801-1987-6399', 'Rosa', 'Perla', 'Bursh', 'Hanks', 'perl.ros@gmail.com', 'col. La Union'),
(18, '0801-1990-1154', 'Alice', 'Michelle', 'Livingston', 'Klaus', 'k_liv@gmail.com', 'col.Los Pinos'),
(19, '0801-1965-7014', 'Brenda', 'Nevada', 'Guerrero', 'Clayton', 'bren.890@gmail.com', 'col.la Americas'),
(20, '0801-1969-7426', 'Laura', 'Latifah', 'Meyer', 'Pearson', 'LauLa@gmail.com', 'col. La sosa'),
(21, '0801-188-24567', 'Alex', 'Roberto', 'Perales', 'ayala', 'ay@gmail.com', 'col. Las Brisas'),
(22, '0801-1987-34564', 'Tadeo', 'Rodrigo', 'Rodriguez', 'Martinez', 'mx.88@gmail.com', 'col. Kennedy'),
(23, '0801-1990-15655', 'Miranda', 'Sofia', 'Canales', 'Cosgrove', 'mi.00@gmail.com', 'col. Estados Unidos'),
(24, '0802-1980-44344', 'Josellyn', 'scarleth', 'Campos', 'Canales', 'sca_1@gmail.com', 'col.Las Americas'),
(25, '0801-1992-67890', 'estrella', 'Corales', 'Mar', 'Lagunas', 'lag.44@gmail.com', 'col.los oceanos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `idProveedores` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(25) NOT NULL,
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idProveedores`),
  KEY `FK_PROVEEDORES_PERSONA` (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedores`, `Nombre`, `idPersona`) VALUES
(1, 'Auto Suspension', 21),
(2, 'RSA Autoparts', 22),
(3, 'Auto Repuestos', 23),
(4, 'American Autoparts', 24),
(5, 'Autoparts Honduras', 25),
(6, 'La casa del tornillo', 5),
(7, 'Repuestos para alternador', 15),
(8, 'Suplidora Honda', 19),
(9, 'Todo Repuestos', 3),
(10, 'Auto Mundo', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `renta`
--

CREATE TABLE IF NOT EXISTS `renta` (
  `idRenta` int(11) NOT NULL AUTO_INCREMENT,
  `idFactura` int(11) NOT NULL,
  `idVehiculo` int(11) NOT NULL,
  `idAgenda` int(11) NOT NULL,
  `mora` decimal(10,0) DEFAULT NULL,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idRenta`),
  KEY `FK_RENTA_FACTURA` (`idFactura`),
  KEY `FK_RENTA_VEHICULO` (`idVehiculo`),
  KEY `FK_RENTA_AGENDA` (`idAgenda`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `renta`
--

INSERT INTO `renta` (`idRenta`, `idFactura`, `idVehiculo`, `idAgenda`, `mora`, `estado`) VALUES
(1, 13, 3, 1, '0', 'D'),
(2, 14, 5, 2, '500', 'D'),
(3, 15, 7, 3, '200', 'D'),
(4, 16, 9, 4, '0', 'D'),
(5, 19, 11, 5, '0', 'D'),
(6, 20, 13, 6, '100', 'D'),
(7, 14, 15, 7, '0', 'D'),
(8, 13, 19, 8, '0', 'ND'),
(9, 16, 21, 9, '0', 'ND'),
(10, 20, 23, 10, '100', 'D'),
(11, 13, 25, 1, '0', 'D'),
(12, 19, 27, 2, '0', 'D');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE IF NOT EXISTS `repuestos` (
  `idRepuestos` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `precio` decimal(10,0) NOT NULL,
  `idInventario` int(11) NOT NULL,
  `idMarcaRepuesto` int(11) NOT NULL,
  `idMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idRepuestos`),
  KEY `FK_REPUESTOS_INVENTARIO` (`idInventario`),
  KEY `FK_REPUESTOS_MARCARESPUESTO` (`idMarcaRepuesto`),
  KEY `FK_REPUESTOS_MANTENIMIENTO` (`idMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`idRepuestos`, `descripcion`, `precio`, `idInventario`, `idMarcaRepuesto`, `idMantenimiento`) VALUES
(1, 'Filtro de aceite', '150', 6, 1, 1),
(2, 'Filtro de aire', '100', 6, 2, 8),
(3, 'Bujías', '100', 6, 3, 3),
(4, 'Bujes', '80', 6, 4, 6),
(5, 'Llantas', '700', 6, 5, 2),
(6, 'Aceite de motor', '150', 6, 6, 1),
(7, 'Aceite de caja', '150', 6, 7, 1),
(8, 'Liquido de frenos', '100', 6, 8, 16),
(9, 'Liquido hidráulico', '150', 6, 9, 17),
(10, 'Fricciones', '1500', 6, 10, 18),
(11, 'Tijeras', '150', 6, 11, 7),
(12, 'Soportes de motor', '150', 6, 12, 14),
(13, 'Cadena de tiempo', '150', 6, 13, 13),
(14, 'Soporte de amortiguación', '150', 6, 14, 19),
(15, 'Dirección completa', '1500', 6, 15, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos`
--

CREATE TABLE IF NOT EXISTS `requisitos` (
  `idRequisitos` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idRequisitos`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `requisitos`
--

INSERT INTO `requisitos` (`idRequisitos`, `descripcion`) VALUES
(1, 'Tarjeta Id'),
(2, 'Permiso de Conducir'),
(3, 'Mayoria de Edad'),
(4, 'Historial de Multas'),
(5, 'Deposito'),
(6, 'Completos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

CREATE TABLE IF NOT EXISTS `salida` (
  `idSalida` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `FechaSalida` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSalida`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `salida`
--

INSERT INTO `salida` (`idSalida`, `descripcion`, `FechaSalida`) VALUES
(1, 'Factura', '2019-02-01'),
(2, 'Devolucion de compra', '2018-05-12'),
(3, 'Salida  a Sucursal', '2019-12-20'),
(4, 'Salida a Taller', '2018-07-30'),
(5, 'Entrega', '2018-11-27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudmantenimiento`
--

CREATE TABLE IF NOT EXISTS `solicitudmantenimiento` (
  `idSolicitudMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idVehiculo` int(11) NOT NULL,
  `idMantenimiento` int(11) NOT NULL,
  `fechaSolicitud` date NOT NULL,
  `estado` varchar(20) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  `idTipoMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idSolicitudMantenimiento`),
  KEY `FK_SOLICITUDMANTENIMIENTO_VEHICULO` (`idVehiculo`),
  KEY `FK_SOLICITUDMANTENIMIENTO_MANTENIMIENTO` (`idMantenimiento`),
  KEY `FK_SOLICITUDMANTENIMIENTO_EMPLEADO` (`idEmpleado`),
  KEY `FK_SOLICITUDMANTENIMIENTO_TIPOMANTENIMIENTO` (`idTipoMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `solicitudmantenimiento`
--

INSERT INTO `solicitudmantenimiento` (`idSolicitudMantenimiento`, `idVehiculo`, `idMantenimiento`, `fechaSolicitud`, `estado`, `idEmpleado`, `idTipoMantenimiento`) VALUES
(1, 1, 1, '0000-00-00', 'Valida', 1, 1),
(2, 2, 2, '0000-00-00', 'Valida', 2, 2),
(3, 3, 3, '0000-00-00', 'Valida', 3, 3),
(4, 4, 4, '0000-00-00', 'Valida', 4, 4),
(5, 6, 5, '0000-00-00', 'Valida', 5, 5),
(6, 5, 6, '0000-00-00', 'Valida', 6, 6),
(7, 7, 7, '0000-00-00', 'Valida', 7, 7),
(8, 8, 8, '0000-00-00', 'Valida', 8, 8),
(9, 9, 9, '0000-00-00', 'Valida', 9, 9),
(10, 10, 10, '0000-00-00', 'Valida', 10, 10),
(11, 11, 11, '0000-00-00', 'Valida', 1, 11),
(12, 13, 12, '0000-00-00', 'Valida', 2, 12),
(13, 14, 13, '0000-00-00', 'Invalida', 3, 13),
(14, 16, 14, '0000-00-00', 'Espera', 4, 14),
(15, 18, 15, '0000-00-00', 'Enviada', 5, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudrenta`
--

CREATE TABLE IF NOT EXISTS `solicitudrenta` (
  `idSolicitudRenta` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idVehiculo` int(11) NOT NULL,
  `idAgenda` int(11) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  PRIMARY KEY (`idSolicitudRenta`),
  KEY `FK_SOLICITUDRENTA_CLIENTE` (`idCliente`),
  KEY `FK_SOLICITUDRENTA_VEHICULO` (`idVehiculo`),
  KEY `FK_SOLICITUDRENTA_AGENDA` (`idAgenda`),
  KEY `FK_SOLICITUDRENTA_EMPLEADO` (`idEmpleado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `solicitudrenta`
--

INSERT INTO `solicitudrenta` (`idSolicitudRenta`, `descripcion`, `estado`, `idCliente`, `idVehiculo`, `idAgenda`, `idEmpleado`) VALUES
(1, 'renta', 'Validada', 1, 1, 1, 1),
(2, 'renta', 'invalidad', 2, 3, 2, 2),
(3, 'renta', 'Validada', 3, 5, 3, 3),
(4, 'renta', 'invalidada', 4, 6, 4, 4),
(5, 'renta', 'Validada', 5, 7, 5, 5),
(6, 'renta', 'Validada', 6, 8, 6, 6),
(7, 'renta', 'Validada', 7, 10, 7, 7),
(8, 'renta', 'Validada', 8, 11, 8, 8),
(9, 'renta', 'Validada', 9, 13, 9, 9),
(10, 'renta', 'Validada', 10, 14, 10, 10),
(11, 'renta', 'Validada', 1, 16, 1, 1),
(12, 'renta', 'Validada', 2, 18, 2, 2),
(13, 'renta', 'Espera', 3, 20, 3, 3),
(14, 'renta', 'Enviada', 4, 3, 4, 4),
(15, 'renta', 'Enviada', 5, 4, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudrequisitos`
--

CREATE TABLE IF NOT EXISTS `solicitudrequisitos` (
  `idSolicitudRenta` int(11) NOT NULL,
  `idRequisitos` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idSolicitudRenta`,`idRequisitos`),
  KEY `FK_SOLICITUDREQUISITOS_REQUISITOS` (`idRequisitos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `solicitudrequisitos`
--

INSERT INTO `solicitudrequisitos` (`idSolicitudRenta`, `idRequisitos`, `estado`) VALUES
(1, 6, 'V'),
(2, 6, 'V'),
(3, 4, 'I'),
(4, 6, 'V'),
(5, 6, 'V'),
(6, 6, 'V'),
(7, 6, 'V'),
(8, 6, 'V'),
(9, 6, 'V'),
(10, 6, 'V'),
(11, 6, 'V'),
(12, 6, 'E'),
(13, 6, 'V'),
(14, 6, 'V'),
(15, 2, 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE IF NOT EXISTS `sucursal` (
  `idSucursal` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  PRIMARY KEY (`idSucursal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`idSucursal`, `nombre`, `direccion`) VALUES
(1, 'Tegucigalpa 1', 'Carrizal'),
(2, 'Tegucigalpa 2', 'La Granja'),
(3, 'Comayagua 1', 'Los Hidalgos'),
(4, 'Comayagua 2', '21 de Febrero'),
(5, 'San Pedro Sula 1', 'Brisas del Canadá'),
(6, 'San Pedro Sula 2', 'El Carmen'),
(7, 'Tela 1', 'Villa Franca'),
(8, 'Tela 2', 'Divagna'),
(9, 'Ceiba 1', 'Villa Union'),
(10, 'Ceiba 2', 'La Uniòn'),
(11, 'Trujillo 1', 'Villa Franca'),
(12, 'Trujillo 2', 'La Merced'),
(13, 'Cholute 1', 'Barrio Abajo'),
(14, 'Choluteca 2', 'La Sabana'),
(15, 'Danlí', 'La Americana');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taller`
--

CREATE TABLE IF NOT EXISTS `taller` (
  `idTaller` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `idSucursal` int(11) NOT NULL,
  PRIMARY KEY (`idTaller`),
  KEY `FK_TALLER_SUCURSAL` (`idSucursal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `taller`
--

INSERT INTO `taller` (`idTaller`, `descripcion`, `idSucursal`) VALUES
(1, 'Taller 1', 1),
(2, 'Taller 2', 2),
(3, 'Taller 3', 3),
(4, 'Taller 4', 4),
(5, 'Taller 5', 5),
(6, 'Taller 6', 6),
(7, 'Taller 7', 7),
(8, 'Taller 8', 8),
(9, 'Taller 9', 9),
(10, 'Taller 10', 10),
(11, 'Taller 11', 11),
(12, 'Taller 12', 12),
(13, 'Taller 13', 13),
(14, 'Taller 14', 14),
(15, 'Taller 15', 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefonos`
--

CREATE TABLE IF NOT EXISTS `telefonos` (
  `idTelefonos` int(11) NOT NULL AUTO_INCREMENT,
  `telefono` varchar(45) NOT NULL,
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idTelefonos`),
  KEY `FK_TELEFONOS_PERSONA` (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

--
-- Volcado de datos para la tabla `telefonos`
--

INSERT INTO `telefonos` (`idTelefonos`, `telefono`, `idPersona`) VALUES
(1, '+504-9175-6813', 1),
(2, '+504-3479-3934', 2),
(3, '+504-9974-4267', 3),
(4, '+504-9028-3159', 4),
(5, '+504-9048-5832', 5),
(6, '+504-3420-1067', 6),
(7, '+504-9499-8923', 7),
(8, '+504-9960-6230', 8),
(9, '+504-9028-3980', 9),
(10, '+504-3465-6776', 10),
(11, '+504-3494-1250', 11),
(12, '+504-3375-6121', 12),
(13, '+504-3065-6461', 13),
(14, '+504-9604-7135', 14),
(15, '+504-9614-7211', 15),
(16, '+504-3898-3310', 16),
(17, '+504-9830-1714', 17),
(18, '+504-3394-3443', 18),
(19, '+504-3352-8853', 19),
(20, '+504-3073-5522', 20),
(21, '+504-3535-5196', 1),
(22, '+504-3551-6763', 2),
(23, '+504-3137-8372', 3),
(24, '+504-9199-3532', 4),
(25, '+504-3156-2507', 5),
(26, '+504-9324-1000', 6),
(27, '+504-9998-1647', 7),
(28, '+504-3468-2892', 8),
(29, '+504-9163-2910', 9),
(30, '+504-9128-3418', 10),
(31, '+504-9458-9499', 11),
(32, '+504-9038-4956', 12),
(33, '+504-3076-9390', 13),
(34, '+504-3061-2589', 14),
(35, '+504-3178-8316', 15),
(36, '+504-3147-4384', 16),
(37, '+504-3329-9302', 17),
(38, '+504-3673-8423', 18),
(39, '+504-3341-2382', 19),
(40, '+504-9946-8064', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoentrada`
--

CREATE TABLE IF NOT EXISTS `tipoentrada` (
  `idTipoEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `idEntrada` int(11) NOT NULL,
  `idProveedores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTipoEntrada`),
  KEY `FK_TIPOENTRADA_ENTRADA` (`idEntrada`),
  KEY `FK_TIPOENTRADA_PROVEEDORES` (`idProveedores`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `tipoentrada`
--

INSERT INTO `tipoentrada` (`idTipoEntrada`, `descripcion`, `idEntrada`, `idProveedores`) VALUES
(3, 'Devolución de Venta', 1, 2),
(4, 'Entrada de Sucursal', 2, 9),
(5, 'Compra', 3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomantenimiento`
--

CREATE TABLE IF NOT EXISTS `tipomantenimiento` (
  `idTipoMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Volcado de datos para la tabla `tipomantenimiento`
--

INSERT INTO `tipomantenimiento` (`idTipoMantenimiento`, `descripcion`) VALUES
(1, 'Cambio de aceite'),
(2, 'Cambio de bujías'),
(3, 'Cambio de llantas'),
(4, 'Alineamiento'),
(5, 'Cambio de fricciones'),
(6, 'Cambio de bujes'),
(7, 'Cambio de tijeras'),
(8, 'Cambio de filtro de aire'),
(9, 'Cambio de barras estabilizadoras'),
(10, 'Cambio de rótulas'),
(11, 'Cambio de suspensión'),
(12, 'Cambio de batería'),
(13, 'Cambio de coolant'),
(14, 'Cambio de soporte'),
(15, 'Polarizado'),
(16, 'COMODIN');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomotor`
--

CREATE TABLE IF NOT EXISTS `tipomotor` (
  `idTipoGasolina` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`idTipoGasolina`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tipomotor`
--

INSERT INTO `tipomotor` (`idTipoGasolina`, `descripcion`) VALUES
(1, 'Diesel'),
(2, 'Regular'),
(3, 'Superior'),
(4, 'Gas LPG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposalida`
--

CREATE TABLE IF NOT EXISTS `tiposalida` (
  `idTipoSalida` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `idVentas` varchar(45) DEFAULT NULL,
  `idRenta` int(11) DEFAULT NULL,
  `idSalida` int(11) NOT NULL,
  PRIMARY KEY (`idTipoSalida`),
  KEY `FK_TIPOSALIDA_VENTAS` (`idVentas`),
  KEY `FK_TIPOSALIDA_RENTA` (`idRenta`),
  KEY `FK_TIPOSALIDA_SALIDA` (`idSalida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tiposalida`
--

INSERT INTO `tiposalida` (`idTipoSalida`, `descripcion`, `idVentas`, `idRenta`, `idSalida`) VALUES
('1', 'Factura', '1', NULL, 1),
('2', 'Devolcuion de compra', NULL, NULL, 2),
('3', 'Salida  a Sucursal', NULL, NULL, 3),
('4', 'Salida a Taller', NULL, NULL, 4),
('5', 'Entrega', NULL, 10, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipovehiculo`
--

CREATE TABLE IF NOT EXISTS `tipovehiculo` (
  `idTipoVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoVehiculo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `tipovehiculo`
--

INSERT INTO `tipovehiculo` (`idTipoVehiculo`, `descripcion`) VALUES
(1, 'Autos'),
(2, 'Motocicleta'),
(3, 'Camiones y Buses'),
(4, 'Barcos y Yates'),
(5, 'Equipo pesado y maquinaria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transmision`
--

CREATE TABLE IF NOT EXISTS `transmision` (
  `idTransmision` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`idTransmision`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `transmision`
--

INSERT INTO `transmision` (`idTransmision`, `descripcion`) VALUES
(1, 'Automatica'),
(2, 'Mecanica'),
(3, 'Triptónica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `idVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(45) NOT NULL,
  `precioVenta` decimal(10,0) NOT NULL,
  `precioRentaHora` varchar(45) NOT NULL,
  `precioRentaDia` varchar(45) NOT NULL,
  `placa` varchar(8) DEFAULT NULL,
  `año` INT(4) NOT NULL,
  `idModelo` int(11) NOT NULL,
  `idInventario` int(11) NOT NULL,
  `idTipoVehiculo` int(11) NOT NULL,
  `idTipoGasolina` int(11) NOT NULL,
  `idTransmision` int(11) NOT NULL,
  `idCilindraje` int(11) NOT NULL,
  
  PRIMARY KEY (`idVehiculo`),
  KEY `FK_VEHICULO_MODELO` (`idModelo`),
  KEY `FK_VEHICULO_INVENTARIO` (`idInventario`),
  KEY `FK_VEHICULO_TIPOVEHICULO` (`idTipoVehiculo`),
  KEY `FK_VEHICULO_TIPOMOTOR` (`idTipoGasolina`),
  KEY `FK_VEHICULO_TRANSMISION` (`idTransmision`),
  KEY `FK_VEHICULO_CILINDRAJE` (`idCilindraje`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`idVehiculo`, `color`, `precioVenta`, `precioRentaHora`, `precioRentaDia`, `placa`, `año`, `idModelo`, `idInventario`, `idTipoVehiculo`, `idTipoGasolina`, `idTransmision`, `idCilindraje`) VALUES
(1, 'rojo', '1000000', '100', '200', 'PCU28959', 2018, 1, 2, 1, 1, 2, 1),
(2, 'Negro', '1400000', '100', '200', 'LMU3325', 2017, 2, 2, 1, 2, 1, 2),
(3, 'Negro', '1200000', '100', '200', 'JKL90432', 2019, 3, 2, 1, 3, 3, 3),
(4, 'Negro', '1200000', '100', '200', 'ANM89233', 2016, 4, 2, 1, 4, 1, 4),
(5, 'Azul', '1300000', '100', '200', 'QUWJ2839', 2015, 5, 2, 1, 4, 1, 5),
(6, 'Verde', '1700000', '100', '200', 'CKL87392', 2018, 6, 2, 1, 3, 2, 5),
(7, 'Blanco', '1800000', '100', '200', 'PKS34940', 2017, 7, 2, 1, 2, 2, 6),
(8, 'Negro', '1500000', '100', '200', 'PKJUE829', 2019, 8, 2, 1, 1, 3, 7),
(9, 'Azul', '2000000', '100', '200', 'WERT3829', 2016, 9, 2, 1, 1, 1, 1),
(10, 'Blanco', '2500000', '100', '200', 'IOP00292', 2015, 10, 2, 1, 2, 1, 2),
(11, 'Azul', '1700000', '100', '200', 'UIE793J2', 2018, 11, 2, 1, 3, 1, 3),
(12, 'Negro', '1500000', '100', '200', '2YWHJD88', 2017, 12, 2, 1, 4, 1, 4),
(13, 'Negro', '1600000', '100', '200', 'LKI89772', 2019, 13, 2, 1, 4, 2, 5),
(14, 'Negro', '1500000', '100', '200', 'KLIO0383', 2016, 14, 2, 1, 3, 2, 6),
(15, 'Verde', '1400000', '100', '200', 'PCWHEE24', 2015, 15, 2, 1, 2, 3, 7),
(16, 'Verde', '1300000', '50', '200', 'JKL90432', 2018, 16, 1, 2, 1, 3, 2),
(17, 'Verde', '1200000', '50', '200', 'ANM89233', 2017, 17, 1, 2, 1, 2, 3),
(18, 'Verde', '1500000', '50', '200', 'QUWJ2839', 2019, 18, 1, 2, 2, 2, 2),
(19, 'Rojo', '1200000', '50', '200', 'CKL87392', 2016, 19, 1, 2, 3, 2, 2),
(20, 'Rojo', '1300000', '50', '200', 'PKS34940', 2015, 20, 1, 2, 4, 1, 1),
(21, 'Rojo', '80000', '50', '200', 'PKJUE829', 2018, 21, 7, 3, 4, 1, 2),
(22, 'Azul', '350000', '50', '200', 'WERT3829', 2017, 22, 7, 3, 3, 1, 4),
(23, 'Azul', '70000', '50', '200', 'PCWHEE24', 2019, 23, 7, 3, 2, 2, 5),
(24, 'Azul', '60000', '50', '200', 'KLIO0383', 2016, 24, 7, 3, 1, 1, 2),
(25, 'Amarillo', '500000', '500', '2000', '2YWHJD88', 2015, 25, 4, 5, 4, 1, 6),
(26, 'amarillo', '500000', '500', '2000', 'UIE793J2', 2018, 26, 4, 5, 3, 2, 7),
(27, 'Amarillo', '500000', '500', '2000', 'IOP00292', 2017, 27, 8, 5, 2, 2, 3),
(28, 'Amarillo', '650000', '500', '2000', 'WERT3829', 2019, 28, 9, 5, 1, 3, 2),
(29, 'Amarillo', '600000', '500', '2000', 'PKJUE829', 2016, 29, 8, 5, 4, 3, 2),
(30, 'Blanco', '1300000', '1500', '20000', 'QUWJ2839', 2015, 30, 5, 4, 2, 3, 4),
(31, 'Blanco', '1200000', '1200', '20000', 'KLIO0383', 2014, 30, 5, 4, 2, 3, 5),
(32, 'Blanco', '15000000', '1000', '20000', 'UIE793J2', 2018, 30, 5, 4, 2, 2, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE IF NOT EXISTS `ventas` (
  `idVentas` varchar(45) NOT NULL,
  `idFactura` int(11) NOT NULL,
  `idVehiculo` int(11) NOT NULL,
  PRIMARY KEY (`idVentas`),
  KEY `FK_VENTAS_FACTURA` (`idFactura`),
  KEY `FK_VENTAS_VEHICULO` (`idVehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVentas`, `idFactura`, `idVehiculo`) VALUES
('1', 2, 2),
('10', 6, 19),
('11', 8, 20),
('12', 3, 22),
('2', 3, 4),
('3', 4, 6),
('4', 5, 8),
('5', 6, 10),
('6', 2, 12),
('7', 3, 14),
('8', 4, 16),
('9', 5, 18);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_CLIENTE_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `control`
--
ALTER TABLE `control`
  ADD CONSTRAINT `FK_CONTROL_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_CONTROL_ENTRADA` FOREIGN KEY (`idEntrada`) REFERENCES `entrada` (`idEntrada`),
  ADD CONSTRAINT `FK_CONTROL_INVENTARIO` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`),
  ADD CONSTRAINT `FK_CONTROL_SALIDA` FOREIGN KEY (`idSalida`) REFERENCES `salida` (`idSalida`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `FK_EMPLEADO_CARGO` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`idCargo`),
  ADD CONSTRAINT `FK_EMPLEADO_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `FK_FACTURA_CLIENTE` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  ADD CONSTRAINT `FK_FACTURA_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_FACTURA_FACTURAMANTENIMIENTO` FOREIGN KEY (`idFacturaMantenimiento`) REFERENCES `facturapormantenimiento` (`idFacturaMantenimiento`),
  ADD CONSTRAINT `FK_FACTURA_FORMAPAGO` FOREIGN KEY (`idFormaPago`) REFERENCES `formapago` (`idFormaPago`),
  ADD CONSTRAINT `FK_FACTURA_IMPUESTO` FOREIGN KEY (`idImpuesto`) REFERENCES `impuesto` (`idImpuesto`);

--
-- Filtros para la tabla `factura_descuento`
--
ALTER TABLE `factura_descuento`
  ADD CONSTRAINT `FK_FACTURADESCUENTO_DESCUENTO` FOREIGN KEY (`idDescuento`) REFERENCES `descuento` (`idDescuento`),
  ADD CONSTRAINT `FK_FACTURADESCUENTO_FACTURA` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`);

--
-- Filtros para la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD CONSTRAINT `FK_FOTOS_VEHICULO` FOREIGN KEY (`Vehiculo_idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`);

--
-- Filtros para la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD CONSTRAINT `FK_MANTENIMIENTO_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_MANTENIMIENTO_FACTURAMANTENIMIENTO` FOREIGN KEY (`idFacturaMantenimiento`) REFERENCES `facturapormantenimiento` (`idFacturaMantenimiento`),
  ADD CONSTRAINT `FK_MANTENIMIENTO_TALLER` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`);

--
-- Filtros para la tabla `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `FK_MODELO_MARCA` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`);

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `FK_PROVEEDORES_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `renta`
--
ALTER TABLE `renta`
  ADD CONSTRAINT `FK_RENTA_AGENDA` FOREIGN KEY (`idAgenda`) REFERENCES `agenda` (`idAgenda`),
  ADD CONSTRAINT `FK_RENTA_FACTURA` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`),
  ADD CONSTRAINT `FK_RENTA_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`);

--
-- Filtros para la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD CONSTRAINT `FK_REPUESTOS_INVENTARIO` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`),
  ADD CONSTRAINT `FK_REPUESTOS_MANTENIMIENTO` FOREIGN KEY (`idMantenimiento`) REFERENCES `mantenimiento` (`idMantenimiento`),
  ADD CONSTRAINT `FK_REPUESTOS_MARCARESPUESTO` FOREIGN KEY (`idMarcaRepuesto`) REFERENCES `marcarepuesto` (`idMarcaRepuesto`);

--
-- Filtros para la tabla `solicitudmantenimiento`
--
ALTER TABLE `solicitudmantenimiento`
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_MANTENIMIENTO` FOREIGN KEY (`idMantenimiento`) REFERENCES `mantenimiento` (`idMantenimiento`),
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_TIPOMANTENIMIENTO` FOREIGN KEY (`idTipoMantenimiento`) REFERENCES `tipomantenimiento` (`idTipoMantenimiento`),
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`);

--
-- Filtros para la tabla `solicitudrenta`
--
ALTER TABLE `solicitudrenta`
  ADD CONSTRAINT `FK_SOLICITUDRENTA_AGENDA` FOREIGN KEY (`idAgenda`) REFERENCES `agenda` (`idAgenda`),
  ADD CONSTRAINT `FK_SOLICITUDRENTA_CLIENTE` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  ADD CONSTRAINT `FK_SOLICITUDRENTA_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_SOLICITUDRENTA_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`);

--
-- Filtros para la tabla `solicitudrequisitos`
--
ALTER TABLE `solicitudrequisitos`
  ADD CONSTRAINT `FK_SOLICITUDREQUISITOS_REQUISITOS` FOREIGN KEY (`idRequisitos`) REFERENCES `requisitos` (`idRequisitos`),
  ADD CONSTRAINT `FK_SOLICITUDREQUISITOS_SOLICITUD` FOREIGN KEY (`idSolicitudRenta`) REFERENCES `solicitudrenta` (`idSolicitudRenta`);

--
-- Filtros para la tabla `taller`
--
ALTER TABLE `taller`
  ADD CONSTRAINT `FK_TALLER_SUCURSAL` FOREIGN KEY (`idSucursal`) REFERENCES `sucursal` (`idSucursal`);

--
-- Filtros para la tabla `telefonos`
--
ALTER TABLE `telefonos`
  ADD CONSTRAINT `FK_TELEFONOS_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `tipoentrada`
--
ALTER TABLE `tipoentrada`
  ADD CONSTRAINT `FK_TIPOENTRADA_ENTRADA` FOREIGN KEY (`idEntrada`) REFERENCES `entrada` (`idEntrada`),
  ADD CONSTRAINT `FK_TIPOENTRADA_PROVEEDORES` FOREIGN KEY (`idProveedores`) REFERENCES `proveedores` (`idProveedores`);

--
-- Filtros para la tabla `tiposalida`
--
ALTER TABLE `tiposalida`
  ADD CONSTRAINT `FK_TIPOSALIDA_RENTA` FOREIGN KEY (`idRenta`) REFERENCES `renta` (`idRenta`),
  ADD CONSTRAINT `FK_TIPOSALIDA_SALIDA` FOREIGN KEY (`idSalida`) REFERENCES `salida` (`idSalida`),
  ADD CONSTRAINT `FK_TIPOSALIDA_VENTAS` FOREIGN KEY (`idVentas`) REFERENCES `ventas` (`idVentas`);

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `FK_VEHICULO_CILINDRAJE` FOREIGN KEY (`idCilindraje`) REFERENCES `cilindraje` (`idCilindraje`),
  ADD CONSTRAINT `FK_VEHICULO_INVENTARIO` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`),
  ADD CONSTRAINT `FK_VEHICULO_MODELO` FOREIGN KEY (`idModelo`) REFERENCES `modelo` (`idModelo`),
  ADD CONSTRAINT `FK_VEHICULO_TIPOMOTOR` FOREIGN KEY (`idTipoGasolina`) REFERENCES `tipomotor` (`idTipoGasolina`),
  ADD CONSTRAINT `FK_VEHICULO_TIPOVEHICULO` FOREIGN KEY (`idTipoVehiculo`) REFERENCES `tipovehiculo` (`idTipoVehiculo`),
  ADD CONSTRAINT `FK_VEHICULO_TRANSMISION` FOREIGN KEY (`idTransmision`) REFERENCES `transmision` (`idTransmision`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `FK_VENTAS_FACTURA` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`),
  ADD CONSTRAINT `FK_VENTAS_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
