$(document).ready(function(){
    console.log("hola bitches");
    verSucursales();

})

function verSucursales(){
    console.log("carga la funcion");
    $.ajax({
        url:"../ajax/eventos_gestion_sucursal.php?accion=1",
        method: "GET",
        dataType:"json",
        success:function(respuesta){
            console.log(respuesta);
            for(var i =0; i<respuesta.length; i++){
                $("#lista").append(
                    `<tr>
                        <th>
                            <label class="customcheckbox">
                                <input type="checkbox" class="listCheckbox" value="${respuesta[i].idSurcusal}"/>
                                <span class="checkmark"></span>
                            </label>
                        </th>
                        <td>${respuesta[i].nombre}</td>
                        <td>${respuesta[i].direccion}</td>
                        </tr>
                        <tr>`);
                }
        },
    });
}