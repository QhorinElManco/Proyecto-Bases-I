DELIMITER $$

CREATE PROCEDURE SP_SOLICITUD_RENTA(
    IN pnidSolicitudRenta           INT,
    IN pnidVehiculo                 INT,
    IN pnidEmpleado                 INT,
    IN pnidCliente                  INT,
    IN pnidAgenda                   INT,
    IN pcAccion                     VARCHAR(10),
    IN pcEstado                      VARCHAR(10),
    OUT pbOcurreError               BOOLEAN,
    OUT pcMensajeError              VARCHAR(1000)
)
SP:BEGIN
    DECLARE vnConteo, vnSR    INT;    
    DECLARE vcTempMensajeError, vcEstado VARCHAR(1000);
    DECLARE vdFechaEntrega,vdFechaReserva DATE;
    SET vcTempMensajeError='';
    SET pbOcurreError=TRUE;
    SET vdFechaReserva=CURDATE();
    SET autocommit=0;
    START TRANSACTION;


     IF pcAccion='' OR pcAccion IS NULL THEN
        SET pcMensajeError='Se requiere el campo accion';
        LEAVE SP;
    END IF;
    IF pcAccion='AGREGAR' THEN

        IF pnidVehiculo='' OR pnidVehiculo IS NULL THEN
            SET vcTempMensajeError='Vehiculo ';
        END IF;
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Empleado');
        END IF;
        IF pnidCliente='' OR pnidCliente IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Cliente');
        END IF; 
        IF pnidAgenda='' OR pnidAgenda IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Agenda');
        END IF;
        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM vehiculo
        WHERE idVehiculo=pnidVehiculo;

        IF vnConteo=0 THEN
            SET pcMensajeError='El vehiculo que ingreso no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM empleado
        WHERE idEmpleado=pnidEmpleado;

        IF vnConteo=0 THEN
            SET pcMensajeError='El empleado que ingreso no existe';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Cliente c
        WHERE c.idCliente=pnidCliente;
                 
            IF vnConteo=0 THEN
                SET pcMensajeError='El cliente ingresado no existe'; 
                LEAVE SP;
            END IF;
        
        SELECT COUNT(*) INTO vnConteo FROM SolicitudRenta sr
        INNER JOIN Vehiculo vh ON vh.idVehiculo=sr.idVehiculo
        WHERE vh.idVehiculo=pnidVehiculo AND estado='PENDIENTE';

        IF vnConteo>0 THEN
            SET pcMensajeError="Ya tiene una solicitud pendiente";
            LEAVE SP;
        END IF;

        SELECT a.fechaEntrega INTO vdFechaEntrega FROM SolicitudRenta sr
        INNER JOIN Agenda a ON sr.idAgenda=a.idAgenda
        WHERE  sr.idSolicitudRenta=pnidSolicitudRenta;

        IF vdFechaEntrega>=vdFechaReserva THEN
            SET vcEstado="aprobada";
        ELSE
            SET vcEstado="pendiente";
            SET vdFechaEntrega=NULL;
        END IF;

        SELECT a.fechaEntrega INTO vdFechaEntrega FROM SolicitudRenta sr
        INNER JOIN Agenda a ON sr.idAgenda=a.idAgenda
        WHERE  sr.idSolicitudRenta=pnidSolicitudRenta;


        SELECT COUNT(*) INTO vnConteo FROM SolicitudRentaRequisitos srr
        INNER JOIN SolicitudRenta sr ON srr.idSolicitudRenta=sr.idSolicitudRenta
        INNER JOIN Requisitos r ON srr.idRequisitos=r.idRequisitos
        WHERE sr.idSolicitudRenta=pnidSolicitudRenta AND srr.estado='Presentado';

        IF vnConteo<5 THEN
            SET pcMensajeError='No cumple con los requisitos para la renta';
            LEAVE SP;
        END IF;

                 SELECT (MAX(idSolicitudRenta)+1) INTO vnSR FROM SolicitudRenta;

                INSERT SolicitudRenta(idSolicitudRenta, estado, idCliente,idVehiculo,idAgenda ,idEmpleado)
                VALUES (vnSR, vcEstado,pnidCliente, pnidVehiculo, pnidAgenda, pnidEmpleado);

                COMMIT;
                SET pcMensajeError='Solicitud enviada';
                SET pbOcurreError=FALSE;
                LEAVE SP;

    END IF; 

    IF pcAccion='EDITAR' THEN

        IF pnidSolicitudRenta='' OR pnidSolicitudRenta IS NULL THEN
            SET vcTempMensajeError='ID de solicitud ';
        END IF;
        IF pnidVehiculo='' OR pnidVehiculo IS NULL THEN
            SET vcTempMensajeError='Vehiculo ';
        END IF;
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError,'Empleado ');
        END IF;
        IF pnidCliente='' OR pnidCliente IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Cliente');
        END IF;
         IF pnidAgenda='' OR pnidAgenda IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Agenda');
        END IF;
        IF pcEstado='' OR pcEstado IS NULL THEN
            SET vcTempMensajeError=CONCAT(vcTempMensajeError, 'Estado');
        END IF;

        IF vcTempMensajeError<>'' THEN
            SET pcMensajeError=CONCAT('Se necesita que ingrese los siguientes campos: ', vcTempMensajeError);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM SolicitudRenta
        WHERE idSolicitudRenta=pnidSolicitudRenta;
        IF vnConteo=0 THEN
            SET pcMensajeError='La solicitud que desea editar no existe';
            LEAVE SP;
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM vehiculo
        WHERE idVehiculo=pnidVehiculo;

        IF vnConteo=0 THEN
            SET pcMensajeError="El vehiculo que ingreso no existe";
            LEAVE SP;
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Agenda
            WHERE idAgenda=pnidAgenda;

            IF vnConteo=0 THEN
                SET pcMensajeError="la agenda ingresad no existe";
                LEAVE SP;
            END IF;
            SELECT COUNT(*) INTO vnConteo FROM cliente
            WHERE idCliente=pnidCliente;

            IF vnConteo=0 THEN
                SET pcMensajeError="El cliente ingresado no existe";
                LEAVE SP;
            END IF;
         SELECT COUNT(*) INTO vnConteo FROM empleado
        WHERE idEmpleado=pnidEmpleado;

        IF vnConteo=0 THEN
            SET pcMensajeError="El empleado que ingreso no existe";
            LEAVE SP;
        END IF;
        

        UPDATE SolicitudRenta 
        SET estado=pcEstado,
            idCliente=pnidCliente,
            idVehiculo=pnidVehiculo,
            idAgenda=pnidAgenda,
            idEmpleado=pnidEmpleado
                      
        WHERE idSolicitudRenta=pnidSolicitudRenta;
        COMMIT;
        SET pcMensajeError='Se ha editado de forma correcta la solicitud';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    IF pcAccion='ELIMINAR' THEN 

        IF pnidSolicitudRenta='' OR pnidSolicitudRenta IS NULL THEN
            SET pcMensajeError='Se requiere el ID de la solicitud';
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM SolicitudRenta
        WHERE idSolicitudRenta=pnidSolicitudRenta;
        IF vnConteo=0 THEN
            SET pcMensajeError='La solicitud que desea eliminar no existe';
            LEAVE SP;
        END IF;

        DELETE FROM SolicitudRenta
        WHERE idSolicitudRenta=pnidSolicitudRenta;
        COMMIT;
        SET pcMensajeError='Se ha eliminado de forma exitosa la solicitud';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    ELSE
        SET pcMensajeError='La accion ingresada no es valida, por ingrese una accion valida. Acciones validas: AGREGAR, EDITAR, ELIMINAR';
        LEAVE SP;
    END IF;



END