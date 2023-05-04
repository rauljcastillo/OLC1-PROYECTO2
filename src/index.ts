import express from 'express';
import cors from 'cors';
import { Ambiente } from './Simbolos/Ambiente';
import { Consola } from './abstracts/Consola';
import { tabla } from './Simbolos/Grafico';
import { Declaracion } from './instrucciones/Declaracion';
import { Funciones } from './instrucciones/Funciones';
import { Main } from './instrucciones/Main';

const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('¡Hola, mundo!');
});

app.listen(4000, () => {
  console.log('Servidor iniciado en el puerto 3000');
});


app.post("/texto", (req, res) => {
  var parser = require("./gramar/gramatica")
  let { texto } = req.body;
  var resultado = parser.parse(texto);
  let global = new Ambiente(null)
  let consola = new Consola();
  tabla.eliminar();


  

  try {
    for (let inst of resultado.gram) {
      if(inst instanceof Declaracion || inst instanceof Funciones){
        inst.ejecutar(global,consola)
      }
    }
  } catch (error) {
    consola.borrar();
    consola.escribirCadena(error.message);
  }

  try {
    for (let inst of resultado.gram) {
      if(inst instanceof Main){
        inst.ejecutar(global,consola)
        break;
      }
    }
  } catch (error) {
    consola.borrar();
    consola.escribirCadena(error.message);
  }
  


  res.send({valor: consola.getCadena(),table: tabla.graficarTabla(),tree: resultado.nodo.graficarA()});
})