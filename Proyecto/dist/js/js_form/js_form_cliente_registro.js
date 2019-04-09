$(document).ready(function(){
/* txt_pnombre, txt_snombre, txt_papellido, txt_papellido, txt_correo, txt_contraseña, txt_direccion, txt_telefono, date_fechaNacimiento, slc_genero, txt_identidad.
"&="+$("#").val()+*/
    $("#btnGuardar").click(function(){
        var parametros = "txt_pnombre=" + $("#txt_pnombre").val()+
                         "txt_identidad=" +$("#txt_identidad").val()+
                         "&txt_snombre=" + $("#txt_snombre").val()+
                         "&txt_papellido=" +$("#txt_papellido").val()+
                         "&txt_sapellido=" +$("#txt_sapellido").val()+
                         "&txt_correo="+$("#txt_correo").val()+
                         "&txt_contraseña="+$("#txt_contraseña").val()+
                         "&txt_direccion="+$("#txt_direccion").val()+
                         "&txt_telefono="+$("#txt_telefono").val()+
						 "&date_fechaNacimiento=" + $("#date_fecha_consulta").val()+
						 "&slc_genero=" + $("#slc_genero").val();
		$.ajax({
			url:"../ajax/eventos_form_cliente_registro.php?accion=1",
			method:"POST",
			data: parametros,
			success:function(resultado){
				$("#divMensaje").html(resultado);
			}

		});//ajax 
	});//btn crear consulta

});//document