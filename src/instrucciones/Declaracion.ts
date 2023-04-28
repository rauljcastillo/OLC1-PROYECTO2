import { Tipo } from "../abstracts/Retorno";
import { Ambiente } from "../Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";
import { Consola } from "../abstracts/Consola";

export class Declaracion extends Instruccion {

    constructor(public tipo: Tipo, public id: string, public valor: Expresion | null, linea: number, columna: number) {
        super(linea, columna);
    }

    public ejecutar(entorno: Ambiente,consola:Consola) {
        if (this.valor) {
            let { valor, type } = this.valor.ejecutar(entorno,consola);
            if (this.tipo == type) {
                let result = entorno.guardar(this.tipo, this.id, valor);
                
                if (!result) {
                    throw new Error(`Variabe ${this.id} ya existe`);
                }
            }else{
                throw new Error(`No se puede asignar ${Tipo[type]} a ${Tipo[this.tipo]}`);
            }
            return;
        }

        if(!entorno.guardar(this.tipo,this.id,null)){
            throw new Error(`Variabe ${this.id} ya existe`);
        }
    }
}