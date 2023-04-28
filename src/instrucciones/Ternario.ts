import { Logicas } from "../Expresion/Logicas";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";

export class TERNARIO extends Instruccion{
    constructor(public condicion:Expresion, public verdad: Expresion, public falso:Expresion,linea:number,columna:number){
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola) {
        if(this.condicion instanceof Logicas){
            let a=this.condicion.ejecutar(entorno,consola);
            if(a.valor){
                let verd=this.verdad.ejecutar(entorno,consola);
                return {valor: verd.valor, type: verd.type}
            }else{
                let fals=this.falso.ejecutar(entorno,consola);
                return {valor:fals.valor,type:fals.type};
            }
        }else{
            throw new Error(`La operacion debe contener una condicion`);
        }
    }
}