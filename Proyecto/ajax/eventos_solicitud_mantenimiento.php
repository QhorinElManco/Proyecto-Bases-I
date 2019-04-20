<?php
    include("../class/class_conexion.php");
    switch($_GET["accion"]){

        case 'cargarVehiculos':
            $conexion = new conexion();

            $sql = "SELECT v.idVehiculo, m.descripcion FROM vehiculo v
                    INNER JOIN modelo m ON m.idModelo=v.idModelo";
            $resultado = $conexion->ejecutarInstruccion($sql);
            if(!$resultado){
                echo "No hay resultado de la consulta";
            }
            else{
                while($fila = $conexion->obtenerFila($resultado)){
                    echo '<option value="'.$fila["idVehiculo"].'">'.$fila["descripcion"].'</option>';
                }
            }
            $conexion->cerrarConexion();
        break;

        case 'cargarEmpleados':
            $conexion = new conexion();

            $sql = "SELECT e.idEmpleado, CONCAT_WS(' ',p.pnombre, p.snombre, papellido, sapellido) AS NombreCompleto FROM empleado e
                    INNER JOIN persona p ON p.idPersona=e.idPersona";
            $resultado = $conexion->ejecutarInstruccion($sql);
            if(!$resultado){
                echo "No hay resultado de la consulta";
            }
            else{
                while($fila = $conexion->obtenerFila($resultado)){
                    echo '<option value="'.$fila["idEmpleado"].'">'.$fila["NombreCompleto"].'</option>';
                }
            }
            $conexion->cerrarConexion();
        break;
        
        case 'cargarTipoMantenimiento':
            $conexion = new conexion();

            $sql = "SELECT idTipoMantenimiento, descripcion FROM tipomantenimiento";
            $resultado = $conexion->ejecutarInstruccion($sql);
            if(!$resultado){
                echo "No hay resultado de la consulta";
            }
            else{
                while($fila = $conexion->obtenerFila($resultado)){
                    echo '<option value="'.$fila["idTipoMantenimiento"].'">'.$fila["descripcion"].'</option>';
                }
            }
            $conexion->cerrarConexion();
        break;
        
        case 'cargarClientes':
        $conexion = new conexion();

        $sql = "SELECT c.idCliente, CONCAT_WS(' ',p.pnombre, p.snombre, papellido, sapellido) AS NombreCompleto FROM cliente c
                INNER JOIN persona p ON p.idPersona=c.idPersona";
        $resultado = $conexion->ejecutarInstruccion($sql);
        if(!$resultado){
            echo "No hay resultado de la consulta";
        }
        else{
            while($fila = $conexion->obtenerFila($resultado)){
                echo '<option value="'.$fila["idCliente"].'">'.$fila["NombreCompleto"].'</option>';
            }
        }
        $conexion->cerrarConexion();
    break;



        default:
            echo "Opcion no valida";
        break;
    }




















?>