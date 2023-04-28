class TABLA {
    private tabla: any[]
    constructor(){
        this.tabla = [];
    }
    public save(objeto:any){
        for(let elem of this.tabla){
            if(elem.id == objeto.id){
                return;
            }
        }

        this.tabla.push(objeto);
    }

    public eliminar(){
        this.tabla.length=0
    }
}

let tabla=new TABLA()
export {tabla}
