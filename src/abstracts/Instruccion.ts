import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "./Consola";

export abstract class Instruccion{
    public linea:number;
    public columna:number;
    constructor(linea:number,columna:number){
        this.linea=linea;
        this.columna=columna;
    }

    public abstract ejecutar(entorno:Ambiente,consola:Consola):any;
}