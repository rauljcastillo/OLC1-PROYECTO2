
export class Variable {
    constructor(private tipo:number,private id:string, private valor:any){
        this.tipo = tipo;
        this.id=id;
        this.valor=valor;
    }

    public getValor(){
        return this.valor;
    }

    public getTipo(){
        return this.tipo;
    }

    public setValor(valor:any){
        this.valor=valor;
    }
}