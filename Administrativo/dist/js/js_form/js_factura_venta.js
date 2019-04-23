$(document).ready(function () {
    verInfo();
    total();

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
                $("#total").empty();
                total();
                verInfo();
                $("#idEmpleado").append(respuesta);
                $("#idCliente").append(respuesta);
                alert(respuesta);
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
            $("#total").append(respuesta);
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
            $("#codigoFactura").append(respuesta);
           
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
            $("#fecha").append(respuesta);
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
            $("#idVehiculo").append(respuesta);
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
            $("#idTipoDescuento").append(respuesta);
           
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
            $("#idEmpleado").append(respuesta);
           
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
            $("#idCliente").append(respuesta);
           
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
            $("#idFormaPago").append(respuesta);
           
        },
        error: function(error){
            console.log(error);
        }
    });
  
  
}