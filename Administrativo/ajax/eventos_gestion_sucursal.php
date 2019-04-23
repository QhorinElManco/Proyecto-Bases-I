<?php
    include("../class/class_conexion.php");
    switch($_GET["accion"]){
        case "1":
            $conexion = new Conexion();
            $acentos = $conexion->ejecutarInstruccion("SET NAMES 'utf8'");
            $sql = "SELECT idSucursal, nombre, direccion FROM sucursal";
            $resultado = $conexion->ejecutarInstruccion($sql);	
            if(!$resultado){
                echo "Hay una error en la sentencia sql: ".$sql;
            }
            else{
                while($fila=$conexion->obtenerFila($resultado)){
                    
                    echo '<tr>
                                <th scope="row">'.$fila["idSucursal"].'</th>
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
            if(isset($_POST["nombre"])){
                $nombre = $_POST["nombre"];
            }
            if(isset($_POST["direccion"])){
                $direccion = $_POST["direccion"];
            }
            if($nombre=="" || $nombre==NULL){
                $respuesta="Ingrese el nombre";
                echo $respuesta;
            }
            else if($direccion=="" || $direccion==NULL){
                $respuesta="Ingrese la direccion";
                echo $respuesta;
            }
            else{
                $conexion = new Conexion();
                $accion = "AGREGAR";
                $sql = "CALL SP_GESTION_SUCURSAL('0', '$nombre','$direccion','$accion', @p4, @p5);";
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
            if(isset($_POST["nombre"])){
                $nombre = $_POST["nombre"];
            }
            if(isset($_POST["direccion"])){
                $direccion = $_POST["direccion"];
            }
            if($id=="" || $id==NULL){
                $respuesta="Ingrese el id";
                echo $respuesta;
            }
            if($nombre=="" || $nombre==NULL){
                $respuesta="Ingrese el nombre";
                echo $respuesta;
            }
            else if($direccion=="" || $direccion==NULL){
                $respuesta="Ingrese la direccion";
                echo $respuesta;
            }
            else{
                $conexion = new Conexion();
                $accion = "EDITAR";
                $sql = "CALL SP_GESTION_SUCURSAL('$id', '$nombre','$direccion','$accion', @p4, @p5);";
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
                $sql="CALL SP_GESTION_SUCURSAL('$id', @p1, @p2, '$accion', @p4, @p5);";
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

?>