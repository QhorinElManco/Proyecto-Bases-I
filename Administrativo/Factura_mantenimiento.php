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
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title>Auto Motor</title>
    <!-- Custom CSS -->
    <link href="assets/libs/flot/css/float-chart.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<style>
    label{color:white;}
    </style>

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
                    <a class="navbar-brand" href="index.php">
                        <!-- Logo icon -->
                        <b class="logo-icon p-l-10">
                            <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                            <!-- Dark Logo icon -->
                            <img src="assets/images/logo-icon.png" alt="homepage" class="light-logo" />

                        </b>
                        <!--End Logo icon -->
                        <!-- Logo text -->
                        <span class="logo-text">
                            <!-- dark Logo text -->
                            <img src="assets/images/logo2.png" alt="homepage" class="light-logo" />

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
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-calculator"></i><span
                                    class="hide-menu">Facturacion</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="Factura_venta.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Venta </span></a>
                                </li>
                                <li class="sidebar-item"><a href="Factura_renta.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Renta
                                        </span></a></li>
                                 <li class="sidebar-item"><a href="Factura_mantenimiento.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Mantenimiento
                                        </span></a></li>
                            </ul>
                        </li>
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
        <div class="page-wrapper" style="background-color:rgb(0,0,0)">
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid" style="background-image: url(assets/images/background/img3.jpg); background-repeat: repeat; background-size:cover;  width: 100%; height: 100vh; ">
                <!-- ============================================================== -->
                <!-- Inicio Formulario -->
                <!-- ============================================================== -->
               
                        <div class="row" style="" >
                        
                        
                            <!--Margen de 3 columnas a la izquierda-->
                            <div class="col-md-6 auth-box  border-top border-secondary float-left mx-auto" style="background-color:rgba(52, 58, 64,0.8)" >
                
                                <form class="form-horizontal">
                                <div class="card-body" style="text-align:center;">
                                <div class="text-center p-t-20 p-b-20">
                                        <IMG SRC="assets/images/logo2.png">
                                    </div>
                                    <h3 style="margin: 0px 0px 30px 0px; color:white;">FACTURA DE VENTA</h3>
                                                <input type="hidden" id="idPersona">
                                                <input type="hidden" id="idCliente">
                                               <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label" >Codigo de Factura</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="txt_codigoFactura"
                                                                placeholder="Codigo No">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Fecha</label>
                                                        <div class="col-sm-9">
                                                        <input type="text" class="form-control" id="datepicker-autoclose"
                                        placeholder="mm/dd/yyyy">
                                                        </div>
                                                    </div>
                                                 <div class="form-group row">
                                                    <label class="col-sm-3 text-left control-label col-form-label">Nombre Cliente</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="txt_pnombre"
                                                            placeholder="Primer nombre">
                                                    </div>
                                                    <div class="col-sm-5">
                                                        <input type="text" class="form-control" id="txt_snombre"
                                                            placeholder="Segundo nombre">
                                                    </div>
                                                 </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-3 text-left control-label col-form-label">Apellidos Cliente</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="txt_papellido"
                                                            placeholder="Primer apellido">
                                                    </div>
                                                    <div class="col-sm-5">
                                                        <input type="text" class="form-control" id="txt_saptxt_papellido"
                                                            placeholder="Segundo apellido">
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-sm-3 text-left control-label col-form-label">Nombre Empleado</label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="txt_pnombre"
                                                            placeholder="Primer nombre">
                                                    </div>
                                                     <div class="col-sm-5">
                                                        <input type="text" class="form-control" id="txt_papellido"
                                                            placeholder="Primer apellido">
                                                    </div>                                         
                                                                                     
                                                </div>
                                                <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Vehiculo</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="txt_vehiculo"
                                                                placeholder="Vehiculo">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Tipo de Mantenimiento</label>
                                                        <div class="col-sm-9">
                                                        <select name="tipoMantenimiento" id="tipoMantenimiento" class="form-control border border-secondary" maxlength="50">
                                                        <option value="1">Cambio de aceite</option>
                                                            <option value="2">Cambio de bujias</option>
                                                            <option value="3">Cambio de LLantas</option>
                                                            <option value="4">Cambio de motor</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-6 text-center control-label col-form-label">Fecha Entrada</label>
                                                        <label class="col-sm-6 text-center control-label col-form-label">Fecha Salida</label>
                                                    </div>
                                                    <div class="form-group row">
                                                       <div class="col-sm-6">
                                                            <input type="Date" class="form-control" id="txt_fechaEntrada"
                                                               >
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input type="Date" class="form-control" id="txt_fechaSalida"
                                                               >
                                                        </div>
                                                      
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Precio por Mantenimiento</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="txt_totalVenta"
                                                                placeholder="Total">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Impuesto</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="txt_Imp"
                                                                placeholder="Impuesto">
                                                        </div>
                                                    </div>
                                                     <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label"> Tipo de Descuento</label>
                                                        <div class="col-sm-9">
                                                        
                                                        <select type="text" id="tipoDescuento" class="form-control border border-secondary" maxlength="50">
                                                            <option value="1">Tercera Edad</option>
                                                            <option value="2">Familiares y amigos</option>
                                                            <option value="3">Navidad</option>
                                                            <option value="4">Año Nuevo</option>
                                                        </select>
                                                    
                                                        </div>
                                                    </div>
                                                     <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Descuento</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="txt_Des"
                                                                placeholder="Descuento">
                                                        </div>
                                                    </div>

                                                     <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Total</label>
                                                        <div class="col-sm-9">
                                                            <input type="text" class="form-control" id="txt_Total"
                                                                placeholder="Total">
                                                        </div>
                                                    </div>
                                            </div>
                                                    <div class="card-body" style="text-align:center;">
                                    <button type="button" class="btn btn-success" style=" background-color:#2F4F4F; border-color:white ">IMPRIMIR</button>
                                </div>
                                </form>
                                
                            </div>

                        
                        </div>

                 </div> 
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->


            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
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
    <script src="assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="dist/js/custom.min.js"></script>
    <!--This page JavaScript -->
    <!-- <script src="dist/js/pages/dashboards/dashboard1.js"></script> -->
    <!-- Charts js Files -->
    <script src="assets/libs/flot/excanvas.js"></script>
    <script src="assets/libs/flot/jquery.flot.js"></script>
    <script src="assets/libs/flot/jquery.flot.pie.js"></script>
    <script src="assets/libs/flot/jquery.flot.time.js"></script>
    <script src="assets/libs/flot/jquery.flot.stack.js"></script>
    <script src="assets/libs/flot/jquery.flot.crosshair.js"></script>
    <script src="assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
    <script src="dist/js/pages/chart/chart-page-init.js"></script>
    <script src="assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>

</body>

</html> 