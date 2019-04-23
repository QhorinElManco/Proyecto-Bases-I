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

    llenarInventario = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo.php?accion=6",
			success:function(resultado){
				$("#slc_inventario").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarInventario();

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
						"&slc_anio=" + $("#slc_anio").val()+
						"&slc_modelo=" + $("#slc_modelo").val()+
						"&slc_tipoVehiculo=" + $("#slc_tipoVehiculo").val()+
						"&slc_tipoMotor=" + $("#slc_tipoMotor").val()+
						"&slc_tipoTransmision=" + $("#slc_tipoTransmision").val()+
						"&slc_Cilindraje=" + $("#slc_Cilindraje").val()+
                        "&txt_descripcion=" + $("#txt_descripcion").val()+
                        "&slc_inventario=" + $("#slc_inventario").val();
		$.ajax({
			url:"../ajax/eventos_form_registro_vehiculo.php?accion=7",
			method: "POST",
			data: parametros,
		success:function(resultado){
			$("#div_resultado2").html(resultado);
			$("#btn_agregar").attr("disabled", true);
		}
        });//ajax
        
	   var file = document.getElementById('file_foto[]');
	   if (file.value === '') {
		console.log ("debe ingresar la foto del empleado");
		}
		else {
			var formData = new FormData($("#form_img")[0]);
			image = formData;
			$.ajax({
					url: "../ajax/eventos_form_registro_vehiculo.php?accion=8",
					type: "POST",
					data: formData,
					contentType: false,
					processData: false,
					success: function(datos){
							$("#div_resultado").html(datos);
					}
			});//ajax
		}
	   

	});//btn guardar
	

    validarDatos = function () {
		var errors = "";
		var re = new RegExp(/[+-]?([0-9]*[.])?[0-9]+/);
		var file = document.getElementById('file_foto[]');

	   if (file.value === '') {
		errors += "Debe ingresar el color del vehiculo\n";
		}

		if($("#slc_color").val() ==''){
			errors += "Debe ingresar el color del vehiculo\n";
        }  
		if($("#txt_precioVenta").val() ==''){
			errors += "Debe ingresar el precio venta del vehiculo\n";
        }        
        if ($("#txt_precioVenta").val().match(re)) {
        	console.log("precio venta si es float");
        }else{
            errors += "Debe ingresar un precio Venta válido\n";
        }
		if($("#txt_precioRentaHora").val() ==''){
			errors += "Debe ingresar el precio renta dia\n";
        }
        if ($("#txt_precioRentaHora").val().match(re)) {
        	console.log("precio renta hora si es float");
        }else{
            errors += "Debe ingresar un precio Venta válido\n";
        }
		if($("#txt_precioRentaDia").val() ==''){
			errors += "Debe ingresar el precio renta dia\n";
        }
        if ($("#txt_precioRentaDia").val().match(re)) {
            console.log("precio renta dia si es float");
            }else{
                errors += "Debe ingresar un precio Venta válido\n";
        }
		if($("#txt_placa").val() ==''){
			errors += "Debe ingresar la placa\n";
		}
		if($("#txt_chasis").val() ==''){
			errors += "Debe ingresar el chasis\n";
		}
		if($("#slc_anio").val() ==''){
			errors += "Debe selecionar el año\n";
		}
		if($("#slc_modelo").val() ==''){
			errors += "Debe seleccionar el modelo\n";
		}
		if($("#slc_tipoVehiculo").val() ==''){
			errors += "Debe seleccionar el tipo de vehiculo\n";
		}
		if($("#slc_tipoMotor").val() ==''){
			errors += "Debe seleccionar el tipo de motor\n";
		}
		if ($("#slc_tipoTransmision").val() == '') {
			errors += "Debe seleccionar el tipo de transmicion\n";
		}
		if($("#slc_Cilindraje").val() ==''){
			errors += "Debe seleccionar el cilindraje\n";
		}
		if($("#txt_descripcion").val() ==''){
			errors += "Debe ingresar la descripcion\n";
        }
        if($("#slc_inventario").val() ==''){
			errors += "Debe seleccionar el inventario\n";
		}
		return errors;
	}

});//document