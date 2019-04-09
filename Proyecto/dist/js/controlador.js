$(document).ready(function(){

    document.getElementById("div_registro2").style.display = "none";
    document.getElementById("div_registro3").style.display = "none";

    ocultarRegistro1 = function(){
        document.getElementById("div_registro1").style.display = "none";
        document.getElementById("div_registro2").style.display = "block";
    };

    botonAtras = function(){
        document.getElementById("div_registro2").style.display = "none";
        document.getElementById("div_registro1").style.display = "block";
    };

    botonSiguiente = function(){
        document.getElementById("div_registro2").style.display = "none";
        document.getElementById("div_registro3").style.display = "block";
    };

    botonAtras2 = function(){
        document.getElementById("div_registro3").style.display = "none";
        document.getElementById("div_registro2").style.display = "block";
    }


    botonGuardar = function(){

    };
    /*
    document.getElementById("div_registro2").style.display = "none";
    document.getElementById("div_registro3").style.display = "none";
    
    ocultarRegistro1 = function(){
        document.getElementById("div_registro1").style.display = "none";
        document.getElementById("div1").innerHTML("div_registro2");
    };*/
});
