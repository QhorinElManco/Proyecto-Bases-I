<?php
    include("../class/class_conexion.php");
        
    switch($_GET["accion"]){
        //Cargar las fotos
        case '1':
            /*$conexion = new conexion();
            $idVehiculo = $_POST["idVehiculo"];
            $sql="SELECT direccionEnDisco FROM fotos
                    WHERE idVehiculo=$idVehiculo";
            $resultado=$conexion->ejecutarInstruccion($sql);
            if(!$resultado){
                echo "No hay resultado";
            }
            else{
                while($fila = $conexion->obtenerFila($resultado)){
                    echo '<img src="'.$fila["direccionEnDisco"].'">';
                }
            }*/
                            echo '<!--Div Fotorama-->
                            <div class="col-lg-5 col-md-5" style="background-color: rgba(255, 255, 255, 0.6); padding: 20px; -webkit-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                            -moz-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                            box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55)">
                                <div>
                                    <div class="fotorama" data-width="100%" data-ratio="800/600" data-nav="thumbs"
                                        data-autoplay="2000" data-fit="cover" data-loop="true" style="margin-left:auto; margin-right:auto;">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img1.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img2.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img3.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img4.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img5.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img6.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img7.jpg">
                                        <img src="assets/images/autos/Mercedez Benz Clase-G/img8.jpg">
                                    </div>
                                </div>
                            </div>
                            <script src="dist/js/fotorama.js"></script>
                            <!--Fin Div Fotorama-->';

        break;

        case '2':
            $conexion = new conexion();
            $idVehiculo = $_POST["idVehiculo"];
            $sql="SELECT precioVenta FROM vehiculo
                    WHERE idVehiculo=$idVehiculo AND precioVenta>0;";
            $resultado = $conexion->ejecutarInstruccion($sql);
            if(!$resultado){
                echo "No hay respuesta";
            }
            else{
                while($fila = $conexion->obtenerFila($resultado)){
                    $arreglo=$fila;
                }
                if(!$arreglo["precioVenta"]){
                    echo "No tiene precio venta";                    
                }
                else{
                    $sql2 = "SELECT mr.descripcion AS marca, mo.descripcion AS modelo, v.Anio, t.descripcion AS transmision, tm.descripcion AS motor,
                    c.descripcion AS cilindraje, v.precioVenta FROM vehiculo v
                    INNER JOIN modelo mo ON mo.idModelo=v.idVehiculo
                    INNER JOIN marca mr ON mr.idMarca=mo.idMarca
                    INNER JOIN transmision t ON t.idTransmision=v.idTransmision
                    INNER JOIN tipomotor tm ON tm.idTipoGasolina=v.idTipoGasolina
                    INNER JOIN cilindraje c ON c.idCilindraje=v.idCilindraje
                    WHERE v.idVehiculo = $idVehiculo";
                    $respuesta = $conexion->ejecutarInstruccion($sql2);
                    if($respuesta){
                        $datos = $conexion->obtenerFila($respuesta);
                        echo '<div class="col-lg-1 col-md-1 col-sm-0 col-xs-0"></div>
                                <!--Div Ficha Tecnica-->
                                <div class="col-lg-5 col-md-5" style="background-color: rgba(255, 255, 255, 0.9); padding: 20px; -webkit-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                                -moz-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                                box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55)">
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
                                                    <td style="border-top:0px; font-size:22px">'.$datos["Anio"].'</td>
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
                                            </tbody>
                                        </table>
                                        <br>
                                        <div style="text-align:right; width:580px"><button type="button"
                                                class="btn btn-dark btn-lg"><i class="mdi mdi-cart"> Comprar</i></button>
                                        </div>
                                    </div>
                                </div>
                                <!--Fin Div Ficha Tecnica-->';
                    }
                    else{
                        echo "No hay informacion que cargar";
                    }
                }
            

            }
            break;
            /*
            $sql = "SELECT mr.descripcion AS marca, mo.descripcion AS modelo, v.Anio, t.descripcion AS transmision, tm.descripcion AS motor,
            c.descripcion AS cilindraje, v.precioVenta FROM vehiculo v
            INNER JOIN modelo mo ON mo.idModelo=v.idVehiculo
            INNER JOIN marca mr ON mr.idMarca=mo.idMarca
            INNER JOIN transmision t ON t.idTransmision=v.idTransmision
            INNER JOIN tipomotor tm ON tm.idTipoGasolina=v.idTipoGasolina
            INNER JOIN cilindraje c ON c.idCilindraje=v.idCilindraje
            WHERE v.idVehiculo = $idVehiculo";
            $respuesta = $conexion->ejecutarInstruccion($sql);
            if($respuesta){
                $datos = $conexion->obtenerFila($respuesta);
                echo '<div class="col-lg-1 col-md-1 col-sm-0 col-xs-0"></div>
                <!--Div Ficha Tecnica-->
                <div class="col-lg-5 col-md-5" style="background-color: rgba(255, 255, 255, 0.9); padding: 20px; -webkit-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                -moz-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55)">
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
                                    <td style="border-top:0px; font-size:22px">'.$datos["Anio"].'</td>
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
                            </tbody>
                        </table>
                        <br>
                        <div style="text-align:right; width:580px"><button type="button"
                                class="btn btn-dark btn-lg"><i class="mdi mdi-cart"> Comprar</i></button>
                        </div>
                    </div>
                </div>
                <!--Fin Div Ficha Tecnica-->';
            }
            else{
                echo "No hay informacion que cargar";

            }*/
        


        default:
            echo "Opcion no valida";
        break;
    }


                /*
                <div class="col-lg-1 col-md-1 col-sm-0 col-xs-0"></div>
                                <!--Div Ficha Tecnica-->
                                <div class="col-lg-5 col-md-5" style="background-color: rgba(255, 255, 255, 0.9); padding: 20px; -webkit-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                                -moz-box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55);
                                box-shadow: 11px 10px 25px 4px rgba(0,0,0,0.55)">
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
                                                    <td style="border-top:0px; font-size:22px">'.$datos["año"].'</td>
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
                                            </tbody>
                                        </table>
                                        <br>
                                        <div style="text-align:right; width:580px"><button type="button"
                                                class="btn btn-dark btn-lg"><i class="mdi mdi-cart"> Comprar</i></button>
                                        </div>
                                    </div>
                                </div>
                                <!--Fin Div Ficha Tecnica-->*/


?>