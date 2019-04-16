DROP PROCEDURE IF EXISTS SP_GESTION_TALLER$$

CREATE PROCEDURE SP_GESTION_TALLER(
    IN pnidTaller       INT,
    IN pnidSucursal     INT,
    IN pcDescripcion    VARCHAR(50),
    IN pcAccion         VARCHAR(10),
    OUT pcMensajeError  VARCHAR(1000),
    OUT pbOcurreError   BOOLEAN
)
SP:BEGIN
    DECLARE vnConteo, vnidSucursal INT;
    DECLARE vcTempMensajeError VARCHAR(1000);
    SET vcTempMensajeError='';
    SET pbOcurreError=TRUE;
    SET autocommit=0;
    START TRANSACTION;
    --Validando que la accion no sea nula
    IF pcAccion='' OR pcAccion IS NULL THEN
        SET pcMensajeError='Se requiere el campo accion';
        LEAVE SP;
    END IF;
    --Accion AGREGAR
    IF pcAccion='AGREGAR' THEN
        --Validar que los parametros de entrada no sean nulos
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
        --Verificando que exista la sucursal
        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE idSucursal=pnidSucursal;
        IF vnConteo=0 THEN
            SET pcMensajeError='No existe la sucursal ingresada';
            LEAVE SP;
        END IF;
        SELECT (MAX(idTaller)+1) INTO vnConteo FROM taller;
        --Respectivo insert
        INSERT taller(idTaller, descripcion, idSucursal) VALUES (vnConteo, pcDescripcion, pnidSucursal);
        --Obteniendo el 
        COMMIT;
        SET pcMensajeError='Se ha agregado correctamente un nuevo taller';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    --Accion EDITAR
    IF pcAccion='EDITAR' THEN
        --Validar que los parametros de entrada no sean nulos
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
        --Verificando que exista el taller
        SELECT COUNT(*) INTO vnConteo FROM taller
        WHERE idTaller=pnidTaller;
        IF vnConteo=0 THEN
            SET pcMensajeError='El taller que desea editar no existe';
            LEAVE SP;
        END IF;
        --Verificar si actualizara el id Sucursal
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
        --Actualizando el registro
        UPDATE taller SET descripcion=pcDescripcion
        WHERE idTaller=pnidTaller;
        COMMIT;
        SET pcMensajeError='Se ha editado de forma correcta la sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    --Accion ELIMINAR
    IF pcAccion='ELIMINAR' THEN 
        --Validar que los parametros de entrada no sean nulos
        IF pnidTaller='' OR pnidTaller IS NULL THEN
            SET pcMensajeError='Se requiere el ID de taller';
            LEAVE SP;
        END IF;
        --Verificando que exista la sucursal
        SELECT COUNT(*) INTO vnConteo FROM taller
        WHERE idTaller=pnidTaller;
        IF vnConteo=0 THEN
            SET pcMensajeError='El taller que desea eliminar no existe';
            LEAVE SP;
        END IF;
        --Verifica si la sucursal tiene talleres
        SELECT COUNT(*) INTO vnConteo FROM mantenimiento
        WHERE idTaller=pnidTaller;
        IF vnConteo>0 THEN
            SET pcMensajeError='La sucursal tiene mantenimientos registrados y no puede ser eliminada';
            LEAVE SP;
        END IF;
        --Eliminar la sucursal
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