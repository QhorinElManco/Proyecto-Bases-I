<?php
    include("../class/class_conexion.php");
    switch($_GET["accion"]){

        case 'cargarVehiculos':
            $conexion = new conexion();

            $sql = "SELECT v.idVehiculo, m.descripcion FROM vehiculo v
                    INNER JOIN modelo m ON m.idModelo=v.idModelo
                    ORDER BY m.descripcion ASC;";
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
                    INNER JOIN persona p ON p.idPersona=e.idPersona
                    ORDER BY NombreCompleto ASC";
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

            $sql = "SELECT idTipoMantenimiento, descripcion FROM tipomantenimiento
                    ORDER BY descripcion ASC";
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
                    INNER JOIN persona p ON p.idPersona=c.idPersona
                    ORDER BY NombreCompleto ASC";
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

        case 'agregar':
           if(isset($_POST["idVehiculo"])){
                $idVehiculo=$_POST["idVehiculo"];
            }
            if(isset($_POST["idEmpleado"])){
                $idEmpleado=$_POST["idEmpleado"];
            }            
            if(isset($_POST["idTipoMantenimiento"])){
                $idTipoMantenimiento=$_POST["idTipoMantenimiento"];
            }            
            if(isset($_POST["idCliente"])){
                $idCliente=$_POST["idCliente"];
            }
            if(isset($_POST["fechaFin"])){
                $fechaFin=$_POST["fechaFin"];
            }
            $fechaFin="2019-04-18";
            $conexion=new conexion();
            $accion="AGREGAR";
            $sql="CALL SP_SOLICITUD_MANTENIMIENTO('0','$idVehiculo','$idEmpleado','$idTipoMantenimiento','$idCliente','$fechaFin','$accion','estado',@p8,@p9);";
            $salida = "SELECT @p8 AS Codigo, @p9 AS Mensaje";
            $resultado = $conexion->ejecutarInstruccion($sql);
            $respuesta = $conexion->ejecutarInstruccion($salida);
            if(!$respuesta){
                echo "No hay respuesta";
            }
            else{
                
                $fila = $conexion->obtenerFila($respuesta);
                echo $fila["Mensaje"];    
            }
            $conexion->cerrarConexion();
        break;


        case 'editar':
        break;


        default:
            echo "Opcion no valida";
        break;
    }




















?>