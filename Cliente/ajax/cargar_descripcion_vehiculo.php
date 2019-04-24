<?php
    header("Content-Type: text/html;charset=utf-8");
    include("../class/class_conexion.php");
        
    switch($_GET["accion"]){
        //Cargar las fotos
        case '1':
            $conexion = new conexion();
            $idVehiculo = $_POST["idVehiculo"];
            $sql="SELECT direccionEnDisco FROM fotos
                    WHERE idVehiculo=$idVehiculo";
            $resultado=$conexion->ejecutarInstruccion($sql);
            if(!$resultado){
                echo "No hay resultado";
            }
            else{
                echo '<!--Div Fotorama-->
                <div class="col-lg-5 col-md-5" style="background-color: rgba(255, 255, 255, 1); padding: 20px; -webkit-box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55);
                -moz-box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55);
                box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55)">
                    <div>
                        <div class="fotorama" data-width="100%" data-ratio="800/600" data-nav="thumbs"
                            data-autoplay="4000" data-fit="cover" data-loop="true" style="margin-left:auto; margin-right:auto;">';
                while($fila = $conexion->obtenerFila($resultado)){
                    $ruta = str_replace("../", " ", $fila["direccionEnDisco"]);
                    echo '<img src="'.$ruta.'">';
                }
                echo '      </div>
                        </div>
                    </div>
                    <script src="dist/js/fotorama.js"></script>
                    <!--Fin Div Fotorama-->;';
            }
            $conexion->liberarResultado($resultado);
            $conexion->cerrarConexion();  
        break;
            //Carga la informacion del vehiculo
        case '2':
            $conexion = new conexion();
            $acentos = $conexion->ejecutarInstruccion("SET NAMES 'utf8'");
            $idVehiculo = $_POST["idVehiculo"];
            $sql = "SELECT mr.descripcion AS marca, mo.descripcion AS modelo, v.Año , t.descripcion AS transmision, tm.descripcion AS motor,
                        c.descripcion AS cilindraje, v.precioVenta, precioRentaDia FROM vehiculo v
                        INNER JOIN modelo mo ON mo.idModelo=v.idVehiculo
                        INNER JOIN marca mr ON mr.idMarca=mo.idMarca
                        INNER JOIN transmision t ON t.idTransmision=v.idTransmision
                        INNER JOIN tipomotor tm ON tm.idTipoGasolina=v.idTipoGasolina
                        INNER JOIN cilindraje c ON c.idCilindraje=v.idCilindraje
                        WHERE v.idVehiculo = $idVehiculo";
            $respuesta = $conexion->ejecutarInstruccion($sql);
            if(!$respuesta){
                echo "No hay respuesta";
            }            
            else{              
                $datos = $conexion->obtenerFila($respuesta);
                echo '<div class="col-lg-1 col-md-1 col-sm-0 col-xs-0"></div>
                        <!--Div Ficha Tecnica-->
                        <div class="col-lg-5 col-md-5" style="background-color: rgba(255, 255, 255, 1); padding: 20px; -webkit-box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55);
                        -moz-box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55);
                        box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55)">
                            <div class="table-responsive">
                                <table class="table" >
                                    <thead class="thead-dark">
                                        <th colspan="2" style="text-align:center; font-size:24px">Descripcion</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">Marca:</th>
                                            <td style="border-top:0px; font-size:22px">'.$datos["marca"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Modelo:
                                            </th>
                                            <td style="border-top:0px; font-size:22px">'.$datos["modelo"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Año:
                                            </th>
                                            <td style="border-top:0px; font-size:22px">'.$datos["Año"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Transmision:
                                            </th>
                                            <td style="border-top:0px; font-size:22px">'.$datos["transmision"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Motor:
                                            </th>
                                            <td style="border-top:0px; font-size:22px">'.$datos["motor"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Cilindraje:
                                            </th>
                                            <td style="border-top:0px; font-size:22px">'.$datos["cilindraje"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Precio Venta:
                                            </th>
                                            <td style="border-top:0px; font-size:22px">L'.$datos["precioVenta"].'</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" style="border-top:0px; font-size:22px">
                                                Precio Renta (Dia):
                                            </th>
                                        <td style="border-top:0px; font-size:22px">L'.$datos["precioRentaDia"].'</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--Fin Div Ficha Tecnica-->';
            }
            $conexion->liberarResultado($respuesta);
            $conexion->cerrarConexion();  
            break;

        default:
            echo "Opcion no valida";
        break;
    }
?>