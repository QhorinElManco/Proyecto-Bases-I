$(document).ready(function () {
    cargarVehiculos();
    cargarEmpleados();
    cargarTipoMantenimiento();
    cargarClientes();
    $("#agregar").click(function () {
        $.ajax({
            url: "ajax/eventos_solicitud_mantenimiento.php?accion=agregar",
            method: "POST",
            dataType: "html",
            data:    "idVehiculo="+$("#vehiculo").val()
                    +"&idEmpleado="+$("#empleado").val()
                    +"&idTipoMantenimiento="+$("#tipoMantenimiento").val()
                    +"&idCliente="+$("#cliente").val()
                    +"&fechaFin="+$("#fechaFin").val(),
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

function cargarVehiculos() {
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarVehiculos",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#vehiculo").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
}
function cargarEmpleados() {
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarEmpleados",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#empleado").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
}
function cargarTipoMantenimiento() {
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarTipoMantenimiento",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#tipoMantenimiento").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
}
function cargarClientes() {
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarClientes",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#cliente").append(respuesta);
        },
        error: function (error) {
            console.log(error);
        }
    });
}
