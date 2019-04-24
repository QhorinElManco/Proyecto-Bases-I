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
    <title>Editar Cliente</title>
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
    <div id="main-wrapper" data-sidebartype="mini-sidebar" class="mini-sidebar">
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
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-edit"></i><span
                                    class="hide-menu">Clientes</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="form_cliente_registro.php" class="sidebar-link"><i
                                            class="mdi mdi-account-plus"></i><span class="hide-menu">Agregar cliente
                                        </span></a></li>
                                <li class="sidebar-item"><a href="form_cliente_lista.php" class="sidebar-link"><i
                                            class="mdi mdi-format-list-numbers"></i><span class="hide-menu">Lista de clientes</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-key"></i><span
                                    class="hide-menu">Empleados</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="form_empleado_registro_1.php" class="sidebar-link"><i
                                            class="mdi mdi-account-plus"></i><span class="hide-menu">Agregar empleado
                                        </span></a></li>
                                <li class="sidebar-item"><a href="form_empleado_lista.php" class="sidebar-link"><i
                                            class="mdi mdi-format-list-numbers"></i><span class="hide-menu">Lista de empleados</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-car"></i><span
                                    class="hide-menu">Vehiculos</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                            <li class="sidebar-item"><a href="form_registro_vehiculo.php" class="sidebar-link"><i
                                            class="fas fa-car"></i><span class="hide-menu">
                                            Agregar vehiculo
                                        </span></a></li>
                                <li class="sidebar-item"><a href="../ver_todos_autos.php" class="sidebar-link"><i
                                            class="mdi mdi-car"></i><span class="hide-menu">
                                            Ver todos
                                        </span></a></li>
                                <li class="sidebar-item"><a href="../lista_autos_venta.php" class="sidebar-link"><i
                                            class="mdi mdi-shopping"></i><span class="hide-menu">Vehiculos en
                                            venta</span></a></li>
                                <li class="sidebar-item"><a href="../lista_autos_renta.php" class="sidebar-link"><i
                                            class="mdi mdi-cash"></i><span class="hide-menu"> Vehiculos en
                                            renta</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-receipt"></i><span
                                    class="hide-menu">Solicitud mantenimiento </span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="../agregar_solicitud_mantenimiento.php"
                                        class="sidebar-link"><i class="mdi mdi-playlist-plus"></i><span
                                            class="hide-menu">
                                            Agregar solicitud
                                        </span></a></li>
                                <li class="sidebar-item"><a href="../ver_solicitud_mantenimiento.php"
                                        class="sidebar-link"><i class="mdi mdi-format-list-bulleted"></i><span
                                            class="hide-menu"> Ver las
                                            solicitudes </span></a></li>
                            </ul>
                        </li>
                        
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-calculator"></i><span
                                    class="hide-menu">Facturacion</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="../Factura_venta.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Venta
                                        </span></a>
                                </li>
                                <li class="sidebar-item"><a href="../Factura_renta.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Renta
                                        </span></a></li>
                                <li class="sidebar-item"><a href="Factura_mantenimiento.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura
                                            Mantenimiento
                                        </span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="../solicitud_renta.php" aria-expanded="false"><i class="mdi mdi-calendar-multiple"></i><span
                                    class="hide-menu">Solicitud renta</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="gestion_sucursal.php" aria-expanded="false"><i class="mdi mdi-shopping"></i><span
                                    class="hide-menu">Gestion Sucursal</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="gestion_taller.php" aria-expanded="false"><i class="mdi mdi-engine"></i><span
                                    class="hide-menu">Gestion de talleres</span></a></li>


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
            <div id="" class="container-fluid" style="padding: 50px">
                <!-- ============================================================== -->
                <!-- Inicio Formulario -->
                <!-- ============================================================== -->
                <div id="div_respuesta"></div>
                <input type="hidden" id="txt_idCliente"name="txt_idCliente" value="<?php echo $_GET["idCliente"];?>">
                
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
                                    <h3 style="margin: 0px 0px 30px 0px;">Datos del Cliente</h3>

                                    <div class="row">
                                        <div class="col-sm-2" style="text-align: left;">
                                            <label for="txt_pnombre"><b>Nombre:</b></label>
                                        </div>
                                    </div>
                                    <div class="row "  >
                                        <div class="col-sm-6 p-2" >
                                            <input type="text" class="form-control border border-dark" id="txt_pnombre" maxlength="50" placeholder="Primer nombre" value="">
                                        </div>
                                        <div class="col-sm-6 p-2" >
                                            <input value="" type="text" class="form-control border border-dark" id="txt_snombre" maxlength="50"placeholder="segundo nombre">
                                        </div>
                                        <div class="col-sm-6 p-2" >
                                            <input value="" type="text" class="form-control border border-dark" id="txt_papellido" maxlength="50" placeholder="Primer apellido">
                                        </div>
                                        <div class="col-sm-6 p-2" >
                                            <input value="" type="text" class="form-control border border-dark" id="txt_sapellido" maxlength="50" placeholder="Segundo apellido">
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
                                            <input value="" type="text" id="txt_correo" class="form-control border border-dark" maxlength="50" placeholder="Ingrese su correo electronico">
                                            <span id="emailOK"></span>
                                        </div>
                                        <div class="col-sm-6 " >
                                            <input value="" type="text" class="form-control border border-dark" id="txt_telefono" maxlength="50" placeholder="Ingrese su numero de telefono">
                                        </div>
                                    </div>
                                    <div class="row" >                                    
                                        
                                        <div class="col-sm-6" style="text-align: left;">
                                            <label for="txt_noIdentidad"><b>no Identidad:</b></label>
                                        </div>
                                        
                                    </div>
                                    <div class="row" style="margin: 0px 0px 30px 0px;">
                                        
                                        <div class="col-sm-6 " >
                                            <input value="" type="text" class="form-control border border-dark" id="txt_noIdentidad" maxlength="50" placeholder="Ingrese su numero de identidad">
                                        </div>
                                        
                                    </div>
                                    <div class="row">
                                        <div class="col" style="text-align: left;">
                                            <label for="txt_direccion"><b>Direccion:</b></label>
                                        </div>
                                    </div>
                                    <div class="row p-1">
                                        <div class="col" >
                                            <textarea value="" name="txt_direccion" id="txt_direccion" cols="80" rows="3" class="form-control border border-dark "></textarea>
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
                                            <input value="" type="text" id="txt_usuario" class="form-control border border-dark" maxlength="50" placeholder="Ingrese su nombre de usuario">
                                        </div>
                                    </div>
                                    <div class="row" >
                                        <div class="col-sm-2">
                                            <label for="txt_contraseña"><b>Contraseña:</b></label>
                                        </div>
                                    </div>
                                    <div class="row" style="margin: 0px 0px 30px 0px;">
                                        <div class="col-sm-6">
                                            <input value="" type="password" id="txt_contraseña" class="form-control border border-dark" maxlength="50" placeholder="Ingrese su contraseña">

                                        </div>
                                        <div class="col-sm-6">
                                            <input value="" type="password" id="txt_contraseña2" class="form-control border border-dark" maxlength="50" placeholder="Reingrese su contraseña">
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
                                            <input value="" type="file" name="file_foto" id="file_foto">
                                        </p>
                                        <hr>
                                        <div id="div_resultado">
                                        <img id="img" src='' alt='Producto' class='img-responsive img-thumbnail' width='250' height='200'>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
                
                <button id="btn_editar" type="button" class="btn btn-primary">Editar Empleado</button>
                <button id="btn_cancelar" type="button" class="btn btn-danger">Cancelar</button>
                <div id="div_resultado2"></div>


                
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
    <!-- controlador -->
    <script src="../dist/js/js_form/js_form_cliente_editar.js"></script>
    
</body>

</html>