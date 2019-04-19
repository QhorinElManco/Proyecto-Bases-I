DROP PROCEDURE IF EXISTS SP_GESTION_VEHICULO$$

CREATE PROCEDURE SP_GESTION_VEHICULO(
    IN pcDescripcion VARCHAR(45),
    IN pcColor VARCHAR(45),
    IN pfPrecioVenta FLOAT,
    IN pfPrecioRentaHora FLOAT,
    IN pfPrecioRentaDia FLOAT,
    IN pcPlaca VARCHAR(8),
    IN pyAnio YEAR,
    IN pnIdModelo INT,
    IN pnIdInventario INT,
    IN pnIdTipoVehiculo INT,
    IN pnIdTipoGasolina INT,
    IN pnIdTransmision INT,
    IN pnIdCilindraje INT,
    IN pnIdVehiculo INT,
    IN pcAccion VARCHAR(10),
    OUT pbOcurreError BOOLEAN,
    OUT pcMensajeError VARCHAR(1000)
)
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