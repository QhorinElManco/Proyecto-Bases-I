<
?php>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../assets/images/favicon.png">
    <title>Auto Motor</title>
    <!-- Custom CSS -->
    <link href="../assets/libs/flot/css/float-chart.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
    <style>
        label {
            color: rgba(255, 255, 255, 1)
        }
    </style>
</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <header class="topbar" data-navbarbg="skin5">
            <nav class="navbar top-navbar navbar-expand-md navbar-dark">
                <div class="navbar-header" data-logobg="skin5">
                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i
                            class="ti-menu ti-close"></i></a>
                    <!-- ============================================================== -->
                    <!-- Logo -->
                    <!-- ============================================================== -->
                    <a class="navbar-brand" href="../index.html">
                        <!-- Logo icon -->
                        <b class="logo-icon p-l-10">
                            <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                            <!-- Dark Logo icon -->
                            <img src="../assets/images/logo-icon.png" alt="homepage" class="light-logo" />

                        </b>
                        <!--End Logo icon -->
                        <!-- Logo text -->
                        <span class="logo-text">
                            <!-- dark Logo text -->
                            <img src="../assets/images/logo2.png" alt="homepage" class="light-logo" />

                        </span>
                        <!-- Logo icon -->
                        <!-- <b class="logo-icon"> -->
                        <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                        <!-- Dark Logo icon -->
                        <!-- <img src="assets/images/logo-text.png" alt="homepage" class="light-logo" /> -->

                        <!-- </b> -->
                        <!--End Logo icon -->
                    </a>
                    <!-- ============================================================== -->
                    <!-- End Logo -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Toggle which is visible on mobile only -->
                    <!-- ============================================================== -->
                    <a class="topbartoggler d-block d-md-none waves-effect waves-light" href="javascript:void(0)"
                        data-toggle="collapse" data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><i
                            class="ti-more"></i></a>
                </div>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin5">
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-left mr-auto">
                        <li class="nav-item d-none d-md-block"><a
                                class="nav-link sidebartoggler waves-effect waves-light" href="javascript:void(0)"
                                data-sidebartype="mini-sidebar"><i class="mdi mdi-menu font-24"></i></a></li>
                    </ul>
                    <!-- ============================================================== -->
                    <!-- Right side toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-right">
                        <!-- ============================================================== -->
                        <!-- Search -->
                        <!-- ============================================================== -->
                        <li class="nav-item search-box"> <a class="nav-link waves-effect waves-dark"
                                href="javascript:void(0)"><i class="ti-search"></i></a>
                            <form class="app-search position-absolute">
                                <input type="text" class="form-control" placeholder="Search &amp; enter"> <a
                                    class="srh-btn"><i class="ti-close"></i></a>
                            </form>
                        </li>
                        <!-- ============================================================== -->
                        <!-- End Search -->
                        <!-- ============================================================== -->
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->

                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                    </ul>
                </div>
            </nav>
        </header>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <aside class="left-sidebar" data-sidebarbg="skin5">
            <!-- Sidebar scroll-->
            <div class="scroll-sidebar">
                <!-- Sidebar navigation-->
                <nav class="sidebar-nav">
                    <ul id="sidebarnav" class="p-t-30">
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="../index.html" aria-expanded="false"><i class="mdi mdi-shopping"></i><span
                                    class="hide-menu">Compra</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="../charts.html" aria-expanded="false"><i class="mdi mdi-cash"></i><span
                                    class="hide-menu">Renta</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="../widgets.html" aria-expanded="false"><i class="mdi mdi-history"></i><span
                                    class="hide-menu">Historial</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="../tables.html" aria-expanded="false"><i class="mdi mdi-oil"></i><span
                                    class="hide-menu">Mantenimiento</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="../grid.html" aria-expanded="false"><i class="mdi mdi-view-grid"></i><span
                                    class="hide-menu">Repuestos</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-key"></i><span
                                    class="hide-menu">Authentication </span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="authentication-login.html" class="sidebar-link"><i
                                            class="mdi mdi-all-inclusive"></i><span class="hide-menu"> Login </span></a>
                                </li>
                                <li class="sidebar-item"><a href="authentication-register.html" class="sidebar-link"><i
                                            class="mdi mdi-all-inclusive"></i><span class="hide-menu"> Register
                                        </span></a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <!-- End Sidebar navigation -->
            </div>
            <!-- End Sidebar scroll-->
        </aside>
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div  class="container-fluid" style="padding:100px;">
                <!-- ============================================================== -->
                <!-- Inicio Formulario -->
                <!-- ============================================================== -->
                <div id='div_registro1' class="row" >
                    <div class="col-md-2"></div>
                    <!--Margen de 3 columnas a la izquierda-->
                    <div class="col-md-8 auth-box bg-dark border-top border-secondary" style='box-shadow: 10px 10px 3px rgb(158, 157, 157);'>
                        <div class="card" style="background-color: #343a40">
                                <div class="card-body" style="text-align:center;">
                                    <div class="text-center p-t-20 p-b-20">
                                        <IMG SRC="../assets/images/logo2.png">
                                    </div>
                                    <h3 style="margin: 20px 0px 30px 0px; color: rgba(255, 255, 255, 1)">Crear su cuenta
                                        de AutoMotor</h3>
                                    <input type="hidden" id="idPersona">
                                    <input type="hidden" id="idCliente">
                                    <div class="form-group row">
                                        <label class="col-sm-3 text-left control-label col-form-label">Nombres</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="txt_pnombre"
                                                placeholder="Primer nombre">
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="txt_snombre"
                                                placeholder="Segundo nombre">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-3 text-left control-label col-form-label">Apellidos</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="txt_papellido"
                                                placeholder="Primer apellido">
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="txt_saptxt_papellido"
                                                placeholder="Segundo apellido">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-3 text-left control-label col-form-label">Correo</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="txt_correo"
                                                placeholder="Correo electronico">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label
                                            class="col-sm-3 text-left control-label col-form-label">Contraseña</label>
                                        <div class="col-sm-8">
                                            <input type="password" class="form-control" id="txt_contraseña"
                                                placeholder="Ingrese su contraseña">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-3 text-left control-label col-form-label">Verifique su
                                            contraseña</label>
                                        <div class="col-sm-8">
                                            <input type="password" class="form-control" id="txt_Contraseña2"
                                                placeholder="Ingrese nuevamente la contraseña">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-3 text-left control-label col-form-label">Direccion</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="txt_direccion"
                                                placeholder="Ingrese su direccion">
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="text-align:center">
                                    <button id="btn_sig" onclick="ocultarRegistro1();" class="btn btn-success btn-lg">Siguiente</button>
                                </div>
                         </div>
                    </div>
                </div>
                <div id="div1"></div>
                <!-- Formulario parte 2 -->
                <div id='div_registro2' class="row">
                    <div class="col-md-2"></div>
                    <!--Margen de 3 columnas a la izquierda-->
                    <div class="col-md-8 auth-box bg-dark border-top border-secondary" style='box-shadow: 10px 10px 3px rgb(158, 157, 157);'>
                        <div class="card" style="background-color: #343a40">
                                <div class="card-body" style="text-align:center;">
                                    <div class="text-center p-t-20 p-b-20">
                                        <IMG SRC="../logo/logo_automotor.png"  style="margin: 0px 0px 30px 0px;"> 
                                        <h3 style="margin: 0px 0px 30px 0px; color: rgba(255, 255, 255, 1)" >Bienvenido a AutoMotor</h3>

                                        <div class="form-group row">
                                            <label class="col-sm-3 text-left control-label col-form-label">Telefono</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control border border-secondary" id="txt_telefono" maxlength="50" placeholder="Ingrese su numero de telefono">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-3 text-left control-label col-form-label">No. Identidad</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control border border-secondary" id="txt_identidad" maxlength="50" placeholder="Ingrese su numero de identidad">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="txt_fechaNacimiento"><b>Fecha de Nacimiento:</b></label>
                                            <div class="col-sm-8">
                                                <input type="date" id="date_fechaNacimiento" class="form-control border border-secondary">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="txt_Genero" class="col-sm-3 text-left control-label col-form-label"><b>Genero:</b></label>
                                            <div class="col-sm-8">
                                                <select id="slc_genero" class="form-control border border-secondary" placeholder="Ingrese su genero">
                                                    <option value="">Hombre</option>
                                                    <option value="">Mujer</option>
                                                </select>
                                            </div>                                            
                                        </div>
                                        <div class="row">
                                            <div class="col float-left" >                                           
                                                <button id="btn_atras" onclick="botonAtras();" type="button" class="btn btn-danger btn-lg">Atras</button>
                                            </div>
                                            <div class="col " >
                                                <button id="btn_sig" onclick="botonSiguiente();" type="button" class="btn btn-success btn-lg float-right">Siguiente</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                     <!-- Formulario parte 3 -->

                <div id='div_registro3' class="row">
                    <div class="col-md-2"></div>
                    <!--Margen de 3 columnas a la izquierda-->
                    <div class="col-md-8 auth-box bg-dark border-top border-secondary" style='box-shadow: 10px 10px 3px rgb(158, 157, 157);'>
                        <div class="card" style="background-color: #343a40">
                                <div class="card-body" style="text-align:center;">
                                    <div class="text-center p-t-20 p-b-20">
                                        <IMG SRC="../logo/logo_automotor.png"  style="margin: 0px 0px 30px 0px;">
                                        <h3 style="margin: 0px 0px 30px 0px;">Pivacidad y condiciones</h3>
                                        <div class="form-group row" style="color: rgba(255, 255, 255, 1)">
                                        <p>Para crear una cuenta de AutoMotor, deberás aceptar las Condiciones del servicio que se encuentran a continuación.
                                        </p>
                                        <p>Además, cuando creas una cuenta, procesamos tu información como se describe en nuestra Política de Privacidad, incluidos estos puntos clave:</p>
                                        <p>Datos que procesamos cuando usa AutoMotor
                                        Cuando configura una cuenta de AutoMotor, almacenamos la información que proporciona, como su nombre, dirección de correo electrónico y número de teléfono.
                                        </p>
                                        <p>
                                        Por ejemplo, cuando usa los servicios de AutoMotor para escribir un mensaje a nuestro sistema, almacenamos la información que genera.
                                        </p>
                                        <p>
                                        Por ejemplo, cuando busca un restaurante en AutoMotor Maps o mira las imagenes, procesamos información sobre esa actividad, lo que incluye los siguientes datos: el video que miró, los ID del dispositivo, las direcciones IP, los datos de cookie y la ubicación.
                                        </p>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <label><a href="../index.php">Cancelar</a></label>
                                        </div>
                                        <div class="col">
                                            <button id="btnGuardar" onclick="botonGuardar();" type="button" class="btn btn-primary">Acepto</button>
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
                <div id="divMensaje"><</div>
                

                <!-- ============================================================== -->
                <!-- Fin Formulario -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->


            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
                All Rights Reserved by Matrix-admin. Designed and Developed by <a
                    href="https://wrappixel.com">WrapPixel</a>.
            </footer>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="../assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="../assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="../assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="../assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="../dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="../dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="../dist/js/custom.min.js"></script>    
    <!--This page JavaScript -->
    <!-- <script src="dist/js/pages/dashboards/dashboard1.js"></script> -->
    <!-- Charts js Files -->
    <script src="../assets/libs/flot/excanvas.js"></script>
    <script src="../assets/libs/flot/jquery.flot.js"></script>
    <script src="../assets/libs/flot/jquery.flot.pie.js"></script>
    <script src="../assets/libs/flot/jquery.flot.time.js"></script>
    <script src="../assets/libs/flot/jquery.flot.stack.js"></script>
    <script src="../assets/libs/flot/jquery.flot.crosshair.js"></script>
    <script src="../assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
    <script src="../dist/js/pages/chart/chart-page-init.js"></script>

    <!--Efecto transicion div_registro's-->
    <script src="../dist/js/controlador.js"></script>
    <!--dist\js\js_form\js_form_cliente_registro.js -->
    <script src="../dist/js/js_form/js_form_cliente_registro.js"></script>

</body>

</html>