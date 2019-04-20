$(document).ready(function(){
    cargarVehiculos();
    cargarEmpleados();
    cargarTipoMantenimiento();
    cargarClientes();
})

function cargarVehiculos(){
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarVehiculos",
        method: "POST",
        dataType: "html",
        success: function(respuesta){
            console.log(respuesta);
            $("#vehiculo").append(respuesta);
        },
        error: function(error){
            console.log(error);
        }
    });
}
function cargarEmpleados(){
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarEmpleados",
        method: "POST",
        dataType: "html",
        success: function(respuesta){
            console.log(respuesta);
            $("#empleado").append(respuesta);
        },
        error: function(error){
            console.log(error);
        }
    });
}
function cargarTipoMantenimiento(){
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarTipoMantenimiento",
        method: "POST",
        dataType: "html",
        success: function(respuesta){
            console.log(respuesta);
            $("#tipoMantenimiento").append(respuesta);
        },
        error: function(error){
            console.log(error);
        }
    });
}
function cargarClientes(){
    $.ajax({
        url: "ajax/eventos_solicitud_mantenimiento.php?accion=cargarClientes",
        method: "POST",
        dataType: "html",
        success: function(respuesta){
            console.log(respuesta);
            $("#cliente").append(respuesta);
        },
        error: function(error){
            console.log(error);
        }
    });
}