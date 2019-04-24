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
    <?php 
?>
</head>
<style>
    a {
        color: yellow;
    }

    a:hover {
        color: yellow;
    }

    a:visited {
        color:
    }
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
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic" href=""
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                    src="assets/images/users/1.jpg" alt="user" class="rounded-circle" width="31"></a>
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
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-car"></i><span
                                    class="hide-menu">Vehiculos</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="ver_todos_autos.php" class="sidebar-link"><i
                                            class="mdi mdi-car"></i><span class="hide-menu">
                                            Ver todos
                                        </span></a></li>
                                <li class="sidebar-item"><a href="lista_autos_venta.php" class="sidebar-link"><i
                                            class="mdi mdi-shopping"></i><span class="hide-menu">Vehiculos en
                                            venta</span></a></li>
                                <li class="sidebar-item"><a href="lista_autos_renta.php" class="sidebar-link"><i
                                            class="mdi mdi-cash"></i><span class="hide-menu"> Vehiculos en
                                            renta</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="quienes_somos.php" aria-expanded="false"><i
                                    class="fas fa-users"></i><span class="hide-menu">Quienes somos</span></a>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="service.php" aria-expanded="false"><i class="fas fa-handshake"></i><span
                                    class="hide-menu">Servicios</span></a></li>
                                    <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="sucursal.php" aria-expanded="false"><i class="mdi mdi-google-maps"></i><span
                                    class="hide-menu">Sucursales</span></a></li>
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
            <div class="container-fluid" style="padding: 0px; background-color:black">
                <!-- ============================================================== -->
                <!-- Banner Principal -->
                <!-- ============================================================== -->
                <div class="row">
                <div class="col-12"  style="padding:30px;padding-bottom:0px">
                        <div class="card" style="margin-top:10px; margin-right:0px;margin-left:10px;text-align:center">
                        
                            <div class="card-body" style="margin-left:20px;margin-right:20px;margin-top:10px;margin-bottom:10px;background-color:rgba(128, 128, 128,0.1);border-right-color:black">
                           <div class="text-center p-t-20 p-b-20" style="margin-right:0px">
                                        <IMG SRC="logo/logo_automotor.PNG">
                                    </div >
                                     <hr style="height:4px; background-color:#3e5569">
                                
                                    
                                    <h5 class="card-title" style="margin-bottom:10px;margin-top:10px;color:black; font-size:20px; font-weight:700; font-family:Comic Sans MS">CONOCE NUESTRAS SUCURSALES</h5>
                              <hr style="height:4px; background-color:#3e5569">
                            </div>
                        </div>
                    </div>
                    <div class="row el-element-overlay" style="padding:40px; padding-top:0px">
                    <!--Tarjeta-->
                    <div class="col-lg-4 col-md-6">
                        <div class="card">
                            <div class="el-card-item">
                                <div class="el-card-avatar el-overlay-1"> <img
                                        src="assets/images/sucursal/sucursal9.jpg" alt="user" />
                                    <div class="el-overlay">
                                    </div>
                                </div>
                                <div class="el-card-content">
                                    <h4 class="m-b-0">TEGUCIGALPA</h4> <span class="text-muted">Carrizal</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tarjeta Fin-->
                    <!--Tarjeta-->
                    <div class="col-lg-4 col-md-6">
                        <div class="card">
                            <div class="el-card-item">
                                <div class="el-card-avatar el-overlay-1"> <img
                                        src="assets/images/sucursal/sucursal2.jpg" alt="user" />
                                    <div class="el-overlay">
                                    </div>
                                </div>
                                <div class="el-card-content">
                                    <h4 class="m-b-0">SAN PEDRO SULA</h4> <span class="text-muted">Brisas de Canadá</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tarjeta Fin-->
                    <!--Tarjeta-->
                    <div class="col-lg-4 col-md-6">
                        <div class="card">
                            <div class="el-card-item">
                                <div class="el-card-avatar el-overlay-1"> <img
                                        src="assets/images/sucursal/sucursal3.jpeg" alt="user" />
                                    <div class="el-overlay">
                                    </div>
                                </div>
                                <div class="el-card-content">
                                    <h4 class="m-b-0">COMAYGUA</h4> <span class="text-muted">Los Hidalgos</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tarjeta Fin-->
                    <!--Tarjeta-->
                    <div class="col-lg-4 col-md-6">
                        <div class="card">
                            <div class="el-card-item">
                                <div class="el-card-avatar el-overlay-1"> <img
                                        src="assets/images/sucursal/sucursal4.jpg" alt="user" />
                                    <div class="el-overlay">
                                    </div>
                                </div>
                                <div class="el-card-content">
                                    <h4 class="m-b-0">TELA</h4> <span class="text-muted">Villa Franca</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tarjeta Fin-->
                    <!--Tarjeta-->
                    <div class="col-lg-4 col-md-6">
                        <div class="card">
                            <div class="el-card-item">
                                <div class="el-card-avatar el-overlay-1"> <img src="assets/images/sucursal/sucursal5.jpg"
                                        alt="user" />
                                    <div class="el-overlay">
                                    </div>
                                </div>
                                <div class="el-card-content">
                                    <h4 class="m-b-0">CHOLUTECA</h4> <span class="text-muted">La Sabana</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tarjeta Fin-->
                    <!--Tarjeta-->
                    <div class="col-lg-4 col-md-6">
                        <div class="card">
                            <div class="el-card-item">
                                <div class="el-card-avatar el-overlay-1"> <img
                                        src="assets/images/sucursal/sucursal6.jpg" alt="user" />
                                    <div class="el-overlay">
                                    </div>
                                </div>
                                <div class="el-card-content">
                                    <h4 class="m-b-0">Hummer H3 2007</h4> <span class="text-muted">Ver detalles</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tarjeta Fin-->
                </div>
                    
                </div>
                <!-- ============================================================== -->
                <!-- Fin Banner Principal -->
                <!-- ============================================================== -->
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

</body>

</html>