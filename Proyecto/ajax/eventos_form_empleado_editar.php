<?php 
	include_once("../class/class_conexion.php");
	switch ($_GET["accion"]) {
		case '1'://Llenar informacion
        $conexion = new Conexion();
        $idEmpleado = $_POST['idEmpleado'];

        $accion = "EDITAR";
        $sql = "SELECT idEmpleado, pnombre, snombre, papellido, sapellido, correo, cargo , noIdentidad, direccion, fechaInicio, fechaFin, nombreUsuario, contrasenia, rutaImagen, telefonos 
                FROM VW_EMPLEADO_VER 
                WHERE idEmpleado = $idEmpleado;";
        
        $resultado = $conexion->ejecutarInstruccion($sql);
        while ($fila= $conexion->obtenerFila($resultado)) { ?>

            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Datos Empleado</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Usuario</a>
                </li> 
                <li class="nav-item">
                    <a class="nav-link" id="foto-tab" data-toggle="tab" href="#foto" role="tab" aria-controls="profile" aria-selected="false">Foto</a>
                </li>                
            </ul>
            
            <div class="tab-content" id="myTabContent">
                <!-- Tab 1 -->
                
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                <div class= "row">
                        <div class="col-md-9 auth-box  border-top border-dark float-left mx-auto text-light" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >
                            <div class="card-body" style="text-align:center;">
                                <h3 style="margin: 0px 0px 30px 0px;">Datos del Empleado</h3>
                                <input type="hidden" id="idPersona">
                                <input type="hidden" id="idCliente">
                                <div class="row">
                                    <div class="col-sm-2" style="text-align: left;">
                                        <label for="txt_pnombre"><b>Nombre:</b></label>
                                    </div>
                                </div>
                                <div class="row "  >
                                    <div class="col-sm-6 p-2" >
                                        <input type="text" class="form-control border border-dark" id="txt_pnombre" maxlength="50" placeholder="Primer nombre" value="<?php echo $fila['pnombre'];?>">
                                    </div>
                                    <div class="col-sm-6 p-2" >
                                        <input value="<?php echo $fila['snombre'];?>" type="text" class="form-control border border-dark" id="txt_snombre" maxlength="50"placeholder="segundo nombre">
                                    </div>
                                    <div class="col-sm-6 p-2" >
                                        <input value="<?php echo $fila['papellido'];?>" type="text" class="form-control border border-dark" id="txt_papellido" maxlength="50" placeholder="Primer apellido">
                                    </div>
                                    <div class="col-sm-6 p-2" >
                                        <input value="<?php echo $fila['sapellido'];?>" type="text" class="form-control border border-dark" id="txt_sapellido" maxlength="50" placeholder="Segundo apellido">
                                    </div>
                                </div>
                                <div class="row" >
                                    <div class="col-sm-6" style="text-align: left;">
                                        <label for="txt_correo"><b>Correo:</b></label>
                                    </div>
                                    <div class="col-sm-6" style="text-align: left;">
                                        <label for="txt_telefono"><b>Telefono:</b></label>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0px 0px 30px 0px;">
                                    <div class="col-sm-6">
                                        <input value="<?php echo $fila['correo'];?>" type="text" id="txt_correo" class="form-control border border-dark" maxlength="50" placeholder="Ingrese su correo electronico">
                                        <span id="emailOK"></span>
                                    </div>
                                    <div class="col-sm-6 " >
                                        <input value="<?php echo $fila['telefonos'];?>" type="text" class="form-control border border-dark" id="txt_telefono" maxlength="50" placeholder="Ingrese su numero de telefono">
                                    </div>
                                </div>
                                <div class="row" >                                    
                                    <div class="col-sm-6" style="text-align: left;">
                                        <label for="slc_cargo"><b>Cargo:</b></label>
                                    </div>
                                    <div class="col-sm-6" style="text-align: left;">
                                        <label for="txt_noIdentidad"><b>no Identidad:</b></label>
                                    </div>
                                    
                                </div>
                                <div class="row" style="margin: 0px 0px 30px 0px;">
                                    
                                    <div class="col-sm-6">
                                        <select  id="slc_cargo" class="form-control border border-dark">
                                        </select>
                                    </div>
                                    <div class="col-sm-6 " >
                                        <input value="<?php echo $fila['noIdentidad'];?>" type="text" class="form-control border border-dark" id="txt_noIdentidad" maxlength="50" placeholder="Ingrese su numero de identidad">
                                    </div>
                                    
                                </div>
                                <div class="row">
                                    <div class="col" style="text-align: left;">
                                        <label for="txt_direccion"><b>Direccion:</b></label>
                                    </div>
                                </div>
                                <div class="row p-1">
                                    <div class="col" >
                                        <textarea value="" name="txt_direccion" id="txt_direccion" cols="80" rows="3" class="form-control border border-dark "><?php echo $fila['direccion'];?></textarea>
                                    </div>
                                </div>
                                <div class="row" >
                                    <div class="col-sm-6" style="text-align: left;">
                                        <label for="date_fechaInicio"><b>Fecha de inicio:</b></label>
                                    </div>
                                    <div class="col-sm-6" style="text-align: left;">
                                        <label for="date_fechaFin"><b>Fecha fin:</b></label>
                                    </div>                                        
                                </div>
                                <div class="row" style="margin: 0px 0px 30px 0px;">
                                    <div class="col-sm-6">
                                        <input value="<?php echo $fila['fechaInicio'];?>" type="date" id="date_fechaInicio" class="form-control border border-dark">
                                    </div>
                                    <div class="col-sm-6">
                                        <input value="<?php echo $fila['fechaFin'];?>" type="date" id="date_fechaFin" class="form-control border border-dark">
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <!-- /Tab 1 -->
                <!-- Tab 2 -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class= "row">
                        <div class="col-md-6 auth-box  border-top border-dark float-left mx-auto text-light" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >
                            <div class="card-body" style="text-align:center;">
                                <h3 style="margin: 0px 0px 30px 0px;">ingresar usuario</h3>
                                
                                
                                <div class="row" >
                                    <div class="col-sm-3">
                                        <label for="txt_usuario"><b>Usuario:</b></label>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0px 0px 30px 0px;">
                                    <div class="col">
                                        <input value="<?php echo $fila['nombreUsuario'];?>" type="text" id="txt_usuario" class="form-control border border-dark" maxlength="50" placeholder="Ingrese su nombre de usuario">
                                    </div>
                                </div>
                                <div class="row" >
                                    <div class="col-sm-2">
                                        <label for="txt_contraseña"><b>Contraseña:</b></label>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0px 0px 30px 0px;">
                                    <div class="col-sm-6">
                                        <input value="<?php echo $fila['contrasenia'];?>" type="password" id="txt_contraseña" class="form-control border border-dark" maxlength="50" placeholder="Ingrese su contraseña">

                                    </div>
                                    <input type="hidden" value="<?php echo $fila['contrasenia'];?>">
                                    <div class="col-sm-6">
                                        <input  type="password" id="txt_contraseña2" class="form-control border border-dark" maxlength="50" placeholder="Reingrese su contraseña">
                                        <span id="contraseña2ok"></span>
                                    </div>
                                </div>                                    
                            </div>
                        </div>
                    </div>
                    
                    
                </div>
                <!-- /Tab 2 -->
                <div class="tab-pane fade" id="foto" role="tabpanel" aria-labelledby="foto-tab">
                    <div class= "row">
                        <div class="col-md-6 auth-box  border-top border-dark float-left mx-auto text-light" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >
                            <div class="card-body" style="text-align:center;">
                                <form method="post" id="form_img" enctype="multipart/form-data">
                                    <p><h3>Elije la foto del empleado</h3><br>
                                        <input value="<?php echo $fila['rutaImagen'];?>" type="file" name="file_foto" id="file_foto">
                                    </p>
                                    <hr>
                                    <div id="div_resultado"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>

        <?php    
        }
        
        
        
        $conexion->cerrarConexion();
        break;
        case '2':
            $conexion = new Conexion();
            $idEmpleado = $_POST['idEmpleado'];
            

            $accion = "EDITAR";
            $sql = "CALL SP_GESTION_EMPLEADO('','','','','','','','','','','','',' ','','$idEmpleado','$accion',@p17,@p18);";
            $salida = "SELECT @p17 AS OcurreError, @p18 AS mensaje;";
            $resultado = $conexion->ejecutarInstruccion($sql);
            $respuesta = $conexion->ejecutarInstruccion($salida);
            
            if (!$respuesta) {
                echo 'No hay respuesta del procedimiento';
            }
            else {
                $fila = $conexion->obtenerFila($respuesta);
                echo 'Ocurre error: '.$fila["OcurreError"].'<br>mensaje: '. $fila["mensaje"];
            }
            
            $conexion->cerrarConexion();
        break;
        default:
        # code...
        break;
    }
?>