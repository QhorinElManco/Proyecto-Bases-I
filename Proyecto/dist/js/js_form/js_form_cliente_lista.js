$(document).ready(function(){
    llenarTabla = function(){
        $.ajax({ 
			url:"../ajax/eventos_form_cliente_lista.php?accion=1",
			success:function(resultado){
				$("#tbl_tista").html(resultado);
			}
		});//ajax
    }//llenarTabla
    llenarTabla();
    
    
});//document