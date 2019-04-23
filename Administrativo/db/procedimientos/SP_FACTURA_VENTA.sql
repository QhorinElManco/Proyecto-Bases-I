CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FACTURA_VENTA`(
    IN      pnidVehiculo                INT,
    IN      pnidCliente                 INT,
    IN      pnidEmpleado                INT,
    IN      pnidFormaPago               INT,
    IN      pnidDescuento               INT,
    OUT     pfTotal                     FLOAT,
    OUT     pbOcurreError 		        BOOLEAN,
    OUT     pcMensajeError			    VARCHAR(1000)
)
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
    WHERE idVehiculo=pnidVehiculo;

    IF vnConteo=0 THEN
        SET pcMensajeError='El vehiculo no existe';
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
           SET pfTotal=(vfSubtotal-(vfSubtotal*vfDescuento))+((vfSubtotal-(vfSubtotal*vfDescuento))*vfImpuesto);

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
    COMMIT;
    SET pbOcurreError=FALSE;
    IF pbOcurreError = FALSE THEN 
            UPDATE Vehiculo SET eliminado='1'
            where idVehiculo=pnidVehiculo;
    END if;
    SET pcMensajeError="Se agregado de forma exitosa la factura";
    LEAVE SP;
END