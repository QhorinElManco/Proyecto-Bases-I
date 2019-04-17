DROP PROCEDURE IF EXISTS SP_GESTION_SUCURSAL$$

CREATE PROCEDURE SP_GESTION_SUCURSAL(
    IN pnidSucursal     INT,
    IN pcNombre         VARCHAR(50),
    IN pcDireccion      VARCHAR(100),
    IN pcAccion         VARCHAR(10),
    OUT pcMensajeError  VARCHAR(1000),
    OUT pbOcurreError   BOOLEAN
)
SP:BEGIN
    DECLARE vnConteo INT;
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
        --Verificando que no existan los valores a ingresar
        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE nombre=pcNombre AND direccion=pcDireccion;
        IF vnConteo>0 THEN
            SET pcMensajeError='Ya existe una sucursal con los datos enviados';
            LEAVE SP;
        END IF;
        SELECT (MAX(idSucursal)+1) INTO vnConteo FROM sucursal;
        --Respectivo insert
        INSERT sucursal(idSucursal, nombre, direccion) VALUES (vnConteo, pcNombre, pcDireccion);
        --Obteniendo el 
        COMMIT;
        SET pcMensajeError='Se ha agregado correctamente una nueva sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    --Accion EDITAR
    IF pcAccion='EDITAR' THEN
        --Validar que los parametros de entrada no sean nulos
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
        --Verificando que exista la sucursal
        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE idSucursal=pnidSucursal;
        IF vnConteo=0 THEN
            SET pcMensajeError='La sucursal que desea editar no existe';
            LEAVE SP;
        END IF;
        --Verificando que no se repita el nombre y direccion
        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE nombre=pcNombre AND direccion=pcDireccion;
        IF vnConteo>0 THEN
            SET pcMensajeError='Ya existe una sucursal con el mismo nombre y misma direccion';
            LEAVE SP;
        END IF;
        --Actualizando el registro
        UPDATE sucursal SET nombre=pcNombre, direccion=pcDireccion
        WHERE idSucursal=pnidSucursal;
        COMMIT;
        SET pcMensajeError='Se ha editado de forma correcta la sucursal';
        SET pbOcurreError=FALSE;
        LEAVE SP;
    END IF;
    --Accion ELIMINAR
    IF pcAccion='ELIMINAR' THEN 
        --Validar que los parametros de entrada no sean nulos
        IF pnidSucursal='' OR pnidSucursal IS NULL THEN
            SET pcMensajeError='Se requiere el ID de Sucursal';
            LEAVE SP;
        END IF;
        --Verificando que exista la sucursal
        SELECT COUNT(*) INTO vnConteo FROM sucursal
        WHERE idSucursal=pnidSucursal;
        IF vnConteo=0 THEN
            SET pcMensajeError='La sucursal que desea eliminar no existe';
            LEAVE SP;
        END IF;
        --Verifica si la sucursal tiene talleres
        SELECT COUNT(*) INTO vnConteo FROM taller
        WHERE idSucursal=pnidSucursal;
        IF vnConteo>0 THEN
            SET pcMensajeError='La sucursal tiene talleres y no puede ser eliminada';
            LEAVE SP;
        END IF;
        --Eliminar la sucursal
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