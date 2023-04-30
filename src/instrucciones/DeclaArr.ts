import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";

export class DeclaArray extends Instruccion{
    constructor(public tipo: Tipo, public id: string,public tipo1:Tipo| null,public longitud:any, linea:number,columna:number){
        super(linea,columna);
    }
    // int [] id = new int[1]
    public ejecutar(entorno: Ambiente, consola: Consola): void {
        if(this.tipo1!=null){
            let a=this.longitud.ejecutar(entorno,consola);  
            if(this.tipo===this.tipo1 && a.type==Tipo.INT){
                if(!entorno.guardar(this.tipo,this.id,new Array(a.valor),this.linea,this.columna)) throw new Error("Ya existe");
            }else{
                throw new Error("Error de tipo o Longitud");
            }
            return;
        }
        let objeto: any;
        let temp=[]
        for(let elemento of this.longitud){
            objeto=elemento.ejecutar(entorno,consola);
            if(objeto.type!=this.tipo) throw new Error("Error de tipo"); 
            temp.push(objeto.valor);
        }
        if(!entorno.guardar(this.tipo,this.id,temp,this.linea,this.columna)) throw new Error("Ya existe");
    }
}