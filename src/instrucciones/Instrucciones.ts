import { Ambiente } from "../Simbolos/Ambiente";
import { Instruccion } from "../abstracts/Instruccion";
import { Consola } from "../abstracts/Consola";
export class Instrucciones extends Instruccion {
    public cuerpoIns: Instruccion[]
    
    constructor(inst: Instruccion[],fila:number,columna:number){
        super(fila,columna);
        this.cuerpoIns=inst;
        
    }

    public ejecutar(entorno: Ambiente,consola:Consola){
        let nuevo=new Ambiente(entorno);
        let a:any;
        for(let element of this.cuerpoIns){
            a=element.ejecutar(nuevo,consola);
            if(a!=null){
                if(a.type=="return"){                           //Esta parte es cuando se usan funciones recursivas
                    let val=a.valor.ejecutar(nuevo,consola);
                    return val
                }
                return a;
            } 
        }
    }
}