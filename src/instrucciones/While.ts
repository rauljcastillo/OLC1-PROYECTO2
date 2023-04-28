import { Instruccion } from "../abstracts/Instruccion";
import { Expresion } from "../abstracts/Expresion";
import { Instrucciones } from "./Instrucciones";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
export class While extends Instruccion{
    constructor(public condicion:Expresion,public bloqInst: Instrucciones,linea:number,columna:number){
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola): void {
        let condition=this.condicion.ejecutar(entorno,consola);
        let a:any|null;
        while(condition.valor){
            
            a=this.bloqInst.ejecutar(entorno,consola);
            if(a!=null){
                if(a.type=="break") break;
                else if(a.type=="return" || (a.type!="break" && a.type!="continue")) return a;
            }
            condition.valor=this.condicion.ejecutar(entorno,consola).valor;
            
        }
    }
}