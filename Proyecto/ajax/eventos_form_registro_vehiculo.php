<?php 
    include_once("../class/class_conexion.php");
    session_start();
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
        case '6'://llenar inventario
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

            $_SESSION["slc_modelo"] = $slc_modelo;
            $_SESSION["slc_anio"] = $slc_anio;
            
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
            
            $conexion->cerrarConexion();
        break;
        case '8':
            $conexion = new Conexion(); 
            $idModelo = $_SESSION["slc_modelo"];

            $sql2 = "SELECT m.descripcion modelo, ma.descripcion marca,  MAX(v.idVehiculo) FROM Vehiculo v
            INNER JOIN Modelo m ON m.idModelo = v.idModelo
            INNER JOIN Marca ma ON ma.idMarca = m.idMarca
            WHERE m.idModelo = '$idModelo'";
            $resultado2 = $conexion->ejecutarInstruccion($sql2);
            $fila2= $conexion->obtenerFila($resultado2);
            $modelo = $fila2["modelo"];
            $marca = $fila2["marca"];
            $idVehiculo = $fila2["idVehiculo"];
            
            $carpetaDestino="../assets/images/fotos/vehiculos/$marca/$modelo/$idVehiculo/";
            if(isset($_FILES["file_foto"]) && $_FILES["file_foto"]["name"][0]){
                for($i=0;$i<count($_FILES["file_foto"]["name"]);$i++){
                    //../assets/images/fotos/vehiculos/$marca/$modelo/
                    
                    if($_FILES["file_foto"]["type"][$i]=="image/jpeg" || $_FILES["file_foto"]["type"][$i]=="image/pjpeg" || $_FILES["file_foto"]["type"][$i]=="image/gif" || $_FILES["file_foto"]["type"][$i]=="image/png"){
                        if(file_exists($carpetaDestino)|| @mkdir($carpetaDestino, 755, true)){
                            
                            $origen=$_FILES["file_foto"]["tmp_name"][$i];
                            $destino=$carpetaDestino.$_FILES["file_foto"]["name"][$i];
                            if(@move_uploaded_file($origen, $destino)){ 
                                //echo "<br> $destino <br>";
                                echo "<img src='$destino' class='img-responsive img-thumbnail' width='250' height='200'>";
                                $accion2 = 'AGREGAR';
                                $sql4 = "CALL SP_GESTION_VEHICULO_FOTO('$idVehiculo','','$destino','$accion2',@p5,@p6);";
                                $salida4 = "SELECT @p5 AS OcurreError, @p6 AS mensaje;";
                                $resultado4 = $conexion->ejecutarInstruccion($sql4);
                                $respuesta4 = $conexion->ejecutarInstruccion($salida4);//
                            }
                            else{
                                echo "<br>No se ha podido mover el archivo: ".$_FILES["file_foto"]["name"][$i];
                            }
                        }
                        else{
                            echo "<br>No se ha podido crear la carpeta: ".$carpetaDestino;
                        }
                    }
                    else{
                        echo "<br>".$_FILES["file_foto"]["name"][$i]." - NO es imagen jpg, png o gif";
                    }
                }                
            }else{
            echo "No se encontro el archivo";
            }//
            $conexion->cerrarConexion();
        break;
        default:
            # code...
            break;
    }


?>