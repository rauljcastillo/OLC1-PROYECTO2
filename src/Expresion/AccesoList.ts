import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";

export class  AccesLista extends Expresion{
    constructor(public id:string, public position: Expresion,linea:number,columna:number) {
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola) {
        let vari=entorno.getVariable(this.id);
        let position=this.position.ejecutar(entorno,consola);

        return {valor: vari.valor[position.valor],type: vari.type}

    }
}