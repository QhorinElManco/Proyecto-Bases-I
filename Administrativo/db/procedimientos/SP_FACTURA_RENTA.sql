DELIMITER $$

CREATE PROCEDURE SP_FACTURA_RENTA(
            IN      pnidFactura                 INT,
            IN      pnidCliente                 INT,
            IN      pnidEmpleado                INT,
            IN      pnidFormaPago               INT,
            IN      pnidDescuento               INT,
            IN      pnidRenta                   INT,
            IN      pnidVehiculo                INT,
            IN      pnMora                      INT,
            OUT     pbOcurrioError 		        BOOLEAN,
		    OUT     pcMensaje			        VARCHAR(2000)


)
SP:BEGIN

        DECLARE vnConteo, vnFactura, vnTotal , vnTiempoHoras, vnTiempoDias INT;
        DECLARE vcDescuento, vcTiempo, vcEstado VARCHAR(5);
        DECLARE vdFechaDevolucion DATE;
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
        IF pnidRenta='' OR pnidRenta IS NULL THEN
            SET tempMensaje=CONCAT(tempMensaje,'Renta  no puede ser nulo');
        END IF;
         IF tempMensaje<>'' THEN
            SET pcMensaje=CONCAT('CAMPOS REQUERIDOS: ',tempMensaje);
            LEAVE SP;
        END IF;


            SELECT COUNT(*) INTO vnConteo FROM Renta WHERE idRenta = pnidRenta;
			IF vnConteo=0  THEN
				SET pcMensaje = 'La renta seleccionado no existe.';
				LEAVE SP;
			END IF;

        SELECT COUNT(*) INTO vnConteo FROM Impuesto WHERE idImpuesto = pnidImpuesto;
			IF vnConteo=0  THEN
				SET pcMensaje = 'El impuesto seleccionado no existe.';
				LEAVE SP;
			END IF;

			SELECT COUNT(*) INTO vnConteo FROM FormaPago WHERE idFormaPago = pnidFormaPago;
			IF vnConteo=0  THEN
				SET pcMensaje = 'La forma de pago seleccionada no existe.';
				LEAVE SP;
			END IF;

            SELECT COUNT(*) INTO vnConteo FROM Empleado e
			WHERE e.idEmpleado=pnidEmpleado;
			IF vnConteo=0 THEN
				SET pcMensaje = 'El empleado seleccionado no existe.';
				LEAVE SP;
			END IF;

            SELECT COUNT(*) INTO vnConteo FROM Cliente c
			WHERE c.idCliente=pnidCliente;
			IF vnConteo=0 THEN
				SET pcMensaje = 'El Cliente seleccionado no existe.';
				LEAVE SP;
			END IF;

            SELECT d.estado INTO vcDescuento FROM Descuento d WHERE d.idDescuento=pnidDescuento;
			 IF vcDescuento = 'I'  THEN
				SET pcMensaje='El Descuento esta inactivo';
                                LEAVE SP;
                                ELSE 
                                set pnidDescuento=vcDescuento;
			
			END IF;

            SELECT a.fechaDevolucion INTO vdFechaDevolucion FROM Agenda a
            WHERE idVehiculo=pnidVehiculo;
            IF vdFechaDevolucion IS NULL OR vdFechaDevolucion='' THEN
                SET pcMensaje='El auto todavia no ha sido devuelto';
                LEAVE SP;
            END IF;

            
            SELECT a.tiempoRenta INTO vcTiempo   FROM agenda a;
            IF  vcTiempo='Dia' OR vcTiempo='dia' THEN
                                              
                        SELECT COUNT(r.estado) INTO vcEstado FROM Renta r 
                        INNER JOIN Vehiculo vh ON r.idVehiculo=vh.idVehiculo
                        WHERE idVehiculo=pnidVehiculo AND r.estado IN ('D');

                        IF vcEstado=0 THEN
                            SET pcMensaje='Auto no esta disponible para la renta';
                            LEAVE sp;

                            ELSE
                                SELECT DATEDIFF(  'a.fechaDevolucion', 'a.fechaEntrega' ) INTO vnTiempoDias FROM Agenda a
                                INNER JOIN renta r ON r.idAgenda=a.idAgenda
                                WHERE r.idRenta=pnidRenta;

                                    SELECT ( (vh.precioRentaDia * vnTiempoDias)- ( ( (vh.precioRentaDia * vnTiempoDias) *d.porcentaje) /100) + ( ( ( (vh.precioRentaDia * vnTiempoDias)- ( ( (vh.precioRentaDia * vnTiempoDias) *d.porcentaje) /100) ) *15)/100) + r.mora)
                                    INTO vnTotal FROM Renta r
                                    INNER JOIN vehiculo vh ON vh.idVehiculo=r.idVehiculo
                                    INNER JOIN Factura f ON f.idFactura=r.idFactura
                                    INNER JOIN DescuentoFactura df ON df.idFactura = f.idFactura
                                    INNER JOIN Descuento d ON d.idDescuento = df.idDescuento
                                    INNER JOIN Impuesto i  ON f.idImpuesto = i.idImpuesto
                                    WHERE r.idVehiculo=pnidVehiculo;

                                    SELECT (MAX(f.idFactura)+1) INTO vnFactura FROM Factura f;

                                        INSERT INTO Factura(idFactura, fechaEmision, Total, idCliente,idEmpleado,idImpuesto)
                                        VALUES (vnFactura, CURDATE(), vnTotal, pnidCliente,pnidEmpleado, pnidImpuesto);

                                        INSERT INTO FormaPago(idFormaPago, idFactura)
                                        VALUES (pnidFormaPago,vnFactura);

                                        INSERT INTO descuentofactura(idFactura,idDescuento,fecha)
                                        VALUES(vnFactura,vcDescuento, CURDATE());
                         

                                 COMMIT;
                                    SET pcMensaje='Se ha agregaddo de forma exitosa la transaccion';
                                    SET pbOcurrioError=FALSE;
                                    LEAVE SP;

                        END IF;
                        


             
                ELSE IF vcTiempo='Hora' OR  vcTiempo='hora' THEN 

               

                        SELECT COUNT(r.estado) INTO vcEstado FROM Renta r 
                        INNER JOIN Vehiculo vh ON r.idVehiculo=vh.idVehiculo
                        WHERE idVehiculo=pnidVehiculo AND r.estado IN ('D');

                        IF vcEstado=0 THEN
                            SET pcMensaje='Auto no esta disponible para la renta';
                            LEAVE sp;

                            ELSE
                                    SELECT TIMESTAMPDIFF( HOUR ,  '2019-01-01 12:00:00',  '2019-01-01 18:00:00' ) INTO vnTiempoHoras
                                    FROM Agenda a
                                    INNER JOIN Renta r ON r.idAgenda=a.idAgenda
                                    WHERE r.idRenta=pnidRenta;

                                    SELECT ((vh.precioRentaHora * vnTiempoHoras)- ( ( (vh.precioRentaHora * vnTiempoHoras) *d.porcentaje) /100) + ( ( ( (vh.precioRentaHora * vnTiempoHoras)- ( ( (vh.precioRentaHora * vnTiempoHoras) *d.porcentaje) /100) ) *15)/100) + r.mora)
                                    INTO vnTotal FROM Renta r
                                    INNER JOIN vehiculo vh ON vh.idVehiculo=r.idVehiculo
                                    INNER JOIN Factura f ON f.idFactura=r.idFactura
                                    INNER JOIN DescuentoFactura df ON df.idFactura = f.idFactura
                                    INNER JOIN Descuento d ON d.idDescuento = df.idDescuento
                                    INNER JOIN Impuesto i  ON f.idImpuesto = i.idImpuesto
                                    WHERE r.idVehiculo=pnidVehiculo;


                                        INSERT INTO Factura(idFactura, fechaEmision, Total, idCliente,idEmpleado,idImpuesto)
                                        VALUES (vnFactura, CURDATE(), vnTotal, pnidCliente,pnidEmpleado, pnidImpuesto);

                                        INSERT INTO FormaPago(idFormaPago, idFactura)
                                        VALUES (pnidFormaPago,vnFactura);

                                        INSERT INTO descuentofactura(idFactura,idDescuento,fecha)
                                        VALUES(vnFactura,vcDescuento, CURDATE());

                                       


                                 COMMIT;
                                    SET pcMensaje='Se ha agregaddo de forma exitosa la transaccion';
                                    SET pbOcurrioError=FALSE;
                                    LEAVE SP;

                        END IF;

                END IF;
            END IF;


            


     
END