import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";

export class Especiales extends Instruccion {
    constructor(public tipo:string,public expresion:Expresion,linea:number,columna:number){
        super(linea,columna)
    }   


    public ejecutar(entorno: Ambiente, consola: Consola) {
        let a=this.expresion.ejecutar(entorno,consola)
        switch(this.tipo){
            case "1":           //Este el tipo length 
                if(Array.isArray(a.valor) || a.type==Tipo.STRING){
                    return {valor: a.valor.length, type: Tipo.INT}
                }
            case "2":           //Este el toLower
                if(a.type==Tipo.STRING){
                    return {valor: a.valor.toLowerCase(), type: Tipo.STRING}
                }
            case "3":           //toUpper
                if(a.type==Tipo.STRING){
                    return {valor: a.valor.toUpperCase(), type: Tipo.STRING}
                }
            case "4":        //truncate
                if(a.type==Tipo.DOUBLE){
                    return {valor: Math.trunc(a.valor), type: Tipo.INT}
                }
            case "5":     //ROund
                if(a.type==Tipo.DOUBLE || a.type==Tipo.INT){
                    return {valor: Math.round(a.valor), type: a.type}
                }
            case "6":  //Typeof
                return {valor: `${Tipo[a.type]}`, type: Tipo.STRING}
            case "7":   //toString
                return {valor: a.valor.toString(),type: Tipo.STRING}
        }
    }
}