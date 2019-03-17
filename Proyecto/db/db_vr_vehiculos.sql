-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 17-03-2019 a las 03:13:17
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `db_vr_vehiculos`
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE IF NOT EXISTS `cargo` (
  `idCargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cilindraje`
--

CREATE TABLE IF NOT EXISTS `cilindraje` (
  `idCilindraje` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(10) NOT NULL,
  PRIMARY KEY (`idCilindraje`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `FK_CLIENTE_PERSONA` (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control`
--

CREATE TABLE IF NOT EXISTS `control` (
  `idControl` int(11) NOT NULL AUTO_INCREMENT,
  `idInventario` int(11) NOT NULL,
  `idSalida` int(11) NOT NULL,
  `idEntrada` int(11) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  PRIMARY KEY (`idControl`),
  KEY `FK_CONTROL_INVENTARIO` (`idInventario`),
  KEY `FK_CONTROL_SALIDA` (`idSalida`),
  KEY `FK_CONTROL_ENTRADA` (`idEntrada`),
  KEY `FK_CONTROL_EMPLEADO` (`idEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE IF NOT EXISTS `entrada` (
  `idEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `fechaEntrada` varchar(45) NOT NULL,
  PRIMARY KEY (`idEntrada`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  `idFacturaMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `FK_FACTURA_CLIENTE` (`idCliente`),
  KEY `FK_FACTURA_EMPLEADO` (`idEmpleado`),
  KEY `FK_FACTURA_FORMAPAGO` (`idFormaPago`),
  KEY `FK_FACTURA_IMPUESTO` (`idImpuesto`),
  KEY `FK_FACTURA_FACTURAMANTENIMIENTO` (`idFacturaMantenimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturapormantenimiento`
--

CREATE TABLE IF NOT EXISTS `facturapormantenimiento` (
  `idFacturaMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFacturaMantenimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formapago`
--

CREATE TABLE IF NOT EXISTS `formapago` (
  `idFormaPago` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFormaPago`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuesto`
--

CREATE TABLE IF NOT EXISTS `impuesto` (
  `idImpuesto` int(11) NOT NULL AUTO_INCREMENT,
  `porcentaje` decimal(10,0) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idImpuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE IF NOT EXISTS `inventario` (
  `idInventario` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idInventario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `idFacturaMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idMantenimiento`),
  KEY `FK_MANTENIMIENTO_EMPLEADO` (`idEmpleado`),
  KEY `FK_MANTENIMIENTO_TALLER` (`idTaller`),
  KEY `FK_MANTENIMIENTO_FACTURAMANTENIMIENTO` (`idFacturaMantenimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE IF NOT EXISTS `marca` (
  `idMarca` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcarepuesto`
--

CREATE TABLE IF NOT EXISTS `marcarepuesto` (
  `idMarcaRepuesto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMarcaRepuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `pnombre` varchar(45) NOT NULL,
  `snombre` varchar(45) DEFAULT NULL,
  `papellido` varchar(45) NOT NULL,
  `sapellido` varchar(45) DEFAULT NULL,
  `correo` varchar(45) NOT NULL,
  `direccion` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `idProveedores` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idProveedores`),
  KEY `FK_PROVEEDORES_PERSONA` (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos`
--

CREATE TABLE IF NOT EXISTS `requisitos` (
  `idRequisitos` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idRequisitos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

CREATE TABLE IF NOT EXISTS `salida` (
  `idSalida` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `FechaSalida` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSalida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE IF NOT EXISTS `sucursal` (
  `idSucursal` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  PRIMARY KEY (`idSucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomantenimiento`
--

CREATE TABLE IF NOT EXISTS `tipomantenimiento` (
  `idTipoMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoMantenimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomotor`
--

CREATE TABLE IF NOT EXISTS `tipomotor` (
  `idTipoGasolina` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`idTipoGasolina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipovehiculo`
--

CREATE TABLE IF NOT EXISTS `tipovehiculo` (
  `idTipoVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoVehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transmision`
--

CREATE TABLE IF NOT EXISTS `transmision` (
  `idTransmision` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`idTransmision`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `idVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `precioVenta` decimal(10,0) NOT NULL,
  `precioRentaHora` varchar(45) NOT NULL,
  `precioRentaDia` varchar(45) NOT NULL,
  `placa` varchar(8) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  ADD CONSTRAINT `FK_CONTROL_INVENTARIO` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`),
  ADD CONSTRAINT `FK_CONTROL_SALIDA` FOREIGN KEY (`idSalida`) REFERENCES `salida` (`idSalida`),
  ADD CONSTRAINT `FK_CONTROL_ENTRADA` FOREIGN KEY (`idEntrada`) REFERENCES `entrada` (`idEntrada`),
  ADD CONSTRAINT `FK_CONTROL_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `FK_EMPLEADO_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `FK_EMPLEADO_CARGO` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`idCargo`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `FK_FACTURA_CLIENTE` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  ADD CONSTRAINT `FK_FACTURA_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_FACTURA_FORMAPAGO` FOREIGN KEY (`idFormaPago`) REFERENCES `formapago` (`idFormaPago`),
  ADD CONSTRAINT `FK_FACTURA_IMPUESTO` FOREIGN KEY (`idImpuesto`) REFERENCES `impuesto` (`idImpuesto`),
  ADD CONSTRAINT `FK_FACTURA_FACTURAMANTENIMIENTO` FOREIGN KEY (`idFacturaMantenimiento`) REFERENCES `facturapormantenimiento` (`idFacturaMantenimiento`);

--
-- Filtros para la tabla `factura_descuento`
--
ALTER TABLE `factura_descuento`
  ADD CONSTRAINT `FK_FACTURADESCUENTO_FACTURA` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`),
  ADD CONSTRAINT `FK_FACTURADESCUENTO_DESCUENTO` FOREIGN KEY (`idDescuento`) REFERENCES `descuento` (`idDescuento`);

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
  ADD CONSTRAINT `FK_MANTENIMIENTO_TALLER` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`),
  ADD CONSTRAINT `FK_MANTENIMIENTO_FACTURAMANTENIMIENTO` FOREIGN KEY (`idFacturaMantenimiento`) REFERENCES `facturapormantenimiento` (`idFacturaMantenimiento`);

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
  ADD CONSTRAINT `FK_RENTA_FACTURA` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`),
  ADD CONSTRAINT `FK_RENTA_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`),
  ADD CONSTRAINT `FK_RENTA_AGENDA` FOREIGN KEY (`idAgenda`) REFERENCES `agenda` (`idAgenda`);

--
-- Filtros para la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD CONSTRAINT `FK_REPUESTOS_INVENTARIO` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`),
  ADD CONSTRAINT `FK_REPUESTOS_MARCARESPUESTO` FOREIGN KEY (`idMarcaRepuesto`) REFERENCES `marcarepuesto` (`idMarcaRepuesto`),
  ADD CONSTRAINT `FK_REPUESTOS_MANTENIMIENTO` FOREIGN KEY (`idMantenimiento`) REFERENCES `mantenimiento` (`idMantenimiento`);

--
-- Filtros para la tabla `solicitudmantenimiento`
--
ALTER TABLE `solicitudmantenimiento`
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`),
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_MANTENIMIENTO` FOREIGN KEY (`idMantenimiento`) REFERENCES `mantenimiento` (`idMantenimiento`),
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  ADD CONSTRAINT `FK_SOLICITUDMANTENIMIENTO_TIPOMANTENIMIENTO` FOREIGN KEY (`idTipoMantenimiento`) REFERENCES `tipomantenimiento` (`idTipoMantenimiento`);

--
-- Filtros para la tabla `solicitudrenta`
--
ALTER TABLE `solicitudrenta`
  ADD CONSTRAINT `FK_SOLICITUDRENTA_CLIENTE` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  ADD CONSTRAINT `FK_SOLICITUDRENTA_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`),
  ADD CONSTRAINT `FK_SOLICITUDRENTA_AGENDA` FOREIGN KEY (`idAgenda`) REFERENCES `agenda` (`idAgenda`),
  ADD CONSTRAINT `FK_SOLICITUDRENTA_EMPLEADO` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`);

--
-- Filtros para la tabla `solicitudrequisitos`
--
ALTER TABLE `solicitudrequisitos`
  ADD CONSTRAINT `FK_SOLICITUDREQUISITOS_SOLICITUD` FOREIGN KEY (`idSolicitudRenta`) REFERENCES `solicitudrenta` (`idSolicitudRenta`),
  ADD CONSTRAINT `FK_SOLICITUDREQUISITOS_REQUISITOS` FOREIGN KEY (`idRequisitos`) REFERENCES `requisitos` (`idRequisitos`);

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
  ADD CONSTRAINT `FK_TIPOSALIDA_VENTAS` FOREIGN KEY (`idVentas`) REFERENCES `ventas` (`idVentas`),
  ADD CONSTRAINT `FK_TIPOSALIDA_RENTA` FOREIGN KEY (`idRenta`) REFERENCES `renta` (`idRenta`),
  ADD CONSTRAINT `FK_TIPOSALIDA_SALIDA` FOREIGN KEY (`idSalida`) REFERENCES `salida` (`idSalida`);

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `FK_VEHICULO_MODELO` FOREIGN KEY (`idModelo`) REFERENCES `modelo` (`idModelo`),
  ADD CONSTRAINT `FK_VEHICULO_INVENTARIO` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`),
  ADD CONSTRAINT `FK_VEHICULO_TIPOVEHICULO` FOREIGN KEY (`idTipoVehiculo`) REFERENCES `tipovehiculo` (`idTipoVehiculo`),
  ADD CONSTRAINT `FK_VEHICULO_TIPOMOTOR` FOREIGN KEY (`idTipoGasolina`) REFERENCES `tipomotor` (`idTipoGasolina`),
  ADD CONSTRAINT `FK_VEHICULO_TRANSMISION` FOREIGN KEY (`idTransmision`) REFERENCES `transmision` (`idTransmision`),
  ADD CONSTRAINT `FK_VEHICULO_CILINDRAJE` FOREIGN KEY (`idCilindraje`) REFERENCES `cilindraje` (`idCilindraje`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `FK_VENTAS_FACTURA` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`),
  ADD CONSTRAINT `FK_VENTAS_VEHICULO` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
