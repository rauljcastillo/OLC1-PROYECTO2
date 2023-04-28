import { Tipo } from "../abstracts/Retorno";
import { Expresion } from "../abstracts/Expresion";


export class Literal extends Expresion{
    public linea: number;
    public columna: number;
    public valor:string;
    public tipo:Tipo;
    constructor(valor: string,tipo: Tipo,linea:number,columna:number){
        super(linea,columna);
        this.valor=valor;
        this.tipo=tipo;
    }

    public ejecutar() {
        switch(this.tipo){
            case Tipo.INT:
                return {valor:parseInt(this.valor),type: Tipo.INT};
            case Tipo.STRING:
                return {valor:this.valor.replace("\"","").replace("\"",""),type: Tipo.STRING};
            
            case Tipo.DOUBLE:
                return {valor:parseFloat(this.valor),type: Tipo.DOUBLE};
            
            case Tipo.BOOLEAN:
                return {valor:this.valor==="true",type:Tipo.BOOLEAN};
            case Tipo.CHAR:
                return {valor:this.valor.replace("\'","").replace("\'",""),type:Tipo.CHAR};
            
        }
    }
}


