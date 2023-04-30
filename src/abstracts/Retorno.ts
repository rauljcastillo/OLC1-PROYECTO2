export enum Tipo{
    INT,
    DOUBLE,
    BOOLEAN,
    CHAR,
    STRING,
    VOID,
    FUNCION,
    Array,
    Lista
}

export type RETORNOS={
    valor:any
    type: Tipo
}