import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";

export class Lista extends Instruccion{
    constructor(public tipo:Tipo, public id:string,public tipo1:Tipo,linea:number,columna:number){
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola) {
        if(this.tipo==this.tipo1){
            if(!entorno.guardar(this.tipo,this.id,[])){
                throw new Error(`La lista ${this.id} ya existe`);
            }
        }
    }
}