<?php 
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1'://llenar tabla lista empleados
        $conexion = new Conexion();

        $sql= sprintf("SELECT idEmpleado,pnombre, papellido, noIdentidad, descripcion FROM vw_empleados");
        $resultado = $conexion->ejecutarInstruccion($sql);
        $i=0;
        while ($fila= $conexion->obtenerFila($resultado)) {
            $i+=1;
            ?>
            <tr>
                <td><?php echo $i; ?></td>
                <td><?php echo $fila["noIdentidad"] ;?></td>
                <td><?php echo $fila["pnombre"], ' ' ,$fila["papellido"]; ?></td>
                <td><?php echo $fila["descripcion"] ;?></td>
                <td><a href="form_empleado.php?idEmpleado= <?php echo $fila["idEmpleado"];?>">ver</a></td>
            </tr>
            
        <?php   
        }
        
        $conexion->cerrarConexion();
        break;
        default:
        # code...
        break;
    }
?>