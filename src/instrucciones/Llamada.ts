import { Funcion } from "../Simbolos/Funcion";
import { Ambiente } from "../Simbolos/Ambiente";
import { Consola } from "../abstracts/Consola";
import { Instruccion } from "../abstracts/Instruccion";
import { Tipo } from "../abstracts/Retorno";

export class Llamada extends Instruccion {
    constructor(public id: string, public params: any, linea: number, columna: number) {
        super(linea, columna);
    }


    public ejecutar(entorno: Ambiente, consola: Consola): any {
        let funcion: Funcion=entorno.getFuncion(this.id);
        if(funcion==null){
            throw new Error(`La funcion ${this.id} no existe`);
        }
        
        let paramts=funcion.getParams();   //Obtiene los parametrso de la funcion 
        let temp: any;
        if(this.params!=null){
            let nuevo=new Ambiente(entorno);
            for(let i=0;i<this.params.length;i++){
                let val=this.params[i].ejecutar(entorno)      //Obtiene y ejecuta el argumento que se pasa
                temp=paramts[i].getVariable();              //Obtiene el nombre y valor del parametro
                nuevo.guardar(temp.tipo,temp.id,val.valor,temp.linea,temp.columna);

            }

            let a=funcion.getbloq().ejecutar(nuevo,consola)
            if(a!=null && funcion.getTipo()==Tipo.VOID){
                throw new Error(`La función es de tipo VOID`);
            }
    
            if(a!=null && funcion.getTipo()==a.type){
                return a;
            }else if(funcion.getTipo()!=Tipo.VOID){
                throw new Error(`La funcion debe retornar ${Tipo[funcion.getTipo()]}`);
            }
            return;
            
        }

        let a=funcion.getbloq().ejecutar(entorno,consola);
        if(a!=null && funcion.getTipo()==Tipo.VOID){
            throw new Error(`La función es de tipo VOID`);
        }

        if(a!=null && funcion.getTipo()==a.type){
            return a;
        }else if(funcion.getTipo()!=Tipo.VOID){
            throw new Error(`La funcion debe retornar ${Tipo[funcion.getTipo()]}`);
        }
        return;
    }
}