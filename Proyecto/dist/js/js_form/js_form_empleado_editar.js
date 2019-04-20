$(document).ready(function(){
    var parametros = "idEmpleado= "+document.getElementById("txt_idEmpleado").value;
    
    traerInfo = function(){
    
        $.ajax({ 
            url:"../ajax/eventos_form_empleado_editar.php?accion=1",
            method: "POST",
            data: parametros,
			success:function(resultado){
				$("#div_respuesta").html(resultado);
			}
        });//ajax
        setTimeout ("llenarInfo();", 2000); 
        
        /**/
    }//llenarInfo
    traerInfo();

    llenarInfo = function(){
        document.getElementById("txt_pnombre").value = document.getElementById("pnombre").value;
		document.getElementById("txt_snombre").value = document.getElementById("snombre").value;
		document.getElementById("txt_papellido").value = document.getElementById("papellido").value;
		document.getElementById("txt_sapellido").value = document.getElementById("sapellido").value;
		document.getElementById("txt_correo").value = document.getElementById("correo").value;
		document.getElementById("txt_noIdentidad").value = document.getElementById("noIdentidad").value;
		document.getElementById("txt_direccion").value = document.getElementById("direccion").value;
		document.getElementById("txt_telefono").value = document.getElementById("telefonos").value;
		document.getElementById("date_fechaInicio").value = document.getElementById("fechaInicio").value;
		document.getElementById("date_fechaFin").value = document.getElementById("fechaFin").value;
		document.getElementById("slc_cargo").value = document.getElementById("idCargo").value;
		document.getElementById("txt_usuario").value = document.getElementById("nombreUsuario").value;
        document.getElementById("txt_contraseña").value = document.getElementById("contrasenia").value;
        document.getElementById("txt_contraseña2").value = document.getElementById("contrasenia").value;
        document.getElementById("img").src = document.getElementById("rutaImagen").value;
    }
    
    llenarCargo = function(){
        $.ajax({ 
            url:"../ajax/eventos_form_empleado_editar.php?accion=3",
            success:function(resultado){
                $("#slc_cargo").html(resultado);
            }
        });//ajax
    }//llenarCargo
    llenarCargo();
    var subirFoto = "N";
    //subir imagen
    $("input[name='file_foto']").on("change", function(){
        subirFoto = "S";
        '<%Session["subirFoto"] = "' + subirFoto + '"; %>';
		var formData = new FormData($("#form_img")[0]);
		image = formData;
		$.ajax({
				url: "../ajax/eventos_form_empleado_editar.php?accion=4",
				type: "POST",
				data: formData,
				contentType: false,
				processData: false,
				success: function(datos){
						$("#div_resultado").html(datos);
				}
		});//ajax
	});//subir imagen
    
    $("#btn_editar").click(function(){
		var errors = validarDatos();
		if(!errors == ""){
			alert(errors);
			return;
	    }
        var validarSubirImg = '<%= Session["subirFoto"] %>';
        if (validarSubirImg=== "S") {
            var parametros= "txt_pnombre=" + $("#txt_pnombre").val()+
						"&txt_snombre=" + $("#txt_snombre").val()+
						"&txt_papellido=" + $("#txt_papellido").val()+
						"&txt_sapellido=" + $("#txt_sapellido").val()+
						"&txt_correo=" + $("#txt_correo").val()+
						"&txt_noIdentidad=" + $("#txt_noIdentidad").val()+
						"&txt_direccion=" + $("#txt_direccion").val()+
						"&txt_telefono=" + $("#txt_telefono").val()+
						"&date_fechaInicio=" + $("#date_fechaInicio").val()+
						"&date_fechaFin=" + $("#date_fechaFin").val()+
						"&slc_cargo=" + $("#slc_cargo").val()+
						"&txt_usuario=" + $("#txt_usuario").val()+
                        "&txt_contraseña=" + $("#txt_contraseña").val();
                        "&img=";
        }
        else{
            var urlImg = document.getElementById('img').src;
            var parametros= "txt_pnombre=" + $("#txt_pnombre").val()+
						"&txt_snombre=" + $("#txt_snombre").val()+
						"&txt_papellido=" + $("#txt_papellido").val()+
						"&txt_sapellido=" + $("#txt_sapellido").val()+
						"&txt_correo=" + $("#txt_correo").val()+
						"&txt_noIdentidad=" + $("#txt_noIdentidad").val()+
						"&txt_direccion=" + $("#txt_direccion").val()+
						"&txt_telefono=" + $("#txt_telefono").val()+
						"&date_fechaInicio=" + $("#date_fechaInicio").val()+
						"&date_fechaFin=" + $("#date_fechaFin").val()+
						"&slc_cargo=" + $("#slc_cargo").val()+
						"&txt_usuario=" + $("#txt_usuario").val()+
                        "&txt_contraseña=" + $("#txt_contraseña").val()
                        "&img="+urlImg;
        }

		
		$.ajax({
			url:"../ajax/eventos_form_empleado_editar.php?accion=2",
			method: "POST",
			data: parametros,
		success:function(resultado){
			$("#div_resultado2").html(resultado);
			$("#btn_editar").attr("disabled", true);
		}
		});//ajax
    });//btn guardar
    
    validarCorreo = function () {
		var error = "";
		document.getElementById('txt_correo').addEventListener('input', function() {
			campo = event.target;
			valido = document.getElementById('emailOK');
				 
			emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
			if (emailRegex.test(campo.value)) {
			  valido.innerText = "válido";
			  error = "valido";
			  return error; 
			} else {
			  valido.innerText = "incorrecto";
			  error = "incorrecto";
			  return error; 
			}
		});
	}
    validarCorreo();
    
    validarContraseña = function () {
		var error = "";
		document.getElementById('txt_contraseña2').addEventListener('input', function() {
			campo = event.target;
			valido = document.getElementById('contraseña2ok');
				 
			if ($("#txt_contraseña").val() == $("#txt_contraseña2").val()) {
			  valido.innerText = "válido";
			  error = "contraseña correcta";
			  return error; 
			} else {
			  valido.innerText = "incorrecto";
			  error = "contraseña no concuerda";
			  return error; 
			}
		});
	}
    validarContraseña();
    
    validarDatos = function () {
		var errors = "";
		var correo = validarCorreo();
		var contra = validarContraseña();

		if($("#txt_pnombre").val() ==''){
			errors += "Debe ingresar el primer nombre\n";
		}
		if($("#txt_snombre").val() ==''){
			errors += "Debe ingresar el segundo nombre\n";
		}
		if($("#txt_papellido").val() ==''){
			errors += "Debe ingresar el primer apellido\n";
		}
		if($("#txt_sapellido").val() ==''){
			errors += "Debe ingresar el segundo apellido\n";
		}
		if($("#txt_correo").val() ==''){
			errors += "Debe ingresar el correo\n";
		}
		if (correo === "incorrecto") {
			errors += "Debe ingresar un correo valido\n";
		}

		if($("#txt_noIdentidad").val() ==''){
			errors += "Debe ingresar el numero de identidad\n";
		}
		if($("#txt_direccion").val() ==''){
			errors += "Debe ingresar la direccion\n";
		}
		if($("#txt_telefono").val() ==''){
			errors += "Debe ingresar el telefono\n";
		}
		if($("#date_fechaInicio").val() ==''){
			errors += "Debe ingresar la fecha de inicio\n";
		}
		if($("#date_fechaFin").val() ==''){
			errors += "Debe ingresar la fecha fin\n";
		}
		if ($("#date_fechaFin").val() < $("#date_fechaInicio").val()) {
			errors += "la fecha fin es menor que la fecha inicio, ingrese correctamente las fechas\n";
		}
		if($("#slc_cargo").val() ==''){
			errors += "Debe seleccionar el cargo\n";
		}
		if($("#txt_usuario").val() ==''){
			errors += "Debe ingresar el usuario\n";
		}
		if($("#txt_contraseña").val() ==''){
			errors += "Debe ingresar una contraseña\n";
		}
		if($("#txt_contraseña2").val() ==''){
			errors += "Debe ingresar la confirmacion de la contraseña\n";
		}
		if (contra === "contraseña no concuerda") {
			errors += "las contraseñas no concuerdan\n";
		}
		return errors;
	}//validar datos


});//document