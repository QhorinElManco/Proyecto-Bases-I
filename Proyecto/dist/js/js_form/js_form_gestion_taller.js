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
                    alert(respuesta);
                    $("#lista").empty();
                    verTalleres();
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
                data: "id="+$("#int_id_edit").val()+"&"+"nombre="+$("#txt_nombre_edit").val()+"&"
                       +"direccion="+$("#txt_direccion_edit").val(),
                success: function (respuesta) {
                    alert(respuesta);
                    $("#lista").empty();
                    verTalleres();
                },
                error: function(error){
                    console.log(error);
                }
            });
    });
    //Funcion para eliminar
    $("#ELIMINAR").click(function () {
        $.ajax({
            url: "../ajax/eventos_gestion_taller.php?accion=4",
            method: "POST",
            dataType: "html",
            data: "id="+$("#int_id_remove").val(),
            success: function (respuesta) {
                alert(respuesta);
                $("#lista").empty();
                verTalleres();
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
