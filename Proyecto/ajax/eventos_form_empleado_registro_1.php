<?php 
    session_start();
    include_once("../class/class_conexion.php");
    switch ($_GET["accion"]) {
        case '1'://llenar select cargo
            $conexion = new Conexion();
            $sql = sprintf("SELECT idCargo, descripcion FROM  Cargo");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idCargo"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '2'://subir foto
            if(isset($_FILES["file_foto"])){
                $file = $_FILES["file_foto"];
                $nombre = $file["name"];
                $tipo = $file["type"];
                $ruta_provisional = $file["tmp_name"];
                $size = $file["size"];
                $dimensiones = getimagesize($ruta_provisional);
                $width = $dimensiones[0];
                $height = $dimensiones[1];
                $carpeta = "../assets/images/fotos/empleados/";//C:\wamp\www\Proyecto\assets\images\fotos\empleados
                
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
         
            
        case '3'://guardar
            $conexion = new Conexion();
            //echo $_POST['slc_cargo'] ;
            
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
            $ruta=$_SESSION["ruta"] ;

            $accion = "AGREGAR";
            $sql = "CALL SP_GESTION_EMPLEADO('$txt_pnombre','$txt_snombre','$txt_papellido','$txt_sapellido','$txt_correo','$txt_direccion','$txt_noIdentidad','$txt_telefono','$date_fechaInicio','$date_fechaFin','$slc_cargo','$txt_usuario','$txt_contraseña ','../$ruta','NULL','$accion',@p17,@p18);";
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