import { Expresion } from "abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "abstracts/Consola";
import { CASE } from "./CASE";
import {Tipo} from "../abstracts/Retorno"

export class SWITCH extends Instruccion{
    //(variable es la variable que puede venir dentro del switch )
    //Ejemplo switch(/*numero*/){}
    constructor(public variable: Expresion, public listaCase: CASE[],public defaul: Instruccion[],linea:number,columna:number){
        super(linea,columna);

    }

    public ejecutar(entorno: Ambiente, consola: Consola): void {
        let nuevo=new Ambiente(entorno);
        let variable=this.variable.ejecutar(nuevo,null); //Variable del switch
        let a:any;              //variable de case ejemplo case 0. El 0 es la variable 
        let temp:any    //Almacena el break si viniese
        let paso:boolean=false; //Es una bandera para ejecutar los demas case sino ejecutan la instruccion break
        
        for(let elemento of this.listaCase){
            a=elemento.getValor();
            if((a.valor==variable.valor && a.type==variable.type)|| paso){
                temp=elemento.ejecutarCase(nuevo,consola)
                paso=true;
                if(temp!=null) return;
            }else if(a.type!=variable.type){
                throw new Error(`No se puede verificar un ${Tipo[variable.type]} con ${Tipo[a.type]}`)
            }
            
        }
        //Entra al default si a==null y su this.default es distinto de null
        if(this.defaul!=null){
            for(let temp of this.defaul){
                temp.ejecutar(nuevo,consola);
            }
        }
    }
}