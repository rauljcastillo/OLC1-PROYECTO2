import { Ambiente } from "Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";
import { Consola } from "../abstracts/Consola";
import { Tipo } from "../abstracts/Retorno";

export class CASE {
    constructor(public expresion:Expresion,public instrucciones: Instruccion[]){
    }

    public ejecutarCase(entorno: Ambiente,consola:Consola): any {
        let a:any|null
        for(let elemento of this.instrucciones){
            a=elemento.ejecutar(entorno,consola);
            if(a!=null) return a;
        }
    }   

    public getValor(){
        return this.expresion.ejecutar(null,null);
    }

}