import { Ambiente } from "Simbolos/Ambiente";
import { Consola } from "abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";

export class DOWHile extends Instruccion{
    constructor(public bloque:Instruccion, public condicion: Expresion,linea:number,columna:number){
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola): void {
        let a: any |null;
        let condition=this.condicion.ejecutar(entorno,null);
        do {
            a=this.bloque.ejecutar(entorno,consola);
            if(a!=null){
                if(a.type=="break") return;
            }

            condition.valor=this.condicion.ejecutar(entorno,null).valor;

        } while (condition.valor);
    }
}