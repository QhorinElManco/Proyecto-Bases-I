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
    <title>AutoMotor</title>
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="assets/libs/select2/dist/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libs/jquery-minicolors/jquery.minicolors.css">
    <link rel="stylesheet" type="text/css" href="assets/libs/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" type="text/css" href="assets/libs/quill/dist/quill.snow.css">
    <link href="dist/css/style.min.css" rel="stylesheet">
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
                    <a class="navbar-brand" href="index.html">
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
                            <img src="assets/images/logo-text.png" alt="homepage" class="light-logo" />

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
                    <ul class="navbar-nav float-right mr-auto">
                        <li class="nav-item d-none d-md-block"><a
                                class="nav-link sidebartoggler waves-effect waves-light" href="javascript:void(0)"
                                data-sidebartype="mini-sidebar"><i class="mdi mdi-menu font-24"></i></a></li>
                    </ul>
                    <!-- ============================================================== -->
                    <!-- Right side toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-right">
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
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-edit"></i><span
                                    class="hide-menu">Clientes</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="Form/form_cliente_registro.php" class="sidebar-link"><i
                                            class="mdi mdi-account-plus"></i><span class="hide-menu">Agregar cliente
                                        </span></a></li>
                                <li class="sidebar-item"><a href="Form/form_cliente_lista.php" class="sidebar-link"><i
                                            class="mdi mdi-format-list-numbers"></i><span class="hide-menu">Lista de clientes</span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-key"></i><span
                                    class="hide-menu">Empleados</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="Form/form_empleado_registro_1.php" class="sidebar-link"><i
                                            class="mdi mdi-account-plus"></i><span class="hide-menu">Agregar empleado
                                        </span></a></li>
                                <li class="sidebar-item"><a href="Form/form_empleado_lista.php" class="sidebar-link"><i
                                            class="mdi mdi-format-list-numbers"></i><span class="hide-menu">Lista de empleados</span></a></li>
                            </ul>
                        </li>
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
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-receipt"></i><span
                                    class="hide-menu">Solicitud mantenimiento </span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="agregar_solicitud_mantenimiento.php"
                                        class="sidebar-link"><i class="mdi mdi-playlist-plus"></i><span
                                            class="hide-menu">
                                            Agregar solicitud
                                        </span></a></li>
                                <li class="sidebar-item"><a href="ver_solicitud_mantenimiento.php"
                                        class="sidebar-link"><i class="mdi mdi-format-list-bulleted"></i><span
                                            class="hide-menu"> Ver las
                                            solicitudes </span></a></li>
                            </ul>
                        </li>
                        
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark"
                                href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-calculator"></i><span
                                    class="hide-menu">Facturacion</span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="Factura_venta.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Venta
                                        </span></a>
                                </li>
                                <li class="sidebar-item"><a href="Factura_renta.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura Renta
                                        </span></a></li>
                                <li class="sidebar-item"><a href="Factura_mantenimiento.php" class="sidebar-link"><i
                                            class="mdi mdi-file-document"></i><span class="hide-menu"> Factura
                                            Mantenimiento
                                        </span></a></li>
                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="solicitud_renta.php" aria-expanded="false"><i class="mdi mdi-calendar-multiple"></i><span
                                    class="hide-menu">Solicitud renta</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="Form/gestion_sucursal.php" aria-expanded="false"><i class="mdi mdi-shopping"></i><span
                                    class="hide-menu">Gestion Sucursal</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                href="Form/gestion_taller.php" aria-expanded="false"><i class="mdi mdi-engine"></i><span
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
        <div class="page-wrapper" style="color:white">
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid" style="padding:0px;background-image: url(assets/images/background/img3.jpg);background-repeat: no-repeat;background-size:cover; " >
                <div style="background-color: rgba(0, 0, 0, 0.5) ;width:100%; height:100%">
                <!-- ============================================================== -->
                <!-- Inicio Formulario -->
                <!-- ============================================================== -->
               
                        <div class="row" style="" >
                        
                        
                            <!--Margen de 3 columnas a la izquierda-->
                            <div class="col-md-6 auth-box  border-top border-secondary float-left mx-auto" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >
                            
                                <form class="form-horizontal" id ="formulario">
                                <div class="card-body" style="text-align:center;">

                                <div class="text-center p-t-20 p-b-20">
                                        <IMG SRC="assets/images/logo2.png">
                                    </div>
                                            <div class="border-bottom">
                                                <h3 class="card-title" style="color:white; text-align: center">SOLICITUD PARA RENTA</h3>
                                            </div><br>
                                               <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Codigo Solicitud</label>
                                                        <div class="col-sm-9" id="codigoSolicitud">
                                                           
                                                        </div>
                                                    </div>
                                                    
                                                 <div class="form-group row">
                                                    <label class="col-sm-3 text-left control-label col-form-label">Nombre Cliente</label>
                                                    <div class="col-sm-9">
                                                        <select type="text" id="idCliente" class="form-control border border-secondary" maxlength="50">
                                                        <option value="">Seleccione el nombre del cliente</option>
                                                           
                                                        </select>
                                                        </div>
                                                </div> 
                                                <div class="form-group row">
                                                    <label class="col-sm-3 text-left control-label col-form-label">Nombre Empleado</label>
                                                    <div class="col-sm-9">
                                                        <select type="text" id="idEmpleado" class="form-control border border-secondary" maxlength="50">
                                                        <option value="">Seleccione el nombre del empleado</option>
                                                           
                                                        </select>
                                                        </div>                                        
                                                                                     
                                                </div>
                                                <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Vehiculo</label>
                                                        <div class="col-sm-9">
                                                        <select type="text" id="idVehiculo" class="form-control border border-secondary" maxlength="50">
                                                            
                                                        <option value="">Seleccione el vehiculo</option>
                                                        </select>
                                                        </div>
                                                 </div>

                                                <div class="row mb-3 align-items-center">
                                                        <div class="col-lg-3 col-md-12 text-left">
                                                            <span style="color:white;">Fecha Entrega</span>
                                                        </div>
                                                        <div class="col-lg-9 col-md-12 input-group">
                                                            <input type="text" class="form-control" id="fechaEntrega"
                                                                placeholder="mm/dd/yyyy" data-toggle="tooltip"
                                                                title="Si sera aprobada seleccione la fecha de entrega" >
                                                            <div class="input-group-append">
                                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                </div>
                                                <div class="row mb-3 align-items-center">
                                                    <div class="col-lg-3 col-md-12 text-left">
                                                        <span style="color:white;">Fecha Devolucion</span>
                                                    </div>
                                                    <div class="col-lg-9 col-md-12 input-group">
                                                        <input type="text" class="form-control" id="fechaDevolucion"
                                                            placeholder="mm/dd/yyyy" data-toggle="tooltip"
                                                            title="Si sera aprobada seleccione la fecha de devolucion" >
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="form-group row" class="formulario" action="ajax/eventos_solicitud_renta.php?accion=5" method="POST">
                                                     <label class="col-sm-3 text-left control-label col-form-label">Requisitos</label>
                                                     <div class="checkbox col-sm-9 text-left"  id="">
                                                     <label for="checkbox1"><input type="checkbox" value="1" name="idRequisitos[]" style="margin-right:10px" >Tarjeta Id.</label><br>
                                                     <label for="checkbox2"><input type="checkbox" value="2" name="idRequisitos[]"style="margin-right:10px" >Permiso de conducir</label><br>
                                                     <label for="checkbox3"><input type="checkbox" value="3" name="idRequisitos[]"style="margin-right:10px" >Antecedentes Penales</label><br>
                                                     <label for="checkbox4"><input type="checkbox" value="4" name="idRequisitos[]"style="margin-right:10px" >Historial de multas</label><br>
                                                             
                                                    </div>                              
                                                                                     
                                                </div>
                                                <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label">Tiempo de Renta</label>
                                                        <div class="col-sm-9">
                                                        <select type="text" id="tiempoRenta" class="form-control border border-secondary" maxlength="50">
                                                        <option value="">Seleccione una opcion</option>
                                                        <option value="1" id="tiempoRenta">Dia</option>
                                                        <option value="2" id="tiempoRenta">Horas</option>
                                                        </select>
                                                        </div>
                                                 </div>
                                                
                                                <div class="form-group row">
                                                        <label class="col-sm-3 text-left control-label col-form-label"> Estado</label>
                                                        <div class="col-sm-9">
                                                        
                                                        <input type="text"  class="form-control" id="estado" placeholder="Ingrese el estado de solicitud">
                                                    
                                                        </div>
                                                    </div>

                                            </div>
                                            <div class="border-top">
                                        <div class="card-body" style="text-align:center;">
                                            <button type="button" class="btn btn-success" id="agregar">Agregar</button>
                                        </div>
                                    </div>
                                </form>
                                
                            </div>

                        
                        </div>
                                    <!-- Modal -->
                                    <div class="modal fade" id="Modal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true " style="color:black">
                                        <div class="modal-dialog" role="document ">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Mensaje</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true ">&times;</span>
                                                                </button>
                                                    </div>
                                                    <div class="modal-body" id="cuerpoModal">
                                                    </div>
                                                </div>
                                            </div>
                                      </div>
                                    <!-- Modal -->
                            </div> 
                        </div>
                <!-- ============================================================== -->
                <!-- Fin Formulario -->
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
        <!-- End Wrapper -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- All Jquery -->
        <!-- ============================================================== -->
        <script src="assets/libs/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap tether Core JavaScript -->
        <script src="assets/libs/popper.js/dist/umd/popper.min.js"></script>
        <script src="assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- slimscrollbar scrollbar JavaScript -->
        <script src="assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
        <script src="assets/extra-libs/sparkline/sparkline.js"></script>
        <!--Wave Effects -->
        <script src="dist/js/waves.js"></script>
        <!--Menu sidebar -->
        <script src="dist/js/sidebarmenu.js"></script>
        <!--Custom JavaScript -->
        <script src="dist/js/custom.min.js"></script>
        <!-- This Page JS -->
        <script src="assets/libs/inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
        <script src="dist/js/pages/mask/mask.init.js"></script>
        <script src="assets/libs/select2/dist/js/select2.full.min.js"></script>
        <script src="assets/libs/select2/dist/js/select2.min.js"></script>
        <script src="assets/libs/jquery-asColor/dist/jquery-asColor.min.js"></script>
        <script src="assets/libs/jquery-asGradient/dist/jquery-asGradient.js"></script>
        <script src="assets/libs/jquery-asColorPicker/dist/jquery-asColorPicker.min.js"></script>
        <script src="assets/libs/jquery-minicolors/jquery.minicolors.min.js"></script>
        <script src="assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
        <script src="assets/libs/quill/dist/quill.min.js"></script>
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
            jQuery('#fechaEntrega').datepicker({
                autoclose: true,
                todayHighlight: true
            });
            jQuery('#fechaDevolucion').datepicker({
                autoclose: true,
                todayHighlight: true
            });
            var quill = new Quill('#editor', {
                theme: 'snow'
            });

        </script>
        <script src="dist/js/js_form/js_solicitud_renta.js"> </script>
</body>

</html>