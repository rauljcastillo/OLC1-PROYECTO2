import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";
import { Funcion } from "./Funcion";
import { Variable } from "./Variable"
import { tabla } from "../Simbolos/Grafico";
export class Ambiente {
    public anterior: Ambiente
    private variables: Map<string, Variable>
    private metodos: Map<string, Funcion>

    constructor(anterior: Ambiente | null) {
        this.anterior = anterior
        this.variables = new Map();
        this.metodos = new Map();
    }

    public guardar(tipo: Tipo, id: string, valor: any | null) {
        let entorno: Ambiente = this;
        if (!entorno.variables.has(id)) {
            this.variables.set(id, new Variable(tipo, id, valor));
            (entorno.anterior==null)?tabla.save({id,tipo,valor:"Global"}):tabla.save({id,tipo,valor:"Local"}) ;
            return true
        }
        return false;
    }



    public getVariable(id: string) {
        let entorno: Ambiente = this;
        while (entorno != null) {
            if (entorno.variables.has(id)) {
                return { valor: entorno.variables.get(id).getValor(), type: entorno.variables.get(id).getTipo() };
            }
            entorno = entorno.anterior;
        }
        return null;
    }

    public actualizarVariable(id: string, valor: any, tipo: Tipo) {
        let entorno: Ambiente = this;
        while (entorno != null) {
            if (entorno.variables.has(id) && tipo == entorno.variables.get(id).getTipo()) {

                entorno.variables.get(id).setValor(valor);
                return true;
            } else if (entorno.variables.has(id)) {
                throw new Error(`No se puede asignar ${Tipo[tipo]} a ${Tipo[entorno.variables.get(id).getTipo()]}`);
            }
            entorno = entorno.anterior;

        }
        return null
    }

    public guardarFuncion(tipo: Tipo, id: string, params: any | null, bloq: Instruccion) {
        if (!this.metodos.has(id)) {
            this.metodos.set(id, new Funcion(tipo, id, params, bloq))
            return;
        }
    }

    public getFuncion(id: string) {
        let entorno: Ambiente = this;
        while (entorno != null) {
            if (entorno.metodos.has(id)) {
                return entorno.metodos.get(id);
            }
            entorno = entorno.anterior;
        }
    }

    public getGlobal() {
        let entorno: Ambiente = this;
        while (entorno != null) {
            entorno = entorno.anterior
        }
        return entorno
    }


}

/*
{
    int a=0;
    {
        int a=1;
    }
    int a=1;
}

*/