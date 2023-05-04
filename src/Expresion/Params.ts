import { Tipo } from "../abstracts/Retorno";

export class Params{
    constructor(private tipo:Tipo, private id:string,private linea:number,private columna:number){

    }

    public getVariable(){
        return {id: this.id,tipo:this.tipo,linea: this.linea,columna:this.columna}
    }
}