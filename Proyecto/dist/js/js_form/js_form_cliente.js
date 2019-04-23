$(document).ready(function(){
    var parametros = "idCliente= "+document.getElementById("txt_idCliente").value;
    
    llenarInfo = function(){
    
        $.ajax({ 
            url:"../ajax/eventos_form_cliente.php?accion=1",
            method: "POST",
            data: parametros,
			success:function(resultado){
				$("#div_respuesta").html(resultado);
			}
		});//ajax
    }//llenarInfo
    llenarInfo();

    /*$("#confEliminar").click(function(){

		$.ajax({
			url:"../ajax/eventos_form_empleado.php?accion=2",
			method: "POST",
			data: parametros,
		success:function(resultado){
			$("#div_respuesta2").html(resultado);
			//$("#").attr("disabled", true);
		}
		});//ajax
	});//btn guardar*/
    
    
});//document