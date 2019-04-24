<?php
    include("../class/class_conexion.php");
    switch($_GET["accion"]){
        case "1":
            $conexion = new Conexion();
            $acentos = $conexion->ejecutarInstruccion("SET NAMES 'utf8'");
            $sql = "SELECT * FROM vw_sucursales_taller";
            $resultado = $conexion->ejecutarInstruccion($sql);	
            if(!$resultado){
                echo "alert(`Hay una error en la sentencia sql:`.$sql)";
            }
            else{
                while($fila=$conexion->obtenerFila($resultado)){
                    
                       echo '<tr>
                                <th scope="row">'.$fila["idTaller"].'</th>
                                <td>'.$fila["descripcion"].'</td>
                                <td>'.$fila["nombre"].'</td>
                                <td>'.$fila["direccion"].'</td>
                                <td><button class="btn btn-warning btn btn-success" type="button" data-toggle="modal"
                                data-target="#Modal2"><i class="mdi mdi-tooltip-edit"></i></button></td>
                                <td><button class="btn btn-danger eliminar" type="button" data-toggle="modal"
                                data-target="#Modal3"><i class="mdi mdi-playlist-remove"></i></button></td>
                            </tr>';}
            }
            $conexion->liberarResultado($resultado);
            $conexion->cerrarConexion();
        break;

        case "2":
            if(isset($_POST["descripcion"])){
                $descripcion = $_POST["descripcion"];
            }
            if(isset($_POST["sucursal"])){
                $sucursal = $_POST["sucursal"];
            }
            if($descripcion=="" || $descripcion==NULL){
                $respuesta="Ingrese el descripcion";
                echo $respuesta;
            }
            else if($sucursal=="" || $sucursal==NULL){
                $respuesta="Ingrese la sucursal";
                echo $respuesta;
            }
            else{
                $conexion = new Conexion();
                $accion = "AGREGAR";
                $idSucursal = $conexion->ejecutarInstruccion("SELECT idSucursal FROM sucursal WHERE nombre='$sucursal';");
                $idSucursal = $conexion->obtenerFila($idSucursal);
                $idSucursal = $idSucursal["idSucursal"];
                $sql = "CALL SP_GESTION_TALLER('0', '$idSucursal','$descripcion','$accion', @p4, @p5);";
                $salida = "SELECT @p4 AS mensaje, @p5 AS codigo;";
                $resultado = $conexion->ejecutarInstruccion($sql);
                $respuesta = $conexion->ejecutarInstruccion($salida);
                if(!$respuesta){
                    echo "No hay respuesta del procedimiento";
                }
                else{
                    $fila=$conexion->obtenerFila($respuesta);
                    echo $fila["mensaje"];
                }
                $conexion->cerrarConexion();
            }

        break;

        case "3":
        if(isset($_POST["id"])){
            $id = $_POST["id"];
        }
        if(isset($_POST["taller"])){
            $taller = $_POST["taller"];
        }
        if(isset($_POST["sucursal"])){
            $sucursal = $_POST["sucursal"];
        }
        if($id=="" || $id==NULL){
            $respuesta="Ingrese el id";
            echo $respuesta;
        }
        if($taller=="" || $taller==NULL){
            $respuesta="Ingrese el taller";
            echo $respuesta;
        }
        else if($sucursal=="" || $sucursal==NULL){
            $respuesta="Ingrese la sucursal";
            echo $respuesta;
        }
        else{
            $conexion = new Conexion();
            $accion = "EDITAR";
            $idSucursal = $conexion->ejecutarInstruccion("SELECT idSucursal FROM sucursal WHERE nombre='$sucursal';");
            $idSucursal = $conexion->obtenerFila($idSucursal);
            $idSucursal = $idSucursal["idSucursal"];
            $sql = "CALL SP_GESTION_TALLER('$id', '$idSucursal','$taller','$accion', @p4, @p5);";
            $salida = "SELECT @p4 AS mensaje, @p5 AS codigo;";
            $resultado = $conexion->ejecutarInstruccion($sql);
            $respuesta = $conexion->ejecutarInstruccion($salida);
            if(!$respuesta){
                echo "No hay respuesta del procedimiento";
            }
            else{
                $fila=$conexion->obtenerFila($respuesta);
                echo $fila["mensaje"];
            }
            $conexion->cerrarConexion();
        }
        break;

        case "4":
           if(isset($_POST["id"])){
               $id=$_POST["id"];
           }
            if($id=="" || $id==NULL){
               $respuesta="Ingrese el id";
               echo $respuesta;
            }
            else{
                $conexion= new conexion();
                $accion="ELIMINAR";
                $sql = "CALL SP_GESTION_TALLER('$id', @p1, @p2, '$accion', @p4, @p5);";
                $salida = "SELECT @p4 AS mensaje, @p5 AS codigo";
                $resultado = $conexion->ejecutarInstruccion($sql);
                $respuesta = $conexion->ejecutarInstruccion($salida);
                if(!$respuesta){
                    echo "No hay respuesta del procedimiento";
                }
                else{
                    $fila=$conexion->obtenerFila($respuesta);
                    echo $fila["mensaje"];
                }
                $conexion->cerrarConexion();

            }
        break;
    
        default:
            echo "No registro la opcion";
        break;
    };



?>;