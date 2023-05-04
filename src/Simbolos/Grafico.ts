import { Tipo } from "../abstracts/Retorno";

class TABLA {
    private tabla: any[]
    constructor(){
        this.tabla = [];
    }
    public save(objeto:any){
        for(let elem of this.tabla){
            if(elem.id == objeto.id){
                return;
            }
        }

        this.tabla.push(objeto);
    }

    public eliminar(){
        this.tabla.length=0
    }

    public graficarTabla(){
        let graf:string="digraph  G {\n";
        graf+="node [shape=none, fontname=\"Arial\" fontsize=\"14\"];\n"
        graf+="set1[ label=\n"
        graf+="<<TABLE border=\"0\" cellborder=\"1\" cellspacing=\"0\" cellpadding=\"4\">\n";
        graf+="<TR>\n"
        graf+="     <TD bgcolor=\"green\"> ID </TD>\n";
        graf+="     <TD bgcolor=\"green\"> Tipo </TD>\n";
        graf+="     <TD bgcolor=\"green\"> Objeto </TD>\n";
        graf+="     <TD bgcolor=\"green\"> Entorno </TD>\n";
        graf+="     <TD bgcolor=\"green\"> Línea </TD>\n";
        graf+="     <TD bgcolor=\"green\"> Columna </TD>\n"; 
        graf+="</TR>\n";


        for(let elemento of this.tabla){
            graf+="<TR>\n"
            graf+=`     <TD> ${elemento.id} </TD>\n`
            graf+=`     <TD> ${Tipo[elemento.tipo]}</TD>\n`
            graf+=`     <TD> ${elemento.type} </TD>\n`
            graf+=`     <TD> ${elemento.valor} </TD>\n`
            graf+=`     <TD> ${elemento.linea} </TD>\n`
            graf+=`     <TD> ${elemento.columna} </TD>\n`
            graf+="</TR>\n"
        }
        graf+="</TABLE>>];\n";
        graf+="}";
        return graf;

    }
}

let tabla=new TABLA()
export {tabla}
