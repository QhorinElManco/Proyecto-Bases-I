 DELIMITER $$ 
 CREATE PROCEDURE SP_GESTION_CLIENTE(
    IN      pcpNombre           VARCHAR(45),
    IN      pcsNombre           VARCHAR(45),
    IN      pcpApellido         VARCHAR(45),
    IN      pcsApellido         VARCHAR(45),
    IN      pcCorreo            VARCHAR(45),
    IN      pcDireccion         VARCHAR(60),
    IN      pcNoIdentidad       VARCHAR(45),
    IN      pcTelefono          VARCHAR(45),
    IN      pcNombreUsuario     VARCHAR(45),
    IN      pcContrasenia       VARCHAR(45),
    IN      pcRutaImagen        VARCHAR(1000),
    IN      pcAccion            VARCHAR(100),
    IN      pnIdCliente         INT,
    OUT     pbOcurrioError       BOOLEAN,
    OUT     pcMensaje      VARCHAR(1000)



 )
 SP:BEGIN

        DECLARE vnConteo, vnIdCliente, vnIdTelefono, vnIdPersona, vnIdUsuario INT;
        DECLARE tempMensaje VARCHAR(2000);
        SET autocommit=0;
		START TRANSACTION;
		SET tempMensaje='';
		SET pbOcurrioError=TRUE;

        IF pcAccion= '' OR pcAccion IS NULL THEN
            SET tempMensaje = CONCAT(tempMensaje,'Accion no puede ser nula, ');
        END IF;

        IF pcAccion = 'AGREGAR' OR pcAccion = 'EDITAR' THEN
                IF pcpNombre = '' OR pcpNombre  IS NULL THEN
                    SET tempMensaje = 'Primer nombre, ';
                END IF;
                IF pcsNombre = '' OR pcsNombre IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'Segundo nombre, ');
                END IF;
                IF pcpApellido = '' OR pcpApellido IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'primer apellido, ');
                END IF;
                IF pcsApellido = '' OR pcsApellido IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'segundo apellido, ');
                END IF;
                IF pcCorreo = '' OR pcCorreo IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'correo, ');
                END IF;
                IF pcDireccion = '' OR pcDireccion IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'direccion, ');
                END IF;
                IF pcNoIdentidad = '' OR pcNoIdentidad IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'identidad, ');
                END IF;
                IF pcTelefono = '' OR pcTelefono IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'telefono, ');
                END IF;
                IF pcNombreUsuario = '' OR pcNombreUsuario IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'nombre de usuario, ');
                END IF;
                IF pccontrasenia = '' OR pccontrasenia IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'contrasenia, ');
                END IF;
                IF pcRutaImagen = '' OR pcRutaImagen IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'ruta de la imagen, ');
                END IF;
                
                IF tempMensaje <> '' THEN
                    SET pcMensaje = CONCAT('Faltan los siguientes campos: ', tempMensaje);
                    LEAVE SP;
                END IF;
        END IF;
        IF pcAccion = 'ELIMINAR' OR pcAccion = 'EDITAR' THEN

                IF pnIdCliente = '' OR pnIdCliente IS NULL THEN
                    SET tempMensaje =  'idCliente, ';
                END IF;
                IF tempMensaje <> '' THEN
                    SET pcMensaje= CONCAT('Faltan campos requeridos: ', tempMensaje);
                END IF;

                SELECT COUNT(*) INTO vnConteo FROM Cliente c
                WHERE c.idCliente = pnIdCliente;
                IF vnConteo = 0 THEN
                    SET pcMensaje = 'idcliente no existe';
                    LEAVE SP;
                END if;

                SELECT COUNT(*) INTO vnConteo FROM Cliente c
                INNER JOIN Usuario u ON u.idUsuario = c.idUsuario
                WHERE c.idcliente = pnIdCliente;
                IF vnConteo = 0 THEN
                    SET pcMensaje = 'El Cliente no tiene usuario';
                    LEAVE SP;
                END IF;
                SELECT COUNT(*) INTO vnConteo FROM Cliente e
                INNER JOIN Persona p ON p.idPersona = c.idPersona
                INNER JOIN telefonos t ON t.idPersona = p.idPersona
                WHERE c.idCliente= pnIdCliente;
                IF vnConteo = 0 THEN
                    SET pcMensaje = 'El Cliente no tiene telefonos';
                    LEAVE SP;
                END IF;

        END IF; 

         IF pcAccion = 'AGREGAR' THEN

            SELECT COUNT(*) INTO vnConteo FROM Cliente 
            WHERE idCliente = pnIdCliente;
            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('El Cliente', pnIdCliente,' ya existe ');
                LEAVE SP; 
            END IF;

            SELECT COUNT(*) INTO vnConteo FROM Usuario 
            WHERE nombreUsuario = pcNombreUsuario;
            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('El usuario', pcNombreUsuario,' ya existe en el SI');
                LEAVE SP; 
            END IF;
                    /* si el la persona ya esta registrada con el numero de id y es empleado, la va a registrar solo en cliente y usuario*/

            SELECT COUNT(*) INTO vnConteo FROM Empleado e
            INNER JOIN persona p ON p.idPersona=e.idPersona
            WHERE p.noIdentidad=pcNoIdentidad;

            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe como empleado');
                SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;
               INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                
                 INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);
                LEAVE SP;
                    /* en caso contrario lo agregara desde la tabla persona, usuario, y cliente*/
                    ELSE
                        SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                        SELECT (MAX(p.idPersona)+1) INTO vnIdPersona FROM Persona p;
                        SELECT (MAX(t.idTelefonos)+1) INTO vnIdTelefono FROM Telefonos t;
                        SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;

                        INSERT INTO persona(idPersona,pnombre, snombre, papellido,sapellido, correo,direccion,noIdentidad) 
                        VALUES (vnIdPersona,pcpNombre, pcsNombre,pcpApellido,pcsApellido,pcCorreo,pcDireccion, pcNoIdentidad);
                
                        INSERT INTO telefonos (idTelefonos , telefono , idPersona) 
                        VALUES (vnIdTelefono,pcTelefono ,vnIdPersona);
                        
                        INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                        VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                        
                        INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                        VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);

                        COMMIT;
                        SET pcMensaje = 'Cliente agregado con exito.';
                        SET pbOcurrioError = FALSE;
                        LEAVE SP;
                    
            END IF;
            /* si la persona solo esta registrada  en la tabla persona la agregara en cliente y usuario */        
            SELECT COUNT(*) INTO vnConteo FROM persona p 
            WHERE p.noIdentidad=pcNoIdentidad;
            IF vnConteo > 0 THEN
                SET pcMensaje= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe ');
                SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;
               INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                
                 INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);
                LEAVE SP;

                 /* en caso contrario lo agregara desde la tabla persona, usuario, y cliente*/
                    ELSE
                        SELECT (MAX(c.idCliente)+1) INTO vnIdCliente FROM Cliente c;
                        SELECT (MAX(p.idPersona)+1) INTO vnIdPersona FROM Persona p;
                        SELECT (MAX(t.idTelefonos)+1) INTO vnIdTelefono FROM Telefonos t;
                        SELECT (MAX(u.idUsuario)+1) INTO vnIdUsuario FROM Usuario u;

                        INSERT INTO persona(idPersona,pnombre, snombre, papellido,sapellido, correo,direccion,noIdentidad) 
                        VALUES (vnIdPersona,pcpNombre, pcsNombre,pcpApellido,pcsApellido,pcCorreo,pcDireccion, pcNoIdentidad);
                
                        INSERT INTO telefonos (idTelefonos , telefono , idPersona) 
                        VALUES (vnIdTelefono,pcTelefono ,vnIdPersona);
                        
                        INSERT INTO usuario(idUsuario, nombreUsuario , contraseña, rutaImagen) 
                        VALUES (vnIdUsuario,pcNombreUsuario,pcContrasenia,pcRutaImagen);
                        
                        INSERT INTO Cliente(idCliente,idPersona,idUsuario)
                        VALUES (vnIdCliente, vnIdPersona,vnIdUsuario);

                        COMMIT;
                        SET pcMensaje = 'cliente agregado con exito.';
                        SET pbOcurrioError = FALSE;
                        LEAVE SP;
            END IF;

     END IF;

    IF pcAccion = 'EDITAR' THEN
                IF pnIdCliente = '' OR pnIdCliente IS NULL THEN
                    SET tempMensaje = CONCAT(tempMensaje,'Cliente, ');
                END IF;

        SELECT p.idPersona INTO vnIdPersona FROM Persona p
        INNER JOIN Cliente c ON c.idPersona = p.idPersona
        WHERE c.idCliente=pnIdCliente;

        UPDATE Cliente 
        SET  idPersona=vnIdPersona,
            idUsuario=vnIdUsuario
        WHERE idEmpleado = pnIdEmpleado;

        UPDATE persona 
        SET pnombre= pcpNombre
            ,snombre= pcsNombre
            ,papellido= pcpApellido
            ,sapellido=pcsApellido
            ,correo= pcCorreo
            ,direccion=pcDireccion
            ,noIdentidad=pcNoIdentidad
        WHERE idPersona = vnIdPersona;

        UPDATE telefonos 
        SET telefono=pcTelefono
        WHERE idPersona = vnIdPersona;

        SELECT u.idUsuario INTO vnIdUsuario FROM Usuario u
        INNER JOIN Cliente c ON c.idUsuario = u.idUsuario
        WHERE c.idcliente = pnIdCliente;

        UPDATE usuario 
        SET nombreUsuario= pcNombreUsuario
            ,contraseña= pcContrasenia
            ,rutaImagen= pcRutaImagen
        WHERE idUsuario = vnIdUsuario;
        COMMIT;
                        SET pcMensaje = 'cliente actualizado con exito.';
                        SET pbOcurrioError = FALSE;
                        LEAVE SP;



    END IF;
    IF pcAccion = 'ELIMINAR' THEN

        SELECT p.idPersona INTO vnIdPersona FROM Persona p
        INNER JOIN Cliente  c ON c.idPersona = p.idPersona
        WHERE c.idCliente = pnIdCliente;

        SELECT u.idUsuario INTO vnIdUsuario FROM Usuario u
        INNER JOIN Cliente c ON c.idUsuario = u.idUsuario
        WHERE c.idCliente= pnIdCliente;

        DELETE FROM cliente
        WHERE idCliente = pnIdCliente;

        DELETE FROM telefonos
        WHERE idPersona = vnIdPersona;

        DELETE FROM Persona
        WHERE idPersona = vnIdPersona;

        DELETE FROM Usuario
        WHERE idUsuario = vnIdUsuario;
        COMMIT;
            SET pcMensaje = 'Cliente eliminado con exito.';
            SET pbOcurrioError = FALSE;
    END IF;


 END