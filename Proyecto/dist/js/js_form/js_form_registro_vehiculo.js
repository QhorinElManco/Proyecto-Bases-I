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

});//document