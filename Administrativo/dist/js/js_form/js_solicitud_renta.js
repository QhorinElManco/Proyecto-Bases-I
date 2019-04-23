$(document).ready(function () {
    verInfo();
    
    $("#agregar").click(function () {
        $.ajax({
            url: "ajax/eventos_solicitud_renta.php?accion=agregar",
            method: "POST",
            dataType: "html",
            data:    "idVehiculo="+$("#idVehiculo").val()
                    +"&idEmpleado="+$("#idEmpleado").val()
                    +"&idCliente="+$("#idCliente").val()
                    +"&fechaEntrega="+$("#fechaEntrega").val()
                    +"&fechaDevolucion="+$("#fechaDevolucion").val()
                    +"&estado="+$("#estado").val()
                    +"&tiempoRenta="+$("#tiempoRenta").val(),

                    
            success: function (respuesta) {
                $("#cuerpoModal").empty();
                $("#cuerpoModal").append(respuesta);
                $("#Modal1").modal("show");
                              document.getElementById("formulario").reset();
            },
            error: function (error) {
                console.log(error);
            }
        });

       
    });
    


})



function verInfo() {
    $.ajax({
        url: "ajax/eventos_solicitud_renta.php?accion=1",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#idEmpleado").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_solicitud_renta.php?accion=2",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#idCliente").append(respuesta);
           
        },
        error: function(error){
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_solicitud_renta.php?accion=3",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#idVehiculo").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_solicitud_renta.php?accion=4",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#codigoSolicitud").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
    
    
  
  
}