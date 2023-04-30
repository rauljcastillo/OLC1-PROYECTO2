import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";

export class Funciones extends Instruccion {
    constructor(public tipo: Tipo, public id: string, public params: any | null, public bloqueI: Instruccion, linea: number, columna: number) {
        super(linea, columna);

    }

    public ejecutar(entorno: Ambiente, consola: Consola): void {
        if (entorno.anterior == null) {
            entorno.guardarFuncion(this.tipo, this.id, this.params, this.bloqueI,this.linea,this.columna);
        }

    }

}
