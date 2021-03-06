$(document).ready(function () {
    verTalleres();
    //Funcion de agregar sucursal al precionar boton agregar
    $("#AGREGAR").click(function () {
            $.ajax({
                url: "../ajax/eventos_gestion_taller.php?accion=2",
                method: "POST",
                dataType: "html",
                data: "descripcion="+$("#txt_descripcion").val()+"&"
                       +"sucursal="+$("#txt_nombreSucursal").val(),
                success: function (respuesta) {
                    $("#lista").empty();
                    verTalleres();
                    $("#cuerpoModal").empty();
                    $("#cuerpoModal").append(respuesta);
                    $("#ModalMensaje").modal("show");
                },
                error: function(error){
                    console.log(error);
                }
            });
    });
    //Funcion para editar
    $("#EDITAR").click(function () {
            $.ajax({
                url: "../ajax/eventos_gestion_taller.php?accion=3",
                method: "POST",
                dataType: "html",
                data: "id="+$("#int_id_edit").val()+"&"+"taller="+$("#nombre_edit").val()+"&"
                       +"sucursal="+$("#direccion_edit").val(),
                success: function (respuesta) {
                    $("#lista").empty();
                    verTalleres();
                    $("#cuerpoModal").empty();
                    $("#cuerpoModal").append(respuesta);
                    $("#ModalMensaje").modal("show");
                },
                error: function(error){
                    console.log(error);
                }
            });
    });
    //Funcion para eliminar
    $("#ELIMINAR").click(function () {
        console.log("Llama eliminar");
        $.ajax({
            url: "../ajax/eventos_gestion_taller.php?accion=4",
            method: "POST",
            dataType: "html",
            data: "id="+$("#id_remove").val(),
            success: function (respuesta) {
                console.log("despues de la respuesta");
                $("#lista").empty();
                verTalleres();
                $("#cuerpoModal").empty();
                $("#cuerpoModal").append(respuesta);
                $("#ModalMensaje").modal("show");
            },
            error: function(error){
                console.log(error);
            }
        });
});
})

//Funcion que carga todas las surcusales
function verTalleres() {
    $.ajax({
        url: "../ajax/eventos_gestion_taller.php?accion=1",
        method: "POST",
        dataType: "html",
        success: function (respuesta) {
            $("#lista").append(respuesta);
        },
        error: function(error){
            console.log(error);
        }
    });
}
