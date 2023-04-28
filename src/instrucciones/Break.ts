import { Expresion } from "../abstracts/Expresion";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Instruccion } from "../abstracts/Instruccion";

export class BREAK extends Instruccion{
    constructor(public tipo:string,public instruccion:Expresion,linea:number,columna:number){
        super(linea,columna);

    }

    public ejecutar(entorno: Ambiente, consola: Consola): object {
        if(this.tipo=="1"){
            return {type: "break"};
        }else if(this.tipo=="2"){
            return {type:"continue",valor:null};
        }else{
            return {type: "return",valor:this.instruccion}
        }
    }
}