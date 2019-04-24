<?php 
    include_once("../class/class_conexion.php");
    session_start();
    
	switch ($_GET["accion"]) {
        case '1'://llenar select de modelo
            $conexion = new Conexion();
            $sql = sprintf("SELECT idModelo, descripcion FROM  Modelo");
            $resultado = $conexion->ejecutarInstruccion($sql);
            echo '<option>--Seleccionar el modelo--</option>';
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
            echo '<option>--Seleccionar Tipo transmicion--</option>';
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
            echo '<option>--Seleccionar Tipo de motor--</option>';
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
            echo '<option>--Seleccionar Tipo transmicion--</option>';
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idTransmision"] ?>"><?php echo $fila["descripcion"] ;?></option>
             <?php   
            }
            $conexion->cerrarConexion();
            break;
        case '5'://llenar select cilindraje
            $conexion = new Conexion();
            $sql = sprintf("SELECT idCilindraje, descripcion FROM  Cilindraje");
            $resultado = $conexion->ejecutarInstruccion($sql);
            echo '<option>--Seleccionar el cilindraje--</option>';
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
            echo '<option>--Seleccionar Inventario--</option>';
            while ($fila= $conexion->obtenerFila($resultado)) { ?>
                    <option value="<?php echo $fila["idInventario"] ?>"><?php echo $fila["descripcion"] ;?></option>
            <?php   
            }
            $conexion->cerrarConexion();
        case '7'://Llenar informacion del formulario
        echo '</h1> hola </h1>';
        /*$conexion = new Conexion();
        $idVehiculo = $_POST['idVehiculo'];
        $accion = "EDITAR";
        $sql = "SELECT idVehiculo, color, descripcion, anio, precioVenta, precioRentaHora,
                precioRentaDia, placa, eliminado, idModelo, idInventario, idTipoVehiculo,
                idTipoGasolina, idTransmision, idCilindraje, modelo, inventario,
                 tipovehiculo,  tipomotor, transmision,cilindraje
                FROM VW_VEHICULO 
                WHERE idVehiculo = '$idVehiculo';";
        
        $resultado = $conexion->ejecutarInstruccion($sql);
        while ($fila= $conexion->obtenerFila($resultado)) { ?>
            

            <input type="text" id="idVehiculo" value="<?php echo $fila['idVehiculo'];?>">
            <input type="text" id="color" value="<?php echo $fila['color'];?>">
            <input type="text" id="descripcion" value="<?php echo $fila['descripcion'];?>">
            <input type="text" id="anio" value="<?php echo $fila['anio'];?>">
            <input type="text" id="precioVenta" value="<?php echo $fila['precioVenta'];?>">
            <input type="text" id="precioRentaHora" value="<?php echo $fila['precioRentaHora'];?>">
            <input type="text" id="precioRentaDia" value="<?php echo $fila['precioRentaDia'];?>">
            <input type="text" id="placa" value="<?php echo $fila['placa'];?>">
            <input type="text" id="idModelo" value="<?php echo $fila['idModelo'];?>">
            <input type="text" id="idInventario" value="<?php echo $fila['idInventario'];?>">
            <input type="text" id="idTipoVehiculo" value="<?php echo $fila['idTipoVehiculo'];?>">
            <input type="text" id="idTipoGasolina" value="<?php echo $fila['idTipoGasolina'];?>">
            <input type="text" id="idTransmision" value="<?php echo $fila['idTransmision'];?>">
            <input type="text" id="idCilindraje" value="<?php echo $fila['idCilindraje'];?>">

        <?php
        }
        
        
        
        $conexion->cerrarConexion();*/
        break;

        case '8'://guardar imagen
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
        case '9'://editar empleado
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
                $ruta2 = $_POST["img"];
                $sql = "CALL SP_GESTION_EMPLEADO('$txt_pnombre','$txt_snombre','$txt_papellido','$txt_sapellido','$txt_correo','$txt_direccion','$txt_noIdentidad','$txt_telefono','$date_fechaInicio','$date_fechaFin','$slc_cargo','$txt_usuario','$txt_contraseña ','$ruta2','$idEmpleado','$accion',@p17,@p18);";
            }
            else{
                $ruta=$_SESSION["ruta"];
                $sql = "CALL SP_GESTION_EMPLEADO('$txt_pnombre','$txt_snombre','$txt_papellido','$txt_sapellido','$txt_correo','$txt_direccion','$txt_noIdentidad','$txt_telefono','$date_fechaInicio','$date_fechaFin','$slc_cargo','$txt_usuario','$txt_contraseña ','../$ruta','$idEmpleado','$accion',@p17,@p18);";
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