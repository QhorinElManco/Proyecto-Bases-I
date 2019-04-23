<?php 
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1'://llenar tabla lista empleados
        $conexion = new Conexion();
        
        $sql= sprintf("SELECT c.idCliente, p.noIdentidad, CONCAT(p.pnombre,' ', p.snombre, ' ', p.papellido, ' ', p.sapellido) nombre, u.nombreUsuario FROM Cliente c
        INNER JOIN Persona p ON p.idPersona = c.idPersona
        INNER JOIN Usuario u ON u.idUsuario = c.idUsuario");
        $resultado = $conexion->ejecutarInstruccion($sql);
        $i=0;
        while ($fila= $conexion->obtenerFila($resultado)) { 
            $i+=1;
            ?>
            <tr>
                <td><?php echo $i; ?></td>
                <td><?php echo $fila["noIdentidad"] ;?></td>
                <td><?php echo $fila["nombre"]; ?></td>
                <td><?php echo $fila["nombreUsuario"] ;?></td>
                <td><a href="form_cliente.php?idCliente= <?php echo $fila["idCliente"];?>">ver</a></td>
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