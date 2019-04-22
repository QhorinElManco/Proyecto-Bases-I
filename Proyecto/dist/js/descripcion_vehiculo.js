$(document).ready(function(){
    //Obteniendo el id
    var parametros = "idVehiculo= "+document.getElementById("int_idVehiculo").value;
    $.ajax({ 
        url:"ajax/cargar_descripcion_vehiculo.php?accion=1",
        method: "POST",
        data: parametros,
        success:function(respuesta){
            $("#contenedor").html(respuesta);
        }
    });//ajax

    $.ajax({ 
        url:"ajax/cargar_descripcion_vehiculo.php?accion=2",
        method: "POST",
        data: parametros,
        success:function(resultado){
            $("#contenedor").append(resultado);
        }
    });



    
    
});