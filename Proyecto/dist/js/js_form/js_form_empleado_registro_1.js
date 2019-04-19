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



});//document