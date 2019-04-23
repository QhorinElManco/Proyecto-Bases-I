<?php 
    include_once("../class/class_conexion.php");
    session_start();
    
	switch ($_GET["accion"]) {
		case '1'://Llenar informacion del formulario
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
        
        case '2'://llenar cargo
            $conexion = new Conexion();
            $sql = sprintf("SELECT idCargo, descripcion FROM  Cargo");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idCargo"] ?>"><?php echo $fila["descripcion"] ;?></option>
            <?php   
            }
            $conexion->cerrarConexion();
        break;
        case '3'://guardar imagen
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
        case '4'://editar empleado
             $idEmpleado = $_POST['idEmpleado'];
             $txt_pnombre = $_POST['txt_pnombre'];
             $txt_snombre= $_POST['txt_snombre'];
             $txt_papellido= $_POST['txt_papellido'];
             $txt_sapellido= $_POST['txt_sapellido'];
             $txt_correo= $_POST['txt_correo'];
             $txt_direccion= $_POST['txt_direccion'];
             $txt_noIdentidad= $_POST['txt_noIdentidad'];
             $txt_telefono=$_POST['txt_telefono'];
             $date_fechaInicio=$_POST['date_fechaInicio'];
             $date_fechaFin=$_POST['date_fechaFin'];
             $txt_usuario=$_POST['txt_usuario'] ;
             $txt_contraseña=$_POST['txt_contraseña'] ;
             $slc_cargo=$_POST['slc_cargo'] ;
            
            $conexion = new Conexion();
            $accion = "EDITAR";

            if (isset($_POST["img"])) {
                $ruta=$_SESSION["ruta"];
                $sql = "CALL SP_GESTION_EMPLEADO('$txt_pnombre','$txt_snombre','$txt_papellido','$txt_sapellido','$txt_correo','$txt_direccion','$txt_noIdentidad','$txt_telefono','$date_fechaInicio','$date_fechaFin','$slc_cargo','$txt_usuario','$txt_contraseña ','../$ruta','$idEmpleado','$accion',@p17,@p18);";
            }
            else{
                $ruta2 = $_POST["img"];
                $sql = "CALL SP_GESTION_EMPLEADO('$txt_pnombre','$txt_snombre','$txt_papellido','$txt_sapellido','$txt_correo','$txt_direccion','$txt_noIdentidad','$txt_telefono','$date_fechaInicio','$date_fechaFin','$slc_cargo','$txt_usuario','$txt_contraseña ','$ruta2','$idEmpleado','$accion',@p17,@p18);";
            }
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
        
        default:
        # code...
        break;
    }
?>