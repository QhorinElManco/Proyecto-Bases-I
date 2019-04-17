-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 17-04-2019 a las 23:35:54
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FACTURA_VENTA`(
            IN      pnidFactura                 INT,
            IN      pnidCliente                 INT,
            IN      pnidEmpleado                INT,
            IN      pnidFormaPago               INT,
            IN      pnidDescuento               INT,
            IN      pnidVentas                  INT,
            IN      pnidVehiculo                INT,
            OUT     pbOcurrioError 		        BOOLEAN,
		    OUT     pcMensaje			        VARCHAR(2000)


)
SP:BEGIN
        DECLARE vcConteo, vnFactura, vnSalida, vnTipoSalida, vnVentas, vnTotal INT;
        DECLARE vcDescuento VARCHAR(5);
        DECLARE tempMensaje VARCHAR(2000);
        SET autocommit=0;
		START TRANSACTION;
		SET tempMensaje='';
		SET pbOcurrioError=TRUE;

        IF pnidFactura='' OR pnidFactura IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,' factura no puede ser nulo');
        END IF;
        
        IF pnidCliente='' OR pnidCliente IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Cliente no puede ser nulo');
        END IF;
        
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,' empleado no puede ser nulo');
        END IF;
        
       IF pnidFormaPago='' OR pnidFormaPago IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,' forma de pago no puede ser nulo');
        END IF;
        IF pnidDescuento='' OR pnidDescuento IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Descuento por mantenimiento  no puede ser nulo');
        END IF;
        IF pnidImpuesto='' OR pnidImpuesto IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de impuesto por mantenimiento  no puede ser nulo');
        END IF;
        IF pnidVentas='' OR pnidVentas IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'venta por mantenimiento  no puede ser nulo');
        END IF;
         IF tempMensaje<>'' THEN
            SET pcMensaje=CONCAT('CAMPOS REQUERIDOS: ',tempMensaje);
            LEAVE SP;
        END IF;

        
            SELECT COUNT(*) INTO vcConteo FROM Impuesto WHERE idImpuesto = pnidImpuesto;
			IF vcConteo=0  THEN
				SET pcMensaje = 'El impuesto seleccionado no existe.';
				LEAVE SP;
			END IF;

			SELECT COUNT(*) INTO vcConteo FROM FormaPago WHERE idFormaPago = pnidFormaPago;
			IF vcConteo=0  THEN
				SET pcMensaje = 'La forma de pago seleccionada no existe.';
				LEAVE SP;
			END IF;

            SELECT COUNT(*) INTO vcConteo FROM Empleado e
			WHERE e.idEmpleado=pnidEmpleado;
			IF vcConteo=0 THEN
				SET pcMensaje = 'El empleado seleccionado no existe.';
				LEAVE SP;
			END IF;

            SELECT COUNT(*) INTO vcConteo FROM Cliente c
			WHERE c.idCliente=pnidCliente;
			IF vcConteo=0 THEN
				SET pcMensaje = 'El Cliente seleccionado no existe.';
				LEAVE SP;
			END IF;

            SELECT d.estado INTO vcDescuento FROM Descuento d WHERE d.idDescuento=pnidDescuento;
			 

            SELECT (MAX(f.idFactura)+1) INTO vnFactura FROM Factura f;
            SELECT (MAX(v.idVentas)+1) INTO vnVentas FROM Ventas v;
            SELECT (MAX(ts.idTipoSalida)+1) INTO vnTipoSalida FROM TipoSalida ts;
            SELECT (MAX(s.idSalida)+1) INTO vnSalida FROM Salida s;

            SELECT ( vh.precioVenta-((vh.precioVenta * d.porcentaje)/100) + ( ((vh.precioVenta-((vh.precioVenta * d.porcentaje)/100)) *15)/100 ))  INTO vnTotal FROM venta v
            INNER JOIN vehiculo vh ON vh.idVehiculo=v.idVehiculo
            INNER JOIN Factura f ON f.idFactura=v.idFactura
            INNER JOIN DescuentoFactura df ON df.idFactura = f.idFactura
			INNER JOIN Descuento d ON d.idDescuento = df.idDescuento
			INNER JOIN Impuesto i  ON f.idImpuesto = i.idImpuesto
            WHERE v.pnidVehiculo=pnidVehiculo;


            SELECT COUNT(*) INTO vcConteo FROM  venta v
            INNER JOIN vehiculo vh ON v.idVehiculo=vh.idVehiculo
            INNER JOIN TipoSalida ts ON ts.idVentas=v.idVentas
            WHERE vh.idVehiculo=pnidVehiculo AND  ts.descripcion='Venta';

            IF vcConteo>=1 THEN
                SET pcMensaje='El auto ya esta vendido';

                ELSE 
                    INSERT INTO Ventas(idVentas,idVehiculo )
                    VALUES (vnVentas,pnidVehiculo);

                    INSERT INTO Factura(idFactura, fechaEmision, Total, idCliente,idEmpleado,idImpuesto)
                    VALUES (vnFactura, CURDATE(), vnTotal, pnidCliente,pnidEmpleado, pnidImpuesto);

                    INSERT INTO FormaPago(idFormaPago, idFactura)
                    VALUES (pnidFormaPago,vnFactura);

                    INSERT INTO descuentofactura(idFactura,idDescuento,fecha)
			        VALUES(vnFactura,vcDescuento, CURDATE());

                    INSERT INTO TipoSalida(idTipoSalida,descripcion,idVentas)
			        VALUES(vnTipoSalida,vcDescuento, CURDATE());

                    INSERT INTO Salida(idSalida, descripcion, fechaSalida, idTipoSalida)
                    VALUES (vnSalida,'',CURDATE(), vnTipoSalida);
            END IF;










END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE IF NOT EXISTS `agenda` (
  `idAgenda` int(11) NOT NULL AUTO_INCREMENT,
  `fechaReserva` date NOT NULL,
  `fechaEntrega` datetime NOT NULL,
  `fechaDevolución` datetime NOT NULL,
  `tiempoRenta` varchar(10) NOT NULL,
  PRIMARY KEY (`idAgenda`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `agenda`
--

INSERT INTO `agenda` (`idAgenda`, `fechaReserva`, `fechaEntrega`, `fechaDevolución`, `tiempoRenta`) VALUES
(1, '2018-09-08', '2018-09-12 03:20:15', '2018-10-12 00:00:00', 'Mes'),
(2, '2018-12-10', '2018-12-10 00:00:00', '2019-01-15 00:00:00', 'Dia'),
(3, '2019-01-15', '2019-01-18 05:30:00', '2019-02-18 04:10:00', 'Mes'),
(4, '2018-06-16', '2018-06-17 08:00:00', '2018-06-17 18:00:00', 'Hora'),
(5, '2018-02-20', '2018-02-20 00:00:00', '2018-02-23 10:00:00', 'Dia'),
(6, '2019-02-03', '2019-02-03 00:00:00', '2019-03-03 13:00:00', 'Mes'),
(7, '2019-01-01', '2019-01-01 06:00:00', '2019-01-01 16:00:00', 'Hora'),
(8, '2019-03-22', '2019-03-22 00:00:00', '2019-03-23 10:00:00', 'Dia'),
(9, '2019-03-05', '2019-03-06 00:00:00', '2019-03-10 15:30:00', 'Dia'),
(10, '2019-03-07', '2019-03-08 00:00:00', '2019-03-10 14:00:00', 'Dia');

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
(7, 'Conserje'),
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
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `fk_Cliente_Persona1` (`idPersona`),
  KEY `fk_Cliente_Usuario1` (`idUsuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `idPersona`, `idUsuario`) VALUES
(1, 1, 11),
(2, 3, 12),
(3, 5, 13),
(4, 7, 14),
(5, 9, 15),
(6, 11, 16),
(7, 13, 17),
(8, 15, 18),
(9, 17, 19),
(10, 19, 20);

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
  KEY `fk_Control_Inventario1` (`idInventario`),
  KEY `fk_Control_Salida1` (`idSalida`),
  KEY `fk_Control_Entrada1` (`idEntrada`),
  KEY `fk_Control_Empleado1` (`idEmpleado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `control`
--

INSERT INTO `control` (`idControl`, `idInventario`, `idSalida`, `idEntrada`, `idEmpleado`) VALUES
(1, 2, 1, NULL, 1),
(2, 1, 2, NULL, 2),
(3, 3, 3, NULL, 3),
(4, 5, 4, NULL, 4),
(5, 4, 5, NULL, 5),
(6, 7, NULL, 1, 6),
(7, 6, NULL, 2, 7),
(8, 8, NULL, 3, 8);

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
-- Estructura de tabla para la tabla `descuentofactura`
--

CREATE TABLE IF NOT EXISTS `descuentofactura` (
  `idFactura` int(11) NOT NULL,
  `idDescuento` int(11) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`idFactura`,`idDescuento`),
  KEY `fk_Factura_has_Descuento_Descuento1` (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `fk_Empleado_Persona1` (`idPersona`),
  KEY `fk_Empleado_Cargo1` (`idCargo`),
  KEY `fk_Empleado_Usuario1` (`idUsuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `fechaInicio`, `fechaFin`, `idPersona`, `idCargo`, `idUsuario`) VALUES
(1, '2018-10-01', NULL, 2, 3, 1),
(2, '2019-02-15', NULL, 4, 3, 2),
(3, '2016-12-25', NULL, 6, 4, 3),
(4, '2017-10-05', NULL, 10, 6, 4),
(5, '2016-05-15', NULL, 12, 5, 5),
(6, '2019-01-20', NULL, 14, 2, 6),
(7, '2017-05-30', NULL, 16, 1, 7),
(8, '2018-06-10', NULL, 18, 6, 8),
(9, '2015-09-19', NULL, 20, 6, 9),
(10, '2015-10-05', '2018-05-30', 8, 2, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE IF NOT EXISTS `entrada` (
  `idEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `fechaEntrada` varchar(45) NOT NULL,
  `idTipoEntrada` int(11) NOT NULL,
  PRIMARY KEY (`idEntrada`),
  KEY `fk_Entrada_TipoEntrada1` (`idTipoEntrada`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `entrada`
--

INSERT INTO `entrada` (`idEntrada`, `descripcion`, `fechaEntrada`, `idTipoEntrada`) VALUES
(1, NULL, '2015-12-12', 1),
(2, NULL, '2018-12-05', 2),
(3, NULL, '2018-12-05', 3);

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
  `idImpuesto` int(11) NOT NULL,
  `idFacturaMantenimiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `fk_Factura_Cliente1` (`idCliente`),
  KEY `fk_Factura_Empleado1` (`idEmpleado`),
  KEY `fk_Factura_Impuesto1` (`idImpuesto`),
  KEY `fk_Factura_FacturaMantenimiento1` (`idFacturaMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`idFactura`, `fechaEmision`, `Total`, `idCliente`, `idEmpleado`, `idImpuesto`, `idFacturaMantenimiento`) VALUES
(1, '2017-01-20', '1500', 1, 1, 1, 9),
(2, '2015-02-15', '1500', 2, 10, 1, NULL),
(3, '2016-03-18', '1500', 3, 9, 1, NULL),
(4, '2018-04-01', '1500', 4, 8, 1, NULL),
(5, '2019-05-19', '1500', 5, 7, 1, NULL),
(6, '2017-06-23', '1500', 6, 6, 1, NULL),
(7, '2015-07-10', '1500', 7, 5, 1, 3),
(8, '2016-08-13', '1500', 8, 4, 1, NULL),
(9, '2018-09-09', '1500', 8, 3, 1, 14),
(10, '2019-01-05', '1500', 9, 3, 1, 6),
(11, '2017-02-04', '1500', 10, 2, 1, 13),
(12, '2015-03-08', '1500', 1, 1, 1, 14),
(13, '2016-04-04', '1500', 2, 10, 1, NULL),
(14, '2018-05-11', '1500', 3, 8, 1, NULL),
(15, '2019-06-17', '1500', 4, 7, 1, NULL),
(16, '2017-07-06', '1500', 2, 9, 1, NULL),
(17, '2015-08-07', '2500', 4, 8, 1, 5),
(18, '2016-09-20', '3500', 5, 5, 1, 10),
(19, '2018-01-29', '4500', 6, 4, 1, NULL),
(20, '2019-02-27', '5500', 7, 2, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturapormantenimiento`
--

CREATE TABLE IF NOT EXISTS `facturapormantenimiento` (
  `idFacturaMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `idMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idFacturaMantenimiento`),
  KEY `fk_FacturaPorMantenimiento_Mantenimiento1` (`idMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `facturapormantenimiento`
--

INSERT INTO `facturapormantenimiento` (`idFacturaMantenimiento`, `descripcion`, `idMantenimiento`) VALUES
(1, 'Reparacion taller 1', 1),
(2, 'Reparacion taller 1', 2),
(3, 'Reparacion taller 1', 3),
(4, 'Reparacion taller 1', 4),
(5, 'Reparacion taller 1', 5),
(6, 'Reparacion taller 2', 6),
(7, 'Reparacion taller 2', 7),
(8, 'Reparacion taller 2', 8),
(9, 'Reparacion taller 1', 9),
(10, 'Reparacion taller 1', 10),
(11, 'Reparacion taller 2', 11),
(12, 'Reparacion taller 2', 12),
(13, 'Reparacion taller 2', 13),
(14, 'Reparacion taller 2', 14),
(15, 'Reparacion taller 2', 15);

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
-- Estructura de tabla para la tabla `formapagofactura`
--

CREATE TABLE IF NOT EXISTS `formapagofactura` (
  `idFormaPago` int(11) DEFAULT NULL,
  `idFactura` int(11) DEFAULT NULL,
  KEY `FK_Forma_Pago` (`idFormaPago`),
  KEY `FK_Factura` (`idFactura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `formapagofactura`
--

INSERT INTO `formapagofactura` (`idFormaPago`, `idFactura`) VALUES
(1, 1),
(5, 2),
(4, 3),
(3, 4),
(3, 5),
(2, 6),
(1, 7),
(5, 8),
(4, 9),
(3, 10),
(2, 11),
(3, 12),
(5, 13),
(3, 14),
(5, 15),
(5, 16),
(4, 17),
(3, 18),
(2, 19),
(1, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE IF NOT EXISTS `fotos` (
  `idFotos` int(11) NOT NULL AUTO_INCREMENT,
  `direccionEnDisco` varchar(45) NOT NULL,
  `idVehiculo` int(11) NOT NULL,
  PRIMARY KEY (`idFotos`),
  UNIQUE KEY `direccionEnDisco` (`direccionEnDisco`),
  KEY `fk_Fotos_Vehiculo1` (`idVehiculo`)
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
  `idSolicitudMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idMantenimiento`),
  KEY `fk_Mantenimiento_Empleado1` (`idEmpleado`),
  KEY `fk_Mantenimiento_Taller1` (`idTaller`),
  KEY `fk_Mantenimiento_SolicitudMantenimiento1` (`idSolicitudMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `mantenimiento`
--

INSERT INTO `mantenimiento` (`idMantenimiento`, `idEmpleado`, `idTaller`, `descripcionReparaciones`, `costo`, `idSolicitudMantenimiento`) VALUES
(1, 1, 2, 'Cambio de aceite', '1500', 1),
(2, 3, 4, 'Llantas', '1500', 2),
(3, 3, 4, 'Cambio de bujías', '1500', 3),
(4, 10, 14, 'Alineamiento', '1500', 4),
(5, 2, 8, 'Cambio de fricciones', '1500', 5),
(6, 8, 11, 'Cambio de bujes', '1500', 6),
(7, 1, 7, 'Cambio de tijeras', '1500', 7),
(8, 8, 9, 'Cambio de filtro de aire', '1500', 8),
(9, 4, 5, 'Cambio de barras estabilizadoras', '1500', 9),
(10, 8, 2, 'Cambio de rótulas', '1500', 10),
(11, 10, 10, 'Cambio de suspensión', '1500', 11),
(12, 10, 15, 'Cambio de batería', '1500', 12),
(13, 2, 13, 'Cambio de coolant', '1500', 13),
(14, 1, 4, 'Cambio de soporte', '1500', 14),
(15, 4, 7, 'Polarizado', '1500', 15);

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
  KEY `fk_Modelo_Marca1` (`idMarca`)
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
(29, 'PC110R\n Textos completos	\nidModelo\ndescripcio', 24),
(30, '430', 30),
(31, '27', 31),
(32, '43 fly', 32);

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
  `noIdentidad` varchar(45) NOT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `pnombre`, `snombre`, `papellido`, `sapellido`, `correo`, `direccion`, `noIdentidad`) VALUES
(1, 'Zephania', 'George', 'Robles', 'Hernandez', 'gHer@gmail.com', 'col.la esperanza', '0801-1980-9802'),
(2, 'Hakeem', 'Flynn', 'Compton', 'Ortega', 'H.flynn@gmail.com', 'col. Centro America', '0801-1990-6406'),
(3, 'Tucker', 'Simon', 'Walker', 'Craig', 'T-simon@gmail.com', 'col.El Hato ', '0801-1996-1194'),
(4, 'Ali', 'Jarrod', 'Murphy', 'Hansen', 'Ali.j@gmail.com', 'col.Kennedy', '0801-1965-7887'),
(5, 'Buckminster', 'Valentine', 'Oneal', 'Strickland', 'on_val@gmail.com', 'col.21 de Febrero', '0801-1962-4092'),
(6, 'Zeus', 'Elmo', 'Dickson', 'Meyer', 'ElDick@gmail.com', 'col.Centro America', '0801-1985-5370'),
(7, 'Omar', 'Rolando', 'Lee', 'Pollard', 'om_ro@gmail.com', 'col.la esperanza', '0801-1987-5237'),
(8, 'Addison', 'Xenos', 'Harrington', 'Bradford', 'harri.1@gmail.com', 'col.la esperanza', '0801-1987-6751'),
(9, 'Ignacio', 'Lucius', 'Henderson', 'McAdams', 'ig.adams@gmail.com', 'col.Kennedy', '0801-1969-5125'),
(10, 'Leonard', 'Bruce', 'Potter', 'McAboy', 'potter@gmail.com', 'col.Las Americas', '0801-1992-9752'),
(11, 'Jack', 'Vincent', 'Clarke', 'Guerrero', 'vin.15@gmail.com', 'col.La union', '0801-1991-2251'),
(12, 'Joseph', 'Armando', 'Campos', 'Lomas', 'c.lomas55@gmail.com', 'col.Prados Universitarios', '0801-1965-4747'),
(13, 'Roger', 'Rabbbit', 'Dodson', 'Hammond', 'zanahorias@gmail.com', 'col.la Alianza', '0801-1978-4068'),
(14, 'Peter', 'Oliver', 'Quill', 'Velez', 'starLord@gmail.com', 'col.Xandar', '0801-1986-7478'),
(15, 'Dante', 'Eugenio', 'Harrington', 'Hernandez', 'eug@gmail.com', 'col. Miramontes', '0801-1962-2584'),
(16, 'Sara', 'Eugenia', 'Douglas', 'Vasquez', 'vasquez8890gmail.com', 'col. Divina Providencia', '0801-1989-2762'),
(17, 'Rosa', 'Perla', 'Bursh', 'Hanks', 'perl.ros@gmail.com', 'col. La Union', '0801-1987-6399'),
(18, 'Alice', 'Michelle', 'Livingston', 'Klaus', 'k_liv@gmail.com', 'col.Los Pinos', '0801-1990-1154'),
(19, 'Brenda', 'Nevada', 'Guerrero', 'Clayton', 'bren.890@gmail.com', 'col.la Americas', '0801-1965-7014'),
(20, 'Laura', 'Latifah', 'Meyer', 'Pearson', 'LauLa@gmail.com', 'col. La sosa', '0801-1969-7426'),
(21, 'Alex', 'Roberto', 'Perales', 'ayala', 'ay@gmail.com', 'col. Las Brisas', '0801-188-24567'),
(22, 'Tadeo', 'Rodrigo', 'Rodriguez', 'Martinez', 'mx.88@gmail.com', 'col. Kennedy', '0801-1987-34564'),
(23, 'Miranda', 'Sofia', 'Canales', 'Cosgrove', 'mi.00@gmail.com', 'col. Estados Unidos', '0801-1990-15655'),
(24, 'Josellyn', 'scarleth', 'Campos', 'Canales', 'sca_1@gmail.com', 'col.Las Americas', '0802-1980-44344'),
(25, 'estrella', 'Corales', 'Mar', 'Lagunas', 'lag.44@gmail.com', 'col.los oceanos', '0801-1992-67890');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `idProveedores` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idProveedores`),
  KEY `fk_Proveedores_Persona1` (`idPersona`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idProveedores`, `idPersona`, `nombre`) VALUES
(1, 21, 'Auto Suspension'),
(2, 22, 'RSA Autoparts'),
(3, 23, 'Auto Repuestos'),
(4, 24, 'American Autoparts'),
(5, 25, 'Autoparts Honduras'),
(6, 5, 'La casa del tornillo'),
(7, 15, 'Repuestos para alternador'),
(8, 19, 'Suplidora Honda'),
(9, 3, 'Todo Repuestos'),
(10, 7, 'Auto Mundo');

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
  KEY `fk_Renta_Factura1` (`idFactura`),
  KEY `fk_Renta_Vehiculo1` (`idVehiculo`),
  KEY `fk_Renta_Agenda1` (`idAgenda`)
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
  PRIMARY KEY (`idRepuestos`),
  KEY `fk_Repuestos_Inventario1` (`idInventario`),
  KEY `fk_Repuestos_MarcaRepuesto1` (`idMarcaRepuesto`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`idRepuestos`, `descripcion`, `precio`, `idInventario`, `idMarcaRepuesto`) VALUES
(1, 'Filtro de aceite', '150', 6, 1),
(2, 'Filtro de aire', '100', 6, 2),
(3, 'Bujías', '100', 6, 3),
(4, 'Bujes', '80', 6, 4),
(5, 'Llantas', '700', 6, 5),
(6, 'Aceite de motor', '150', 6, 6),
(7, 'Aceite de caja', '150', 6, 7),
(8, 'Liquido de frenos', '100', 6, 8),
(9, 'Liquido hidráulico', '150', 6, 9),
(10, 'Fricciones', '1500', 6, 10),
(11, 'Tijeras', '150', 6, 11),
(12, 'Soportes de motor', '150', 6, 12),
(13, 'Cadena de tiempo', '150', 6, 13),
(14, 'Soporte de amortiguación', '150', 6, 14),
(15, 'Dirección completa', '1500', 6, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestosmantenimiento`
--

CREATE TABLE IF NOT EXISTS `repuestosmantenimiento` (
  `idRepuestosMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idMantenimiento` int(11) NOT NULL,
  `idRepuestos` int(11) NOT NULL,
  `totalRepuestos` decimal(10,0) NOT NULL,
  PRIMARY KEY (`idRepuestosMantenimiento`),
  KEY `fk_Mantenimiento_has_Repuestos_Mantenimiento1` (`idMantenimiento`),
  KEY `fk_Mantenimiento_has_Repuestos_Repuestos1` (`idRepuestos`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `repuestosmantenimiento`
--

INSERT INTO `repuestosmantenimiento` (`idRepuestosMantenimiento`, `idMantenimiento`, `idRepuestos`, `totalRepuestos`) VALUES
(1, 1, 2, '1500'),
(2, 5, 2, '1500'),
(3, 1, 3, '1500'),
(4, 2, 3, '1500'),
(5, 15, 3, '1500'),
(6, 3, 4, '1500'),
(7, 5, 4, '1500'),
(8, 10, 4, '1500'),
(9, 4, 5, '1500'),
(10, 6, 7, '1500');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos`
--

CREATE TABLE IF NOT EXISTS `requisitos` (
  `idRequisitos` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idRequisitos`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `requisitos`
--

INSERT INTO `requisitos` (`idRequisitos`, `descripcion`) VALUES
(1, 'Tarjeta Id'),
(2, 'Permiso de Conducir'),
(3, 'Antecedentes Penales'),
(4, 'Historial de Multas'),
(5, 'Deposito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

CREATE TABLE IF NOT EXISTS `salida` (
  `idSalida` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `FechaSalida` varchar(45) DEFAULT NULL,
  `idTipoSalida` varchar(45) NOT NULL,
  PRIMARY KEY (`idSalida`),
  KEY `fk_Salida_TipoSalida1` (`idTipoSalida`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `salida`
--

INSERT INTO `salida` (`idSalida`, `descripcion`, `FechaSalida`, `idTipoSalida`) VALUES
(1, NULL, '2019-02-01', '1'),
(2, NULL, '2018-05-12', '2'),
(3, NULL, '2019-12-20', '3'),
(4, NULL, '2018-07-30', '4'),
(5, NULL, '2018-11-27', '5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudmantenimiento`
--

CREATE TABLE IF NOT EXISTS `solicitudmantenimiento` (
  `idSolicitudMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idVehiculo` int(11) NOT NULL,
  `fechaSolicitud` date NOT NULL,
  `estado` varchar(20) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  `idTipoMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idSolicitudMantenimiento`),
  KEY `fk_Vehiculo_has_Mantenimiento_Vehiculo1` (`idVehiculo`),
  KEY `fk_SolicitudMantenimiento_Empleado1` (`idEmpleado`),
  KEY `fk_SolicitudMantenimiento_TipoMantenimiento1` (`idTipoMantenimiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `solicitudmantenimiento`
--

INSERT INTO `solicitudmantenimiento` (`idSolicitudMantenimiento`, `idVehiculo`, `fechaSolicitud`, `estado`, `idEmpleado`, `idTipoMantenimiento`) VALUES
(1, 1, '2019-11-25', 'Aprobada', 1, 1),
(2, 2, '2017-10-18', 'Aprobada', 2, 2),
(3, 3, '2019-10-28', 'Aprobada', 3, 3),
(4, 4, '2016-06-06', 'Aprobada', 4, 4),
(5, 6, '2019-04-11', 'Rechazada', 5, 5),
(6, 5, '2020-01-26', 'Pendiente', 6, 6),
(7, 7, '2018-08-01', 'Rechazada', 7, 7),
(8, 8, '2016-02-15', 'Pendiente', 8, 8),
(9, 9, '2019-01-22', 'Rechazada', 9, 9),
(10, 10, '2017-07-12', 'Pendiente', 10, 10),
(11, 11, '2017-09-04', 'Rechazada', 1, 11),
(12, 13, '2017-11-20', 'Pendiente', 2, 12),
(13, 14, '2017-05-11', 'Pendiente', 3, 13),
(14, 16, '2015-11-10', 'Aprobada', 4, 14),
(15, 18, '2015-10-14', 'Aprobada', 5, 15);

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
  KEY `fk_SolicitudRenta_Cliente1` (`idCliente`),
  KEY `fk_SolicitudRenta_Vehiculo1` (`idVehiculo`),
  KEY `fk_SolicitudRenta_Agenda1` (`idAgenda`),
  KEY `fk_SolicitudRenta_Empleado1` (`idEmpleado`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `solicitudrenta`
--

INSERT INTO `solicitudrenta` (`idSolicitudRenta`, `descripcion`, `estado`, `idCliente`, `idVehiculo`, `idAgenda`, `idEmpleado`) VALUES
(1, 'renta', 'Aprobada', 1, 1, 1, 1),
(2, 'renta', 'Aprobada', 2, 3, 2, 2),
(3, 'renta', 'Rechazada', 3, 5, 3, 3),
(4, 'renta', 'Aprobada', 4, 6, 4, 4),
(5, 'renta', 'Pendiente', 5, 7, 5, 5),
(6, 'renta', 'Aprobada', 6, 8, 6, 6),
(7, 'renta', 'Rechazada', 7, 10, 7, 7),
(8, 'renta', 'Aprobada', 8, 11, 8, 8),
(9, 'renta', 'Aprobada', 9, 13, 9, 9),
(10, 'renta', 'Pendiente', 10, 14, 10, 10),
(11, 'renta', 'Aprobada', 1, 16, 1, 1),
(12, 'renta', 'Rechazada', 2, 18, 2, 2),
(13, 'renta', 'Aprobada', 3, 20, 3, 3),
(14, 'renta', 'Rechazada', 4, 3, 4, 4),
(15, 'renta', 'Rechazada', 5, 4, 5, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudrentarequisitos`
--

CREATE TABLE IF NOT EXISTS `solicitudrentarequisitos` (
  `idSolicitudRenta` int(11) NOT NULL,
  `idRequisitos` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idSolicitudRenta`,`idRequisitos`),
  KEY `fk_SolicitudRenta_has_Requisitos_Requisitos1` (`idRequisitos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `solicitudrentarequisitos`
--

INSERT INTO `solicitudrentarequisitos` (`idSolicitudRenta`, `idRequisitos`, `estado`) VALUES
(1, 1, 'Presentado'),
(1, 2, 'Pendiente'),
(2, 1, 'Pendiente'),
(3, 1, 'Presentado'),
(3, 2, 'Presentado');

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
  KEY `fk_Taller_Sucursal1` (`idSucursal`)
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
  KEY `fk_Telefonos_Persona` (`idPersona`)
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
  `idProveedores` int(11) DEFAULT NULL,
  `idVentas` varchar(45) DEFAULT NULL,
  `idRenta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTipoEntrada`),
  KEY `fk_TipoEntrada_Proveedores1` (`idProveedores`),
  KEY `fk_TipoEntrada_Ventas1` (`idVentas`),
  KEY `fk_TipoEntrada_Renta1` (`idRenta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `tipoentrada`
--

INSERT INTO `tipoentrada` (`idTipoEntrada`, `descripcion`, `idProveedores`, `idVentas`, `idRenta`) VALUES
(1, 'Devolución de Venta', NULL, '4', NULL),
(2, 'Entrada de Sucursal', NULL, NULL, NULL),
(3, 'Compra', 3, NULL, NULL);

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
(16, 'Preventivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomotor`
--

CREATE TABLE IF NOT EXISTS `tipomotor` (
  `idTipoGasolina` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`idTipoGasolina`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `tipomotor`
--

INSERT INTO `tipomotor` (`idTipoGasolina`, `descripcion`) VALUES
(1, 'Diesel'),
(2, 'Regular'),
(3, 'Superior'),
(4, 'Gas LPG'),
(5, 'Electrico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposalida`
--

CREATE TABLE IF NOT EXISTS `tiposalida` (
  `idTipoSalida` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `idVentas` varchar(45) DEFAULT NULL,
  `idRenta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTipoSalida`),
  KEY `fk_Salida_has_Ventas_Ventas1` (`idVentas`),
  KEY `fk_Salida_has_Ventas_Renta1` (`idRenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tiposalida`
--

INSERT INTO `tiposalida` (`idTipoSalida`, `descripcion`, `idVentas`, `idRenta`) VALUES
('1', 'Venta', '1', NULL),
('2', 'Devolcuion de compra', NULL, NULL),
('3', 'Salida  a Sucursal', NULL, NULL),
('4', 'Salida a Taller', NULL, NULL),
('5', 'Renta', NULL, 10);

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
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombreUsuario` varchar(45) NOT NULL,
  `contraseña` varchar(45) NOT NULL,
  `rutaImagen` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `nombreUsuario` (`nombreUsuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombreUsuario`, `contraseña`, `rutaImagen`) VALUES
(1, 'user1', '123456', NULL),
(2, 'user2', '123456', NULL),
(3, 'user3', '123456', NULL),
(4, 'user4', '123456', NULL),
(5, 'user5', '123456', NULL),
(6, 'user6', '123456', NULL),
(7, 'user7', '123456', NULL),
(8, 'user8', '123456', NULL),
(9, 'user9', '123456', NULL),
(10, 'user10', '123456', NULL),
(11, 'user11', '123456', NULL),
(12, 'user12', '123456', NULL),
(13, 'user13', '123456', NULL),
(14, 'user14', '123456', NULL),
(15, 'user15', '123456', NULL),
(16, 'user16', '123456', NULL),
(17, 'user17', '123456', NULL),
(18, 'user18', '123456', NULL),
(19, 'user19', '123456', NULL),
(20, 'user20', '123456', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `idVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `precioVenta` float NOT NULL,
  `precioRentaHora` float NOT NULL,
  `precioRentaDia` float NOT NULL,
  `placa` varchar(8) DEFAULT NULL,
  `Año` year(4) NOT NULL,
  `idModelo` int(11) NOT NULL,
  `idInventario` int(11) NOT NULL,
  `idTipoVehiculo` int(11) NOT NULL,
  `idTipoGasolina` int(11) NOT NULL,
  `idTransmision` int(11) NOT NULL,
  `idCilindraje` int(11) NOT NULL,
  PRIMARY KEY (`idVehiculo`),
  KEY `fk_Vehiculo_Modelo1` (`idModelo`),
  KEY `fk_Vehiculo_Productos1` (`idInventario`),
  KEY `fk_Vehiculo_TipoVehiculo1` (`idTipoVehiculo`),
  KEY `fk_Vehiculo_TipoMotor1` (`idTipoGasolina`),
  KEY `fk_Vehiculo_Transmision1` (`idTransmision`),
  KEY `fk_Vehiculo_Cilindraje1` (`idCilindraje`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`idVehiculo`, `descripcion`, `color`, `precioVenta`, `precioRentaHora`, `precioRentaDia`, `placa`, `Año`, `idModelo`, `idInventario`, `idTipoVehiculo`, `idTipoGasolina`, `idTransmision`, `idCilindraje`) VALUES
(1, '', 'rojo', 1000000, 100, 200, 'PCU28959', 2018, 1, 2, 1, 1, 2, 1),
(2, '', 'Negro', 1400000, 100, 200, 'LMU3325', 2017, 2, 2, 1, 2, 1, 2),
(3, '', 'Negro', 1200000, 100, 200, 'JKL90432', 2015, 3, 2, 1, 3, 3, 3),
(4, '', 'Negro', 1200000, 100, 200, 'ANM89233', 2016, 4, 2, 1, 4, 1, 4),
(5, '', 'Azul', 1300000, 100, 200, 'QUWJ2839', 2015, 5, 2, 1, 4, 1, 5),
(6, '', 'Verde', 1700000, 100, 200, 'CKL87392', 2018, 6, 2, 1, 3, 2, 5),
(7, '', 'Blanco', 1800000, 100, 200, 'PKS34940', 2017, 7, 2, 1, 2, 2, 6),
(8, '', 'Negro', 1500000, 100, 200, 'PKJUE829', 2015, 8, 2, 1, 1, 3, 7),
(9, '', 'Azul', 2000000, 100, 200, 'WERT3829', 2017, 9, 2, 1, 1, 1, 1),
(10, '', 'Blanco', 2500000, 100, 200, 'IOP00292', 2018, 10, 2, 1, 2, 1, 2),
(11, '', 'Azul', 1700000, 100, 200, 'UIE793J2', 2015, 11, 2, 1, 3, 1, 3),
(12, '', 'Negro', 1500000, 100, 200, '2YWHJD88', 2016, 12, 2, 1, 4, 1, 4),
(13, '', 'Negro', 1600000, 100, 200, 'LKI89772', 2016, 13, 2, 1, 4, 2, 5),
(14, '', 'Negro', 1500000, 100, 200, 'KLIO0383', 2018, 14, 2, 1, 3, 2, 6),
(15, '', 'Verde', 1400000, 100, 200, 'PCWHEE24', 2017, 15, 2, 1, 2, 3, 7),
(16, '', 'Verde', 1300000, 50, 200, 'JKL90432', 2015, 16, 1, 2, 1, 3, 2),
(17, '', 'Verde', 1200000, 50, 200, 'ANM89233', 2016, 17, 1, 2, 1, 2, 3),
(18, '', 'Verde', 1500000, 50, 200, 'QUWJ2839', 2016, 18, 1, 2, 2, 2, 2),
(19, '', 'Rojo', 1200000, 50, 200, 'CKL87392', 2017, 19, 1, 2, 3, 2, 2),
(20, '', 'Rojo', 1300000, 50, 200, 'PKS34940', 2015, 20, 1, 2, 4, 1, 1),
(21, '', 'Rojo', 80000, 50, 200, 'PKJUE829', 2018, 21, 7, 3, 4, 1, 2),
(22, '', 'Azul', 350000, 50, 200, 'WERT3829', 2019, 22, 7, 3, 3, 1, 4),
(23, '', 'Azul', 70000, 50, 200, 'PCWHEE24', 2016, 23, 7, 3, 2, 2, 5),
(24, '', 'Azul', 60000, 50, 200, 'KLIO0383', 2015, 24, 7, 3, 1, 1, 2),
(25, '', 'Amarillo', 500000, 500, 2000, '2YWHJD88', 2016, 25, 4, 5, 4, 1, 6),
(26, '', 'amarillo', 500000, 500, 2000, 'UIE793J2', 2017, 26, 4, 5, 3, 2, 7),
(27, '', 'Amarillo', 500000, 500, 2000, 'IOP00292', 2016, 27, 8, 5, 2, 2, 3),
(28, '', 'Amarillo', 650000, 500, 2000, 'WERT3829', 2015, 28, 9, 5, 1, 3, 2),
(29, '', 'Amarillo', 600000, 500, 2000, 'PKJUE829', 2018, 29, 8, 5, 4, 3, 2),
(30, '', 'Blanco', 1300000, 1500, 20000, 'QUWJ2839', 2015, 30, 5, 4, 2, 3, 4),
(31, '', 'Blanco', 1200000, 1200, 20000, 'KLIO0383', 2017, 30, 5, 4, 2, 3, 5),
(32, '', 'Blanco', 15000000, 1000, 20000, 'UIE793J2', 2018, 30, 5, 4, 2, 2, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE IF NOT EXISTS `ventas` (
  `idVentas` varchar(45) NOT NULL,
  `idFactura` int(11) NOT NULL,
  `idVehiculo` int(11) NOT NULL,
  PRIMARY KEY (`idVentas`),
  KEY `fk_Factura_has_Vehiculo_Factura1` (`idFactura`),
  KEY `fk_Factura_has_Vehiculo_Vehiculo1` (`idVehiculo`)
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
  ADD CONSTRAINT `fk_Cliente_Persona1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cliente_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `control`
--
ALTER TABLE `control`
  ADD CONSTRAINT `fk_Control_Empleado1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Control_Entrada1` FOREIGN KEY (`idEntrada`) REFERENCES `entrada` (`idEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Control_Inventario1` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Control_Salida1` FOREIGN KEY (`idSalida`) REFERENCES `salida` (`idSalida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `descuentofactura`
--
ALTER TABLE `descuentofactura`
  ADD CONSTRAINT `fk_Factura_has_Descuento_Descuento1` FOREIGN KEY (`idDescuento`) REFERENCES `descuento` (`idDescuento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Factura_has_Descuento_Factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `fk_Empleado_Cargo1` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`idCargo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Empleado_Persona1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Empleado_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `entrada`
--
ALTER TABLE `entrada`
  ADD CONSTRAINT `fk_Entrada_TipoEntrada1` FOREIGN KEY (`idTipoEntrada`) REFERENCES `tipoentrada` (`idTipoEntrada`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `fk_Factura_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Factura_Empleado1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Factura_FacturaMantenimiento1` FOREIGN KEY (`idFacturaMantenimiento`) REFERENCES `facturapormantenimiento` (`idFacturaMantenimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Factura_Impuesto1` FOREIGN KEY (`idImpuesto`) REFERENCES `impuesto` (`idImpuesto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `facturapormantenimiento`
--
ALTER TABLE `facturapormantenimiento`
  ADD CONSTRAINT `fk_FacturaPorMantenimiento_Mantenimiento1` FOREIGN KEY (`idMantenimiento`) REFERENCES `mantenimiento` (`idMantenimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `formapagofactura`
--
ALTER TABLE `formapagofactura`
  ADD CONSTRAINT `FK_Forma_Pago` FOREIGN KEY (`idFormaPago`) REFERENCES `formapago` (`idFormaPago`),
  ADD CONSTRAINT `FK_Factura` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`);

--
-- Filtros para la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD CONSTRAINT `fk_Fotos_Vehiculo1` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD CONSTRAINT `fk_Mantenimiento_Empleado1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Mantenimiento_SolicitudMantenimiento1` FOREIGN KEY (`idSolicitudMantenimiento`) REFERENCES `solicitudmantenimiento` (`idSolicitudMantenimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Mantenimiento_Taller1` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `fk_Modelo_Marca1` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `fk_Proveedores_Persona1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `renta`
--
ALTER TABLE `renta`
  ADD CONSTRAINT `fk_Renta_Agenda1` FOREIGN KEY (`idAgenda`) REFERENCES `agenda` (`idAgenda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Renta_Factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Renta_Vehiculo1` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `repuestos`
--
ALTER TABLE `repuestos`
  ADD CONSTRAINT `fk_Repuestos_Inventario1` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Repuestos_MarcaRepuesto1` FOREIGN KEY (`idMarcaRepuesto`) REFERENCES `marcarepuesto` (`idMarcaRepuesto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `repuestosmantenimiento`
--
ALTER TABLE `repuestosmantenimiento`
  ADD CONSTRAINT `fk_Mantenimiento_has_Repuestos_Mantenimiento1` FOREIGN KEY (`idMantenimiento`) REFERENCES `mantenimiento` (`idMantenimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Mantenimiento_has_Repuestos_Repuestos1` FOREIGN KEY (`idRepuestos`) REFERENCES `repuestos` (`idRepuestos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `salida`
--
ALTER TABLE `salida`
  ADD CONSTRAINT `fk_Salida_TipoSalida1` FOREIGN KEY (`idTipoSalida`) REFERENCES `tiposalida` (`idTipoSalida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `solicitudmantenimiento`
--
ALTER TABLE `solicitudmantenimiento`
  ADD CONSTRAINT `fk_SolicitudMantenimiento_Empleado1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SolicitudMantenimiento_TipoMantenimiento1` FOREIGN KEY (`idTipoMantenimiento`) REFERENCES `tipomantenimiento` (`idTipoMantenimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vehiculo_has_Mantenimiento_Vehiculo1` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `solicitudrenta`
--
ALTER TABLE `solicitudrenta`
  ADD CONSTRAINT `fk_SolicitudRenta_Agenda1` FOREIGN KEY (`idAgenda`) REFERENCES `agenda` (`idAgenda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SolicitudRenta_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SolicitudRenta_Empleado1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SolicitudRenta_Vehiculo1` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `solicitudrentarequisitos`
--
ALTER TABLE `solicitudrentarequisitos`
  ADD CONSTRAINT `fk_SolicitudRenta_has_Requisitos_Requisitos1` FOREIGN KEY (`idRequisitos`) REFERENCES `requisitos` (`idRequisitos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SolicitudRenta_has_Requisitos_SolicitudRenta1` FOREIGN KEY (`idSolicitudRenta`) REFERENCES `solicitudrenta` (`idSolicitudRenta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `taller`
--
ALTER TABLE `taller`
  ADD CONSTRAINT `fk_Taller_Sucursal1` FOREIGN KEY (`idSucursal`) REFERENCES `sucursal` (`idSucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `telefonos`
--
ALTER TABLE `telefonos`
  ADD CONSTRAINT `fk_Telefonos_Persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tipoentrada`
--
ALTER TABLE `tipoentrada`
  ADD CONSTRAINT `fk_TipoEntrada_Proveedores1` FOREIGN KEY (`idProveedores`) REFERENCES `proveedores` (`idProveedores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TipoEntrada_Renta1` FOREIGN KEY (`idRenta`) REFERENCES `renta` (`idRenta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TipoEntrada_Ventas1` FOREIGN KEY (`idVentas`) REFERENCES `ventas` (`idVentas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tiposalida`
--
ALTER TABLE `tiposalida`
  ADD CONSTRAINT `fk_Salida_has_Ventas_Renta1` FOREIGN KEY (`idRenta`) REFERENCES `renta` (`idRenta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Salida_has_Ventas_Ventas1` FOREIGN KEY (`idVentas`) REFERENCES `ventas` (`idVentas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `fk_Vehiculo_Cilindraje1` FOREIGN KEY (`idCilindraje`) REFERENCES `cilindraje` (`idCilindraje`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vehiculo_Modelo1` FOREIGN KEY (`idModelo`) REFERENCES `modelo` (`idModelo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vehiculo_Productos1` FOREIGN KEY (`idInventario`) REFERENCES `inventario` (`idInventario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vehiculo_TipoMotor1` FOREIGN KEY (`idTipoGasolina`) REFERENCES `tipomotor` (`idTipoGasolina`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vehiculo_TipoVehiculo1` FOREIGN KEY (`idTipoVehiculo`) REFERENCES `tipovehiculo` (`idTipoVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vehiculo_Transmision1` FOREIGN KEY (`idTransmision`) REFERENCES `transmision` (`idTransmision`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_Factura_has_Vehiculo_Factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`idFactura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Factura_has_Vehiculo_Vehiculo1` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
