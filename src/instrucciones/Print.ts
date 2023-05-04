import { Ambiente } from "Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";
import { Consola } from "../abstracts/Consola";

export class Print extends Instruccion {
    public valor: Expresion;
    public linea:number;
    public columna:number;
    constructor(valor:Expresion,linea:number,columna:number){
        super(linea,columna);
        this.valor=valor; 
    }

    public ejecutar(entorno:Ambiente,consola:Consola) {
        let value=this.valor.ejecutar(entorno,consola);
        consola.escribirCadena(value.valor);
    }
}