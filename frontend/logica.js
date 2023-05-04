const editor = CodeMirror.fromTextArea(document.getElementById("codigo"), {
    lineNumbers: true,
    tabSize: 4,
    theme: "material-darker",
    matchBrackets: true,
    autoCloseBrackets: true,
    mode: "javascript"
});

const editor1 = CodeMirror.fromTextArea(document.getElementById("salida"), {
    lineNumbers: true,
    theme: "material-darker",
    mode: "text"
})
editor1.options.readOnly=true;
document.getElementById("home").addEventListener("click", () => {
    document.querySelector(".home").style.display = "flex";
    document.querySelector(".main").style.display = "none";
    document.querySelector(".Reportes").style.display = "none";
    document.getElementById("container-graph").style.display="none";
    document.getElementById("table").style.display="none"
    document.getElementById("tree").style.display="none"
})

document.getElementById("editor").addEventListener("click", () => {
    document.querySelector(".home").style.display = "none";
    document.querySelector(".main").style.display = "block";
    document.querySelector(".Reportes").style.display = "none";
    document.getElementById("container-graph").style.display="none";
    document.getElementById("table").style.display="none"
    document.getElementById("tree").style.display="none"
})

document.getElementById("reporte").addEventListener("click", () => {
    document.querySelector(".home").style.display = "none";
    document.querySelector(".main").style.display = "none";
    document.querySelector(".Reportes").style.display = "flex";
    document.getElementById("container-graph").style.display="none";
    document.getElementById("table").style.display="none"
    document.getElementById("tree").style.display="none"
})


document.getElementById("grafTab").addEventListener("click", () => {
    document.querySelector(".home").style.display = "none";
    document.querySelector(".main").style.display = "none";
    document.querySelector(".Reportes").style.display = "none";
    document.getElementById("container-graph").style.display="flex";
    document.getElementById("table").style.display="block"
    document.getElementById("tree").style.display="none"
})


document.getElementById("grafAST").addEventListener("click", () => {
    document.querySelector(".home").style.display = "none";
    document.querySelector(".main").style.display = "none";
    document.querySelector(".Reportes").style.display = "none";
    document.getElementById("container-graph").style.display="flex";
    document.getElementById("table").style.display="none"
    document.getElementById("tree").style.display="block"
})


//Peticion fetch
document.getElementById("ejecutar").addEventListener("click",()=>{
    let codigo = editor.getValue();
    console.log(codigo)
    fetch('http://localhost:4000/texto',{
        method: "POST",
        headers:{"Content-Type": "application/json"},
        body: JSON.stringify({"texto": codigo})
    })
    .then(respuesta => respuesta.json())
    .then(datos => {
        editor1.setValue(datos.valor)
        this.graficarT(datos.table)
        this.graficarAST(datos.tree)
    })
    .catch(error => console.log(error));
    
})

function limpiarConsola(){
    editor1.setValue("");
    console.log(editor1)
}


document.getElementById("btn-file").addEventListener("change",(e)=>{
    let archivo=e.target.files[0]
    let reader= new FileReader();
    reader.onload= function(e){
        editor.setValue(e.target.result)
    }

    reader.readAsText(archivo);
});


function graficarT(cadena){
    d3.select("#table").graphviz()
        .renderDot(cadena)
}

function graficarAST(cadena){
    d3.select("#tree").graphviz()
        .renderDot(cadena)
}