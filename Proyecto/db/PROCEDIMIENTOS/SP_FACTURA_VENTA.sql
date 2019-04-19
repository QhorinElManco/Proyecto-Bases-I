DELIMITER $$

CREATE PROCEDURE SP_FACTURA_VENTA(
            IN      pnidFactura                 INT,
            IN      pnidCliente                 INT,
            IN      pnidEmpleado                INT,
            IN      pnidFormaPago               INT,
            IN      pnidDescuento               INT,
            IN      pnidVentas                  INT,
            IN      pnidVehiculo                INT,
            OUT     pbOcurrioError 		        BOOLEAN,
		    OUT     pcMensaje			        VARCHAR(2000)


)
SP:BEGIN
        DECLARE vcConteo, vnFactura, vnSalida, vnTipoSalida, vnVentas, vnTotal INT;
        DECLARE vcDescuento VARCHAR(5);
        DECLARE tempMensaje VARCHAR(2000);
        SET autocommit=0;
		START TRANSACTION;
		SET tempMensaje='';
		SET pbOcurrioError=TRUE;

        IF pnidFactura='' OR pnidFactura IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,' factura no puede ser nulo');
        END IF;
        
        IF pnidCliente='' OR pnidCliente IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Cliente no puede ser nulo');
        END IF;
        
        IF pnidEmpleado='' OR pnidEmpleado IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,' empleado no puede ser nulo');
        END IF;
        
       IF pnidFormaPago='' OR pnidFormaPago IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,' forma de pago no puede ser nulo');
        END IF;
        IF pnidDescuento='' OR pnidDescuento IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Descuento por mantenimiento  no puede ser nulo');
        END IF;
        IF pnidImpuesto='' OR pnidImpuesto IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Codigo de impuesto por mantenimiento  no puede ser nulo');
        END IF;
        IF pnidVentas='' OR pnidVentas IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'venta   no puede ser nulo');
        END IF;
         IF tempMensaje<>'' THEN
            SET pcMensaje=CONCAT('CAMPOS REQUERIDOS: ',tempMensaje);
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
			WHERE e.idEmpleado=pnidEmpleado;
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

            SELECT d.estado INTO vcDescuento FROM Descuento d WHERE d.idDescuento=pnidDescuento;
			 IF vcDescuento = 'I'  THEN
				SET pcMensaje='El Descuento esta inactivo';
                                LEAVE SP;
                                ELSE 
                                set pnidDescuentovcDescuento;
			
			END IF;

            SELECT (MAX(f.idFactura)+1) INTO vnFactura FROM Factura f;
            SELECT (MAX(v.idVentas)+1) INTO vnVentas FROM Ventas v;
            SELECT (MAX(ts.idTipoSalida)+1) INTO vnTipoSalida FROM TipoSalida ts;
            SELECT (MAX(s.idSalida)+1) INTO vnSalida FROM Salida s;

            SELECT ( vh.precioVenta-((vh.precioVenta * d.porcentaje)/100) + ( ((vh.precioVenta-((vh.precioVenta * d.porcentaje)/100)) *15)/100 ))  INTO vnTotal FROM venta v
            INNER JOIN vehiculo vh ON vh.idVehiculo=v.idVehiculo
            INNER JOIN Factura f ON f.idFactura=v.idFactura
            INNER JOIN DescuentoFactura df ON df.idFactura = f.idFactura
			INNER JOIN Descuento d ON d.idDescuento = df.idDescuento
			INNER JOIN Impuesto i  ON f.idImpuesto = i.idImpuesto
            WHERE v.idVehiculo=pnidVehiculo;


            SELECT COUNT(*) INTO vcConteo FROM  venta v
            INNER JOIN vehiculo vh ON v.idVehiculo=vh.idVehiculo
            INNER JOIN TipoSalida ts ON ts.idVentas=v.idVentas
            WHERE vh.idVehiculo=pnidVehiculo AND  ts.descripcion='Venta';

            IF vcConteo>=1 THEN
                SET pcMensaje='El auto ya esta vendido';

                ELSE 
                    INSERT INTO Ventas(idVentas,idVehiculo )
                    VALUES (vnVentas,pnidVehiculo);

                    INSERT INTO Factura(idFactura, fechaEmision, Total, idCliente,idEmpleado,idImpuesto)
                    VALUES (vnFactura, CURDATE(), vnTotal, pnidCliente,pnidEmpleado, pnidImpuesto);

                    INSERT INTO FormaPago(idFormaPago, idFactura)
                    VALUES (pnidFormaPago,vnFactura);

                    INSERT INTO descuentofactura(idFactura,idDescuento,fecha)
			        VALUES(vnFactura,vcDescuento, CURDATE());

                    INSERT INTO TipoSalida(idTipoSalida,descripcion,idVentas)
			        VALUES(vnTipoSalida,'', pnidVentas);

                    INSERT INTO Salida(idSalida, descripcion, fechaSalida, idTipoSalida)
                    VALUES (vnSalida,'',CURDATE(), vnTipoSalida);

                    COMMIT;
                                    SET pcMensaje='Se ha agregaddo de forma exitosa la transaccion';
                                    SET pbOcurrioError=FALSE;
                                    LEAVE SP;
            END IF;




END
