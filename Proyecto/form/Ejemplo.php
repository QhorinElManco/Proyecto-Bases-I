<link href="estilo.css" rel="stylesheet">

<div id="boton" onclick="divLogin()">

Mostrar/Ocultar

</div>

<div id="caja">

</div>

<h3 style="margin: 20px 0px 30px 0px; ">Crear su cuenta
                                        de AutoMotor</h3>
                                    <input type="hidden" id="idPersona">
                                    <input type="hidden" id="idCliente">
                                    <div id="div-contenido" class="form-group row ">
                                        <label class="col-sm-3 text-left control-label col-form-label">Nombres</label>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="txt_pnombre"
                                                placeholder="Primer nombre">
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control" id="txt_snombre"
                                                placeholder="Segundo nombre">
                                        </div>
                                    </div>
                                    <button onclick="llenarDiv();">Llenar contenido</button>
<script>
var clic = 1;


llenarDiv = function(){
    document.getElementById("div-contenido").style.display = 'none';
}


function divLogin(){ 

   if(clic==1){

   document.getElementById("caja").style.height = "100px";

   clic = clic + 1;

   } else{

       document.getElementById("caja").style.height = "0px";      

    clic = 1;

   }   

}

</script>