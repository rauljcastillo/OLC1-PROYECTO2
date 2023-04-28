import { Ambiente } from "../Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";

export class Acceso extends Expresion {
    public id:string;
    

    constructor(id: string,linea:number,columna:number){
        super(linea,columna);
        this.id=id;

        
    }

    public ejecutar(entorno:Ambiente) {
        let valor=entorno.getVariable(this.id);
        if(valor==null){
            throw new Error("Variable "+this.id+" no encontrada");
        }
        return valor;
    }
}