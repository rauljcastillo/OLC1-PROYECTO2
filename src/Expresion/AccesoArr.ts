import { Ambiente } from "../Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";

export class AccesoArr extends Expresion{
    constructor(public id:string, public position: Expresion,linea:number,columna:number){
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente) {
        let a=entorno.getVariable(this.id);
        let pos=this.position.ejecutar(entorno,null);
        return {valor: a.valor[pos.valor], type: a.type};
    }
}