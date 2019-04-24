-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-04-2019 a las 07:21:24
-- Versión del servidor: 5.00.15
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FACTURA_VENTA`(IN `pnidVehiculo` INT, IN `pnidCliente` INT, IN `pnidEmpleado` INT, IN `pnidFormaPago` INT, IN `pnidDescuento` INT, OUT `pfTotal` FLOAT, OUT `pbOcurreError` BOOLEAN, OUT `pcMensajeError` VARCHAR(1000))
SP:BEGIN
    DECLARE vnConteo, vnidFactura, vnidVentas, vnidTipoSalida, vnidSalida, vnidControl, vnidInventario INT;
    DECLARE vfSubtotal, vfDescuento, vfImpuesto FLOAT;
    DECLARE vcTempMensajeError VARCHAR(1000);
    SET vcTempMensajeError='';
    SET pbOcurreError=TRUE;
    SET autocommit=0;
    START TRANSACTION;
       IF pnidVehiculo='' OR pnidVehiculo IS NULL THEN
        SET vcTempMensajeError='Vehiculo ';
    END IF;
    IF pnidCliente='' OR pnidCliente IS NULL THEN
        SET vcTempMensajeError='Cliente ';
    END IF;
    IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
        SET vcTempMensajeError='Empleado ';
    END IF;
    IF pnidFormaPago='' OR pnidFormaPago IS NULL THEN
        SET vcTempMensajeError='Forma de pago ';
    END IF;
    IF vcTempMensajeError<>'' THEN
        SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
        LEAVE SP;
    END IF;
    
      
    SELECT COUNT(*) INTO vnConteo FROM vehiculo
    WHERE idVehiculo=pnidVehiculo AND eliminado=1;

    IF vnConteo>0 THEN
        SET pcMensajeError='El vehiculo no existe';
        LEAVE SP;
    END IF;

    SELECT COUNT(*) INTO vnConteo FROM vehiculo
    WHERE idVehiculo=pnidVehiculo AND (precioVenta=0 OR precioVenta IS NULL);

    IF vnConteo>0 THEN
        SET pcMensajeError='El vehiculo no esta en venta, pertenece a renta';
        LEAVE SP;
    END IF;
   
    SELECT COUNT(*) INTO vnConteo FROM ventas
    WHERE idVehiculo=pnidVehiculo;

    IF vnConteo>0 THEN
        SET pcMensajeError='Ya vehiculo ya se vendio';
        LEAVE SP;
    END IF;
   
    SELECT COUNT(*) INTO vnConteo FROM cliente
    WHERE idCliente=pnidCliente;

    IF vnConteo=0 THEN
        SET pcMensajeError='El cliente no existe, por favor haga su respectivo registro';
        LEAVE SP;
    END IF;
    
    SELECT COUNT(*) INTO vnConteo FROM empleado
    WHERE idempleado=pnidempleado;

    IF vnConteo=0 THEN
        SET pcMensajeError='El empleado no existe, por favor haga su respectivo registro';
        LEAVE SP;
    END IF;
      
    SELECT COUNT(*) INTO vnConteo FROM formapago
    WHERE idFormaPago=pnidFormaPago;

    IF vnConteo=0 THEN
        SET pcMensajeError='La forma de pago no existe';
        LEAVE SP;
    END IF;
         
    SELECT precioVenta INTO vfSubtotal FROM vehiculo
    WHERE idVehiculo=pnidVehiculo;
       
    SELECT porcentaje INTO vfDescuento FROM descuento
    WHERE idDescuento=pnidDescuento;
           SELECT porcentaje INTO vfImpuesto FROM impuesto
    WHERE idImpuesto=1;
           SET pfTotal=(vfSubtotal-(vfSubtotal*vfDescuento)+ (vfSubtotal-(vfSubtotal*vfDescuento))*vfImpuesto);

    SELECT (MAX(idFactura)+1) INTO vnidFactura FROM factura;

    INSERT factura(idFactura, fechaEmision, Total, idCliente, idEmpleado, idImpuesto, idFacturaMantenimiento)
            VALUES(vnidFactura, CURDATE(), pfTotal, pnidCliente, pnidEmpleado, 1, NULL);
 
    INSERT formapagofactura(idFormaPago, idFactura)
            VALUES(pnidFormaPago, vnidFactura);
   
    INSERT descuentofactura(idFactura, idDescuento, fecha)
            VALUES(vnidFactura, pnidDescuento, CURDATE());
    
    SELECT (MAX(idVentas)+1) INTO vnidVentas FROM ventas;

    INSERT ventas(idVentas, idFactura, idVehiculo)
            VALUES(vnidVentas, vnidFactura, pnidVehiculo);
  
    
    SELECT (MAX(idSalida)+1) INTO vnidSalida FROM salida;

    INSERT salida(idSalida, descripcion,FechaSalida,  idTipoSalida,idRenta,  idVentas)
    VALUES (vnidSalida, "Venta", CURDATE(), '1',NULL, vnidVentas );
 
    SELECT idInventario INTO vnidInventario FROM vehiculo
    WHERE idVehiculo=pnidVehiculo;

    SELECT (MAX(idControl)+1) INTO vnidControl FROM control;

    INSERT control (idControl , idInventario, idSalida, idEntrada, idEmpleado)
    VALUES (vnidControl, vnidInventario, vnidSalida, NULL, pnidEmpleado);

    UPDATE Vehiculo SET eliminado='1' where idVehiculo=pnidVehiculo;

    COMMIT;
    SET pbOcurreError=FALSE;
    SET pcMensajeError="Se agregado de forma exitosa la factura";
    LEAVE SP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GESTION_CLIENTE`(
    IN      pcpNombre           VARCHAR(45),
    IN      pcsNombre           VARCHAR(45),
    IN      pcpApellido         VARCHAR(45),
    IN      pcsApellido         VARCHAR(45),
    IN      pcCorreo            VARCHAR(45),
    IN      pcDireccion         VARCHAR(60),
    IN      pcNoIdentidad       VARCHAR(45),
    IN      pcTelefono          VARCHAR(45),
    IN      pcNombreUsuario     VARCHAR(45),
    IN      pcContrasenia       VARCHAR(45),
    IN      pcRutaImagen        VARCHAR(1000),
    IN      pcAccion            VARCHAR(100),
    IN      pnIdCliente         INT,
    OUT     pbOcurrioError       BOOLEAN,
    OUT     pcMensaje      VARCHAR(1000)



 )
SP:BEGIN

        DECLARE vnConteo, vnIdCliente, vnIdTelefono, vnIdPersona, vnIdUsuario INT;
        DECLARE tempMensaje VARCHAR(2000);
        SET autocommit=0;
		START TRANSACTION;
		SET tempMensaje='';
		SET pbOcurrioError=TRUE;

        IF pcAccion= '' OR pcAccion IS NULL THEN
            SET tempMensaje = CONCAT(tempMensaje,'Accion no puede ser nula, ');
        END IF;

        IF pcAccion = 'AGREGAR' OR pcAccion = 'EDITAR' THEN
                IF pcpNombre = '' OR pcpNombre  IS NULL THEN
                    SET tempMensaje = 'Primer nombre, ';
                END IF;
                IF pcsNombre = '' OR pcsNombre IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'Segundo nombre, ');
                END IF;
                IF pcpApellido = '' OR pcpApellido IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'primer apellido, ');
                END IF;
                IF pcsApellido = '' OR pcsApellido IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'segundo apellido, ');
                END IF;
                IF pcCorreo = '' OR pcCorreo IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'correo, ');
                END IF;
                IF pcDireccion = '' OR pcDireccion IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'direccion, ');
                END IF;
                IF pcNoIdentidad = '' OR pcNoIdentidad IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'identidad, ');
                END IF;
                IF pcTelefono = '' OR pcTelefono IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'telefono, ');
                END IF;
                IF pcNombreUsuario = '' OR pcNombreUsuario IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'nombre de usuario, ');
                END IF;
                IF pccontrasenia = '' OR pccontrasenia IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'contrasenia, ');
                END IF;
                IF pcRutaImagen = '' OR pcRutaImagen IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'ruta de la imagen, ');
                END IF;
                
                IF tempMensaje <> '' THEN
                    SET pcMensaje = CONCAT('Faltan los siguientes campos: ', tempMensaje);
                    LEAVE SP;
                END IF;
        END IF;
        IF pcAccion = 'ELIMINAR' OR pcAccion = 'EDITAR' THEN

                IF pnIdCliente = '' OR pnIdCliente IS NULL THEN
                    SET tempMensaje =  'idCliente, ';
                END IF;
                IF tempMensaje <> '' THEN
                    SET pcMensaje= CONCAT('Faltan campos requeridos: ', tempMensaje);
                END IF;

                SELECT COUNT(*) INTO vnConteo FROM Cliente c
                WHERE c.idCliente = pnIdCliente;
                IF vnConteo = 0 THEN
                    SET pcMensaje = 'idcliente no existe';
                    LEAVE SP;
                END if;

                SELECT COUNT(*) INTO vnConteo FROM Cliente c
                INNER JOIN Usuario u ON u.idUsuario = c.idUsuario
                WHERE c.idcliente = pnIdCliente;
                IF vnConteo = 0 THEN
                    SET pcMensaje = 'El Cliente no tiene usuario';
                    LEAVE SP;
                END IF;
                SELECT COUNT(*) INTO vnConteo FROM Cliente c
                INNER JOIN Persona p ON p.idPersona = c.idPersona
                INNER JOIN telefonos t ON t.idPersona = p.idPersona
                WHERE c.idCliente= pnIdCliente;
                IF vnConteo = 0 THEN
                    SET pcMensaje = 'El Cliente no tiene telefonos';
                    LEAVE SP;
                END IF;

        END IF; 

         IF pcAccion = 'AGREGAR' THEN

            SELECT COUNT(*) INTO vnConteo FROM Cliente 
            WHERE idCliente = pnIdCliente;
            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('El Cliente', pnIdCliente,' ya existe ');
                LEAVE SP; 
            END IF;

            SELECT COUNT(*) INTO vnConteo FROM Usuario 
            WHERE nombreUsuario = pcNombreUsuario;
            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('El usuario', pcNombreUsuario,' ya existe en el SI');
                LEAVE SP; 
            END IF;
                    /* si el la persona ya esta registrada con el numero de id y es empleado, la va a registrar solo en cliente y usuario*/

            SELECT COUNT(*) INTO vnConteo FROM Empleado e
            INNER JOIN persona p ON p.idPersona=e.idPersona
            WHERE p.noIdentidad=pcNoIdentidad;

            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe como empleado');
                SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;
               INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                
                 INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);
                LEAVE SP;
                    /* en caso contrario lo agregara desde la tabla persona, usuario, y cliente*/
                    ELSE
                        SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                        SELECT (MAX(p.idPersona)+1) INTO vnIdPersona FROM Persona p;
                        SELECT (MAX(t.idTelefonos)+1) INTO vnIdTelefono FROM Telefonos t;
                        SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;

                        INSERT INTO persona(idPersona,pnombre, snombre, papellido,sapellido, correo,direccion,noIdentidad) 
                        VALUES (vnIdPersona,pcpNombre, pcsNombre,pcpApellido,pcsApellido,pcCorreo,pcDireccion, pcNoIdentidad);
                
                        INSERT INTO telefonos (idTelefonos , telefono , idPersona) 
                        VALUES (vnIdTelefono,pcTelefono ,vnIdPersona);
                        
                        INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                        VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                        
                        INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                        VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);

                        COMMIT;
                        SET pcMensaje = 'Cliente agregado con exito.';
                        SET pbOcurrioError = FALSE;
                        LEAVE SP;
                    
            END IF;
            /* si la persona solo esta registrada  en la tabla persona la agregara en cliente y usuario */        
            SELECT COUNT(*) INTO vnConteo FROM persona p 
            WHERE p.noIdentidad=pcNoIdentidad;
            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe ');
                SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;
               INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                
                 INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);
                LEAVE SP;

                 /* en caso contrario lo agregara desde la tabla persona, usuario, y cliente*/
                    ELSE
                        SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                        SELECT (MAX(p.idPersona)+1) INTO vnIdPersona FROM Persona p;
                        SELECT (MAX(t.idTelefonos)+1) INTO vnIdTelefono FROM Telefonos t;
                        SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;

                        INSERT INTO persona(idPersona,pnombre, snombre, papellido,sapellido, correo,direccion,noIdentidad) 
                        VALUES (vnIdPersona,pcpNombre, pcsNombre,pcpApellido,pcsApellido,pcCorreo,pcDireccion, pcNoIdentidad);
                
                        INSERT INTO telefonos (idTelefonos , telefono , idPersona) 
                        VALUES (vnIdTelefono,pcTelefono ,vnIdPersona);
                        
                        INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                        VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                        
                        INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                        VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);

                        COMMIT;
                        SET pcMensaje = 'cliente agregado con exito.';
                        SET pbOcurrioError = FALSE;
                        LEAVE SP;
            END IF;

     END IF;

    IF pcAccion = 'EDITAR' THEN

        SELECT COUNT(*) INTO vnConteo FROM Persona 
        WHERE correo = pcCorreo;
        IF vnConteo >1 THEN
            SET pcMensaje = 'El correo existe en el sistema.';
            SET pbOcurrioError = TRUE;
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Usuario
        WHERE nombreUsuario = pcNombreUsuario;
        IF vnConteo >1 THEN
            SET pcMensaje = 'El nombre de usuario ya existe.';
            SET pbOcurrioError = TRUE;
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Persona
        WHERE noIdentidad = pcNoIdentidad;
        IF vnConteo > 1 THEN
            SET pcMensaje = 'El numero de identidad ya existe en el sistema.';
            SET pbOcurrioError = TRUE;
            LEAVE SP;
        END IF;

        SELECT p.idPersona INTO vnIdPersona FROM Persona p
        INNER JOIN Cliente c ON c.idPersona = p.idPersona
        WHERE c.idCliente=pnIdCliente;

        UPDATE persona 
        SET pnombre= pcpNombre
            ,snombre= pcsNombre
            ,papellido= pcpApellido
            ,sapellido=pcsApellido
            ,correo= pcCorreo
            ,direccion=pcDireccion
            ,noIdentidad=pcNoIdentidad
        WHERE idPersona = vnIdPersona;

        UPDATE telefonos 
        SET telefono=pcTelefono
        WHERE idPersona = vnIdPersona;

        SELECT u.idUsuario INTO vnIdUsuario FROM Usuario u
        INNER JOIN Cliente c ON c.idUsuario = u.idUsuario
        WHERE c.idcliente = pnIdCliente;

        UPDATE usuario 
        SET nombreUsuario= pcNombreUsuario
            ,contraseña= pcContrasenia
            ,rutaImagen= pcRutaImagen
        WHERE idUsuario = vnIdUsuario;
        
        SET pcMensaje = 'cliente actualizado con exito.';
        SET pbOcurrioError = FALSE;
        LEAVE SP;



    END IF;
    IF pcAccion = 'ELIMINAR' THEN

        SELECT p.idPersona INTO vnIdPersona FROM Persona p
        INNER JOIN Cliente  c ON c.idPersona = p.idPersona
        WHERE c.idCliente = pnIdCliente;

        SELECT u.idUsuario INTO vnIdUsuario FROM Usuario u
        INNER JOIN Cliente c ON c.idUsuario = u.idUsuario
        WHERE c.idCliente= pnIdCliente;

        DELETE FROM cliente
        WHERE idCliente = pnIdCliente;

        DELETE FROM telefonos
        WHERE idPersona = vnIdPersona;

        DELETE FROM Persona
        WHERE idPersona = vnIdPersona;

        DELETE FROM Usuario
        WHERE idUsuario = vnIdUsuario;
        COMMIT;
            SET pcMensaje = 'Cliente eliminado con exito.';
            SET pbOcurrioError = FALSE;
    END IF;


 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GESTION_EMPLEADO`(
    IN pcpNombre VARCHAR(45),
    IN pcsNombre VARCHAR(45),
    IN pcpApellido VARCHAR(45),
    IN pcsApellido VARCHAR(45),
    IN pcCorreo VARCHAR(45),
    IN pcDireccion VARCHAR(60),
    IN pcNoIdentidad VARCHAR(45),
    IN pcTelefono VARCHAR(45),
    IN pdFechaInicio DATE,
    IN pdFechaFin DATE,
    IN pnIdCargo INT,
    IN pcNombreUsuario VARCHAR(45),
    IN pcContrasenia VARCHAR(45),
    IN pcRutaImagen VARCHAR(1000),
    IN pnIdEmpleado INT,
    IN pcAccion VARCHAR(100),
    OUT pbOcurreError BOOLEAN,
    OUT pcMensajeError VARCHAR(1000)
)
SP:BEGIN
    DECLARE vnConteo, vnIdPersona, vnIdEmpleado, vnIdTelefonos, vnIdUsuario, vnIdPersona2,vnConteo2 INT;
    DECLARE vcMensajeTemp VARCHAR(1000);
    SET pbOcurreError = TRUE;
    SET vcMensajeTemp = '';

    SET AUTOCOMMIT=0;
    START TRANSACTION;

    IF pcAccion = 'AGREGAR' OR pcAccion = 'EDITAR' THEN
        IF pcpNombre = '' OR pcpNombre  IS NULL THEN
            SET vcMensajeTemp = 'Primer nombre, ';
        END IF;
        IF pcsNombre = '' OR pcsNombre IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'Segundo nombre, ');
        END IF;
        IF pcpApellido = '' OR pcpApellido IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'primer apellido, ');
        END IF;
        IF pcsApellido = '' OR pcsApellido IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'segundo apellido, ');
        END IF;
        IF pcCorreo = '' OR pcCorreo IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'correo, ');
        END IF;
        IF pcDireccion = '' OR pcDireccion IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'direccion, ');
        END IF;
        IF pcNoIdentidad = '' OR pcNoIdentidad IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'identidad, ');
        END IF;
        IF pcTelefono = '' OR pcTelefono IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'telefono, ');
        END IF;
        IF pdFechaInicio = '' OR pdFechaInicio IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'fecha de inicio, ');
        END IF;
        IF pdFechaFin = '' THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'fecha fin, ');
        END IF;
        IF pnIdCargo = '' OR pnIdCargo IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'cargo, ');
        END IF;
        IF pcNombreUsuario = '' OR pcNombreUsuario IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'nombre de usuario, ');
        END IF;
        IF pccontrasenia = '' OR pccontrasenia IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'contrasenia, ');
        END IF;
        IF pcRutaImagen = '' OR pcRutaImagen IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'ruta de la imagen, ');
        END IF;
        IF vcMensajeTemp <> '' THEN
            SET pcMensajeError = CONCAT('Faltan los siguientes campos: ', vcMensajeTemp);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Cargo
        WHERE idCargo = pnIdCargo;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'No existe el idCargo';
            LEAVE SP;
        END IF;
        
    END IF;
    IF pcAccion = 'ELIMINAR' OR pcAccion = 'EDITAR' THEN

        IF pnIdEmpleado = '' OR pnIdEmpleado IS NULL THEN
            SET vcMensajeTemp =  'idEmpleado, ';
        END IF;
        IF vcMensajeTemp <> '' THEN
            SET pcMensajeError = CONCAT('Faltan campos requeridos: ', vcMensajeTemp);
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Empleado
        WHERE idEmpleado = pnIdEmpleado;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'idEmpleado no existe';
            LEAVE SP;
        END if;

        SELECT COUNT(*) INTO vnConteo FROM Empleado e
        INNER JOIN Usuario u ON u.idUsuario = e.idUsuario
        WHERE e.idEmpleado = pnIdEmpleado;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'El empleado no tiene usuario';
            LEAVE SP;
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Empleado e
        INNER JOIN Persona p ON p.idPersona = e.idPersona
        INNER JOIN telefonos t ON t.idPersona = p.idPersona
        WHERE e.idEmpleado = pnIdEmpleado;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'El empleado no tiene telefonos';
            LEAVE SP;
        END IF;

    END IF;

    IF pcAccion = 'AGREGAR' THEN
        

        SELECT COUNT(*) INTO vnConteo FROM Usuario 
        WHERE nombreUsuario = pcNombreUsuario;
        IF vnConteo > 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('El usuario', pcNombreUsuario,' ya existe en el SI');
            LEAVE SP; 
        END IF;        

        SELECT idPersona, COUNT(*) INTO  vnIdPersona2, vnConteo2 FROM persona
        WHERE noIdentidad = pcNoIdentidad;
        IF vnConteo2 = 0 THEN
            INSERT INTO persona
                    (idPersona, 
                    pnombre, 
                    snombre, 
                    papellido, 
                    sapellido, 
                    correo, 
                    direccion, 
                    noIdentidad) 
            VALUES (NULL,
                    pcpNombre,
                    pcsNombre,
                    pcpApellido,
                    pcsApellido,
                    pcCorreo,
                    pcDireccion,
                    pcNoIdentidad);
            

            SELECT MAX(idPersona) INTO vnIdPersona FROM Persona;

            INSERT INTO telefonos
                        (idTelefonos
                        , telefono
                        , idPersona) 
            VALUES (NULL
                    ,pcTelefono
                    ,vnIdPersona);
            
            INSERT INTO usuario
                    (idUsuario
                    , nombreUsuario
                    , contraseña
                    , rutaImagen) 
            VALUES (NULL
                    ,pcNombreUsuario
                    ,pcContrasenia
                    ,pcRutaImagen);
            
            SELECT MAX(idUsuario) INTO vnIdUsuario FROM usuario;

            INSERT INTO empleado
                        (idEmpleado
                        , fechaInicio
                        , fechaFin
                        , idPersona
                        , idCargo
                        , idUsuario) 
            VALUES (NULL
                    ,pdFechaInicio
                    ,pdFechaFin
                    ,vnIdPersona
                    ,pnIdCargo
                    ,vnIdUsuario);
        END IF;
        IF vnConteo2 > 0 THEN
            SELECT COUNT(*) INTO vnConteo FROM Persona p
            INNER JOIN Cliente c ON c.idPersona = p.idPersona
            WHERE p.idPersona = vnIdPersona2;
            IF vnConteo = 0 THEN
                SET pbOcurreError = TRUE;
                SET pcMensajeError= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe en el SI');
                LEAVE SP;
            END IF;
            IF vnConteo > 0 THEN
                INSERT INTO usuario
                        (idUsuario
                        , nombreUsuario
                        , contraseña
                        , rutaImagen) 
                VALUES (NULL
                        ,pcNombreUsuario
                        ,pcContrasenia
                        ,pcRutaImagen);
                
                SELECT MAX(idUsuario) INTO vnIdUsuario FROM usuario;

                INSERT INTO empleado
                            (idEmpleado
                            , fechaInicio
                            , fechaFin
                            , idPersona
                            , idCargo
                            , idUsuario)
                VALUES (NULL
                        ,pdFechaInicio
                        ,pdFechaFin
                        ,vnIdPersona2
                        ,pnIdCargo
                        ,vnIdUsuario);
            END IF;
        
        END IF;


        
        
    END IF;
    IF pcAccion = 'EDITAR' THEN
        SELECT COUNT(*)-1 INTO vnConteo FROM Usuario 
        WHERE nombreUsuario = pcNombreUsuario;
        IF vnConteo > 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('El usuario', pcNombreUsuario,' ya existe en el SI');
            LEAVE SP; 
        END IF;
        SELECT COUNT(*)-1 INTO vnConteo FROM Persona
        WHERE correo = pcCorreo;
        IF vnConteo > 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('El correo', pcCorreo,' ya existe en el SI');
            LEAVE SP; 
        END IF;

        SELECT COUNT(*)-1 INTO vnConteo FROM Persona
        WHERE noIdentidad = pcNoIdentidad;
        IF vnConteo >0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe en el SI');
            LEAVE SP;
        END IF;

        SELECT p.idPersona INTO vnIdPersona FROM Persona p
        INNER JOIN Empleado e ON e.idPersona = p.idPersona
        WHERE e.idEmpleado = pnIdEmpleado;

        UPDATE empleado 
        SET fechaInicio= pdFechaInicio
            ,fechaFin= pdFechaFin
            ,idCargo= pnIdCargo 
        WHERE idEmpleado = pnIdEmpleado;

        UPDATE persona 
        SET pnombre= pcpNombre
            ,snombre= pcsNombre
            ,papellido= pcpApellido
            ,sapellido=pcsApellido
            ,correo= pcCorreo
            ,direccion=pcDireccion
            ,noIdentidad=pcNoIdentidad
        WHERE idPersona = vnIdPersona;

        UPDATE telefonos 
        SET telefono=pcTelefono
        WHERE idPersona = vnIdPersona;

        SELECT u.idUsuario INTO vnIdUsuario FROM Usuario u
        INNER JOIN Empleado e ON e.idUsuario = u.idUsuario
        WHERE e.idEmpleado = pnIdEmpleado;

        UPDATE usuario 
        SET nombreUsuario= pcNombreUsuario
            ,contraseña= pcContrasenia
            ,rutaImagen= pcRutaImagen
        WHERE idUsuario = vnIdUsuario;


    END IF;
    IF pcAccion = 'ELIMINAR' THEN

        UPDATE Empleado
        SET eliminado = TRUE
        WHERE idEmpleado = pnIdEmpleado;

        

    END IF;

    COMMIT;
    SET pcMensajeError = 'Procedimiento realizado con exito.';
    SET pbOcurreError = FALSE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GESTION_SUCURSAL`(IN `pnidSucursal` INT, IN `pcNombre` VARCHAR(50), IN `pcDireccion` VARCHAR(100), IN `pcAccion` VARCHAR(10), OUT `pcMensajeError` VARCHAR(1000), OUT `pbOcurreError` BOOLEAN)
SP:BEGIN
    DECLARE vnConteo INT;
    DECLARE vcTempMensajeError VARCHAR(1000);
    SET vcTempMensajeError='';
    SET pbOcurreError=TRUE;
    SET autocommit=0;
    START TRANSACTION;
    IF pcAccion='' OR pcAccion IS NULL THEN
        SET pcMensajeError='Se requiere el campo accion';
        LEAVE SP;
    END IF;
    IF pcAccion='AGREGAR' THEN

        IF pcNombre='' OR pcNombre IS NULL THEN
            SET vcTempMensajeError='Nombre ';
        END IF;
        IF pcDireccion='' OR pcDireccion IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Direccion');
        END IF;
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE nombre=pcNombre AND direccion=pcDireccion;
        IF vnConteo>0 THEN
            SET pcMensajeError='Ya existe una sucursal con los datos enviados';
            LEAVE SP;
        END IF;
        SELECT (MAX(idSucursal)+1) INTO vnConteo FROM sucursal;

        INSERT sucursal(idSucursal, nombre, direccion) VALUES (vnConteo, pcNombre, pcDireccion);

        COMMIT;
        SET pcMensajeError='Se ha agregado correctamente una nueva sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='EDITAR' THEN

        IF pnidSucursal='' OR pnidSucursal IS NULL THEN
            SET vcTempMensajeError='ID de Sucursal ';
        END IF;
        IF pcNombre='' OR pcNombre IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError,'Nombre ');
        END IF;
        IF pcDireccion='' OR pcDireccion IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Direccion');
        END IF;
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE idSucursal=pnidSucursal;
        IF vnConteo=0 THEN
            SET pcMensajeError='La sucursal que desea editar no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE nombre=pcNombre AND direccion=pcDireccion;
        IF vnConteo>0 THEN
            SET pcMensajeError='Ya existe una sucursal con el mismo nombre y misma direccion';
            LEAVE SP;
        END IF;

        UPDATE sucursal SET nombre=pcNombre, direccion=pcDireccion
        WHERE idSucursal=pnidSucursal;
        COMMIT;
        SET pcMensajeError='Se ha editado de forma correcta la sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='ELIMINAR' THEN 

        IF pnidSucursal='' OR pnidSucursal IS NULL THEN
            SET pcMensajeError='Se requiere el ID de Sucursal';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE idSucursal=pnidSucursal;
        IF vnConteo=0 THEN
            SET pcMensajeError='La sucursal que desea eliminar no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM taller
        WHERE idSucursal=pnidSucursal;
        IF vnConteo>0 THEN
            SET pcMensajeError='La sucursal tiene talleres y no puede ser eliminada';
            LEAVE SP;
        END IF;

        DELETE FROM sucursal
        WHERE idSucursal=pnidSucursal;
        COMMIT;
        SET pcMensajeError='Se ha eliminado de forma exitosa la sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    ELSE
        SET pcMensajeError='La accion ingresada no es valida, por ingrese una accion valida. Acciones validas: AGREGAR, EDITAR, ELIMINAR';
        LEAVE SP;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GESTION_TALLER`(IN `pnidTaller` INT, IN `pnidSucursal` INT, IN `pcDescripcion` VARCHAR(50), IN `pcAccion` VARCHAR(10), OUT `pcMensajeError` VARCHAR(1000), OUT `pbOcurreError` BOOLEAN)
SP:BEGIN
    DECLARE vnConteo, vnidSucursal INT;
    DECLARE vcTempMensajeError VARCHAR(1000);
    SET vcTempMensajeError='';
    SET pbOcurreError=TRUE;
    SET autocommit=0;
    START TRANSACTION;
    IF pcAccion='' OR pcAccion IS NULL THEN
        SET pcMensajeError='Se requiere el campo accion';
        LEAVE SP;
    END IF;
    IF pcAccion='AGREGAR' THEN

        IF pnidSucursal='' OR pnidSucursal IS NULL THEN
            SET vcTempMensajeError='ID de Sucursal ';
        END IF;
        IF pcDescripcion='' OR pcDescripcion IS NULL THEN
            SET vcTempMensajeError='Descripcion ';
        END IF;
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE idSucursal=pnidSucursal;
        IF vnConteo=0 THEN
            SET pcMensajeError='No existe la sucursal ingresada';
            LEAVE SP;
        END IF;
        SELECT (MAX(idTaller)+1) INTO vnConteo FROM taller;

        INSERT taller(idTaller, descripcion, idSucursal) VALUES (vnConteo, pcDescripcion, pnidSucursal);

        COMMIT;
        SET pcMensajeError='Se ha agregado correctamente un nuevo taller';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='EDITAR' THEN

        IF pnidTaller='' OR pnidTaller IS NULL THEN
            SET vcTempMensajeError='ID de taller ';
        END IF;
        IF pcDescripcion='' OR pcDescripcion IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError,'Descripcion ');
        END IF;
        IF pnidSucursal='' OR pnidSucursal IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError,'ID de Sucursal');
        END IF;
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM taller
        WHERE idTaller=pnidTaller;
        IF vnConteo=0 THEN
            SET pcMensajeError='El taller que desea editar no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnidSucursal FROM taller
        WHERE idTaller=pnidTaller;

        IF pnidSucursal<>vnidSucursal THEN
            SELECT COUNT(*) INTO vnConteo FROM sucursal
            WHERE idSucursal=pnidSucursal;
            IF vnConteo=0 THEN
                SET pcMensajeError='La sucursal que ha ingresado no existe';
                LEAVE SP;
            ELSE
                UPDATE taller SET descripcion=pcDescripcion, idSucursal=pnidSucursal
                WHERE idTaller=pnidTaller;
                COMMIT;
                SET pcMensajeError='Se ha editado de forma correcta la sucursal';
                SET pbOcurreError=FALSE;
                LEAVE SP;
            END IF;
        END IF;

        UPDATE taller SET descripcion=pcDescripcion
        WHERE idTaller=pnidTaller;
        COMMIT;
        SET pcMensajeError='Se ha editado de forma correcta la sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='ELIMINAR' THEN 

        IF pnidTaller='' OR pnidTaller IS NULL THEN
            SET pcMensajeError='Se requiere el ID de taller';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM taller
        WHERE idTaller=pnidTaller;
        IF vnConteo=0 THEN
            SET pcMensajeError='El taller que desea eliminar no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM mantenimiento
        WHERE idTaller=pnidTaller;
        IF vnConteo>0 THEN
            SET pcMensajeError='La sucursal tiene mantenimientos registrados y no puede ser eliminada';
            LEAVE SP;
        END IF;

        DELETE FROM taller
        WHERE idTaller=pnidTaller;
        COMMIT;
        SET pcMensajeError='Se ha eliminado de forma exitosa la sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    ELSE
        SET pcMensajeError='La accion ingresada no es valida, por ingrese una accion valida. Acciones validas: AGREGAR, EDITAR, ELIMINAR';
        LEAVE SP;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GESTION_VEHICULO`(IN `pcDescripcion` VARCHAR(45), IN `pcColor` VARCHAR(45), IN `pfPrecioVenta` FLOAT, IN `pfPrecioRentaHora` FLOAT, IN `pfPrecioRentaDia` FLOAT, IN `pcPlaca` VARCHAR(8), IN `pyAnio` YEAR, IN `pnIdModelo` INT, IN `pnIdInventario` INT, IN `pnIdTipoVehiculo` INT, IN `pnIdTipoGasolina` INT, IN `pnIdTransmision` INT, IN `pnIdCilindraje` INT, IN `pnIdVehiculo` INT, IN `pcAccion` VARCHAR(10), OUT `pbOcurreError` BOOLEAN, OUT `pcMensajeError` VARCHAR(1000))
SP:BEGIN
    DECLARE vnConteo, vnidVehiculo INT;
    DECLARE vcMensajeTem VARCHAR(50);
    SET vcMensajeTem = '';
    SET pbOcurreError = TRUE;

    SET AUTOCOMMIT = 0;
    START TRANSACTION;
    IF pcAccion = 'AGREGAR' OR pcAccion = 'EDITAR' THEN
        IF pcDescripcion = '' OR pcDescripcion IS NULL THEN
            SET vcMensajeTem = 'Descripcion, ';
        END IF;
        IF pcColor = '' OR pcColor IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'Color, ');
        END IF;
        IF pfPrecioVenta = '' OR pfPrecioVenta IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'precio venta, ');
        END IF;
        IF pfPrecioRentaHora = '' OR pfPrecioRentaHora IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'precio venta hora, ');
        END IF;
        IF pfPrecioRentaDia = '' OR pfPrecioRentaDia IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'precio venta dia, ');
        END IF;
        IF pcPlaca = '' OR pcPlaca IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'placa, ');
        END IF;
        IF pyAnio = '' OR pyAnio IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'anio, ');
        END IF;
        IF pnIdModelo = '' OR pnIdModelo IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'modelo, ');
        END IF;
        IF pnIdInventario = '' OR pnIdInventario IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'idInventario, ');
        END IF;
        IF pnIdTipoVehiculo = '' OR pnIdTipoVehiculo IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'IdTipoVehiculo, ');
        END IF;
        IF pnIdTipoGasolina = '' OR pnIdTipoGasolina IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'IdTipoGasolina, ');
        END IF;
        IF pnIdTransmision = '' OR pnIdTransmision IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'IdTransmision, ');
        END IF;
        IF pnIdCilindraje = '' OR pnIdCilindraje IS NULL THEN
            SET vcMensajeTem = CONCAT(vcMensajeTem,'IdTransmision, ');
        END IF;
        IF vcMensajeTem <> '' THEN
            SET pcMensajeError = CONCAT('Faltan campos requeridos: ',vcMensajeTem);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Modelo
        WHERE idModelo = pnIdModelo;
        IF vnConteo = 0 THEN 
            SET pcMensajeError = 'El idModelo no existe';
            LEAVE SP; 
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Inventario
        WHERE idInventario = pnIdInventario;
        IF vnConteo = 0 THEN 
            SET pcMensajeError = 'El idInventario no existe';
            LEAVE SP; 
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM TipoVehiculo
        WHERE idTipoVehiculo = pnIdTipoVehiculo;
        IF vnConteo = 0 THEN 
            SET pcMensajeError = 'El idTipoVehiculo no existe';
            LEAVE SP; 
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM TipoMotor
        WHERE idTipoGasolina = pnIdTipoGasolina;
        IF vnConteo = 0 THEN 
            SET pcMensajeError = 'El idTipoGasolina no existe';
            LEAVE SP; 
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Transmision
        WHERE idTransmision = pnIdTransmision;
        IF vnConteo = 0 THEN 
            SET pcMensajeError = 'El idTransmision no existe';
            LEAVE SP; 
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Cilindraje
        WHERE idCilindraje = pnIdCilindraje;
        IF vnConteo = 0 THEN 
            SET pcMensajeError = 'El idCilindraje no existe';
            LEAVE SP; 
        END IF;

          
    END IF;

    IF pcAccion = 'EDITAR' OR pcAccion = 'ELIMINAR' THEN

        IF pnIdVehiculo = '' OR pnIdVehiculo IS NULL THEN
            SET pcMensajeError = 'Falta campo requerido: idVehiculo';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Vehiculo
        WHERE idVehiculo = pnIdVehiculo;
        IF vnConteo = 0 THEN
            SET pcMensajeError = 'El idVehiculo no existe';
            LEAVE SP;
        END IF;

    END IF;

    IF pcAccion = 'AGREGAR' THEN
    
        SELECT COUNT(*) INTO vnConteo FROM Vehiculo
        WHERE placa = pcPlaca;
        IF vnConteo >0 THEN 
            SET pcMensajeError = 'Ya existe un vehiculo con ese numero de placa';
            LEAVE SP; 
        END IF; 

        INSERT INTO vehiculo
        (idVehiculo
        , descripcion
        , color
        , precioVenta
        , precioRentaHora
        , precioRentaDia
        , placa
        , Año
        , idModelo
        , idInventario
        , idTipoVehiculo
        , idTipoGasolina
        , idTransmision
        , idCilindraje) 
        VALUES (NULL
                ,pcDescripcion
                ,pcColor
                ,pfPrecioVenta
                ,pfPrecioRentaHora
                ,pfPrecioRentaDia
                ,pcPlaca
                ,pyAnio
                ,pnIdModelo
                ,pnIdInventario
                ,pnIdTipoVehiculo
                ,pnIdTipoGasolina
                ,pnIdTransmision
                ,pnIdCilindraje);

    END IF;

    IF pcAccion = 'EDITAR' THEN 

        UPDATE vehiculo 
        SET descripcion= pcDescripcion
            ,color= pcColor
            ,precioVenta= pfPrecioVenta
            ,precioRentaHora= pfPrecioRentaHora
            ,precioRentaDia= pfPrecioRentaDia
            ,placa= pcPlaca
            ,Año= pyAnio
            ,idModelo=pnIdModelo
            ,idInventario= pnIdInventario
            ,idTipoVehiculo=pnIdTipoVehiculo
            ,idTipoGasolina= pnIdTipoGasolina
            ,idTransmision= pnIdTransmision
            ,idCilindraje= pnIdCilindraje
        WHERE idVehiculo = pnIdVehiculo;
    END IF;
    IF pcAccion = 'ELIMINAR' THEN 
        DELETE FROM vehiculo 
        WHERE idVehiculo = pnIdVehiculo;
    END IF;
    
    COMMIT;
    SET pcMensajeError = 'Procedimiento realizado con exito.';
    SET pbOcurreError = FALSE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GESTION_VEHICULO_FOTO`(IN `pnIdVehiculo` INT, IN `pnIdFotos` INT, IN `pcDireccionEnDisco` VARCHAR(1000), IN `pcAccion` VARCHAR(45), OUT `pbOcurreError` BOOLEAN, OUT `pcMensajeError` VARCHAR(1000))
SP:BEGIN
    DECLARE vnConteo INT;
    DECLARE vcMensajeTem VARCHAR(100);
    SET vcMensajeTem = '';
    SET pbOcurreError = TRUE;

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    IF pcAccion = 'ELIMINARTODO' OR pcAccion = 'AGREGAR'  THEN
        IF pnIdVehiculo = '' OR pnIdVehiculo IS NULL THEN
            SET pcMensajeError = 'Pendiente campo requerido: idVehiculo, ';
            LEAVE SP;
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Vehiculo
        WHERE idVehiculo = pnIdVehiculo;
        IF vnConteo = 0 THEN
            SET pcMensajeError = 'El idVehiculo no existe';
            LEAVE SP;
        END IF;
    END IF;

    IF pcAccion = 'AGREGAR' OR pcAccion = 'EDITAR' THEN
        IF pcDireccionEnDisco = '' OR pcDireccionEnDisco IS NULL THEN
            SET vcMensajeTem = 'DireccionEnDisco, ';
        END IF;
        IF vcMensajeTem <> '' THEN
            SET pcMensajeError = CONCAT('Pendiente campos requeridos: ', vcMensajeTem);
            LEAVE SP;
        END IF;
        
    END IF;
    IF pcAccion = 'EDITAR' OR pcAccion = 'ELIMINAR' THEN

        IF pnIdFotos = '' OR pnIdFotos IS NULL THEN
            SET pcMensajeError = 'Pendiente campo requerido: idFoto, ';
            LEAVE SP;
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM fotos
        WHERE idFotos = pnIdFotos;
        IF vnConteo = 0 THEN
            SET pcMensajeError = 'El idFoto no existe, ';
            LEAVE SP;
        END IF;

    END IF;
    IF pcAccion = 'AGREGAR' THEN
        
        INSERT INTO fotos
                    (idFotos
                    , direccionEnDisco
                    , idVehiculo) 
        VALUES (NULL
                ,pcDireccionEnDisco
                ,pnIdVehiculo);
    END IF;

    IF pcAccion = 'EDITAR' THEN
        UPDATE fotos 
        SET direccionEnDisco=pcDireccionEnDisco
        WHERE idFotos = pnIdFotos;
    END IF;

    IF pcAccion = 'ELIMINAR' THEN
        DELETE FROM fotos 
        WHERE idFotos = pnIdFotos;
    END IF;

    IF pcAccion = 'ELIMINARTODO' THEN
        DELETE FROM fotos 
        WHERE idVehiculo = pnIdVehiculo;
    END IF;


    COMMIT;
    SET pcMensajeError = 'Procedimiento realizado con exito.';
    SET pbOcurreError = FALSE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SOLICITUD_MANTENIMIENTO`(IN `pnidSolicitudMantenimiento` INT, IN `pnidVehiculo` INT, IN `pnidEmpleado` INT, IN `pnidTipoMantenimiento` INT, IN `pnidCliente` INT, IN `pdFechaFin` DATE, IN `pcAccion` VARCHAR(10), IN `pcEstado` VARCHAR(10), OUT `pbOcurreError` BOOLEAN, OUT `pcMensajeError` VARCHAR(1000))
SP:BEGIN
    DECLARE vnConteo    INT;
    DECLARE vcTempMensajeError, vcEstado VARCHAR(1000);
    DECLARE vdFechaSolicitud, vdFechaFin DATE;
    SET vcTempMensajeError='';
    SET pbOcurreError=TRUE;
    SET vdFechaSolicitud=CURDATE();
    SET autocommit=0;
    START TRANSACTION;
    IF pcAccion='' OR pcAccion IS NULL THEN
        SET pcMensajeError='Se requiere el campo accion';
        LEAVE SP;
    END IF;
    IF pcAccion='AGREGAR' THEN
        IF pnidVehiculo='' OR pnidVehiculo IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Vehiculo');
        END IF;
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Empleado');
        END IF;
        IF pnidTipoMantenimiento='' OR pnidTipoMantenimiento IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Tipo de mantenimiento');
        END IF;      
        IF pdFechaFin='' OR pdFechaFin IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Fecha fin');
        END IF;  
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM vehiculo
        WHERE idVehiculo=pnidVehiculo;

        IF vnConteo=0 THEN
            SET pcMensajeError="El vehiculo que ingreso no existe";
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM empleado
        WHERE idEmpleado=pnidEmpleado;

        IF vnConteo=0 THEN
            SET pcMensajeError="El empleado que ingreso no existe";
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM tipomantenimiento
        WHERE idTipoMantenimiento=pnidTipoMantenimiento;

        IF vnConteo=0 THEN
            SET pcMensajeError="El tipo de mantenimiento que ingreso no existe";
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM solicitudmantenimiento
        WHERE idVehiculo=pnidVehiculo AND estado="Pendiente";

        IF vnConteo>0 THEN
            SET pcMensajeError="Ya tiene una solicitud pendiente";
            LEAVE SP;
        END IF;
        
        IF pnidCliente=0 THEN
            SET pnidCliente=NULL;
        ELSE
            SELECT COUNT(*) INTO vnConteo FROM cliente
            WHERE idCliente=pnidCliente;

            IF vnConteo=0 THEN
                SET pcMensajeError="El id de cliente ingresado no existe";
                LEAVE SP;
            END IF;
        END IF;
        
        IF pdFechaFin<vdFechaSolicitud THEN
            SET vcEstado="Pendiente";
            SET pdFechaFin=NULL;
        ELSE
            SET vcEstado="Aprobada";
        END IF;
        
        SELECT (MAX(idSolicitudMantenimiento)+1) INTO vnConteo FROM solicitudmantenimiento;

        INSERT solicitudmantenimiento(idSolicitudMantenimiento, idVehiculo, fechaSolicitud, fechaFin, estado, idEmpleado, idTipoMantenimiento, idCliente)
        VALUES (vnConteo, pnidVehiculo, vdFechaSolicitud, pdFechaFin, vcEstado, pnidEmpleado,pnidTipoMantenimiento, pnidCliente);
        COMMIT;
        SET pcMensajeError='Solicitud guardada exitosamente';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='EDITAR' THEN

        IF pnidSolicitudMantenimiento='' OR pnidSolicitudMantenimiento IS NULL THEN
            SET vcTempMensajeError='ID de solicitud ';
        END IF;
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError,'Empleado ');
        END IF;
        IF pnidTipoMantenimiento='' OR pnidTipoMantenimiento IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Tipo de mantenimiento');
        END IF;
        IF pdFechaFin='' OR pdFechaFin IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Fecha fin');
        END IF;
        IF pcEstado='' OR pcEstado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'estado');
        END IF;
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM solicitudmantenimiento
        WHERE idSolicitudMantenimiento=pnidSolicitudMantenimiento;
        IF vnConteo=0 THEN
            SET pcMensajeError='La solicitud que desea editar no existe';
            LEAVE SP;
        END IF;
        IF pcEstado="Pendiente" THEN
            SET pdFechaFin=NULL;
        END IF;
        IF  pcEstado="Aprobada" OR pcEstado="rechazada" THEN
            SET pdFechaFin=CURDATE();
        ELSE
            SET pcMensajeError="estado invalido";
            LEAVE SP;
        END IF;
        
        IF pnidCliente=0 THEN
            SET pnidCliente=NULL;
        ELSE
            SELECT COUNT(*) INTO vnConteo FROM cliente
            WHERE idCliente=pnidCliente;

            IF vnConteo=0 THEN
                SET pcMensajeError="El cliente ingresado no existe";
                LEAVE SP;
            END IF;
        END IF;

        UPDATE solicitudmantenimiento SET idEmpleado=pnidEmpleado, idTipoMantenimiento=pnidTipoMantenimiento,
                                        fechaFin=pdFechaFin, estado=pcEstado, fechaSolicitud=CURDATE(), idCliente=pnidCliente
        WHERE idSolicitudMantenimiento=pnidSolicitudMantenimiento;
        COMMIT;
        SET pcMensajeError='Se ha editado de forma correcta la solicitud';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='ELIMINAR' THEN 

        IF pnidSolicitudMantenimiento='' OR pnidSolicitudMantenimiento IS NULL THEN
            SET pcMensajeError='Se requiere el ID de la solocicitud';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM solicitudmantenimiento
        WHERE idSolicitudMantenimiento=pnidSolicitudMantenimiento;
        IF vnConteo=0 THEN
            SET pcMensajeError='La solicitud que desea eliminar no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM mantenimiento
        WHERE idSolicitudMantenimiento=pnidSolicitudMantenimiento;
        IF vnConteo>0 THEN
            SET pcMensajeError='La solicitud seleccionada esta en la tabla mantenimiento y no puede ser eliminada';
            LEAVE SP;
        END IF;

        DELETE FROM solicitudmantenimiento
        WHERE idSolicitudMantenimiento=pnidSolicitudMantenimiento;
        COMMIT;
        SET pcMensajeError='Se ha eliminado de forma exitosa la solicitud';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    ELSE
        SET pcMensajeError='La accion ingresada no es valida, por ingrese una accion valida. Acciones validas: AGREGAR, EDITAR, ELIMINAR';
        LEAVE SP;
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
  `TiempoRenta` varchar(45) NOT NULL,
  PRIMARY KEY (`idAgenda`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `agenda`
--

INSERT INTO `agenda` (`idAgenda`, `fechaReserva`, `fechaEntrega`, `fechaDevolución`, `TiempoRenta`) VALUES
(1, '2018-09-08', '2018-09-12 03:20:15', '2018-10-22 00:00:00', 'dia'),
(2, '2018-12-10', '2018-12-10 00:00:00', '2019-01-15 00:00:00', 'hora'),
(3, '2019-01-15', '2019-01-18 05:30:00', '2019-02-18 04:10:00', 'dia'),
(4, '2018-06-16', '2018-06-17 00:00:00', '2018-08-22 00:00:00', 'hora'),
(5, '2018-02-20', '2018-02-20 00:00:00', '2018-02-23 10:00:00', 'dia'),
(6, '2019-02-03', '2019-02-03 00:00:00', '2019-03-03 13:00:00', 'hora'),
(7, '2019-01-01', '2019-01-01 00:00:00', '2019-02-01 14:00:00', 'dia'),
(8, '2019-03-22', '2019-03-22 00:00:00', '2019-03-23 10:00:00', 'hora'),
(9, '2019-03-05', '2019-03-06 00:00:00', '2019-03-10 15:30:00', 'dia'),
(10, '2019-03-07', '2019-03-08 00:00:00', '2019-03-10 14:00:00', 'hora');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE IF NOT EXISTS `cargo` (
  `idCargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

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
(8, 8, NULL, 3, 8),
(9, 2, 5, NULL, 1),
(10, 2, 7, NULL, 1),
(11, 2, 8, NULL, 1),
(12, 2, 9, NULL, 3),
(13, 2, 10, NULL, 1),
(14, 1, 11, NULL, 7),
(15, 2, 12, NULL, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `descuento`
--

CREATE TABLE IF NOT EXISTS `descuento` (
  `idDescuento` int(11) NOT NULL AUTO_INCREMENT,
  `porcentaje` float NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `estado` varchar(1) NOT NULL,
  PRIMARY KEY (`idDescuento`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `descuento`
--

INSERT INTO `descuento` (`idDescuento`, `porcentaje`, `descripcion`, `estado`) VALUES
(1, 0.15, 'General', 'I'),
(2, 0.3, 'Tercera edad', 'A'),
(3, 0.5, 'Black friday', 'I'),
(4, 0.2, 'Navideño', 'I'),
(5, 0.2, 'Año nuevo', 'I'),
(6, 0.2, 'Verano', 'I'),
(7, 0.1, 'Familiares y amigos', 'A'),
(8, 0, 'Ninguno', 'A');

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
  `eliminado` tinyint(1) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `fk_Empleado_Persona1` (`idPersona`),
  KEY `fk_Empleado_Cargo1` (`idCargo`),
  KEY `fk_Empleado_Usuario1` (`idUsuario`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `fechaInicio`, `fechaFin`, `idPersona`, `idCargo`, `idUsuario`, `eliminado`) VALUES
(1, '2018-10-01', NULL, 2, 3, 1, 0),
(2, '2019-02-15', NULL, 4, 3, 2, 0),
(3, '2016-12-25', NULL, 6, 4, 3, 0),
(4, '2017-10-05', NULL, 10, 6, 4, 1),
(5, '2016-05-15', NULL, 12, 5, 5, 0),
(6, '2019-01-20', NULL, 14, 2, 6, 1),
(7, '2017-05-30', NULL, 16, 1, 7, 0),
(8, '2018-06-10', NULL, 18, 6, 8, 1),
(9, '2015-09-19', NULL, 20, 6, 9, 0),
(10, '2015-10-05', '2018-05-30', 8, 2, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrada`
--

CREATE TABLE IF NOT EXISTS `entrada` (
  `idEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `fechaEntrada` date NOT NULL,
  `idTipoEntrada` int(11) NOT NULL,
  `idProveedores` int(11) DEFAULT NULL,
  `idVentas` int(11) DEFAULT NULL,
  `idRenta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEntrada`),
  KEY `fk_TipoEntrada_Proveedores1` (`idProveedores`),
  KEY `fk_TipoEntrada_Ventas1` (`idVentas`),
  KEY `fk_TipoEntrada_Renta1` (`idRenta`),
  KEY `fk_Entrada_TipoEntrada1` (`idTipoEntrada`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `entrada`
--

INSERT INTO `entrada` (`idEntrada`, `descripcion`, `fechaEntrada`, `idTipoEntrada`, `idProveedores`, `idVentas`, `idRenta`) VALUES
(1, NULL, '2015-12-12', 1, NULL, NULL, NULL),
(2, NULL, '2018-12-05', 2, NULL, NULL, NULL),
(3, NULL, '2018-12-05', 3, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE IF NOT EXISTS `factura` (
  `idFactura` int(11) NOT NULL AUTO_INCREMENT,
  `fechaEmision` date NOT NULL,
  `Total` float NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idEmpleado` int(11) DEFAULT NULL,
  `idImpuesto` int(11) NOT NULL,
  `idFacturaMantenimiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `fk_Factura_Cliente1` (`idCliente`),
  KEY `fk_Factura_Empleado1` (`idEmpleado`),
  KEY `fk_Factura_Impuesto1` (`idImpuesto`),
  KEY `fk_Factura_FacturaMantenimiento1` (`idFacturaMantenimiento`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`idFactura`, `fechaEmision`, `Total`, `idCliente`, `idEmpleado`, `idImpuesto`, `idFacturaMantenimiento`) VALUES
(1, '2017-01-20', 1500, 1, 1, 1, 9),
(2, '2015-02-15', 1500, 2, 10, 1, NULL),
(3, '2016-03-18', 1500, 3, 9, 1, NULL),
(4, '2018-04-01', 1500, 4, 8, 1, NULL),
(5, '2019-05-19', 1500, 5, 7, 1, NULL),
(6, '2017-06-23', 1500, 6, 6, 1, NULL),
(7, '2015-07-10', 1500, 7, 5, 1, 3),
(8, '2016-08-13', 1500, 8, 4, 1, NULL),
(9, '2018-09-09', 1500, 8, 3, 1, 14),
(10, '2019-01-05', 1500, 9, 3, 1, 6),
(11, '2017-02-04', 1500, 10, 2, 1, 13),
(12, '2015-03-08', 1500, 1, 1, 1, 14),
(13, '2016-04-04', 1500, 2, 10, 1, NULL),
(14, '2018-05-11', 1500, 3, 8, 1, NULL),
(15, '2019-06-17', 1500, 4, 7, 1, NULL),
(16, '2017-07-06', 1500, 2, 9, 1, NULL),
(17, '2015-08-07', 2500, 4, 8, 1, 5),
(18, '2016-09-20', 3500, 5, 5, 1, 10),
(19, '2018-01-29', 4500, 6, 4, 1, NULL),
(26, '2019-04-21', 1288000, 1, 1, 1, NULL),
(27, '2019-04-21', 1288000, 1, 1, 1, NULL),
(28, '2019-04-21', 1840000, 5, 6, 1, NULL),
(29, '2019-04-21', 1207500, 1, 1, 1, NULL),
(30, '2019-04-21', 1150000, 1, 1, 1, NULL),
(34, '2019-04-23', -1035000, 1, 2, 1, NULL),
(32, '2019-04-23', -690000, 1, 1, 1, NULL),
(33, '2019-04-23', -747500, 6, 7, 1, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

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
  `idFormaPago` int(11) NOT NULL,
  `idFactura` int(11) NOT NULL,
  PRIMARY KEY (`idFormaPago`,`idFactura`),
  KEY `fk_FormaPago_has_Factura_Factura1` (`idFactura`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE IF NOT EXISTS `fotos` (
  `idFotos` int(11) NOT NULL AUTO_INCREMENT,
  `direccionEnDisco` varchar(1000) NOT NULL,
  `idVehiculo` int(11) NOT NULL,
  PRIMARY KEY (`idFotos`),
  UNIQUE KEY `direccionEnDisco` (`direccionEnDisco`),
  KEY `fk_Fotos_Vehiculo1` (`idVehiculo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Volcado de datos para la tabla `fotos`
--

INSERT INTO `fotos` (`idFotos`, `direccionEnDisco`, `idVehiculo`) VALUES
(1, '../assets/images/fotos/vehiculos/Mazda/Mazda Cx-3/1/1 cx33.jpg', 1),
(2, '../assets/images/fotos/vehiculos/Mazda/Mazda Cx-3/1/1 cx32.jpg', 1),
(3, '../assets/images/fotos/vehiculos/Mazda/Mazda Cx-3/1/1 cx3.jpg', 1),
(4, '../assets/images/fotos/vehiculos/Mazda/Mazda Rx-8/2/2 rx82.jpg', 2),
(5, '../assets/images/fotos/vehiculos/Mazda/Mazda Rx-8/2/2 rx8.jpg', 2),
(6, '../assets/images/fotos/vehiculos/Porsche/Porsche cayenne-platinum-edition/3/3 Porsche cayenne-platinum-edition.jpg', 3),
(7, '../assets/images/fotos/vehiculos/Porsche/Porsche cayenne-platinum-edition/3/3 Porsche cayenne-platinum-edition 3.jpg', 3),
(8, '../assets/images/fotos/vehiculos/Porsche/Porsche cayenne-platinum-edition/3/3 Porsche cayenne-platinum-edition 2.jpg', 3),
(9, '../assets/images/fotos/vehiculos/BMW/BMW X5/4/4 BMW X5.jpg', 4),
(10, '../assets/images/fotos/vehiculos/BMW/BMW X5/4/4 BMW X5 2.jpg', 4),
(11, '../assets/images/fotos/vehiculos/Honda/Honda Civic/5/5Honda Civic.png', 5),
(12, '../assets/images/fotos/vehiculos/Honda/Honda Civic/5/5 Honda Civic 2.jpg', 5),
(13, '../assets/images/fotos/vehiculos/Nissan/Nissan Navara/6/6 Nissan Navara2.jpg', 6),
(14, '../assets/images/fotos/vehiculos/Nissan/Nissan Navara/6/6 Nissan Navara.jpg', 6),
(15, '../assets/images/fotos/vehiculos/Ferrari/Ferrari 458 Italia/7/7 Ferrari 458 Italia3.jpg', 7),
(16, '../assets/images/fotos/vehiculos/Ferrari/Ferrari 458 Italia/7/7 Ferrari 458 Italia.jpg', 7),
(17, '../assets/images/fotos/vehiculos/Ferrari/Ferrari 458 Italia/7/7 Ferrari 458 Italia 2.jpg', 7),
(18, '../assets/images/fotos/vehiculos/Jaguar/Jaguar E-Pace/8/8 Jaguar E-Pace.jpg', 8),
(19, '../assets/images/fotos/vehiculos/Jaguar/Jaguar E-Pace/8/8 Jaguar E-Pace 3.jpg', 8),
(20, '../assets/images/fotos/vehiculos/Jaguar/Jaguar E-Pace/8/8 Jaguar E-Pace 2.jpg', 8),
(21, '../assets/images/fotos/vehiculos/Hummer/Hummer H3/9/9 Hummer H3.jpg', 9),
(22, '../assets/images/fotos/vehiculos/Hummer/Hummer H3/9/9 Hummer H3 3.jpg', 9),
(23, '../assets/images/fotos/vehiculos/Hummer/Hummer H3/9/9 Hummer H3 2.jpg', 9),
(24, '../assets/images/fotos/vehiculos/Lamborghini/Lamborghini Gallardo/10/9 Hummer H3.jpg', 10),
(25, '../assets/images/fotos/vehiculos/Lamborghini/Lamborghini Gallardo/10/9 Hummer H3 3.jpg', 10),
(26, '../assets/images/fotos/vehiculos/Lamborghini/Lamborghini Gallardo/10/9 Hummer H3 2.jpg', 10),
(27, '../assets/images/fotos/vehiculos/Lamborghini/Lamborghini Gallardo/10/10 Lamborghini Gallardo.jpg', 10),
(28, '../assets/images/fotos/vehiculos/Lamborghini/Lamborghini Gallardo/10/10 Lamborghini Gallardo 3.jpg', 10),
(29, '../assets/images/fotos/vehiculos/Lamborghini/Lamborghini Gallardo/10/10 Lamborghini Gallardo 2.jpg', 10),
(30, '../assets/images/fotos/vehiculos/Mercedes-Benz/Mercedez Benz Clase-G/11/11Mercedez Benz Clase-G3.jpg', 11),
(31, '../assets/images/fotos/vehiculos/Mercedes-Benz/Mercedez Benz Clase-G/11/11Mercedez Benz Clase-G2.jpg', 11),
(32, '../assets/images/fotos/vehiculos/Mercedes-Benz/Mercedez Benz Clase-G/11/11Mercedez Benz Clase-G.jpg', 11),
(33, '../assets/images/fotos/vehiculos/Toyota/Toyota Hilux/12/12 Toyota Hilux.jpg', 12),
(34, '../assets/images/fotos/vehiculos/Toyota/Toyota Hilux/12/12 Toyota Hilux 3.jpg', 12),
(35, '../assets/images/fotos/vehiculos/Toyota/Toyota Hilux/12/12 Toyota Hilux 2.jpg', 12),
(36, '../assets/images/fotos/vehiculos/Hyundai/Hyundai H-1/13/13 Hyundai H-1.jpg', 13),
(37, '../assets/images/fotos/vehiculos/Volkswagen/Volkswagen New Beetle/14/14 Volkswagen New Beetle.jpg', 14),
(38, '../assets/images/fotos/vehiculos/Volkswagen/Volkswagen New Beetle/14/14 Volkswagen New Beetle 2.jpg', 14),
(39, '../assets/images/fotos/vehiculos/Jeep/Jeep Compass/15/15 Jeep Compass.jpg', 15),
(40, '../assets/images/fotos/vehiculos/BMW/C 400 GT/16/16 C 400 GT.jpg', 16),
(41, '../assets/images/fotos/vehiculos/BMW/C 400 GT/16/16 C 400 GT 3.jpg', 16),
(42, '../assets/images/fotos/vehiculos/BMW/C 400 GT/16/16 C 400 GT 2.jpg', 16),
(43, '../assets/images/fotos/vehiculos/BMW/C 650 sport/17/17 C 650 sport.jpg', 17),
(44, '../assets/images/fotos/vehiculos/Ducati/Panigale V4/18/18 Panigale V4.jpg', 18),
(45, '../assets/images/fotos/vehiculos/Ducati/Panigale V4/18/18 Panigale V4 2.jpg', 18),
(46, '../assets/images/fotos/vehiculos/Honda/CB 100R/19/19 CB 100R.jpg', 19),
(47, '../assets/images/fotos/vehiculos/Honda/CB 100R/19/19 CB 100R 2.jpg', 19),
(48, '../assets/images/fotos/vehiculos/YAMAHA/X-MAX 400/20/20 X-MAX 400.jpg', 20),
(49, '../assets/images/fotos/vehiculos/YAMAHA/X-MAX 400/20/20 X-MAX 400 2.jpg', 20),
(50, '../assets/images/fotos/vehiculos/DINA/Buller/21/21 Buller3.jpg', 21),
(51, '../assets/images/fotos/vehiculos/DINA/Buller/21/21 Buller2.jpg', 21),
(52, '../assets/images/fotos/vehiculos/DINA/Buller/21/21 Buller.jpg', 21),
(53, '../assets/images/fotos/vehiculos/VOLVO/9800 2017/22/22 9800 2017.jpg', 22),
(54, '../assets/images/fotos/vehiculos/VOLVO/9800 2017/22/22 9800 2017 2.jpg', 22),
(55, '../assets/images/fotos/vehiculos/Mercedes-Benz/Turiclass/23/23 Turiclass.jpg', 23),
(56, '../assets/images/fotos/vehiculos/Mercedes-Benz/Turiclass/23/23 Turiclass 3.jpg', 23),
(57, '../assets/images/fotos/vehiculos/Mercedes-Benz/Turiclass/23/23 Turiclass 2.jpg', 23),
(58, '../assets/images/fotos/vehiculos/Isuzu/ELF 600 Bus/24/24 ELF 600 Bus.jpg', 24),
(59, '../assets/images/fotos/vehiculos/Isuzu/ELF 600 Bus/24/24 ELF 600 Bus 2.jpg', 24),
(60, '../assets/images/fotos/vehiculos/CATERPILLAR/Wildleder - Shovel 966K/25/25 Wildleder - Shovel 966K.jpg', 25),
(61, '../assets/images/fotos/vehiculos/CATERPILLAR/Wildleder - Shovel 966K/25/25 Wildleder - Shovel 966K 2.jpg', 25),
(62, '../assets/images/fotos/vehiculos/CATERPILLAR/CS 56/26/26CS 56.jpg', 26),
(63, '../assets/images/fotos/vehiculos/CATERPILLAR/CS 56/26/26CS 56 2.jpg', 26),
(64, '../assets/images/fotos/vehiculos/HITACHI/Graafmachine ZX135US-3/27/27 Graafmachine ZX135US-3.jpg', 27),
(65, '../assets/images/fotos/vehiculos/HITACHI/Graafmachine ZX135US-3/27/27 Graafmachine ZX135US-3 3.jpg', 27),
(66, '../assets/images/fotos/vehiculos/HITACHI/Graafmachine ZX135US-3/27/27 Graafmachine ZX135US-3 2.jpg', 27),
(67, '../assets/images/fotos/vehiculos/JOHN DEERE/6920/28/28 6920 2.jpg', 28),
(68, '../assets/images/fotos/vehiculos/JOHN DEERE/6920/28/28 6920.jpg', 28),
(69, '../assets/images/fotos/vehiculos/KOMATSU/PC110R/29/29 PC110R.JPG', 29),
(70, '../assets/images/fotos/vehiculos/KOMATSU/PC110R/29/29 PC110R 3.JPG', 29),
(71, '../assets/images/fotos/vehiculos/KOMATSU/PC110R/29/29 PC110R 2.JPG', 29),
(72, '../assets/images/fotos/vehiculos/FERRETI YATCHS/430/30/30 430.jpg', 30),
(73, '../assets/images/fotos/vehiculos/FERRETI YATCHS/430/30/30 430 4.jpg', 30),
(74, '../assets/images/fotos/vehiculos/FERRETI YATCHS/430/30/30 430 3.jpg', 30),
(75, '../assets/images/fotos/vehiculos/FERRETI YATCHS/430/30/30 430 2.jpg', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impuesto`
--

CREATE TABLE IF NOT EXISTS `impuesto` (
  `idImpuesto` int(11) NOT NULL AUTO_INCREMENT,
  `porcentaje` float NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idImpuesto`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `impuesto`
--

INSERT INTO `impuesto` (`idImpuesto`, `porcentaje`, `descripcion`) VALUES
(1, 0.15, 'ISR ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE IF NOT EXISTS `inventario` (
  `idInventario` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idInventario`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
  `costo` float NOT NULL,
  `idSolicitudMantenimiento` int(11) NOT NULL,
  PRIMARY KEY (`idMantenimiento`),
  KEY `fk_Mantenimiento_Empleado1` (`idEmpleado`),
  KEY `fk_Mantenimiento_Taller1` (`idTaller`),
  KEY `fk_Mantenimiento_SolicitudMantenimiento1` (`idSolicitudMantenimiento`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `mantenimiento`
--

INSERT INTO `mantenimiento` (`idMantenimiento`, `idEmpleado`, `idTaller`, `descripcionReparaciones`, `costo`, `idSolicitudMantenimiento`) VALUES
(1, 1, 2, 'Cambio de aceite', 1500, 1),
(2, 3, 4, 'Llantas', 1500, 2),
(3, 3, 4, 'Cambio de bujías', 1500, 3),
(4, 10, 14, 'Alineamiento', 1500, 4),
(5, 2, 8, 'Cambio de fricciones', 1500, 5),
(6, 8, 11, 'Cambio de bujes', 1500, 6),
(7, 1, 7, 'Cambio de tijeras', 1500, 7),
(8, 8, 9, 'Cambio de filtro de aire', 1500, 8),
(9, 4, 5, 'Cambio de barras estabilizadoras', 1500, 9),
(10, 8, 2, 'Cambio de rótulas', 1500, 10),
(11, 10, 10, 'Cambio de suspensión', 1500, 11),
(12, 10, 15, 'Cambio de batería', 1500, 12),
(13, 2, 13, 'Cambio de coolant', 1500, 13),
(14, 1, 4, 'Cambio de soporte', 1500, 14),
(15, 4, 7, 'Polarizado', 1500, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE IF NOT EXISTS `marca` (
  `idMarca` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

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
(29, 'PC110R', 24),
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

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
  `mora` float NOT NULL,
  `estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idRenta`),
  KEY `fk_Renta_Factura1` (`idFactura`),
  KEY `fk_Renta_Vehiculo1` (`idVehiculo`),
  KEY `fk_Renta_Agenda1` (`idAgenda`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `renta`
--

INSERT INTO `renta` (`idRenta`, `idFactura`, `idVehiculo`, `idAgenda`, `mora`, `estado`) VALUES
(1, 13, 3, 1, 0, 'D'),
(2, 14, 5, 2, 500, 'D'),
(3, 15, 7, 3, 200, 'D'),
(4, 16, 9, 4, 0, 'D'),
(5, 19, 11, 5, 0, 'D'),
(6, 20, 13, 6, 100, 'D'),
(7, 14, 15, 7, 0, 'D'),
(8, 13, 19, 8, 0, 'ND'),
(9, 16, 21, 9, 0, 'ND'),
(10, 20, 23, 10, 100, 'D'),
(11, 13, 25, 1, 0, 'D'),
(12, 19, 27, 2, 0, 'D');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestos`
--

CREATE TABLE IF NOT EXISTS `repuestos` (
  `idRepuestos` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `precio` float NOT NULL,
  `idInventario` int(11) NOT NULL,
  `idMarcaRepuesto` int(11) NOT NULL,
  PRIMARY KEY (`idRepuestos`),
  KEY `fk_Repuestos_Inventario1` (`idInventario`),
  KEY `fk_Repuestos_MarcaRepuesto1` (`idMarcaRepuesto`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `repuestos`
--

INSERT INTO `repuestos` (`idRepuestos`, `descripcion`, `precio`, `idInventario`, `idMarcaRepuesto`) VALUES
(1, 'Filtro de aceite', 150, 6, 1),
(2, 'Filtro de aire', 100, 6, 2),
(3, 'Bujías', 100, 6, 3),
(4, 'Bujes', 80, 6, 4),
(5, 'Llantas', 700, 6, 5),
(6, 'Aceite de motor', 150, 6, 6),
(7, 'Aceite de caja', 150, 6, 7),
(8, 'Liquido de frenos', 100, 6, 8),
(9, 'Liquido hidráulico', 150, 6, 9),
(10, 'Fricciones', 1500, 6, 10),
(11, 'Tijeras', 150, 6, 11),
(12, 'Soportes de motor', 150, 6, 12),
(13, 'Cadena de tiempo', 150, 6, 13),
(14, 'Soporte de amortiguación', 150, 6, 14),
(15, 'Dirección completa', 1500, 6, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repuestosmantenimiento`
--

CREATE TABLE IF NOT EXISTS `repuestosmantenimiento` (
  `idRepuestosMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idMantenimiento` int(11) NOT NULL,
  `idRepuestos` int(11) NOT NULL,
  `totalRespuestos` float NOT NULL,
  PRIMARY KEY (`idRepuestosMantenimiento`),
  KEY `fk_Mantenimiento_has_Repuestos_Mantenimiento1` (`idMantenimiento`),
  KEY `fk_Mantenimiento_has_Repuestos_Repuestos1` (`idRepuestos`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `requisitos`
--

CREATE TABLE IF NOT EXISTS `requisitos` (
  `idRequisitos` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idRequisitos`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

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
  `FechaSalida` date NOT NULL,
  `idTipoSalida` int(11) NOT NULL,
  `idVentas` int(11) DEFAULT NULL,
  `idRenta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSalida`),
  KEY `fk_Salida_has_Ventas_Ventas1` (`idVentas`),
  KEY `fk_Salida_has_Ventas_Renta1` (`idRenta`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudmantenimiento`
--

CREATE TABLE IF NOT EXISTS `solicitudmantenimiento` (
  `idSolicitudMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idVehiculo` int(11) NOT NULL,
  `fechaSolicitud` date NOT NULL,
  `fechaFin` date DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `idEmpleado` int(11) NOT NULL,
  `idTipoMantenimiento` int(11) NOT NULL,
  `idCliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSolicitudMantenimiento`),
  KEY `fk_Vehiculo_has_Mantenimiento_Vehiculo1` (`idVehiculo`),
  KEY `fk_SolicitudMantenimiento_Empleado1` (`idEmpleado`),
  KEY `fk_SolicitudMantenimiento_TipoMantenimiento1` (`idTipoMantenimiento`),
  KEY `fk_SolicitudMantenimiento_Cliente1` (`idCliente`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `solicitudmantenimiento`
--

INSERT INTO `solicitudmantenimiento` (`idSolicitudMantenimiento`, `idVehiculo`, `fechaSolicitud`, `fechaFin`, `estado`, `idEmpleado`, `idTipoMantenimiento`, `idCliente`) VALUES
(1, 1, '2019-11-25', '2019-11-25', 'Aprobada', 1, 1, NULL),
(2, 2, '2017-10-18', '2017-10-18', 'Aprobada', 2, 2, NULL),
(3, 3, '2019-10-28', '2019-10-28', 'Aprobada', 3, 3, NULL),
(4, 4, '2016-06-06', '2016-06-06', 'Aprobada', 4, 4, NULL),
(5, 6, '2019-04-11', '2019-04-11', 'Rechazada', 5, 5, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

--
-- Volcado de datos para la tabla `telefonos`
--

INSERT INTO `telefonos` (`idTelefonos`, `telefono`, `idPersona`) VALUES
(1, ' 504-9175-6813', 1),
(2, '+504-3479-3934', 2),
(3, ' 504-3137-8372', 3),
(4, '+504-9028-3159', 4),
(5, '504-9048-5832', 5),
(6, '+504-3420-1067', 6),
(7, '-9499-8923', 7),
(8, '+504-9960-6230', 8),
(9, ' 504-9163-2910', 9),
(10, '+504-3465-6776', 10),
(11, ' 504-9458-9499', 11),
(12, '+504-3375-6121', 12),
(13, '504-3065-6461', 13),
(14, '+504-9604-7135', 14),
(15, '504-3178-8316', 15),
(16, '+504-3898-3310', 16),
(17, ' 504-3329-9302, 504-9830-1714', 17),
(18, '+504-3394-3443', 18),
(19, ' 504-3341-2382, 504-3352-8853', 19),
(20, '+504-3073-5522', 20),
(21, ' 504-3535-5196', 1),
(22, '+504-3551-6763', 2),
(23, ' 504-9974-4267', 3),
(24, '+504-9199-3532', 4),
(25, ' 504-3156-2507', 5),
(26, '+504-9324-1000', 6),
(27, ' 504-9998-1647', 7),
(28, '+504-3468-2892', 8),
(29, '504-9028-3980', 9),
(30, '+504-9128-3418', 10),
(31, ' 504-3494-1250', 11),
(32, '+504-9038-4956', 12),
(33, ' 504-3076-9390', 13),
(34, '+504-3061-2589', 14),
(35, ' 504-9614-7211', 15),
(36, '+504-3147-4384', 16),
(37, ' 504-3329-9302, 504-9830-1714', 17),
(38, '+504-3673-8423', 18),
(39, ' 504-3341-2382, 504-3352-8853', 19),
(40, '+504-9946-8064', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoentrada`
--

CREATE TABLE IF NOT EXISTS `tipoentrada` (
  `idTipoEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoEntrada`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `tipoentrada`
--

INSERT INTO `tipoentrada` (`idTipoEntrada`, `descripcion`) VALUES
(1, 'Devolución de Venta'),
(2, 'Entrada de Sucursal'),
(3, 'Compra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomantenimiento`
--

CREATE TABLE IF NOT EXISTS `tipomantenimiento` (
  `idTipoMantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoMantenimiento`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tipomantenimiento`
--

INSERT INTO `tipomantenimiento` (`idTipoMantenimiento`, `descripcion`) VALUES
(1, 'Preventivo'),
(2, 'Correctivo'),
(3, 'Servicio'),
(4, 'Post-venta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipomotor`
--

CREATE TABLE IF NOT EXISTS `tipomotor` (
  `idTipoGasolina` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(20) NOT NULL,
  PRIMARY KEY (`idTipoGasolina`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

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
  PRIMARY KEY (`idTipoSalida`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tiposalida`
--

INSERT INTO `tiposalida` (`idTipoSalida`, `descripcion`) VALUES
('1', 'Venta'),
('2', 'Devolcuion de compra'),
('3', 'Salida  a Sucursal'),
('4', 'Salida a Taller'),
('5', 'Renta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipovehiculo`
--

CREATE TABLE IF NOT EXISTS `tipovehiculo` (
  `idTipoVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoVehiculo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombreUsuario`, `contraseña`, `rutaImagen`) VALUES
(1, 'user1', '123456', '../assets/images/fotos/empleados/3.jpg'),
(2, 'user2', '123456', '../assets/images/fotos/empleados/5.jpg'),
(3, 'user3', '123456', '../assets/images/fotos/empleados/9.jpg'),
(4, 'user4', '123456', '../assets/images/fotos/empleados/10.jpg'),
(5, 'user5', '123456', '../assets/images/fotos/empleados/11.png'),
(6, 'user6', '123456', '../assets/images/fotos/empleados/13.jpg'),
(7, 'user7', '123456', '../assets/images/fotos/empleados/1.jpg'),
(8, 'user8', '123456', '../assets/images/fotos/empleados/2.png'),
(9, 'user9', '123456', '../assets/images/fotos/empleados/4.jpg'),
(10, 'user10', '123456', '../assets/images/fotos/empleados/15.jpg'),
(11, 'user11', '123456 ', '../assets/images/fotos/clientes/1.jpg'),
(12, 'user12', '123456 ', '../assets/images/fotos/clientes/2.jpg'),
(13, 'user13', '123456 ', '../assets/images/fotos/clientes/3.jpg'),
(14, 'user14', '123456 ', '../assets/images/fotos/clientes/4.jpg'),
(15, 'user15', '123456 ', '../assets/images/fotos/clientes/5.jpg'),
(16, 'user16', '123456 ', '../assets/images/fotos/clientes/6.jpg'),
(17, 'user17', '123456 ', '../assets/images/fotos/clientes/7.jpg'),
(18, 'user18', '123456 ', '../assets/images/fotos/clientes/8.jpg'),
(19, 'user19', '123456 ', '../assets/images/fotos/clientes/9.jpg'),
(20, 'user20', '123456 ', '../assets/images/fotos/clientes/10.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `idVehiculo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `precioVenta` float DEFAULT NULL,
  `precioRentaHora` float DEFAULT NULL,
  `precioRentaDia` float DEFAULT NULL,
  `placa` varchar(8) DEFAULT NULL,
  `Año` year(4) NOT NULL,
  `idModelo` int(11) NOT NULL,
  `idInventario` int(11) NOT NULL,
  `idTipoVehiculo` int(11) NOT NULL,
  `idTipoGasolina` int(11) NOT NULL,
  `idTransmision` int(11) NOT NULL,
  `idCilindraje` int(11) NOT NULL,
  `eliminado` tinyint(1) NOT NULL,
  PRIMARY KEY (`idVehiculo`),
  KEY `fk_Vehiculo_Modelo1` (`idModelo`),
  KEY `fk_Vehiculo_Productos1` (`idInventario`),
  KEY `fk_Vehiculo_TipoVehiculo1` (`idTipoVehiculo`),
  KEY `fk_Vehiculo_TipoMotor1` (`idTipoGasolina`),
  KEY `fk_Vehiculo_Transmision1` (`idTransmision`),
  KEY `fk_Vehiculo_Cilindraje1` (`idCilindraje`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`idVehiculo`, `descripcion`, `color`, `precioVenta`, `precioRentaHora`, `precioRentaDia`, `placa`, `Año`, `idModelo`, `idInventario`, `idTipoVehiculo`, `idTipoGasolina`, `idTransmision`, `idCilindraje`, `eliminado`) VALUES
(1, '', 'Rojo', 1000000, 0, 0, 'PCU28959', 2018, 1, 2, 1, 1, 2, 1, 0),
(2, '', 'Negro', 0, 100, 200, 'LMU3325', 2017, 2, 2, 1, 2, 1, 2, 0),
(3, '', 'Negro', 1200000, 0, 0, 'JKL90432', 2015, 3, 2, 1, 3, 3, 3, 0),
(4, '', 'Negro', 0, 100, 200, 'ANM89233', 2016, 4, 2, 1, 4, 1, 4, 0),
(5, '', 'Azul', 1300000, 0, 0, 'QUWJ2839', 2015, 5, 2, 1, 4, 1, 5, 0),
(6, '', 'Verde', 0, 100, 200, 'CKL87392', 2018, 6, 2, 1, 3, 2, 5, 0),
(7, '', 'Blanco', 1800000, 0, 0, 'PKS34940', 2017, 7, 2, 1, 2, 2, 6, 0),
(8, '', 'Negro', 0, 100, 200, 'PKJUE829', 2015, 8, 2, 1, 1, 3, 7, 0),
(9, '', 'Azul', 2000000, 0, 0, 'WERT3829', 2017, 9, 2, 1, 1, 1, 1, 0),
(10, '', 'Blanco', 0, 100, 200, 'IOP00292', 2018, 10, 2, 1, 2, 1, 2, 0),
(11, '', 'Azul', 1700000, 0, 0, 'UIE793J2', 2015, 11, 2, 1, 3, 1, 3, 0),
(12, '', 'Negro', 0, 100, 200, '2YWHJD88', 2016, 12, 2, 1, 4, 1, 4, 0),
(13, '', 'Negro', 1600000, 0, 0, 'LKI89772', 2016, 13, 2, 1, 4, 2, 5, 0),
(14, '', 'Negro', 1500000, 0, 0, 'KLIO0383', 2018, 14, 2, 1, 3, 2, 6, 0),
(15, '', 'Verde', 0, 100, 200, 'PCWHEE24', 2017, 15, 2, 1, 2, 3, 7, 0),
(16, '', 'Verde', 1300000, 0, 0, 'JKL90432', 2015, 16, 1, 2, 1, 3, 2, 0),
(17, '', 'Verde', 0, 50, 200, 'ANM89233', 2016, 17, 1, 2, 1, 2, 3, 0),
(18, '', 'Verde', 1500000, 0, 0, 'QUWJ2839', 2016, 18, 1, 2, 2, 2, 2, 0),
(19, '', 'Rojo', 0, 50, 200, 'CKL87392', 2017, 19, 1, 2, 3, 2, 2, 0),
(20, '', 'Rojo', 1300000, 0, 0, 'PKS34940', 2015, 20, 1, 2, 4, 1, 1, 0),
(21, '', 'Rojo', 0, 50, 200, 'PKJUE829', 2018, 21, 7, 3, 4, 1, 2, 0),
(22, '', 'Azul', 350000, 0, 0, 'WERT3829', 2019, 22, 7, 3, 3, 1, 4, 0),
(23, '', 'Azul', 0, 50, 200, 'PCWHEE24', 2016, 23, 7, 3, 2, 2, 5, 0),
(24, '', 'Azul', 60000, 0, 0, 'KLIO0383', 2015, 24, 7, 3, 1, 1, 2, 0),
(25, '', 'Amarillo', 0, 500, 2000, '2YWHJD88', 2016, 25, 4, 5, 4, 1, 6, 0),
(26, '', 'amarillo', 500000, 0, 0, 'UIE793J2', 2017, 26, 4, 5, 3, 2, 7, 0),
(27, '', 'Amarillo', 0, 500, 2000, 'IOP00292', 2016, 27, 8, 5, 2, 2, 3, 0),
(28, '', 'Amarillo', 650000, 0, 0, 'WERT3829', 2015, 28, 9, 5, 1, 3, 2, 0),
(29, '', 'Amarillo', 0, 500, 2000, 'PKJUE829', 2018, 29, 8, 5, 4, 3, 2, 0),
(30, '', 'Blanco', 1300000, 0, 0, 'QUWJ2839', 2015, 30, 5, 4, 2, 3, 4, 0),
(31, '', 'Blanco', 0, 1200, 20000, 'KLIO0383', 2017, 30, 5, 4, 2, 3, 5, 0),
(32, '', 'Blanco', 0, 1000, 20000, 'UIE793J2', 2018, 30, 5, 4, 2, 2, 6, 0);

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_cliente`
--
CREATE TABLE IF NOT EXISTS `vw_cliente` (
`idPersona` int(11)
,`pnombre` varchar(45)
,`snombre` varchar(45)
,`papellido` varchar(45)
,`sapellido` varchar(45)
,`correo` varchar(45)
,`noIdentidad` varchar(45)
,`direccion` varchar(60)
,`idCliente` int(11)
,`idUsuario` int(11)
,`nombreUsuario` varchar(45)
,`contrasenia` varchar(45)
,`rutaImagen` varchar(1000)
,`telefonos` varchar(45)
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_empleados`
--
CREATE TABLE IF NOT EXISTS `vw_empleados` (
`idEmpleado` int(11)
,`pnombre` varchar(45)
,`papellido` varchar(45)
,`noIdentidad` varchar(45)
,`descripcion` varchar(45)
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_empleado_ver`
--
CREATE TABLE IF NOT EXISTS `vw_empleado_ver` (
`idEmpleado` int(11)
,`pnombre` varchar(45)
,`snombre` varchar(45)
,`papellido` varchar(45)
,`sapellido` varchar(45)
,`correo` varchar(45)
,`cargo` varchar(45)
,`noIdentidad` varchar(45)
,`direccion` varchar(60)
,`fechaInicio` date
,`fechaFin` date
,`nombreUsuario` varchar(45)
,`contrasenia` varchar(45)
,`rutaImagen` varchar(1000)
,`telefonos` text
,`idCargo` int(11)
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vw_vehiculo`
--
CREATE TABLE IF NOT EXISTS `vw_vehiculo` (
`idVehiculo` int(11)
,`color` varchar(45)
,`descripcion` varchar(45)
,`anio` year(4)
,`precioVenta` float
,`precioRentaHora` float
,`precioRentaDia` float
,`placa` varchar(8)
,`eliminado` tinyint(1)
,`idModelo` int(11)
,`idInventario` int(11)
,`idTipoVehiculo` int(11)
,`idTipoGasolina` int(11)
,`idTransmision` int(11)
,`idCilindraje` int(11)
,`modelo` varchar(45)
,`inventario` varchar(45)
,`tipovehiculo` varchar(45)
,`tipomotor` varchar(20)
,`transmision` varchar(20)
,`cilindraje` varchar(10)
);
-- --------------------------------------------------------

--
-- Estructura para la vista `vw_cliente`
--
DROP TABLE IF EXISTS `vw_cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_cliente` AS (select `p`.`idPersona` AS `idPersona`,`p`.`pnombre` AS `pnombre`,`p`.`snombre` AS `snombre`,`p`.`papellido` AS `papellido`,`p`.`sapellido` AS `sapellido`,`p`.`correo` AS `correo`,`p`.`noIdentidad` AS `noIdentidad`,`p`.`direccion` AS `direccion`,`c`.`idCliente` AS `idCliente`,`u`.`idUsuario` AS `idUsuario`,`u`.`nombreUsuario` AS `nombreUsuario`,`u`.`contraseña` AS `contrasenia`,`u`.`rutaImagen` AS `rutaImagen`,max(`t`.`telefono`) AS `telefonos` from (((`cliente` `c` join `persona` `p` on((`p`.`idPersona` = `c`.`idPersona`))) join `usuario` `u` on((`u`.`idUsuario` = `c`.`idUsuario`))) join `telefonos` `t` on((`t`.`idPersona` = `p`.`idPersona`))) group by `c`.`idCliente`,`p`.`pnombre`,`p`.`snombre`,`p`.`papellido`,`p`.`sapellido`,`p`.`correo`,`p`.`noIdentidad`,`p`.`direccion`,`u`.`nombreUsuario`,`u`.`contraseña`,`u`.`rutaImagen`);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_empleados`
--
DROP TABLE IF EXISTS `vw_empleados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_empleados` AS (select `e`.`idEmpleado` AS `idEmpleado`,`p`.`pnombre` AS `pnombre`,`p`.`papellido` AS `papellido`,`p`.`noIdentidad` AS `noIdentidad`,`c`.`descripcion` AS `descripcion` from ((`empleado` `e` join `persona` `p` on((`p`.`idPersona` = `e`.`idPersona`))) join `cargo` `c` on((`c`.`idCargo` = `e`.`idCargo`))) where (`e`.`eliminado` <> 1));

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_empleado_ver`
--
DROP TABLE IF EXISTS `vw_empleado_ver`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_empleado_ver` AS (select `e`.`idEmpleado` AS `idEmpleado`,`p`.`pnombre` AS `pnombre`,`p`.`snombre` AS `snombre`,`p`.`papellido` AS `papellido`,`p`.`sapellido` AS `sapellido`,`p`.`correo` AS `correo`,`c`.`descripcion` AS `cargo`,`p`.`noIdentidad` AS `noIdentidad`,`p`.`direccion` AS `direccion`,`e`.`fechaInicio` AS `fechaInicio`,`e`.`fechaFin` AS `fechaFin`,`u`.`nombreUsuario` AS `nombreUsuario`,`u`.`contraseña` AS `contrasenia`,`u`.`rutaImagen` AS `rutaImagen`,group_concat(`t`.`telefono` separator ',') AS `telefonos`,`c`.`idCargo` AS `idCargo` from ((((`empleado` `e` join `persona` `p` on((`p`.`idPersona` = `e`.`idPersona`))) join `cargo` `c` on((`c`.`idCargo` = `e`.`idCargo`))) join `usuario` `u` on((`u`.`idUsuario` = `e`.`idUsuario`))) join `telefonos` `t` on((`t`.`idPersona` = `p`.`idPersona`))) where (`e`.`eliminado` <> 1) group by `e`.`idEmpleado`,`p`.`pnombre`,`p`.`snombre`,`p`.`papellido`,`p`.`sapellido`,`p`.`correo`,`c`.`descripcion`,`p`.`noIdentidad`,`p`.`direccion`,`e`.`fechaInicio`,`e`.`fechaFin`,`u`.`nombreUsuario`,`u`.`contraseña`,`u`.`rutaImagen`,`c`.`idCargo`);

-- --------------------------------------------------------

--
-- Estructura para la vista `vw_vehiculo`
--
DROP TABLE IF EXISTS `vw_vehiculo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_vehiculo` AS (select `v`.`idVehiculo` AS `idVehiculo`,`v`.`color` AS `color`,`v`.`descripcion` AS `descripcion`,`v`.`Año` AS `anio`,`v`.`precioVenta` AS `precioVenta`,`v`.`precioRentaHora` AS `precioRentaHora`,`v`.`precioRentaDia` AS `precioRentaDia`,`v`.`placa` AS `placa`,`v`.`eliminado` AS `eliminado`,`v`.`idModelo` AS `idModelo`,`v`.`idInventario` AS `idInventario`,`v`.`idTipoVehiculo` AS `idTipoVehiculo`,`v`.`idTipoGasolina` AS `idTipoGasolina`,`v`.`idTransmision` AS `idTransmision`,`v`.`idCilindraje` AS `idCilindraje`,`m`.`descripcion` AS `modelo`,`i`.`descripcion` AS `inventario`,`tv`.`descripcion` AS `tipovehiculo`,`tm`.`descripcion` AS `tipomotor`,`t`.`descripcion` AS `transmision`,`c`.`descripcion` AS `cilindraje` from ((((((`vehiculo` `v` join `modelo` `m` on((`m`.`idModelo` = `v`.`idModelo`))) join `inventario` `i` on((`i`.`idInventario` = `v`.`idInventario`))) join `tipovehiculo` `tv` on((`tv`.`idTipoVehiculo` = `v`.`idTipoVehiculo`))) join `tipomotor` `tm` on((`tm`.`idTipoGasolina` = `v`.`idTipoGasolina`))) join `transmision` `t` on((`t`.`idTransmision` = `v`.`idTransmision`))) join `cilindraje` `c` on((`c`.`idCilindraje` = `v`.`idCilindraje`))) where (`v`.`eliminado` <> 1));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
