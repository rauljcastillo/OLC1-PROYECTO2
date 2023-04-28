import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";

export class DeclaArray extends Instruccion{
    constructor(public tipo: Tipo, public id: string,public tipo1:Tipo| null,public longitud:any, linea:number,columna:number){
        super(linea,columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola): void {
        if(this.tipo1!=null){
            let a=this.longitud.obtener(entorno);
            if(this.tipo===this.tipo1 && a.type==Tipo.INT){
                if(!entorno.guardar(this.tipo,this.id,new Array(a.valor))) throw new Error("Ya existe");
            }else{
                throw new Error("Error de tipo o Longitud");
            }
            return;
        }
        let objeto: any;
        let temp=[]
        for(let elemento of this.longitud){
            objeto=elemento.obtener(entorno);
            if(objeto.type!=this.tipo) throw new Error("Error de tipo"); 
            temp.push(objeto.valor);
        }
        if(!entorno.guardar(this.tipo,this.id,temp)) throw new Error("Ya existe");
    }
}