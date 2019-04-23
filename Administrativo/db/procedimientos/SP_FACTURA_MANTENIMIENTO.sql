DELIMITER $$

CREATE PROCEDURE SP_FACTURA_MANTENIMIENTO(
            IN      pnidFactura                 INT,
            IN      pnidCliente                 INT,
            IN      pnidEmpleado                INT,
            IN      pnidFormaPago               INT,
            IN      pnidFacturaMantenimiento    INT,
            IN      pnidDescuento               INT,
            IN      pnidImpuesto               INT,
            IN      pcAccion                    VARCHAR(45),
            OUT     pbOcurrioError 		        BOOLEAN,
		    OUT     pcMensaje			        VARCHAR(2000)


)
SP:BEGIN
        DECLARE vcConteo, vcCliente, vcEmpleado, vcFactura, vcTotal INT; 
        DECLARE vcDescuento VARCHAR(40);
        DECLARE tempMensaje VARCHAR(2000);
        SET autocommit=0;
		START TRANSACTION;
		SET tempMensaje='';
		SET pbOcurrioError=TRUE;

        IF pnidFactura='' OR pnidFactura IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'codigo de factura no puede ser nulo');
        END IF;
        IF pnidCliente='' OR pnidCliente IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de cliente no puede ser nulo');
        END IF;
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de Empleado no puede ser nulo');
        END IF;
        IF pnidFormaPago='' OR pnidFormaPago IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de forma de pago no puede ser nulo');
        END IF;
        IF pnidFacturaMantenimiento='' OR pnidFacturaMantenimiento IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de factura por mantenimiento  no puede ser nulo');
        END IF;
        IF pnidDescuento='' OR pnidDescuento IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de Descuento por mantenimiento  no puede ser nulo');
        END IF;
        IF pnidImpuesto='' OR pnidImpuesto IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de impuesto por mantenimiento  no puede ser nulo');
        END IF;
        IF pcAccion='' OR pcAccion IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Accion  no puede ser nulo');
        END IF;
        IF tempMensaje<>'' THEN
            SET pcMensaje=CONCAT('CAMPOS REQUERIDOS: ',tempMensaje);
            LEAVE SP;
        END IF;

        /*----------------------Comprobaciones de existencia------------------------*/

			SELECT COUNT(*) INTO vcConteo FROM Mantenimiento m WHERE m.idMantenimiento = pnidMantenimiento;
			IF vcConteo=0 THEN
				SET pcMensaje = 'El mantenimiento seleccionado no existe.';
				LEAVE SP;
			END IF;

			SELECT COUNT(*) INTO vcConteo FROM Descuento WHERE idDescuento = pnidDescuento;
			IF vcConteo=0  THEN
				SET pcMensaje = 'El descuento seleccionado no existe.';
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
			WHERE e.idEmpleado=pnidEmpleado
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

            SELECT COUNT(*) INTO vcConteo FROM FacturaPorMantenimiento WHERE fpm.idFacturaMantenimiento = pnidFacturaMantenimiento;
			IF vcConteo=0 THEN
				SET pcMensaje = 'El codigo factura por mantenimiento seleccionado no existe.';
				LEAVE SP;
			END IF;

			SELECT d.estado INTO vcDescuento FROM Descuento d WHERE d.idDescuento=pnidDescuento;
			 SELECT d.estado INTO vcDescuento FROM Descuento d WHERE d.idDescuento=pnidDescuento;
			 IF vcDescuento = 'I'  THEN
				SET pcMensaje='El Descuento esta inactivo';
                                LEAVE SP;
                                ELSE 
                                set pnidDescuentovcDescuento;
			
			END IF;

			

            /*-------------------Insertando---------------------------*/

			SELECT MAX(f.idFactura) INTO vcFactura FROM Factura f
			where vcFactura=vcFactura+1;

			SELECT v.idCliente INTO vcCliente FROM Mantenimiento m
			INNER JOIN SolicitudMantenimiento sm ON sm.idSolicitudMantenimiento = m.idSolicitudMantenimiento
			INNER JOIN Vehiculo v ON v.idVehiculo = sm.idVehiculo
			WHERE m.idMantenimiento = pnidMantenimiento;

             SELECT  (rm.totalRepuestos+ m.costo)-(((rm.totalRepuestos+ m.costo) * d.porcentaje)/100) + ( (((rm.totalRepuestos+ m.costo)-(((rm.totalRepuestos+ m.costo) * d.porcentaje)/100)) *15)/100 ) 
            INTO vcTotal FROM Factura f
			
			INNER JOIN FacturaPorMantenimiento fpm ON fpm.idMantenimiento = m.idMantenimiento
			INNER JOIN FacturaPorMantenimiento fpm2 ON f.idFacturaMantenimiento = fpm2.idFacturaMantenimiento
			INNER JOIN DescuentoFactura df ON df.idFactura = f.idFactura
			INNER JOIN Descuento d ON d.idDescuento = df.idDescuento
			INNER JOIN Impuesto i  ON f.idImpuesto = i.idImpuesto
            INNER JOIN RepuestosMantenimiento rm ON rm.idMantenimiento=m.idMantenimiento
			WHERE m.idMantenimiento = pnidMantenimiento;


	
			INSERT INTO Factura(idFactura, fechaEmision, Total,idCliente,idEmpleado, idImpuesto, idFacturaMantenimiento)
			VALUES(vcFactura, CURDATE(),vcTotal, vcCliente, vcEmpleado, pnidImpuesto, pnidFacturaMantenimiento);

			INSERT INTO FacturaPorMantenimiento(idFacturaMantenimiento,descripcion, idMantenimiento)
			VALUES(pnidFacturaMantenimiento, '',pnidMantenimiento);

			INSERT INTO descuentofactura(idFactura,idDescuento,fecha)
			VALUES(vcFactura,vcDescuento, CURDATE());
            		INSERT INTO formapagofactura(idFormaPago,idFactura)
			VALUES(pnidFormaPago,vcFactura);
                        COMMIT;
                    SET pcMensaje='Se ha agregado correctamente ';
                    SET pbOcurrioError=FALSE;
                    LEAVE SP;
                   
END