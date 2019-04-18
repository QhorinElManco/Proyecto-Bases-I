DROP PROCEDURE IF EXISTS SP_GESTION_BUSQUEDA_VEHICULO$$

CREATE PROCEDURE SP_GESTION_BUSQUEDA_VEHICULO(
    IN pnIdMarca INT,
    IN pnIdModelo INT,
    IN pyAnio YEAR,
    IN pfPrecioInicial INT,
    IN pfPrecioFin INT,
    OUT pcvehiculos VARCHAR(100)
)
SP:BEGIN
    DECLARE vcIdVehiculos VARCHAR(100);

    SET AUTOCOMMIT = 0;
    START TRANSACTION;
    SELECT GROUP_CONCAT(v.idVehiculo) INTO vcIdVehiculos FROM Vehiculo v
    WHERE v.idModelo LIKE CONCAT('%', pnIdModelo, '%') AND
          v.año LIKE CONCAT('%', pyAnio, '%') AND
          v.precioVenta >= pfPrecioInicial AND v.precioVenta <= pfPrecioFin;

    SET pcvehiculos = vcIdVehiculos;
    COMMIT;
END$$