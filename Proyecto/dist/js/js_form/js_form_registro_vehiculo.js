$(document).ready(function(){
    
    llenarModelo = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo.php?accion=1",
			success:function(resultado){
				$("#slc_modelo").html(resultado);
			}
    	});//ajax
    }//llenarModelo
    llenarModelo();
    
    llenarTipoVehiculo = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo.php?accion=2",
			success:function(resultado){
				$("#slc_tipoVehiculo").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarTipoVehiculo();

    llenarTipoMotor = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo.php?accion=3",
			success:function(resultado){
				$("#slc_tipoMotor").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarTipoMotor();

    llenarTipoTransmision = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo.php?accion=4",
			success:function(resultado){
				$("#slc_tipoTransmision").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarTipoTransmision();

    llenarCilindraje = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo.php?accion=5",
			success:function(resultado){
				$("#slc_Cilindraje").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarCilindraje();

    $("#btn_agregar").click(function(){
		var errors = validarDatos();
		if(!errors == ""){
			alert(errors);
			return;
	  }

		var parametros= "slc_color=" + $("#slc_color").val()+
						"&txt_precioVenta=" + $("#txt_precioVenta").val()+
						"&txt_precioRentaHora=" + $("#txt_precioRentaHora").val()+
						"&txt_precioRentaDia=" + $("#txt_precioRentaDia").val()+
						"&txt_placa=" + $("#txt_placa").val()+
						"&txt_chasis=" + $("#txt_chasis").val()+
						"&date_fechaRegistro=" + $("#date_fechaRegistro").val()+
						"&slc_modelo=" + $("#slc_modelo").val()+
						"&slc_tipoVehiculo=" + $("#slc_tipoVehiculo").val()+
						"&slc_tipoMotor=" + $("#slc_tipoMotor").val()+
						"&slc_tipoTransmision=" + $("#slc_tipoTransmision").val()+
						"&slc_Cilindraje=" + $("#slc_Cilindraje").val()+
						"&txt_descripcion=" + $("#txt_descripcion").val();
		$.ajax({
			url:"../ajax/eventos_form_registro_vehiculo.php?accion=6",
			method: "POST",
			data: parametros,
		success:function(resultado){
			$("#div_resultado2").html(resultado);
			$("#btn_agregar").attr("disabled", true);
		}
        });//ajax
        
        /*$("input[name='file_foto[]']").on("change", function(){
            var formData = new FormData($("#form_img")[0]);
            image = formData;
            $.ajax({
                    url: "../ajax/eventos_form_registro_vehiculo.php?accion=7",
                    type: "POST",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function(datos){
                            $("#div_resultado").html(datos);
                    }
            });//ajax
        });//inputfile*/

	});//btn guardar
    slc_color
    txt_precioVenta
    txt_precioRentaHora
    txt_precioRentaDia
    txt_placa
    txt_chasis
    date_fechaRegistro
    slc_modelo
    slc_tipoVehiculo
    slc_tipoMotor
    slc_tipoTransmision
    slc_Cilindraje
    txt_descripcion
    validarDatos = function () {
		var errors = "";
		var correo = validarCorreo();
		var contra = validarContraseña();
		var file = document.getElementById('file_foto');

		if($("#slc_color").val() ==''){
			errors += "Debe ingresar el color del vehiculo\n";
		}
		if($("#txt_precioVenta").val() ==''){
			errors += "Debe ingresar el precio venta del vehiculo\n";
		}
		if($("#txt_precioRentaHora").val() ==''){
			errors += "Debe ingresar el precio renta dia\n";
		}
		if($("#txt_precioRentaDia").val() ==''){
			errors += "Debe ingresar el precio renta dia\n";
		}
		if($("#txt_placa").val() ==''){
			errors += "Debe ingresar la placa\n";
		}
		if($("#txt_chasis").val() ==''){
			errors += "Debe ingresar el chasis\n";
		}
		if($("#date_fechaRegistro").val() ==''){
			errors += "Debe ingresar la direccion\n";
		}
		if($("#slc_modelo").val() ==''){
			errors += "Debe ingresar el telefono\n";
		}
		if($("#slc_tipoVehiculo").val() ==''){
			errors += "Debe ingresar la fecha de inicio\n";
		}
		if($("#slc_tipoMotor").val() ==''){
			errors += "Debe ingresar la fecha fin\n";
		}
		if ($("#slc_tipoTransmision").val() < $("#date_fechaInicio").val()) {
			errors += "la fecha fin es menor que la fecha inicio, ingrese correctamente las fechas\n";
		}
		if($("#slc_Cilindraje").val() ==''){
			errors += "Debe seleccionar el cargo\n";
		}
		if($("#txt_descripcion").val() ==''){
			errors += "Debe ingresar la descripcion\n";
		}
		return errors;
	}

});//document