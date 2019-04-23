<?php

include("../class/class_conexion.php");

switch($_GET["accion"]){
    case "1":
        $conexion = new Conexion();
        $sql = "SELECT (MAX(f.idFactura)+1) as codigo, f.fechaEmision FROM Factura f";
        $resultado = $conexion->ejecutarInstruccion($sql);	
        if(!$resultado){
            echo "alert(`Hay una error en la sentencia sql:`.$sql)";
        }
        else{
            while($fila=$conexion->obtenerFila($resultado)){
              
                   echo '<input type="text" readonly=”readonly” class="form-control" id="codigoFactura"
                   placeholder="'.$fila["codigo"].'"> ';
                    }
        };
       
        $conexion->liberarResultado($resultado);
        $conexion->cerrarConexion();
        break;
        case "2":
        $conexion = new Conexion();
        $sql = "SELECT  CURDATE() as fecha ";
        $resultado = $conexion->ejecutarInstruccion($sql);	
        if(!$resultado){
            echo "alert(`Hay una error en la sentencia sql:`.$sql)";
        }
        else{
            while($fila=$conexion->obtenerFila($resultado)){
              
                   echo '<input type="text" readonly=”readonly” class="form-control" id="codigoFactura"
                   placeholder="'.$fila["fecha"].'">';
                    }
        }
        $conexion->liberarResultado($resultado);
        $conexion->cerrarConexion();
        break;

        case "3":
        $conexion = new Conexion();
        $sql = "SELECT m.descripcion, m.idModelo from vehiculo vh inner join Modelo m on m.idModelo=vh.idModelo where vh.eliminado not in (1) and vh.precioVenta>0";
        $resultado = $conexion->ejecutarInstruccion($sql);	
        if(!$resultado){
            echo "alert(`Hay una error en la sentencia sql:`.$sql)";
        }
        else{
            while($fila=$conexion->obtenerFila($resultado)){
              
                   echo '<option value= "'.$fila["idModelo"].'">'.$fila["descripcion"].'</option>'
                   ; }
        }
        $conexion->liberarResultado($resultado);
        $conexion->cerrarConexion();

       break;

       

        case "4":
        $conexion = new Conexion();
        $sql = "SELECT  d.idDescuento,d.descripcion from Descuento d ";
        $resultado = $conexion->ejecutarInstruccion($sql);	
        if(!$resultado){
            echo "alert(`Hay una error en la sentencia sql:`.$sql)";
        }
        else{
            while($fila=$conexion->obtenerFila($resultado)){
              
                   echo '<option value= "'.$fila["idDescuento"].'">'.$fila["descripcion"].'</option>'
                   ; }
        }
        $conexion->liberarResultado($resultado);
        $conexion->cerrarConexion();
       
        break;
/* empleado */
        case "5":
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
        /*cliente */
        case "6":
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

        case "7":
        $conexion = new conexion();

        $sql = "SELECT fp.idFormaPago, fp.descripcion FROM FormaPago fp;";
        $resultado = $conexion->ejecutarInstruccion($sql);
        if(!$resultado){
            echo "No hay resultado de la consulta";
        }
        else{
            while($fila = $conexion->obtenerFila($resultado)){
                echo '<option value="'.$fila["idFormaPago"].'">'.$fila["descripcion"].'</option>';
            }
        }
        $conexion->cerrarConexion();
        break;
        

        case "8":
        
        if(isset($_POST["idCliente"])){
            $idCliente=$_POST["idCliente"];
        }
            if($idCliente=="" || $idCliente==NULL){
                $respuesta="Ingrese el nombre del cliente";
                echo $respuesta;
            }
            if(isset($_POST["idEmpleado"])){
                $idEmpleado=$_POST["idEmpleado"];
                
            }   
            if($idEmpleado=="" || $idEmpleado==NULL){
                $respuesta="Ingrese el nombre del Empleado";
                echo $respuesta;
            }         
             /* ------ */
            if(isset($_POST["idFormaPago"])){
                $idFormaPago = $_POST["idFormaPago"];
            }
            if($idFormaPago=="" || $idFormaPago==NULL){
                $respuesta="Ingrese la forma de pago";
                echo $respuesta;
            }
            /* ------ */
            if(isset($_POST["idTipoDescuento"])){
                $idTipoDescuento = $_POST["idTipoDescuento"];
            }
            if($idTipoDescuento=="" || $idTipoDescuento==NULL){
                $respuesta="Ingrese el tipo de descuento";
                echo $respuesta;
            }
         
             /* ------ */
             if(isset($_POST["idVehiculo"])){
                $idVehiculo=$_POST["idVehiculo"];
            }
            if($idVehiculo=="" || $idVehiculo==NULL){
                $respuesta="Ingrese el vehiculo";
                echo $respuesta;
            
              } else{
                $conexion = new Conexion();

                $sql = "CALL SP_FACTURA_VENTA('$idVehiculo', '$idCliente','$idEmpleado','$idFormaPago','$idTipoDescuento',@p3 ,@p4, @p5);";
                $salida = "SELECT @p3 as total, @p4 AS mensaje, @p5 AS codigo;";
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
        case "9":
        $conexion = new conexion();

        $sql = "SELECT max(f.total) FROM Factura f;";
        $resultado = $conexion->ejecutarInstruccion($sql);
        if(!$resultado){
            echo "No hay resultado de la consulta";
        }
        else{
            while($fila = $conexion->obtenerFila($resultado)){
                echo '<input type="text" class="form-control" id="txt_Des"
                placeholder="'.$fila["max(f.total)"].'">';
            }
        }
        $conexion->cerrarConexion();
        break;
       
        


};

?>;