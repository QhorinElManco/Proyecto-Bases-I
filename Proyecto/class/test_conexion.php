<?php	
	
	include_once("class_conexion.php");
	$conexion = new Conexion();	

    $resultado = $conexion->ejecutarInstruccion(
        'SELECT idpersona, concat (pnombre, snombre, papellido, sapellido) nombre FROM persona'
        );
	echo '<table border="1px">';
	while($fila = $conexion->obtenerFila($resultado)){
        echo "<tr>";
        echo "<td>". $fila["idpersona"]. "</td>"; 
        echo "<td>". $fila["nombre"]. "</td>";        
		echo "</tr>";
	}
    echo "</table>";
    
	$conexion->liberarResultado($resultado);
	$conexion->cerrarConexion();

?>