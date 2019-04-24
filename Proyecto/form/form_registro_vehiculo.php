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
    <title>Registro Vehiculo</title>
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
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic" href=""
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                    src="../assets/images/users/1.jpg" alt="user" class="rounded-circle" width="31"></a>
                            <div class="dropdown-menu dropdown-menu-right user-dd animated">
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-user m-r-5 m-l-5"></i>
                                    My Profile</a>
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-wallet m-r-5 m-l-5"></i>
                                    My Balance</a>
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-email m-r-5 m-l-5"></i>
                                    Inbox</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="javascript:void(0)"><i
                                        class="ti-settings m-r-5 m-l-5"></i> Account Setting</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="javascript:void(0)"><i
                                        class="fa fa-power-off m-r-5 m-l-5"></i> Logout</a>
                                <div class="dropdown-divider"></div>
                                <div class="p-l-30 p-10"><a href="javascript:void(0)"
                                        class="btn btn-sm btn-success btn-rounded">View Profile</a></div>
                            </div>
                        </li>
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
            <div class="container-fluid" style="padding: 50px">
                <!-- ============================================================== -->
                <!-- Inicio de formulario  -->
                <!-- ============================================================== -->
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Datos del Vehiculo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Fotografias</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <div class= "row">
                            <div class="col-md-11 auth-box  border-top border-secondary float-left mx-auto text-light" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >         
                                <div class="card-body" style="text-align:center;">                            
                                    <h3 style="margin: 0px 0px 30px 0px;">Registro de vehiculo</h3>
                                    <div class="row p-2">
                                        <div class="col-sm-2">
                                            <label for="slc_color"><b>color:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select name="slc_color" id="slc_color" class="form-control border border-secondary">
                                                <option value="Azul">Azul</option>
                                                <option value="Rojo">Rojo</option>
                                                <option value="Amarillo">Amarillo</option>
                                                <option value="Verde">Verde</option>
                                                <option value="Negro">Negro</option>
                                                <option value="Gris">Gris</option>
                                                <option value="Blanco">Blanco</option>
                                                <option value="Anaranjado">Anaranjado</option>
                                            </select>
                                        </div>                            
                                        <div class="col-sm-2">
                                            <label for="txt_precioVenta"><b>Precio venta:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" id="txt_precioVenta" class="form-control border border-secondary"placeholder="Ingrese el precio venta del vehiculo">
                                        </div>                                
                                    </div>
                                
                                    <div class="row p-2" >
                                        <div class="col-sm-2">
                                            <label for="txt_precioRentaHora"><b>Precio renta/hora:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" id="txt_precioRentaHora" class="form-control border border-secondary" placeholder="Ingrese el precio renta por hora">
                                        </div>
                                        <div class="col-sm-2">
                                                <label for="txt_precioRentaDia"><b>Precio renta/dia:</b></label>
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" id="txt_precioRentaDia" class="form-control border border-secondary" placeholder="Ingrese el precio renta por dia">
                                        </div>
                                        </div>
                                    <div class="row p-2">
                                        <div class="col-sm-2">
                                            <label for="txt_placa"><b>Placa:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" id="txt_placa" class="form-control border border-secondary" pattern="[A-Za-z0-9]{7-8}" maxlength="8" required
                                                placeholder="Ingrese la placa del vehiculo">
                                        </div>
                
                                        <div class="col-sm-2">
                                            <label for="slc_inventario"><b>Inventario:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="slc_inventario" class="form-control border border-secondary">
                                                
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <div class="col-sm-2">
                                            <label for="date_fechaRegistro"><b>año:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select name="slc_anio" id="slc_anio" class="form-control border border-secondary">
                                            <?php 
                                            $year = date("Y");
                                            for ($i= date("Y"); $i >= 1945 ; $i--) {                        
                                                echo'<option VALUE="'.$i.'">'.$i.'</option>';
                                            }
                                            ?>
                                            
                                            </select>
                                        </div>
                                    
                                        <div class="col-sm-2">
                                            <label for="slc_modelo"><b>Modelo:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="slc_modelo" class="form-control border border-secondary">
                                                
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <div class="col-sm-2">
                                            <label for="slc_tipoVehiculo"><b>Tipo de vehiculo:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="slc_tipoVehiculo" class="form-control border border-secondary">
                                                
                                            </select>
                                        </div>
                                    
                                        <div class="col-sm-2">
                                            <label for="slc_tipoMotor"><b>Tipo de motor:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="slc_tipoMotor" class="form-control border border-secondary">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="row p-2">
                                        <div class="col-sm-2">
                                            <label for="slc_tipoTransmision"><b>Tipo de transmision:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="slc_tipoTransmision" class="form-control border border-secondary">
                                                
                                            </select>
                                        </div>
                                    
                                        <div class="col-sm-2">
                                            <label for="slc_Cilindraje"><b>cilindraje:</b></label>
                                        </div>
                                        <div class="col-sm-4">
                                            <select id="slc_Cilindraje" class="form-control border border-secondary">
                                                
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row p-2">
                                        <div class="col-sm-2">
                                            <label for="txt_descripcion"><b>Descripcion del vehiculo:</b></label>
                                        </div>
                                        <div class="col-sm-10 form-group">
                                            <textarea id="txt_descripcion"  class="form-control"
                                                placeholder="ingrese la descripcion del vehiculo"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class= "row">
                            <div class="col-md-6 auth-box  border-top border-dark float-left mx-auto text-light" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >
                                <div class="card-body" style="text-align:center;">
                                    <form method="post" id="form_img" enctype="multipart/form-data">
                                        <p><h3>Ingrese las fotografias del vehiculo</h3><br>
                                            <input type="file" name="file_foto[]" id="file_foto[]" multiple="">
                                        </p>
                                        <hr>
                                        <div id="div_resultado"></div>
                                    </form>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    
                </div>
                <button id="btn_agregar" type="button" class="btn btn-primary">Añadir vehiculo</button>
                <button onclick="location.href='form_vehiculos_lista.php'" type="button" class="btn btn-danger">Cancelar</button>
                <div id="div_resultado2"></div>
                <!-- ============================================================== -->
                <!-- Fin de formulario  -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
                All Rights Reserved by AutoMotor. Designed and Developed by <a
                    href="https://wrappixel.com">JCM</a>.
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
    <!-- Controlador -->
    <script src="../dist/js/js_form/js_form_registro_vehiculo.js"></script>
</body>

</html>