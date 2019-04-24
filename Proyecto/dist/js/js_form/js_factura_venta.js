$(document).ready(function () {
    verInfo();
    $("#AGREGAR").click(function () {
        $.ajax({
            url: "ajax/eventos_factura_venta.php?accion=8",
            method: "POST",
            dataType: "html",
            data: "idVehiculo="+$("#idVehiculo").val()+"&"
            +"idEmpleado="+$("#idEmpleado").val()+"&"
            +"idCliente="+$("#idCliente").val()+"&"      
             +"&idFormaPago="+$("#idFormaPago").val()+"&"
             +"&idTipoDescuento="+$("#idTipoDescuento").val() ,
            success: function (respuesta) {
                $("#cuerpoModal").empty();
                $("#cuerpoModal").append(respuesta);
                $("#Modal1").modal("show");
                total();
                document.getElementById("formulario").reset();
            },
            error: function(error){
                console.log(error);
            }
        });
});



})
function total() {
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=9",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#total").append(res);
        },
        error: function(error){
            console.log(error);
        }
    });
}


function verInfo() {
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=1",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#codigoFactura").append(res);
           
        },
        error: function(error){
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=2",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#fecha").append(res);
        },
        error: function(error){
            console.log(error);
        }
    });

    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=3",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#idVehiculo").append(res);
        },
        error: function(error){
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=4",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#idTipoDescuento").append(res);
           
        },
        error: function(error){
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=5",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#idEmpleado").append(res);
           
        },
        error: function(error){
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=6",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#idCliente").append(res);
           
        },
        error: function(error){
            console.log(error);
        }
    });
    $.ajax({
        url: "ajax/eventos_factura_venta.php?accion=7",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            var res = respuesta.replace(";", " ");
            $("#idFormaPago").append(res);
           
        },
        error: function(error){
            console.log(error);
        }
    });
}