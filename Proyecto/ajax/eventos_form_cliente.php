<?php 
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1'://llenar imformacion de empleado
        $conexion = new Conexion();
        $idCliente = $_POST['idCliente'];

        $sql= sprintf("SELECT idPersona, pnombre, snombre, papellido, sapellido, correo, noIdentidad, direccion, idCliente, idUsuario, nombreUsuario, contrasenia, rutaImagen, telefonos
                        FROM vw_cliente
                        WHERE idCliente = '$idCliente'");
        $resultado = $conexion->ejecutarInstruccion($sql);
        $i=0;
        while ($fila= $conexion->obtenerFila($resultado)) { 
        
            ?>
            <div class="row">
                <div class="col"><img class="img-thumbnail" src=<?php echo $fila["rutaImagen"]; ?> alt="" width="250" height="200"></div>  
            </div><br>
            <div class="row">
            <div class="col-lg-6 auth-box" style="margin-left:auto; margin-right:auto;">
            <div class="row">
                <div class="col-sm-6" style="text-align: left;">Nombre:</div>
                <div class="col-sm-6" style="text-align: left;"><?php echo $fila["pnombre"] .' '. $fila["snombre"].' '. $fila["papellido"] .' '. $fila["sapellido"];?></div>
            </div>
            <div class="row">
                <div class="col-sm-6" style="text-align: left;">Correo: </div>
                <div class="col-sm-6" style="text-align: left;"><?php echo $fila["correo"];?></div>
            </div>
            <div class="row">
                <div class="col-sm-6" style="text-align: left;">Telefonos: </div>
                <div class="col-sm-6" style="text-align: left;"><?php echo $fila["telefonos"];?></div>
            </div>
            <div class="row">
                <div class="col-sm-6" style="text-align: left;">No Identidad: </div>
                <div class="col-sm-6" style="text-align: left;"><?php echo $fila["noIdentidad"];?></div>
            </div>
            <div class="row">
                <div class="col-sm-6" style="text-align: left;">Direccion: </div>
                <div class="col-sm-6" style="text-align: left;"><?php echo $fila["direccion"];?></div>
            </div>
            <div class="row">
                <div class="col-sm-6" style="text-align: left;">Usuario: </div>
                <div class="col-sm-6" style="text-align: left;"><?php echo $fila["nombreUsuario"];?></div>
            </div>
            <div class="row p-4">
                <div class="col">
                    <button id="btn_editar" type="button" class="btn btn-dark" onclick="location.href='form_cliente_editar.php?idCliente=<?php echo $idCliente;?>'">Editar</button>  
                </div>
                </div>
            </div>
            </div>
        <?php
        }
        $conexion->cerrarConexion();
        break;
        /*case '2':
        $conexion = new Conexion();
        $idEmpleado = $_POST['idEmpleado'];
        

        $accion = "ELIMINAR";
        $sql = "CALL SP_GESTION_EMPLEADO('','','','','','','','','','','','',' ','','$idEmpleado','$accion',@p17,@p18);";
        $salida = "SELECT @p17 AS OcurreError, @p18 AS mensaje;";
        $resultado = $conexion->ejecutarInstruccion($sql);
        $respuesta = $conexion->ejecutarInstruccion($salida);
        
        if (!$respuesta) {
            echo 'No hay respuesta del procedimiento';
        }
        else {
            $fila = $conexion->obtenerFila($respuesta);
            echo 'Ocurre error: '.$fila["OcurreError"].'<br>mensaje: '. $fila["mensaje"];
        }
        
        $conexion->cerrarConexion();
        break;*/
        default:
        # code...
        break;
    }
?>