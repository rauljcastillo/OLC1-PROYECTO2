import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "./Consola";
import { Tipo } from "./Retorno";
import { Tabla } from "./TablaD";

export abstract class Expresion {

    public linea: number;
    public columna: number;

    constructor(linea: number, columna: number) {
        this.linea = linea;
        this.columna = columna;
    }

    public abstract ejecutar(entorno:Ambiente,consola:Consola):any;

    public OperacionD(tipoA: Tipo,tipoB:Tipo):Tipo{
        return Tabla[tipoA][tipoB];
    }
}