DROP PROCEDURE IF EXISTS SP_GESTION_EMPLEADO$$

CREATE PROCEDURE SP_GESTION_EMPLEADO(
    IN pcpNombre VARCHAR(45),
    IN pcsNombre VARCHAR(45),
    IN pcpApellido VARCHAR(45),
    IN pcsApellido VARCHAR(45),
    IN pcCorreo VARCHAR(45),
    IN pcDireccion VARCHAR(60),
    IN pcNoIdentidad VARCHAR(45),
    IN pcTelefono VARCHAR(45),
    IN pdFechaInicio DATE,
    IN pdFechaFin DATE,
    IN pnIdCargo INT,
    IN pcNombreUsuario VARCHAR(45),
    IN pcContrasenia VARCHAR(45),
    IN pcRutaImagen VARCHAR(1000),
    IN pnIdEmpleado INT,
    IN pcAccion VARCHAR(100),
    OUT pbOcurreError BOOLEAN,
    OUT pcMensajeError VARCHAR(1000)
)
SP:BEGIN
    DECLARE vnConteo, vnIdPersona, vnIdEmpleado, vnIdTelefonos, vnIdUsuario, vnIdPersona2,vnConteo2 INT;
    DECLARE vcMensajeTemp VARCHAR(1000);
    SET pbOcurreError = TRUE;
    SET vcMensajeTemp = '';

    SET AUTOCOMMIT=0;
    START TRANSACTION;

    IF pcAccion = 'AGREGAR' OR pcAccion = 'EDITAR' THEN
        IF pcpNombre = '' OR pcpNombre  IS NULL THEN
            SET vcMensajeTemp = 'Primer nombre, ';
        END IF;
        IF pcsNombre = '' OR pcsNombre IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'Segundo nombre, ');
        END IF;
        IF pcpApellido = '' OR pcpApellido IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'primer apellido, ');
        END IF;
        IF pcsApellido = '' OR pcsApellido IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'segundo apellido, ');
        END IF;
        IF pcCorreo = '' OR pcCorreo IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'correo, ');
        END IF;
        IF pcDireccion = '' OR pcDireccion IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'direccion, ');
        END IF;
        IF pcNoIdentidad = '' OR pcNoIdentidad IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'identidad, ');
        END IF;
        IF pcTelefono = '' OR pcTelefono IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'telefono, ');
        END IF;
        IF pdFechaInicio = '' OR pdFechaInicio IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'fecha de inicio, ');
        END IF;
        IF pdFechaFin = '' THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'fecha fin, ');
        END IF;
        IF pnIdCargo = '' OR pnIdCargo IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'cargo, ');
        END IF;
        IF pcNombreUsuario = '' OR pcNombreUsuario IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'nombre de usuario, ');
        END IF;
        IF pccontrasenia = '' OR pccontrasenia IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'contrasenia, ');
        END IF;
        IF pcRutaImagen = '' OR pcRutaImagen IS NULL THEN
            SET vcMensajeTemp = CONCAT(vcMensajeTemp,'ruta de la imagen, ');
        END IF;
        IF vcMensajeTemp <> '' THEN
            SET pcMensajeError = CONCAT('Faltan los siguientes campos: ', vcMensajeTemp);
            LEAVE SP;
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Cargo
        WHERE idCargo = pnIdCargo;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'No existe el idCargo';
            LEAVE SP;
        END IF;
        
    END IF;
    IF pcAccion = 'ELIMINAR' OR pcAccion = 'EDITAR' THEN

        IF pnIdEmpleado = '' OR pnIdEmpleado IS NULL THEN
            SET vcMensajeTemp =  'idEmpleado, ';
        END IF;
        IF vcMensajeTemp <> '' THEN
            SET pcMensajeError = CONCAT('Faltan campos requeridos: ', vcMensajeTemp);
        END IF;

        SELECT COUNT(*) INTO vnConteo FROM Empleado
        WHERE idEmpleado = pnIdEmpleado;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'idEmpleado no existe';
            LEAVE SP;
        END if;

        SELECT COUNT(*) INTO vnConteo FROM Empleado e
        INNER JOIN Usuario u ON u.idUsuario = e.idUsuario
        WHERE e.idEmpleado = pnIdEmpleado;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'El empleado no tiene usuario';
            LEAVE SP;
        END IF;
        SELECT COUNT(*) INTO vnConteo FROM Empleado e
        INNER JOIN Persona p ON p.idPersona = e.idPersona
        INNER JOIN telefonos t ON t.idPersona = p.idPersona
        WHERE e.idEmpleado = pnIdEmpleado;
        IF vnConteo = 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError = 'El empleado no tiene telefonos';
            LEAVE SP;
        END IF;

    END IF;

    IF pcAccion = 'AGREGAR' THEN
        

        SELECT COUNT(*) INTO vnConteo FROM Usuario 
        WHERE nombreUsuario = pcNombreUsuario;
        IF vnConteo > 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('El usuario', pcNombreUsuario,' ya existe en el SI');
            LEAVE SP; 
        END IF;        

        SELECT idPersona, COUNT(*) INTO  vnIdPersona2, vnConteo2 FROM persona
        WHERE noIdentidad = pcNoIdentidad;
        IF vnConteo2 = 0 THEN
            INSERT INTO persona
                    (idPersona, 
                    pnombre, 
                    snombre, 
                    papellido, 
                    sapellido, 
                    correo, 
                    direccion, 
                    noIdentidad) 
            VALUES (NULL,
                    pcpNombre,
                    pcsNombre,
                    pcpApellido,
                    pcsApellido,
                    pcCorreo,
                    pcDireccion,
                    pcNoIdentidad);
            

            SELECT MAX(idPersona) INTO vnIdPersona FROM Persona;

            INSERT INTO telefonos
                        (idTelefonos
                        , telefono
                        , idPersona) 
            VALUES (NULL
                    ,pcTelefono
                    ,vnIdPersona);
            
            INSERT INTO usuario
                    (idUsuario
                    , nombreUsuario
                    , contraseña
                    , rutaImagen) 
            VALUES (NULL
                    ,pcNombreUsuario
                    ,pcContrasenia
                    ,pcRutaImagen);
            
            SELECT MAX(idUsuario) INTO vnIdUsuario FROM usuario;

            INSERT INTO empleado
                        (idEmpleado
                        , fechaInicio
                        , fechaFin
                        , idPersona
                        , idCargo
                        , idUsuario) 
            VALUES (NULL
                    ,pdFechaInicio
                    ,pdFechaFin
                    ,vnIdPersona
                    ,pnIdCargo
                    ,vnIdUsuario);
        END IF;
        IF vnConteo2 > 0 THEN
            SELECT COUNT(*) INTO vnConteo FROM Persona p
            INNER JOIN Cliente c ON c.idPersona = p.idPersona
            WHERE p.idPersona = vnIdPersona2;
            IF vnConteo = 0 THEN
                SET pbOcurreError = TRUE;
                SET pcMensajeError= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe en el SI');
                LEAVE SP;
            END IF;
            IF vnConteo > 0 THEN
                INSERT INTO usuario
                        (idUsuario
                        , nombreUsuario
                        , contraseña
                        , rutaImagen) 
                VALUES (NULL
                        ,pcNombreUsuario
                        ,pcContrasenia
                        ,pcRutaImagen);
                
                SELECT MAX(idUsuario) INTO vnIdUsuario FROM usuario;

                INSERT INTO empleado
                            (idEmpleado
                            , fechaInicio
                            , fechaFin
                            , idPersona
                            , idCargo
                            , idUsuario)
                VALUES (NULL
                        ,pdFechaInicio
                        ,pdFechaFin
                        ,vnIdPersona2
                        ,pnIdCargo
                        ,vnIdUsuario);
            END IF;
        
        END IF;


        
        
    END IF;
    IF pcAccion = 'EDITAR' THEN
        SELECT COUNT(*)-1 INTO vnConteo FROM Usuario 
        WHERE nombreUsuario = pcNombreUsuario;
        IF vnConteo > 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('El usuario', pcNombreUsuario,' ya existe en el SI');
            LEAVE SP; 
        END IF;
        SELECT COUNT(*)-1 INTO vnConteo FROM Persona
        WHERE correo = pcCorreo;
        IF vnConteo > 0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('El correo', pcCorreo,' ya existe en el SI');
            LEAVE SP; 
        END IF;

        SELECT COUNT(*)-1 INTO vnConteo FROM Persona
        WHERE noIdentidad = pcNoIdentidad;
        IF vnConteo >0 THEN
            SET pbOcurreError = TRUE;
            SET pcMensajeError= CONCAT('La persona con el noIdentidad', pcNoIdentidad ,' ya existe en el SI');
            LEAVE SP;
        END IF;

        SELECT p.idPersona INTO vnIdPersona FROM Persona p
        INNER JOIN Empleado e ON e.idPersona = p.idPersona
        WHERE e.idEmpleado = pnIdEmpleado;

        UPDATE empleado 
        SET fechaInicio= pdFechaInicio
            ,fechaFin= pdFechaFin
            ,idCargo= pnIdCargo 
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
        INNER JOIN Empleado e ON e.idUsuario = u.idUsuario
        WHERE e.idEmpleado = pnIdEmpleado;

        UPDATE usuario 
        SET nombreUsuario= pcNombreUsuario
            ,contraseña= pcContrasenia
            ,rutaImagen= pcRutaImagen
        WHERE idUsuario = vnIdUsuario;


    END IF;
    IF pcAccion = 'ELIMINAR' THEN

        UPDATE Empleado
        SET eliminado = TRUE
        WHERE idEmpleado = pnIdEmpleado;

        

    END IF;

    COMMIT;
    SET pcMensajeError = 'Procedimiento realizado con exito.';
    SET pbOcurreError = FALSE;

END$$