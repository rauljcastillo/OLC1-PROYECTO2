import { Instruccion } from "../abstracts/Instruccion";
import { Ambiente } from "../Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";
import { Consola } from "../abstracts/Consola";

export class Asignacion extends Instruccion {

    constructor(public id: string, public expresion: Expresion, public retornar:boolean,linea: number, columna: number) {
        super(linea, columna);

    }

    public ejecutar(entorno: Ambiente, consola: Consola) {
        if ("object" == typeof this.expresion) {
            let objeto = this.expresion.ejecutar(entorno,consola);
            if (!entorno.actualizarVariable(this.id, objeto.valor, objeto.type)) {
                throw new Error(`La variable ${this.id} no declarada`);
            }
            return;
        }

        //Realiza el a-- o a++ y verifica si hay que retornar algo o solamente asignar
        let a=entorno.getVariable(this.id)
        if(this.retornar){
            if(this.expresion=="+"){
                if (!entorno.actualizarVariable(this.id,a.valor+1, a.type)) {
                    throw new Error(`La variable ${this.id} no declarada`);
                }
                return {valor: a.valor+1,type:a.type}
            }else{
                if (!entorno.actualizarVariable(this.id,a.valor-1, a.type)) {
                    throw new Error(`La variable ${this.id} no declarada`);
                }
                return {valor: a.valor-1,type:a.type}
            }
        }
        if(this.expresion=="+"){
            if (!entorno.actualizarVariable(this.id,a.valor+1, a.type)) {
                throw new Error(`La variable ${this.id} no declarada`);
            }
        }else{
            if (!entorno.actualizarVariable(this.id,a.valor-1, a.type)) {
                throw new Error(`La variable ${this.id} no declarada`);
            }
        }

        
        

    }
}