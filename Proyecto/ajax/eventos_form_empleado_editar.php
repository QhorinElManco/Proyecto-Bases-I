<?php 
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1'://Llenar informacion
        $conexion = new Conexion();
        $idEmpleado = $_POST['idEmpleado'];

        $accion = "EDITAR";
        $sql = "SELECT idEmpleado, pnombre, snombre, papellido, sapellido, correo, cargo , noIdentidad, direccion, fechaInicio, fechaFin, nombreUsuario, contrasenia, rutaImagen, telefonos, idCargo 
                FROM VW_EMPLEADO_VER 
                WHERE idEmpleado = $idEmpleado;";
        
        $resultado = $conexion->ejecutarInstruccion($sql);
        while ($fila= $conexion->obtenerFila($resultado)) { ?>
            <input type="hidden" id="rutaImagen" value="<?php echo $fila['rutaImagen'];?>">
            <input type="hidden" id="contrasenia" value="<?php echo $fila['contrasenia'];?>">
            <input type="hidden" id="nombreUsuario" value="<?php echo $fila['nombreUsuario'];?>">
            <input type="hidden" id="fechaFin" value="<?php echo $fila['fechaFin'];?>">
            <input type="hidden" id="fechaInicio" value="<?php echo $fila['fechaInicio'];?>">
            <input type="hidden" id="direccion" value="<?php echo $fila['direccion'];?>">
            <input type="hidden" id="noIdentidad" value="<?php echo $fila['noIdentidad'];?>">
            <input type="hidden" id="telefonos" value="<?php echo $fila['telefonos'];?>">
            <input type="hidden" id="correo" value="<?php echo $fila['correo'];?>">
            <input type="hidden" id="sapellido" value="<?php echo $fila['sapellido'];?>">
            <input type="hidden" id="papellido" value="<?php echo $fila['papellido'];?>">
            <input type="hidden" id="snombre" value="<?php echo $fila['snombre'];?>">
            <input type="hidden" id="pnombre" value="<?php echo $fila['pnombre'];?>">
            <input type="hidden" id="idCargo" value="<?php echo $fila['idCargo'];?>">

        <?php    
        }
        
        
        
        $conexion->cerrarConexion();
        break;
        case '2':
            $conexion = new Conexion();
            $idEmpleado = $_POST['idEmpleado'];
            if (isset) {
                # code...
            }

            $accion = "EDITAR";
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
        break;
        case '3':
            $conexion = new Conexion();
            $sql = sprintf("SELECT idCargo, descripcion FROM  Cargo");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idCargo"] ?>"><?php echo $fila["descripcion"] ;?></option>
            <?php   
            }
            $conexion->cerrarConexion();
        break;
        case '4':

            if(isset($_FILES["file_foto"])){
                $file = $_FILES["file_foto"];
                $nombre = $file["name"];
                $tipo = $file["type"];
                $ruta_provisional = $file["tmp_name"];
                $size = $file["size"];
                $dimensiones = getimagesize($ruta_provisional);
                $width = $dimensiones[0];
                $height = $dimensiones[1];
                $carpeta = "../assets/images/fotos/empleados/";
                //C:\wamp\www\Proyecto\assets\images\fotos\empleados
                
                if ($tipo != 'image/jpg' && $tipo != 'image/jpeg' && $tipo != 'image/png' && $tipo != 'image/gif'){
                echo "Error, el archivo no es una imagen"; 
                }
                else if ($size > 10024*10024){
                echo "Error, el tamaño máximo permitido es un 1MB";
                }
                else if ($width > 5000 || $height > 5000){
                    echo "Error la anchura y la altura maxima permitida es 500px";
                }
                else if($width < 60 || $height < 60){
                    echo "Error la anchura y la altura mínima permitida es 60px";
                }
                else{
                    $src = $carpeta.$nombre;
                    $final = substr($src, 3);
                    $_SESSION["ruta"] = $final;
                    move_uploaded_file($ruta_provisional, $src);
                    echo "<img src='../$final' alt='Producto' class='img-responsive' width='250' height='200'>";
                }
            }else{
                echo "No se encontro el archivo";
            }
    
        break;
         

        break;
        default:
        # code...
        break;
    }
?>