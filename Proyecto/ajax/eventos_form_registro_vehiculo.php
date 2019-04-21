<?php 
    include_once("../class/class_conexion.php");
    switch ($_GET["accion"]) {
        case '1'://llenar select de modelo
            $conexion = new Conexion();
            $sql = sprintf("SELECT idModelo, descripcion FROM  Modelo");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idModelo"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '2'://llenar select de tipo vehiculo
            $conexion = new Conexion();
            $sql = sprintf("SELECT idTipoVehiculo, descripcion FROM  TipoVehiculo");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idTipoVehiculo"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '3'://llenar select de tipo motor
            $conexion = new Conexion();
            $sql = sprintf("SELECT idTipoGasolina, descripcion FROM  TipoMotor");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idTipoGasolina"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '4'://llenar select de tipo transmision
            $conexion = new Conexion();
            $sql = sprintf("SELECT idTransmision, descripcion FROM  Transmision");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idTransmision"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '5'://llenar select de tipo transmision
            $conexion = new Conexion();
            $sql = sprintf("SELECT idCilindraje, descripcion FROM  Cilindraje");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idCilindraje"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '6':
            $conexion = new Conexion();
            $sql = sprintf("SELECT idInventario, descripcion FROM  Inventario");
            $resultado = $conexion->ejecutarInstruccion($sql);
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idInventario"] ?>"><?php echo $fila["descripcion"] ;?></option>
            <?php   
            }
            $conexion->cerrarConexion();
        break;
        case '7'://guardar vehiculo
            $conexion = new Conexion();             

            $slc_color = $_POST['slc_color'];
            $txt_precioVenta= $_POST['txt_precioVenta'];
            $txt_precioRentaHora= $_POST['txt_precioRentaHora'];
            $txt_precioRentaDia= $_POST['txt_precioRentaDia'];
            $txt_placa= $_POST['txt_placa'];
            $txt_chasis= $_POST['txt_chasis'];
            $slc_anio= $_POST['slc_anio'];
            $slc_modelo=$_POST['slc_modelo'];
            $slc_tipoVehiculo=$_POST['slc_tipoVehiculo'];
            $slc_tipoMotor=$_POST['slc_tipoMotor'];
            $slc_tipoTransmision=$_POST['slc_tipoTransmision'] ;
            $slc_Cilindraje=$_POST['slc_Cilindraje'] ;
            $txt_descripcion=$_POST['txt_descripcion'];
            $slc_inventario=$_POST['slc_inventario'];
            
            $accion = "AGREGAR";
            $sql = "CALL SP_GESTION_VEHICULO('$txt_descripcion','$slc_color','$txt_precioVenta','$txt_precioRentaHora','$txt_precioRentaDia','$txt_placa','$slc_anio','$slc_modelo','$slc_inventario','$slc_tipoVehiculo','$slc_tipoMotor','$slc_tipoTransmision','$slc_Cilindraje','NULL','$accion',@p16,@p17);";
            $salida = "SELECT @p16 AS OcurreError, @p17 AS mensaje;";
            $resultado = $conexion->ejecutarInstruccion($sql);
            $respuesta = $conexion->ejecutarInstruccion($salida);
            
            if (!$respuesta) {
                echo 'No hay respuesta del procedimiento';
            }
            else {
                $fila = $conexion->obtenerFila($respuesta);
                echo 'Ocurre error: '.$fila["OcurreError"].'<br>mensaje: '. $fila["mensaje"];
            }

            if(isset($_FILES["file_foto"]) && $_FILES["file_foto"]["name"][0]){
                for($i=0;$i<count($_FILES["file_foto"]["name"]);$i++){
                    $file = $_FILES["file_foto"][$i];
                    $nombre = $file["name"][$i];
                    $tipo = $file["type"][$i];
                    $ruta_provisional = $file["tmp_name"][$i];
                    $size = $file["size"][$i];
                    $dimensiones = getimagesize($ruta_provisional);
                    $width = $dimensiones[0];
                    $height = $dimensiones[1];
                    $carpeta = "../assets/images/fotos/vehiculo/";//C:\wamp\www\Proyecto\assets\images\fotos\empleados
                    
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
                        $_SESSION["ruta"][$i] = $final;
                        move_uploaded_file($ruta_provisional, $src);
                        echo "<img src='../$final' alt='Producto' class='img-responsive' width='250' height='200'>"; 
                    }
                }                
            }else{
                echo "No se encontro el archivo";
            }
    
            $conexion->cerrarConexion();
        break;
        default:
            # code...
            break;
    }


?>