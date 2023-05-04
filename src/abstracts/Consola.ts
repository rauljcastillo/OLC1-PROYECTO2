export class Consola {

    private salida:string="";

    public escribirCadena(cadena:string){
        this.salida+=cadena+"\n";
    }

    public borrar(){
        this.salida="";
    }

    public getCadena():string{
        return this.salida;
    }
}