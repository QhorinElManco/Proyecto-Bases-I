<?php
    include("../class/class_conexion.php");
    switch($_GET["accion"]){
        case "1":
            $conexion = new Conexion();
            $sql = "SELECT * FROM sucursal";
            $resultado = $conexion->ejecutarInstruccion($sql);	
            if(!$resultado){
                echo "Hay una error en la sentencia sql: ".$sql;
            }
            else{
                while($fila=$conexion->obtenerFila($resultado)){
                    $lista[]=$fila;
                }
                echo json_encode($lista);

            }
            $conexion->cerrarConexion();
        break;
        
        default:
            echo json_encode("No registro la opcion");
            break;
    }
    $conexion->liberarResultado($resultado);

?>