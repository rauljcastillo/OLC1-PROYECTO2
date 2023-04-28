import { Tipo } from "../abstracts/Retorno";

export class Params{
    constructor(private tipo:Tipo, private id:string){

    }

    public getVariable(){
        return {id: this.id,tipo:this.tipo}
    }
}