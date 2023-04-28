import { Tipo } from "../abstracts/Retorno";
import { Ambiente } from "../Simbolos/Ambiente";
import { Expresion } from "../abstracts/Expresion";
import { Consola } from "abstracts/Consola";

export class Aritmeticas extends Expresion {
    public izq: Expresion;
    public der: Expresion;
    public op: string;
    constructor(izq: Expresion, operador: string, der: Expresion, linea: number, columna: number) {
        super(linea, columna);
        this.izq = izq;
        this.der = der;
        this.op = operador
    }

    public ejecutar(entorno: Ambiente,consola:Consola) {
        let izquierda = this.izq.ejecutar(entorno,null);
        let derecha = this.der.ejecutar(entorno,null);
        let resultado: any;
        let dom: Tipo = this.OperacionD(izquierda.type, derecha.type);


        switch (this.op) {
            case "+":
                if (dom == Tipo.INT) {

                    if (izquierda.type == Tipo.BOOLEAN) {
                        izquierda.valor = (izquierda.valor) ? 1 : 0;
                    } else if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    if (derecha.type == Tipo.BOOLEAN) {
                        derecha.valor = (derecha.valor) ? 1 : 0;
                    } else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseInt(izquierda.valor) + parseInt(derecha.valor), type: dom };
                    return resultado;

                } else if (dom == Tipo.STRING) {
                    resultado = { valor: izquierda.valor.toString() + derecha.valor.toString(), type: dom };
                    return resultado;
                } else if (dom == Tipo.DOUBLE) {
                    if (izquierda.type == Tipo.BOOLEAN) {

                        izquierda.valor = (izquierda.valor) ? 1 : 0;
                    } else if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    if (derecha.type == Tipo.BOOLEAN) {
                        derecha.valor = (derecha.valor) ? 1 : 0;
                    } else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseFloat(izquierda.valor+derecha.valor), type: dom };
                    return resultado;
                }else{
                    throw new Error(`No se puede operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`);
                }

            case "-":
                if (dom == Tipo.INT) {
                    if (izquierda.type == Tipo.BOOLEAN) {
                        izquierda.valor = (izquierda.valor) ? 1 : 0;
                    } else if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    if (derecha.type == Tipo.BOOLEAN) {
                        derecha.valor = (derecha.valor) ? 1 : 0;
                    } else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseInt(izquierda.valor) - parseInt(derecha.valor), type: dom };
                    return resultado;

                } else if (dom == Tipo.DOUBLE) {
                    if (izquierda.type == Tipo.BOOLEAN) {
                        izquierda.valor = (izquierda.valor) ? 1 : 0;
                    } else if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    if (derecha.type == Tipo.BOOLEAN) {
                        derecha.valor = (derecha.valor) ? 1 : 0;
                    } else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseFloat(izquierda.valor) - parseFloat(derecha.valor), type: dom };
                    return resultado;
                }
                else {
                    throw new Error(`No se puede operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`);
                }
            case "*":
                if (izquierda.type == Tipo.BOOLEAN || derecha.type == Tipo.BOOLEAN || izquierda.type==4 || derecha.type==4) {
                    throw new Error(`No se puede operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`);
                }
                if (dom == Tipo.INT) {
                    if (izquierda.type == Tipo.BOOLEAN || derecha.type == Tipo.BOOLEAN || izquierda.type==4 || derecha.type==4) {
                    throw new Error(`No se puede operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`);
                }
                    if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseInt(izquierda.valor) * parseInt(derecha.valor), type: dom };
                    return resultado;
                } else if (dom == Tipo.DOUBLE) {
                    if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseFloat(izquierda.valor) * parseFloat(derecha.valor), type: dom };
                    return resultado;
                }

            case "/":
                if (izquierda.type == Tipo.BOOLEAN || derecha.type == Tipo.BOOLEAN || izquierda.type==4 || derecha.type==4) {
                    throw new Error(`No se puede operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`);
                }
                //EL / no retorna int pero para no realizar otra tablaD
                if (dom == Tipo.INT) {
                    if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseFloat(izquierda.valor) / parseFloat(derecha.valor), type: Tipo.DOUBLE };
                    return resultado;
                } else if (dom == Tipo.DOUBLE) {
                    if (izquierda.type == Tipo.CHAR) {
                        izquierda.valor = izquierda.valor.charCodeAt(0);
                    }
                    else if (derecha.type == Tipo.CHAR) {
                        derecha.valor = derecha.valor.charCodeAt(0);
                    }
                    resultado = { valor: parseFloat(izquierda.valor) / parseFloat(derecha.valor), type: dom };
                    return resultado;
                }
            case "^":

                if ((izquierda.type == 2 || derecha.type == 2) || (izquierda.type == 3 || derecha.type == 3) || (izquierda.type == 5 || derecha.type == 5)) {
                    throw new Error(`No se operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`)
                }

                if (dom == Tipo.INT) {
                    resultado = { valor: parseFloat(izquierda.valor) ** parseFloat(derecha.valor), type: Tipo.DOUBLE };
                    return resultado;
                } else if (dom == Tipo.DOUBLE) {
                    resultado = { valor: parseFloat(izquierda.valor) ** parseFloat(derecha.valor), type: dom };
                    return resultado;
                } else {
                    throw new Error(`No se operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`)
                }
            case "%":

                if ((izquierda.type == 2 || derecha.type == 2) || (izquierda.type == 3 || derecha.type == 3) || (izquierda.type == 5 || derecha.type == 5)) {
                    throw new Error(`No se operar ${Tipo[izquierda.type]} con ${Tipo[derecha.type]}`)
                }


                if (dom == Tipo.INT) {
                    resultado = { valor: parseFloat(izquierda.valor) % parseFloat(derecha.valor), type: Tipo.DOUBLE };
                    return resultado;
                } else if (dom == Tipo.DOUBLE) {
                    resultado = { valor: parseFloat(izquierda.valor) % parseFloat(derecha.valor), type: dom };
                    return resultado;
                }
            case "NEG":
                resultado={valor: 0-derecha.valor,type: derecha.type};
                return resultado
        }
    }
}