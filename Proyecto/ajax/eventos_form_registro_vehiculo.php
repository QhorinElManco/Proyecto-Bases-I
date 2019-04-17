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
        default:
            # code...
            break;
    }


?>