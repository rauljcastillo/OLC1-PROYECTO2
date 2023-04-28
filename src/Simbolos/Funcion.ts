import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";

export class Funcion {
    constructor(private Tipo:Tipo, private id:string,private params:any[],private bloq: Instruccion) {

    }

    public getParams(){
        return this.params;
    }

    public getTipo(){
        return this.Tipo
    }

    public getbloq(){
        return this.bloq
    }

    public getId(){
        return this.id
    }
}