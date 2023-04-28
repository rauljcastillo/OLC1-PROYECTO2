import { Logicas } from "../Expresion/Logicas";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Expresion } from "../abstracts/Expresion";
import { Instruccion } from "../abstracts/Instruccion";

export class FOR extends Instruccion {
    constructor(public declaracion: Instruccion, public condicion: Expresion, public actualz: Instruccion, public instrucciones: Instruccion, fila: number, columna: number) {
        super(fila, columna);
    }

    public ejecutar(entorno: Ambiente, consola: Consola): void {
        let nuevo = new Ambiente(entorno);
        let retorno:any;

        if (this.condicion instanceof Logicas) {                //La expresion debe ser de tipo Logicas 
            this.declaracion.ejecutar(nuevo, consola)           //Ejecuta las declaraciones ejemplo (int a=0 o a=0;)
            let a = this.condicion.ejecutar(nuevo,consola);              //Retornar la operacion de la condicion
            while (a.valor) {                                   
                retorno=this.instrucciones.ejecutar(nuevo, consola);    //Ejecuto todas las intrucciones que vengan dentro del for
                if(retorno!=null){
                    if(retorno.type=="break") return;
                }
                this.actualz.ejecutar(nuevo, consola);          //Actualizo la variable de incremento o decremento
                a.valor = this.condicion.ejecutar(nuevo,null).valor;
            }
        }
    }
}