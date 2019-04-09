<?php 
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1':
        $conexion = new Conexion();
        /* txt_pnombre, txt_snombre, txt_papellido, txt_papellido, txt_correo, txt_contraseña, txt_direccion, txt_telefono, date_fechaNacimiento, slc_genero*/
        $sql= sprintf("INSERT INTO persona 
                        (idPersona, noIdentidad, pnombre, snombre, papellido, sapellido, correo, direccion)
                        VALUES (NULL , '%s', '%s', '%s', '%s', '%s', '%s', '%s')",
                        stripslashes($_POST['txt_identidad']),
                        stripslashes($_POST['txt_pnombre']),
                        stripslashes($_POST['txt_snombre']),
                        stripslashes($_POST['txt_papellido']),
                        stripslashes($_POST['txt_sapellido']),
                        stripslashes($_POST['txt_correo']),
                        stripslashes($_POST['txt_direccion'])
                        );
                        
        $resultado = $conexion->ejecutarInstruccion($sql);			
        if ($resultado) {?>
        <div class="alert alert-success">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        Consulta se ha guardado con exito</div>                
        <?php   
        }
        else{?>
            <div class="alert alert-danger">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            No se ha podido guardar la informacion en la base de datos</div>              
        <?php
        }	
        $conexion->cerrarConexion();
        break;
        default:
        # code...
        break;
	}

            
?>