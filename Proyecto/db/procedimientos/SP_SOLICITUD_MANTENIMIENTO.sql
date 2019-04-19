DROP PROCEDURE IF EXISTS SP_SOLICITUD_MANTENIMIENTO$$

CREATE PROCEDURE SP_SOLICITUD_MANTENIMIENTO(
    IN pnidSolicitudMantenimiento   INT,
    IN pnidVehiculo                 INT,
    IN pnidEmpleado                 INT,
    IN pnidTipoMantenimiento        INT,
    IN pnidCliente                  INT,
    IN pdFechaFin                   DATE,
    IN pcAccion                     VARCHAR(10),
    IN pcEstado                     VARCHAR(10),
    OUT pbOcurreError               BOOLEAN,
    OUT pcMensajeError              VARCHAR(1000)
)
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
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Empleado');
        END IF;
        IF pnidTipoMantenimiento='' OR pnidTipoMantenimiento IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Tipo de mantenimiento');
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
        WHERE idVehiculo=pnidVehiculo AND estado="PENDIENTE";

        IF vnConteo>0 THEN
            SET pcMensajeError="Ya tiene una solicitud pendiente";
            LEAVE SP;
        END IF;
        --OJO ACA CARLOS
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
        --OJO ACA CARLOS
        IF pdFechaFin=vdFechaSolicitud THEN
            SET vcEstado="aprobada";
        ELSE
            SET vcEstado="pendiente";
            SET pdFechaFin=NULL;
        END IF;
        
        SELECT (MAX(idSolicitudMantenimiento)+1) INTO vnConteo FROM solicitudmantenimiento;

        INSERT solicitudmantenimiento(idSolicitudMantenimiento, idVehiculo, fechaSolicitud, fechaFin, estado, idEmpleado, idTipoMantenimiento, idCliente)
        VALUES (vnConteo, pnidVehiculo, vdFechaSolicitud, pdFechaFin, vcEstado, pnidEmpleado,pnidTipoMantenimiento, pnidCliente);
        COMMIT;
        SET pcMensajeError='Solicitud enviada';
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
        IF pcEstado="pendiente" THEN
            SET pdFechaFin=NULL;
        END IF;
        IF  pcEstado="aprobada" OR pcEstado="rechazada" THEN
            SET pdFechaFin=CURDATE();
        ELSE
            SET pcMensajeError="estado invalido";
            LEAVE SP;
        END IF;
        --OJO ACA CARLOS
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