$(document).ready(function(){
    var parametros = "idEmpleado= "+document.getElementById("txt_idEmpleado").value;

    llenarInfo = function(){
    
        $.ajax({ 
            url:"../ajax/eventos_form_empleado_editar.php?accion=1",
            method: "POST",
            data: parametros,
			success:function(resultado){
				$("#div_respuesta").html(resultado);
			}
		});//ajax
    }//llenarInfo
    llenarInfo();

    $("#confEliminar").click(function(){

		$.ajax({
			url:"../ajax/eventos_form_empleado.php?accion=2",
			method: "POST",
			data: parametros,
		success:function(resultado){
			$("#div_respuesta2").html(resultado);
			//$("#").attr("disabled", true);
		}
		});//ajax
	});//btn guardar
    
    
});//document