<?php
    session_start();
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1':
        if(isset($_FILES["file_foto"])){
            $file = $_FILES["file_foto"];
            $nombre = $file["name"];
            $tipo = $file["type"];
            $ruta_provisional = $file["tmp_name"];
            $size = $file["size"];
            $dimensiones = getimagesize($ruta_provisional);
            $width = $dimensiones[0];
            $height = $dimensiones[1];
            $carpeta = "../assets/images/fotos/clientes/";
            
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
        case '2':
        $conexion = new Conexion();
        $accion = 'AGREGAR';
        $txt_pnombre = $_POST['txt_pnombre'];
        $txt_snombre= $_POST['txt_snombre'];
        $txt_papellido= $_POST['txt_papellido'];
        $txt_sapellido= $_POST['txt_sapellido'];
        $txt_correo= $_POST['txt_correo'];
        $txt_direccion= $_POST['txt_direccion'];
        $txt_noIdentidad= $_POST['txt_noIdentidad'];
        $txt_telefono=$_POST['txt_telefono'];
        $txt_usuario=$_POST['txt_usuario'] ;
        $txt_contraseña=$_POST['txt_contraseña'] ;
        $ruta=$_SESSION["ruta"];


        $sql= sprintf(" CALL SP_GESTION_CLIENTE('$txt_pnombre','$txt_snombre', '$txt_papellido','$txt_sapellido', '$txt_correo', '$txt_direccion','$txt_noIdentidad','$txt_telefono', '$txt_usuario','$txt_contraseña', '$ruta',  '$accion', '', @p17, @p18);");
                        
        $resultado = $conexion->ejecutarInstruccion($sql);
        $salida = "SELECT @p17 AS OcurreError, @p18 AS mensaje;";
        $respuesta = $conexion->ejecutarInstruccion($salida);

        if ($resultado) {
            $fila = $conexion->obtenerFila($respuesta);
            if ($fila["OcurreError"]== '1') {
                echo 'Ocurre error: '.$fila["OcurreError"].'<br>mensaje: '. $fila["mensaje"];
            }
            else{
            }
            $res =  'Ocurre error: '.$fila["OcurreError"].'<br>mensaje: '. $fila["mensaje"]; 
            ?>
        
        <div class="alert alert-primary">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        Se ha creado la cuenta<br> <?php echo $res; ?></div>             
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