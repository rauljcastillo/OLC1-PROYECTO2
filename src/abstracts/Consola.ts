export class Consola {

    private salida:string="";

    public escribirCadena(cadena:string){
        this.salida+=cadena+"\n";
    }

    public getCadena():string{
        return this.salida;
    }
}