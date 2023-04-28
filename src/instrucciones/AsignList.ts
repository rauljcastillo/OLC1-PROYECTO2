import { Tipo } from "../abstracts/Retorno";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";

export class AsignLista extends Instruccion {
    constructor(public id: string, public position: Expresion|null, public valor: Expresion, linea: number, columna: number) {
        super(linea, columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola) {
        let variable = entorno.getVariable(this.id)
        if (variable != null) {
            if (this.position == null) {
                let tem = this.valor.ejecutar(entorno, consola);
                if (variable.type == tem.type) {
                    variable.valor.push(tem.valor);
                } else {
                    throw new Error(`No se puede asignar ${Tipo[tem.type]} a ${Tipo[variable.type]}`)
                }

            }else{
                let tem=this.valor.ejecutar(entorno,consola);
                if(variable.type==tem.type){
                    let pos=this.position.ejecutar(entorno,consola);
                    variable.valor[pos.valor]=tem.valor;
                    return;
                }
                throw new Error(`No se puede asignar ${Tipo[tem.type]} a ${Tipo[variable.type]}`)
            }

        }
    }
}