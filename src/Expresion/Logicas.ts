import { Consola } from "../abstracts/Consola";
import { Ambiente } from "../Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";
import { Tipo } from "../abstracts/Retorno";

export class Logicas extends Expresion{

    public izq:Expresion;
    public der:Expresion;
    public signo:string;

    constructor(izq:Expresion,signo:string,der:Expresion,fila:number,columna:number){
        super(fila,columna);
        this.izq=izq;
        this.der=der;
        this.signo=signo;
    }

    public ejecutar(entorno: Ambiente,consola:Consola) {
        let izq=this.izq.ejecutar(entorno,consola);
        let der=this.der.ejecutar(entorno,consola);
        switch(this.signo){
            case ">":
                return {valor: izq.valor>der.valor,type:Tipo.BOOLEAN};
            case "<":
                return {valor: izq.valor<der.valor,type:Tipo.BOOLEAN};
            case ">=":
                return {valor: izq.valor>=der.valor,type: Tipo.BOOLEAN};
            case "==":
                return {valor:izq.valor==der.valor,type:Tipo.BOOLEAN};
            case "<=":
                return {valor: izq.valor<=der.valor,type: Tipo.BOOLEAN};
            case "&&": 
                return {valor: izq.valor&&der.valor,type: Tipo.BOOLEAN};
            case "||":
                return {valor: izq.valor||der.valor,type: Tipo.BOOLEAN};
            case "!=":
                return {valor: izq.valor!=der.valor,type: Tipo.BOOLEAN};
            
        }
    }
}