<?php

include("../class/class_conexion.php");
    switch($_GET["accion"]){

       /* empleado */
       case "1":
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
       case "2":
       $conexion = new conexion();

       $sql = "SELECT c.idCliente, CONCAT_WS(' ',p.pnombre, p.snombre, papellido, sapellido) AS NombreCompleto FROM cliente c INNER JOIN persona p ON p.idPersona=c.idPersona";
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

/*vehiculo */
        case '3':
        $conexion = new conexion();

        $sql = "SELECT v.idVehiculo, m.descripcion FROM vehiculo v INNER JOIN modelo m ON m.idModelo=v.idModelo";
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

    case '4':
    $conexion = new Conexion();
    $sql = "SELECT (MAX(sr.idSolicitudRenta)+1) as codigo FROM SolicitudRenta sr";
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

    

    case 'agregar':
    if(isset($_POST["idVehiculo"])){
         $idVehiculo=$_POST["idVehiculo"];
     }
     if(isset($_POST["idEmpleado"])){
         $idEmpleado=$_POST["idEmpleado"];
     }            
               
     if(isset($_POST["idCliente"])){
         $idCliente=$_POST["idCliente"];
     }
     if(isset($_POST["fechaEntrega"])){
         $fechaEntrega=$_POST["fechaEntrega"];
     }
     if(isset($_POST["fechaDevolucion"])){
        $fechaDevolucion=$_POST["fechaDevolucion"];
    }  
    if(isset($_POST["estado"])){
        $estado=$_POST["estado"];
    }  
    
    if(isset($_POST["tiempoRenta"])){
        $tiempoRenta=$_POST["tiempoRenta"];
    }
        
     $conexion=new conexion();
     
     $accion="AGREGAR";
     $sql="CALL SP_SOLICITUD_RENTA('null','$idVehiculo','$idEmpleado','$idCliente','$fechaEntrega','$fechaDevolucion','$accion','$estado', '$tiempoRenta', @p8,@p9);";
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
 

 
    
    
    
    }


    



?>