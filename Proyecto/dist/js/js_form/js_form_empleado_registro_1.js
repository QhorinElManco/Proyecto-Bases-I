$(document).ready(function(){

	
    
	llenarCargo = function(){
		$.ajax({ 
			url:"../ajax/eventos_form_empleado_registro_1.php?accion=1",
			success:function(resultado){
				$("#slc_cargo").html(resultado);
			}
		});//ajax
	}//llenarCargo
	llenarCargo();
    
	$("input[name='file_foto']").on("change", function(){
		var formData = new FormData($("#form_img")[0]);
		image = formData;
		$.ajax({
				url: "../ajax/eventos_form_empleado_registro_1.php?accion=2",
				type: "POST",
				data: formData,
				contentType: false,
				processData: false,
				success: function(datos){
						$("#div_resultado").html(datos);
				}
		});//ajax
	});//inputfile

	$("#btn_agregar").click(function(){
		var errors = validarDatos();
		if(!errors == ""){
			alert(errors);
			return;
	  }

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
		$.ajax({
			url:"../ajax/eventos_form_empleado_registro_1.php?accion=3",
			method: "POST",
			data: parametros,
		success:function(resultado){
			$("#div_resultado2").html(resultado);
			$("#btn_agregar").attr("disabled", true);
		}
		});//ajax
	});//btn guardar

	//validacion de ingreso de correo.
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
		var file = document.getElementById('file_foto');

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
		if (file.value === '') {
			errors += "debe ingresar la foto del empleado\n";
		}
		return errors;
	}

});//document