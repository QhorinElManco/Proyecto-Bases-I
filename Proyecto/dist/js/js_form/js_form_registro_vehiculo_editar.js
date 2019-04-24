$(document).ready(function(){
	var parametros = "idCliente= "+$("#txt_idVehiculo").val();
	
    llenarModelo = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=1",
			success:function(resultado){
				$("#slc_modelo").html(resultado);
			}
    	});//ajax
    }//llenarModelo
    llenarModelo();
    
    llenarTipoVehiculo = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=2",
			success:function(resultado){
				$("#slc_tipoVehiculo").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarTipoVehiculo();

    llenarTipoMotor = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=3",
			success:function(resultado){
				$("#slc_tipoMotor").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarTipoMotor();

    llenarTipoTransmision = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=4",
			success:function(resultado){
				$("#slc_tipoTransmision").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarTipoTransmision();

    llenarCilindraje = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=5",
			success:function(resultado){
				$("#slc_Cilindraje").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarCilindraje();

    llenarInventario = function(){
        $.ajax({ 
    		url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=6",
			success:function(resultado){
				$("#slc_inventario").html(resultado);
			}
    	});//ajax
    }//llenarTipoVehiculo
    llenarInventario();
	
	traerInfo = function(){
        
        $.ajax({ 
            url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=7",
            method: "POST",
            data: parametros,
			success:function(resultado){
				$("#div_respuesta").html(resultado);
			}
        });//ajax
        //setTimeout ("llenarInfo();", 2000); 
        
        /**/
    }//llenarInfo
    traerInfo();
    

    llenarInfo = function(){
		document.getElementById("slc_color").value = document.getElementById("color").value;
		document.getElementById("txt_descripcion").value = document.getElementById("descripcion").value;
		document.getElementById("slc_anio").value = document.getElementById("anio").value;
		document.getElementById("txt_precioVenta").value = document.getElementById("precioVenta").value;
		document.getElementById("txt_precioRentaHora").value = document.getElementById("precioRentaHora").value;
		document.getElementById("txt_precioRentaDia").value = document.getElementById("precioRentaDia").value;
		document.getElementById("txt_placa").value = document.getElementById("placa").value;
		document.getElementById("slc_modelo").value = document.getElementById("idModelo").value;
		document.getElementById("slc_inventario").value = document.getElementById("idInventario").value;
		document.getElementById("slc_tipoVehiculo").value = document.getElementById("idTipoVehiculo").value;
		document.getElementById("slc_tipoMotor").value = document.getElementById("idTipoGasolina").value;
        document.getElementById("slc_tipoTransmision").value = document.getElementById("idTransmision").value;
        document.getElementById("slc_Cilindraje").value = document.getElementById("idCilindraje").value;
        //document.getElementById("img").src = document.getElementById("rutaImagen").value;
    }
    
    //subirFotoFunc(false);
    /*var activacionFile = "N";
    //subir imagen
    $("input[name='file_foto']").on("change", function(){
		var formData = new FormData($("#form_img")[0]);
		image = formData;
		$.ajax({
				url: "../ajax/eventos_form_registro_vehiculo_editar.php?accion=8",
				type: "POST",
				data: formData,
				contentType: false,
				processData: false,
				success: function(datos){
					$("#div_resultado").html(datos);
				}
        });//ajax
        activacionFile = "S";
        //subirFotoFunc(true);
	});//subir imagen
    /*subirFotoFunc = function(){
        var subir = 1;
        return subir;
    }*/

    $("#btn_editar").click(function(){
		var errors = validarDatos();
		if(!errors == ""){
			alert(errors);
			return;
	    }

        if (activacionFile === "S") {
            var parametros2= "txt_pnombre=" + $("#txt_pnombre").val()+
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
                        "&txt_contraseña=" + $("#txt_contraseña").val()+
                        "&idEmpleado= "+$("#txt_idEmpleado").val()+
                        "&img=";
        }
        else{
            var urlImg = document.getElementById('img').src;
            var parametros2= "txt_pnombre=" + $("#txt_pnombre").val()+
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
                        "&txt_contraseña=" + $("#txt_contraseña").val()+
                        "&idEmpleado= "+$("#txt_idEmpleado").val()+
                        "&img="+urlImg;
        }
		$.ajax({
			url:"../ajax/eventos_form_registro_vehiculo_editar.php?accion=9",
			method: "POST",
			data: parametros2,
		success:function(resultado){
			$("#div_resultado2").html(resultado);
			$("#btn_editar").attr("disabled", true);
		}
		});//ajax
    });//btn guardar
    
    
    
    validarDatos = function () {
		var errors = "";
		var re = new RegExp(/[+-]?([0-9]*[.])?[0-9]+/);
		var file = document.getElementById('file_foto[]');

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
	}//validar datos


});//document