export class NODO {

    public hijos:NODO[]=[]
    private id:string
    constructor(private nombre:string) {
        this.nombre=nombre;
        this.id=this.generarId();
    }

    public graficarA(){
        let cadena="digraph {\n"
        cadena+="rankdir= TB\n"
        cadena+= this.graficarinterno();
        cadena+="}"
        return cadena;
    }
    private graficarinterno(){
        let cadena=`nodo${this.id}[label="${this.nombre}"]\n`
        for(let hijo of this.hijos){
            cadena+= `nodo${this.id} -> nodo${hijo.id}\n`
            cadena+=hijo.graficarinterno()
        }

        return cadena;
    }

    private generarId(){
        return Math.random().toString(36).substr(2, 18);
    }

}