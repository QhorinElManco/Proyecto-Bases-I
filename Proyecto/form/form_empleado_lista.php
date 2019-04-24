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
    <title>Lista de Empleados</title>
    <!-- Custom CSS -->
    <link href="../assets/libs/flot/css/float-chart.css" rel="stylesheet">
    <link href="../assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
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
                                href="javascript:void(0)" aria-expanded="false"><i
                                    class="mdi mdi-account-edit"></i><span class="hide-menu">Clientes</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="form_cliente_registro.php" class="sidebar-link"><i
                                            class="mdi mdi-account-plus"></i><span class="hide-menu">Agregar cliente
                                        </span></a></li>
                                <li class="sidebar-item"><a href="form_cliente_lista.php" class="sidebar-link"><i
                                            class="mdi mdi-format-list-numbers"></i><span class="hide-menu">Lista de
                                            clientes</span></a></li>
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
                                            class="mdi mdi-format-list-numbers"></i><span class="hide-menu">Lista de
                                            empleados</span></a></li>
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
                                href="../solicitud_renta.php" aria-expanded="false"><i
                                    class="mdi mdi-calendar-multiple"></i><span class="hide-menu">Solicitud
                                    renta</span></a></li>
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
        <div class="page-wrapper"
            style="background-image: url(../assets/images/background/img3.jpg); background-repeat: no-repeat; background-size:cover;  width: 100%; height: 100vh; ">
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid" style="padding:0px; ">
                <div style="background-color: rgba(0, 0, 0, 0.5) ;width:100%; height:100%">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div style="width:80%; margin: auto;">
                        <div class="row el-element-overlay" style="padding-top:100px;">
                            <div class="col-lg-2 col-md-2 col-sm-0 col-xs-0">
                            </div>
                            <!--Div Tabla de sucursales-->
                            <div class="col-lg-8 col-md-8" style="background-color: rgba(255, 255, 255); padding:10px; -webkit-box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55);
                        -moz-box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55);
                        box-shadow: 11px 10px 25px 4px rgba(255,255,255,0.55)">

                                <div class="card" style="background-color: rgba(255, 255, 255)">
                                    <div class="card-body">
                                        <h5 class="card-title m-b-0">Lista de solicitudes</h5>
                                    </div>
                                    <div class="table-responsive">
                                        <table id="zero" class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>No Identidad</th>
                                                    <th>Nombre </th>
                                                    <th>Cargo</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php 
                                                    include("../class/class_conexion.php");
                                                    $conexion = new Conexion();
                                                    $sql= sprintf("SELECT idEmpleado,pnombre, papellido, noIdentidad, descripcion FROM vw_empleados");
                                                    $resultado = $conexion->ejecutarInstruccion($sql);
                                                    $i=0;
                                                    while ($fila= $conexion->obtenerFila($resultado)) {
                                                        $i+=1;
                                                        
                                                        echo '<tr>
                                                                <th scope="row">'.$i.'</th>
                                                                <td>'.$fila["noIdentidad"].'</td>
                                                                <td>'.$fila["pnombre"].' '.$fila["papellido"].'</td>
                                                                <td>'.$fila["descripcion"].'</td>
                                                                <td><a href="form_empleado.php?idEmpleado='.$fila["idEmpleado"].'">ver</a></td>
                                                            </tr>';
                                                    }
                                                    $conexion->liberarResultado($resultado);
                                                    $conexion->cerrarConexion();
                                                    ?>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>




                            </div>
                            <!--Fin Div Tabla de sucursales-->
                            <div class="col-lg-2 col-md-2 col-sm-0 col-xs-0"></div>
                        </div>
                        <!-- ============================================================== -->
                        <!-- End PAge Content -->
                        <!-- ============================================================== -->
                        <!-- ============================================================== -->
                        <!-- Right sidebar -->
                        <!-- ============================================================== -->
                        <!-- .right-sidebar -->
                        <!-- ============================================================== -->
                        <!-- End Right sidebar -->
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
        <script src="../assets/libs/inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
        <script src="dist/js/pages/mask/mask.init.js"></script>
        <script src="../assets/libs/select2/dist/js/select2.full.min.js"></script>
        <script src="../assets/libs/select2/dist/js/select2.min.js"></script>
        <script src="../assets/libs/jquery-asColor/dist/jquery-asColor.min.js"></script>
        <script src="../assets/libs/jquery-asGradient/dist/jquery-asGradient.js"></script>
        <script src="../assets/libs/jquery-asColorPicker/dist/jquery-asColorPicker.min.js"></script>
        <script src="../assets/libs/jquery-minicolors/jquery.minicolors.min.js"></script>
        <script src="../assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="../assets/libs/quill/dist/quill.min.js"></script>
        <script src="../assets/extra-libs/DataTables/datatables.min.js"></script>
        <script>
            //***********************************//
            // For select 2
            //***********************************//
            $(".select2").select2();

            /*colorpicker*/
            $('.demo').each(function () {
                //
                // Dear reader, it's actually very easy to initialize MiniColors. For example:
                //
                //  $(selector).minicolors();
                //
                // The way I've done it below is just for the demo, so don't get confused
                // by it. Also, data- attributes aren't supported at this time...they're
                // only used for this demo.
                //
                $(this).minicolors({
                    control: $(this).attr('data-control') || 'hue',
                    position: $(this).attr('data-position') || 'bottom left',

                    change: function (value, opacity) {
                        if (!value) return;
                        if (opacity) value += ', ' + opacity;
                        if (typeof console === 'object') {
                            console.log(value);
                        }
                    },
                    theme: 'bootstrap'
                });

            });
            /*datwpicker*/
            jQuery('.mydatepicker').datepicker();
            jQuery('#datepicker-autoclose').datepicker({
                autoclose: true,
                todayHighlight: true
            });
            var quill = new Quill('#editor', {
                theme: 'snow'
            });
            $('#zero').DataTable();

        </script>

</body>

</html>