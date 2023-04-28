import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";
import { RETORNOS, Tipo } from "../abstracts/Retorno";

export class Casteo extends Expresion{
    constructor(public tipo:Tipo, public expresion:Expresion,linea:number,columna:number){
        super(linea,columna);
    }


    public ejecutar(entorno: Ambiente, consola: Consola) {
        let a:RETORNOS=this.expresion.ejecutar(entorno,consola)
        switch(a.type){
            case Tipo.INT:
                if(this.tipo==Tipo.DOUBLE){
                    return {valor: parseFloat(a.valor),type: Tipo.DOUBLE}
                }else if(this.tipo==Tipo.CHAR){
                    return {valor: String.fromCharCode(a.valor),type: Tipo.CHAR}
                }
            case Tipo.DOUBLE:
                if(this.tipo==Tipo.INT){
                    return {valor: parseInt(a.valor),type: Tipo.INT}
                }

            case Tipo.CHAR:
                if(this.tipo==Tipo.INT){
                    return {valor: a.valor.charCodeAt(0),type: Tipo.INT}
                }else if(this.tipo==Tipo.DOUBLE){
                    return {valor: parseFloat(a.valor.charCodeAt(0)),type: Tipo.DOUBLE}
                }
        }
    }
}