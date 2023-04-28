import { Tipo } from "../abstracts/Retorno";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";

export class IF extends Instruccion{
    public condicion:Expresion;
    public list: Instruccion;
    public elsf: Instruccion;
    constructor(condicion: Expresion,list: Instruccion,elsf: Instruccion,linea:number,columna:number){
        super(linea,columna);
        this.condicion = condicion;
        this.list=list;
        this.elsf=elsf
    }

    public ejecutar(entorno:Ambiente,consola:Consola): void {
        
        let {valor,type}=this.condicion.ejecutar(entorno,consola);
        let a:any|null;
        //console.log(value,"+",this.condicion);
        if(type!=Tipo.BOOLEAN){
            throw new Error("Error en la condicion de la instruccion IF");
        }

        if(valor){
            a=this.list.ejecutar(entorno,consola);
            if(a!=null) return a; 

        }else{
            if(this.elsf!=null){
                this.elsf.ejecutar(entorno,consola);
            }
        }

    }
}