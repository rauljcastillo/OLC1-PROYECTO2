import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Instruccion } from "../abstracts/Instruccion";

export class Main extends Instruccion {
    constructor(public express: Instruccion,linea:number,columna:number){
        super(linea,columna)
    }

    public ejecutar(entorno: Ambiente, consola: Consola) {
        this.express.ejecutar(entorno,consola);
    }
}