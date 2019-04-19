DROP PROCEDURE IF EXISTS SP_GESTION_VEHICULO_FOTO$$ 

CREATE PROCEDURE SP_GESTION_VEHICULO_FOTO(
    IN pnIdVehiculo INT,
    IN pnIdFotos INT,
    IN pcDireccionEnDisco VARCHAR(45),
    IN pcAccion VARCHAR(45),
    OUT pbOcurreError BOOLEAN,
    OUT pcMensajeError VARCHAR(1000)
)
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