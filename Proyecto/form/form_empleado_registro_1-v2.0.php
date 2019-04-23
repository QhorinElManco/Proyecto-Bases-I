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
    <title>Empleado</title>
    <!-- Custom CSS -->
    <link href="../assets/libs/jquery-steps/jquery.steps.css" rel="stylesheet">
    <link href="../assets/libs/jquery-steps/steps.css" rel="stylesheet">
    <link href="../dist/css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../assets/libs/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
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
        <div class="page-wrapper" style="background-color: rgb(0,0,0); height:930px;">
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid" style="padding: 50px">
                <!-- ============================================================== -->
                <!-- Inicio Formulario -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                    </div>
                    <div class="col-lg-8 col-md-8">
                        <div class="card">
                            <div class="card-body wizard-content">
                                <h4 class="card-title">Datos del empleado</h4>
                                <h6 class="card-subtitle"></h6>
                                <form id="example-form" action="#" class="m-t-40">
                                    <div>
                                        <h3>Datos personales</h3>
                                        <section>
                                            <label for="txt_pnombre">Primer nombre *</label>
                                            <input id="txt_pnombre" name="name" type="text" class="required form-control">
                                            <label for="txt_snombre">Segundo nombre *</label>
                                            <input id="txt_snombre" name="name" type="text" class="required form-control">
                                            <label for="txt_papellido">Primer apellido *</label>
                                            <input id="txt_papellido" name="surname" type="text" class="required form-control"> 
                                            <label for="txt_sapellido">Segundo apellido *</label>
                                            <input id="txt_sapellido" name="surname" type="text" class="required form-control">
                                            <label for="txt_noIdentidad">No Identidad *</label>
                                            <input id="txt_noIdentidad" name="surname" type="text" class="required form-control">
                                            <p>(*) Obligatorio</p>
                                        </section>
                                        <h3>Contacto</h3>
                                        <section>
                                            <label for="txt_correo">Correo electronico *</label>
                                            <input id="txt_correo" name="email" type="text" class="required email form-control"><span id="emailOK"></span>
                                            <label for="txt_telefono">Telefono</label>
                                            <input id="txt_telefono" name="address" type="text" class=" form-control">      
                                            <label for="txt_direccion">Direccion</label>
                                            <textarea name="txt_direccion" id="txt_direccion" cols="80" rows="3" class="required form-control"></textarea>
                                            <p>(*) Obligatorio</p>
                                        </section>
                                        <h3>Cargo</h3>
                                        <section>
                                            <label for="slc_cargo">Cargo</label>
                                            <select id="slc_cargo" class="required form-control" placeholder="Ingrese su genero"></select>
                        
                                            <label for="date_fechaInicio">Fecha inicio</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control datepicker-autoclose" id="date_fechaInicio" placeholder="mm/dd/yyyy">
                                                    <div class="input-group-append">
                                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                            </div>
                                            
                                            <label for="date_fechaFin">Fecha fin</label>
                                            <div class="input-group"> 
                                                <input type="text" class="form-control datepicker-autoclose" id="date_fechaFin" placeholder="mm/dd/yyyy">
                                                    <div class="input-group-append">
                                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                            </div>
                                            <p>(*) Obligatorio</p>
                                        </section>
                                        <h3>Cuenta</h3>
                                        <section>
                                            <ul>
                                            <label for="txt_usuario">Usuario *</label>
                                            <input id="txt_usuario" name="userName" type="text" class="required form-control">
                                            <label for="txt_contraseña">Contraseña *</label>
                                            <input id="txt_contraseña" name="password" type="text" class="required form-control">
                                            <label for="txt_contraseña2">Confirme la contraseña *</label>
                                            <input id="txt_contraseña2" name="confirm" type="text" class="required form-control"><span id="contraseña2ok"></span>
                                            </ul>
                                        </section>
                                        <h3>Foto de perfil</h3>
                                        <section>
                                            <div class= "row">
                                                <div class="col-md-6 auth-box  border-top border-dark float-left mx-auto text-light" style="margin-top:50px;margin-bottom:50px;background-color:rgba(52, 58, 64,0.8)" >
                                                    <div class="card-body" style="text-align:center;">
                                                        <form method="post" id="form_img" enctype="multipart/form-data">
                                                            <p><h3>Elije la foto del empleado</h3><br>
                                                                <input type="file" name="file_foto" id="file_foto">
                                                            </p>
                                                            <hr>
                                                            <div id="div_resultado"></div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </form>
                                <button id="btn_agregar" type="button" class="btn btn-primary" hidden="">Añadir Empleado</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2">
                    </div>
                </div>
                    <!-- Modal -->
                        <div class="modal fade" id="Modal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true ">
                            <div class="modal-dialog" role="document ">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Mensaje</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true ">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" id="cuerpoModal1">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal -->
                        <!-- Modal -->
                        <div class="modal fade" id="Modal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true ">
                            <div class="modal-dialog" role="document ">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Mensaje</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true ">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" id="cuerpoModal2">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal -->
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
    <script src="../assets/libs/jquery-steps/build/jquery.steps.min.js"></script>
    <script src="../assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>
    <script src="../assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script>
        // Basic Example with form
    var form = $("#example-form");
    form.validate({
        errorPlacement: function errorPlacement(error, element) { element.before(error); },
        rules: {
            confirm: {
                equalTo: "#txt_contraseña"
            }
        }
    });
     form.children("div").steps({
        headerTag: "h3",
        bodyTag: "section",
        transitionEffect: "slideLeft",
        onStepChanging: function(event, currentIndex, newIndex) {
            form.validate().settings.ignore = ":disabled,:hidden";
            return form.valid();
        },
        onFinishing: function(event, currentIndex) {
            form.validate().settings.ignore = ":disabled";
            return form.valid();
        },
        onFinished: function(event, currentIndex) {
            $("#btn_agregar").trigger("click");
        }



    });
    jQuery('.mydatepicker').datepicker();
        jQuery('.datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });
    </script>

    <!-- controlador -->
    <script src="../dist/js/js_form/js_form_empleado_registro_1.js"></script>
    
</body>

</html>