%{
    //codigo js

%}

%lex

%options case-insensitive
%x string
     


%%
//Expresiones a ignorar
[ \r\t]+                //Espacios en blanco
"//"[^\n]*              //Comentarios de linea
\/\*[\s\S]*?\*\/         //Comentarios multilinea
\s+                     //espacios en blancos
\n                      //salto de linea

//Palabras reservadas
"for"           return "FOR"
"while"         return "WHILE"
"if"            return "IF"
"else"          return "tELSE"
"double"        return "DOUBLE"
"int"           return "INT"
"boolean"       return "BOOLEAN"
"string"        return "STRING"
"char"          return "CHAR"
"switch"        return "SWITCH"
"case"          return "CASE"
"print"         return "PRINT"
"break"         return "BREAK"
"continue"      return "CONTIN"
"default"       return "DEFAULT"
"do"            return "DO"
"new"           return "NEW"
"add"           return "ADD"
"void"          return "VOID"
"return"        return "RETN"
"main"          return "MAIN"
"list"          return "LIST"
//CADENAS
"toLower"       return "tLow"
"toUpper"       return "tUpp"

//Length
"length"        return "len"

//Trunc
"truncate"      return "trun"

//Round
"round"         return "round"
"typeof"        return "typ"
"toString"      return "toStr"
"toCharArray"   return "tArr"

//Operadores
"?"             {return '?';}
"[["            {return '[[';}
"]]"            {return ']]';}
"."             {return '.';}
"++"            {return '++';}
"&&"            {return '&&';}
"=="            {return '==';}
"!="            {return '!=';}
"<="            {return '<=';}
">="            {return '>=';}
"+"             {return '+';}
"--"            {return '--';}
"*"             {return '*';}
"%"             {return '%';}
"^"             {return '^';}
"/"             {return '/';}
"-"             {return '-';}
//Expresiones
"("             {return '(';}
")"             {return ')';}
"{"             {return '{';}
"}"             {return '}';}
"["             {return '[';}
"]"             {return ']';}
"<"             {return '<';}
">"             {return '>';}
"="             {return '=';}
"true"          {return "ttrue";}
"false"         {return "tfalse";}
"!"             {return '!';}
":"             {return ':';}
";"             {return ';';}
","             {return ',';}
"||"            {return '||';}




//Expresiones regulares
["]                         {cadena = ''; this.begin("string");}
<string>[^"\\]+             {cadena+= yytext;}
<string>"\\\""              {cadena+="\"";}
<string>"\\n"               {cadena+="\n"}
<string>\s                  {cadena+=" ";}
<string>"\\t"               {cadena+="\t";}
<string>"\\\\"              {cadena+="\\";}
<string>"\\r"               {cadena+="\r";}
<string>[\\\']+              {cadena+="\'";}
<string>["]                 {yytext=cadena;this.popState(); return 'CADENA';}

([0-9]+\.[0-9]+)                {return "DECIMAL";}
(\b[a-zA-Z_]\w*\b)              {return "ID";}
([0-9]+)                        {return "ENTERO";}
\'[^\']\'                       {return "CHAR";}
<<EOF>>                         return "EOF"

. {
    console.log("Error",yylloc.first_line,yylloc.first_column,"-",yylloc.last_column)
}

/lex

%{
    const {Literal}= require("../Expresion/Literal");
    const {Tipo}=require("../abstracts/Retorno");
    const {Aritmeticas}=require("../Expresion/Arimeticas");
    const {Print}= require("../instrucciones/Print");
    const {IF}= require("../instrucciones/IF");
    const {Logicas}= require("../Expresion/Logicas");
    const {Casteo}= require("../Expresion/Casteos");
    const {Instrucciones}= require("../instrucciones/Instrucciones");
    const {Declaracion}= require("../instrucciones/Declaracion");
    const {Acceso}= require("../Expresion/Acceso");
    const {Asignacion}= require("../instrucciones/Asignacion");
    const {While}= require("../instrucciones/While");
    const {FOR}= require("../instrucciones/FOR");
    const {SWITCH}= require("../instrucciones/Switch");
    const {CASE}= require("../instrucciones/CASE");
    const {BREAK}= require("../instrucciones/Break");
    const {DOWHile}= require("../instrucciones/DoWhile");
    const {DeclaArray}=require("../instrucciones/DeclaArr");
    const {AccesoArr}=require("../Expresion/AccesoArr");
    const {AsignarA}=require("../instrucciones/AsignArr");
    const {Funciones}=require("../instrucciones/Funciones");
    const {Llamada}=require("../instrucciones/Llamada");
    const {Params}=require("../Expresion/Params");
    const {Lista}=require("../instrucciones/DeclarList");
    const {AsignLista}=require("../instrucciones/AsignList");
    const {AccesLista}=require("../Expresion/AccesoList");
    const {TERNARIO}=require("../instrucciones/Ternario");
    const {Especiales}=require("../instrucciones/FuncEspec");
    const {Main}=require("../instrucciones/Main");
    const {NODO}= require("../Simbolos/AST");
%}

%left '?' ':'
%left '||'
%left '&&'
%right '!'
%left '==' '!=' '<' '<=' '>' '>='
%left '+' '-'
%left '*' '/' '%'
%left '^'
%left ')' '('
%left UMENOS



//Gramatica
%start INICIO
%ebnf
%%

INICIO: instrucciones EOF {$$={gram: $1.gram, nodo: new NODO("INICIO")};
    $$.nodo.hijos.push($1.nodo);
    $$.nodo.hijos.push(new NODO("EOF"));
    return $$
}
;

instrucciones: 
    instrucciones instruccion   {$1.gram.push($2.gram);
    $1.nodo.hijos.push($2.nodo); 
    $$={gram: $1.gram,nodo: $1.nodo};
    }
    | instruccion               {$$={gram: [$1.gram] ,nodo:new NODO("Instrucciones")};
        $$.nodo.hijos.push($1.nodo);
    }
;

instruccion: 
    iIF             {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | iwhile        {$$={gram:$1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | asignacion    {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | declaracion   {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | fPRINT        {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | ifor          {$$={gram:$1.gram,nodo:new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | switch        {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | BREAK ';'     {$$={gram: new BREAK("1",@1.first_line,@1.first_column),nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push(new NODO($1));
    }
    | CONTIN ';'    {$$={gram: new BREAK("2",@1.first_line,@1.first_column),nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push(new NODO($1));
    }
    | dowhile       {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | decArray      {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | asignarArr    {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | FUNCION       {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | Llamada       {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | RETORNO       {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | Listas        {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | AddList     {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
    | MAIN Llamada  {$$={gram: new Main($2.gram,@1.first_line,@1.first_column), nodo:new NODO("Instruccion")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($2.nodo);
    }
    | AsignList {$$={gram: $1.gram,nodo: new NODO("Instruccion")};
        $$.nodo.hijos.push($1.nodo);
    }
;


RETORNO: RETN Expresion ';'  {$$={gram: new BREAK("3",$2.gram,@1.first_line,@1.first_column), nodo: new NODO("RETORNO")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push($2.nodo);
}
;

BSENTENCIAS: 
    '{' instrucciones '}'   {$$={gram: new Instrucciones($2.gram,@1.first_line,@1.first_column), nodo: $2.nodo};}
    | '{' '}'
;

iIF:  
    IF '(' Expresion ')' BSENTENCIAS            {$$={gram: new IF($3.gram,$5.gram,null,@1.first_line,@1.first_column),nodo: new NODO("If")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push(new NODO($4));
        $$.nodo.hijos.push($5.nodo);
    }
    
    | IF '(' Expresion ')' BSENTENCIAS ELSE     {$$={gram: new IF($3.gram,$5.gram,$6.gram,@1.first_line,@1.first_column), nodo: new NODO("if")};
    
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push(new NODO($4));
        $$.nodo.hijos.push($5.nodo);
        $$.nodo.hijos.push($6.nodo);
    }
    
;

ELSE: 
    tELSE iIF           {$$ ={gram: $2.gram ,nodo: new NODO("Else")};
        $$.nodo.hijos.push($2.nodo);
    }     
    | tELSE BSENTENCIAS {$$ ={gram: $2.gram ,nodo: new NODO("Else")};
        $$.nodo.hijos.push($2.nodo);
    }
;

switch: SWITCH '(' Expresion ')' '{' BLOQSWITCH fDEFAULT '}' {$$= {gram:new SWITCH($3.gram,$6.gram,$7.gram,@1.first_line,@1.first_column),nodo: new NODO("Switch")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push($3.nodo);
    $$.nodo.hijos.push(new NODO($4));
    $$.nodo.hijos.push($6.nodo);
    $$.nodo.hijos.push($7.nodo)
}
;

BLOQSWITCH: BLOQSWITCH fcase                {$1.gram.push($2.gram); $1.nodo.hijos.push($2.nodo);

    $$={gram: $1.gram,nodo: $1.nodo};
}
    | fcase                                 {$$={gram: [$1.gram], nodo: new NODO("Bloq_Case")};
        $$.nodo.hijos.push($1.nodo);
    }
;

fcase: CASE Expresion ':' instrucciones     {$$={gram:new CASE($2.gram,$4.gram),nodo:new NODO("Case")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push($2.nodo);
    $$.nodo.hijos.push(new NODO($3));
    $$.nodo.hijos.push($4.nodo);
}
;

fDEFAULT: DEFAULT ':' instrucciones                  {$$= {gram: $3.gram,nodo:new NODO("Default")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    |   {$$={gram: "", nodo: new NODO("Default")};}
;


iwhile: WHILE '(' Expresion ')' BSENTENCIAS  {$$={gram:new While($3.gram,$5.gram,@1.first_line,@1.first_column),nodo: new NODO("While")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push($3.nodo);
    $$.nodo.hijos.push(new NODO($4));
    $$.nodo.hijos.push($5.nodo);
}
;

ifor: 
    FOR '(' AssignFor ';' Expresion ';' Actualiz ')' BSENTENCIAS {$$={gram: new FOR($3.gram,$5.gram,$7.gram,$9.gram,@1.first_line,@1.first_column), nodo: new NODO("FOR")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push($5.nodo);
        $$.nodo.hijos.push($7.nodo);
        $$.nodo.hijos.push($9.nodo);
    } 
;

AssignFor: 
    TIPO ID '=' Expresion               {$$={gram:new Declaracion($1.gram,$2.toLowerCase(),$4.gram,@1.first_line,@1.first_column), nodo: new NODO("Asignacion")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push(new NODO($3));
        $$.nodo.hijos.push($4.nodo);
    }
    | ID  '=' Expresion                 {$$= {gram:new Asignacion($1,$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Asignación")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
;

Actualiz: 
    ID '=' Expresion                   {$$={gram:new Asignacion($1,$3.gram,@1.first_line,@1.first_column),nodo:new NODO("Actualiz")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | ID '++'                          {$$= {gram:new Asignacion($1,"+",false,@1.first_line,@1.first_column),nodo:new NODO("Actualiz")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
    }
    | ID '--'                          {$$= {gram:new Asignacion($1,"-",false,@1.first_line,@1.first_column),nodo:new NODO("Actualiz")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
    }
;

dowhile: DO BSENTENCIAS WHILE '(' Expresion ')' ';'  {$$={gram: new DOWHile($2.gram,$5.gram,@1.first_line,@1.first_column),nodo: new NODO("Do-While")};
    $$.nodo.hijos.push(new NODO("Do"));
    $$.nodo.hijos.push($2.nodo);
    $$.nodo.hijos.push(new NODO("While"));
    $$.nodo.hijos.push($5.nodo);
}
;

declaracion: TIPO ID '=' Expresion ';' {$$={gram:new Declaracion($1.gram,$2.toLowerCase(),$4.gram,@1.first_line,@1.first_column),nodo: new NODO("Declaracion")};
    $$.nodo.hijos.push($1.nodo);
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push(new NODO($3));
    $$.nodo.hijos.push($4.nodo);
}
    | TIPO ID ';'                      {$$={gram: new Declaracion($1.gram,$2.toLowerCase(),null,@1.first_line,@1.first_column),nodo:new NODO("Declaracion")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
    }
;

asignacion: ID '=' Expresion ';'       {$$= {gram:new Asignacion($1.toLowerCase(),$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Asignacion")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push($3.nodo);
}
    | ID '++' ';'                      {$$= {gram:new Asignacion($1.toLowerCase(),"+",false,@1.first_line,@1.first_column),nodo:new NODO("Asignacion")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
    }
    | ID '--' ';'                      {$$= {gram:new Asignacion($1.toLowerCase(),"-",false,@1.first_line,@1.first_column),nodo: new NODO("Asignacion")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
    }
;

decArray: TIPO '[' ']' ID '=' NEW TIPO '[' Expresion ']' ';'  {$$={gram:new DeclaArray($1.gram,$4.toLowerCase(),$7.gram,$9.gram,@1.first_line,@1.first_column),nodo: new NODO("Declarar_Arr")};
    $$.nodo.hijos.push($1.nodo);
    $$.nodo.hijos.push(new NODO($4));
    $$.nodo.hijos.push(new NODO($8));
    $$.nodo.hijos.push($9.nodo);
    $$.nodo.hijos.push(new NODO($10.nodo));
}
    | TIPO '[' ']' ID '=' '{' Lista_Valores '}' ';'                 {$$={gram: new DeclaArray($1.gram,$4.toLowerCase(),null,$7.gram,@1.first_line,@1.first_column),nodo: new NODO("Declarar_Arr")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($4));
        $$.nodo.hijos.push(new NODO($6));
    }
;

Lista_Valores: Lista_Valores ',' Expresion      {$1.gram.push($3.gram); $1.nodo.hijos.push($3.nodo);
    $$={gram: $1.gram,nodo:$1.nodo};
}
    | Expresion                     {$$={gram:[$1.gram], nodo: new NODO("Lista_valores")};
        $$.nodo.hijos.push($1.nodo);
    }
;

asignarArr: ID '[' Expresion ']' '=' Expresion ';'            {$$={gram:new AsignarA($1.toLowerCase(),$3.gram,$6.gram,@1.first_line,@1.first_column),nodo: new NODO("Asignar_Arr")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push($3.nodo);
    $$.nodo.hijos.push($6.nodo);
}
;

TIPO: 
    DOUBLE    {$$={gram: Tipo.DOUBLE,nodo: new NODO("Tipo")};
        $$.nodo.hijos.push(new NODO(`${Tipo[Tipo.DOUBLE]}`));
    }
    | INT       {$$={gram: Tipo.INT,nodo: new NODO("Tipo")};
        $$.nodo.hijos.push(new NODO(`${Tipo[Tipo.INT]}`));
    }
    | STRING    {$$={gram: Tipo.STRING,nodo: new NODO("Tipo")};
        $$.nodo.hijos.push(new NODO(`${Tipo[Tipo.STRING]}`));
    }
    | CHAR      {$$={gram: Tipo.CHAR, nodo: new NODO("Tipo")};
        $$.nodo.hijos.push(new NODO(`${Tipo[Tipo.CHAR]}`));
    }
    | BOOLEAN   {$$={gram: Tipo.BOOLEAN, nodo: new NODO("Tipo")};
        $$.nodo.hijos.push(new NODO(`${Tipo[Tipo.BOOLEAN]}`));
    }
    | VOID      {$$={gram: Tipo.VOID, nodo: new NODO("Tipo")};
        $$.nodo.hijos.push(new NODO(`${Tipo[Tipo.VOID]}`));
    }
;

fPRINT: PRINT '(' Expresion ')' ';' {$$= {gram: new Print($3.gram,@1.first_line,@1.first_column),nodo: new NODO("PRINT")};
    $$.nodo.hijos.push($3.nodo);
}
;


FUNCION: TIPO ID '(' ')' BSENTENCIAS        {$$={gram: new Funciones($1.gram,$2.toLowerCase(),null,$5.gram,@1.first_line,@1.first_column),nodo: new NODO("FUNCION")};
    $$.nodo.hijos.push($1.nodo);
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push(new NODO($3));
    $$.nodo.hijos.push(new NODO($4));
    $$.nodo.hijos.push($5.nodo);

}
    | TIPO ID '(' PARAMS ')' BSENTENCIAS    {$$={gram: new Funciones($1.gram,$2.toLowerCase(),$4.gram,$6.gram,@1.first_line,@1.first_column),nodo: new NODO("FUNCION")};
    $$.nodo.hijos.push($1.nodo);
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push(new NODO($3));
    $$.nodo.hijos.push($4.nodo);
    $$.nodo.hijos.push(new NODO($5));
    $$.nodo.hijos.push($6.nodo);
    
}
;

PARAMS: PARAMS ',' PARAM                {$1.gram.push($3.gram); $1.nodo.hijos.push($3.nodo);
        $$={gram: $1.gram,nodo: $1.nodo};
    }
    | PARAM                               {$$={gram: [$1.gram], nodo: new NODO("PARAMS")};
        $$.nodo.hijos.push($1.nodo)
    }
;

PARAM: TIPO ID                              {$$={gram: new Params($1.gram,$2,@1.first_line,@1.first_column), nodo: new NODO("PARAM")};
    $$.nodo.hijos.push($1.nodo);
    $$.nodo.hijos.push(new NODO($2));
}
;

Llamada: ID '(' ')' ';'           {$$={gram: new Llamada($1.toLowerCase(),null,@1.first_line,@1.first_column),nodo: new NODO("Llamada")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push(new NODO($2));
    $$.nodo.hijos.push(new NODO($3));
}
    | ID '(' ARG ')' ';'                    {$$={gram: new Llamada($1.toLowerCase(),$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Llamada")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push(new NODO($4));
    }
;

ARG: ARG ',' Expresion                  {$1.gram.push($3.gram);
        $1.nodo.hijos.push($3.nodo);
        $$={gram: $1.gram, nodo: $1.nodo};
    }
    | Expresion                         {$$={gram: [$1.gram], nodo: new NODO("PARAMS")};
        $$.nodo.hijos.push($1.nodo)
    }
;


Listas: LIST '<' TIPO '>' ID '=' NEW LIST '<' TIPO '>' ';'     {$$={gram: new Lista($3.gram,$5.toLowerCase(),$10.gram,@1.first_line,@1.first_column), nodo:new NODO("Lista")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push($3.nodo);
    $$.nodo.hijos.push(new NODO($5));
}
;

AddList: ID '.' ADD '(' Expresion ')' ';'         {$$={gram:new AsignLista($1.toLowerCase(),null,$5.gram,@1.first_line,@1.first_column),nodo: new NODO("AddList")};
    $$.nodo.hijos.push(new NODO($1))
    $$.nodo.hijos.push(new NODO($3));
    $$.nodo.hijos.push($5.nodo);
} 
;

AsignList: ID '[[' Expresion ']]' '=' Expresion ';'  {$$={gram: new AsignLista($1.toLowerCase(),$3.gram,$6.gram,@1.first_line,@1.first_column),nodo: new NODO("Asignar_List")};
    $$.nodo.hijos.push(new NODO($1));
    $$.nodo.hijos.push($3.nodo);
    $$.nodo.hijos.push($6.nodo);
}
;


Expresion: 
    '(' Expresion ')'                         {$$={gram: $2.gram ,nodo: new NODO("Expresion")};
        $$.nodo.hijos.push(new NODO("("));
        $$.nodo.hijos.push($2.nodo);
        $$.nodo.hijos.push(new NODO(")"));
    } 
    //| '(' TIPO ')' Expresion 
    | Expresion '*' Expresion              {$$= {gram: new Aritmeticas($1.gram,"*",$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
        $$.nodo.hijos.push($1.nodo)
        $$.nodo.hijos.push(new NODO($2))
        $$.nodo.hijos.push($3.nodo)
    }
    | '-' Expresion      %prec UMENOS      {$$={gram: new Aritmeticas(new Literal(0,Tipo.INT,@1.first_line,@1.first_column),"NEG",$2.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($2.nodo)
    }
    | '!' Expresion {$$={gram: new Logicas($2.gram,"!",$2.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
        $$.nodo.hijos.push(new NODO("!"));
        $$.nodo.hijos.push($2.nodo);
    }
    | Expresion '+' Expresion   {$$= {gram: new Aritmeticas($1.gram,"+",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '-' Expresion   {$$= {gram: new Aritmeticas($1.gram,"-",$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '/' Expresion   {$$= {gram: new Aritmeticas($1.gram,"/",$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '%' Expresion   {$$= {gram: new Aritmeticas($1.gram,"%",$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push(new NODO($1.nodo));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push(new NODO($3.nodo));
    }
    | Expresion '^' Expresion   {$$= {gram:new Aritmeticas($1.gram,"^",$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push(new NODO($1.nodo));
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push(new NODO($3.nodo));
    }
    | Expresion '==' Expresion  {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '!=' Expresion  {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '<=' Expresion  {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '>=' Expresion  {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column),nodo: new  NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '<' Expresion   {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    } 
    | Expresion '>' Expresion   {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '||' Expresion  {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '&&' Expresion  {$$= {gram: new Logicas($1.gram,$2,$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
    }
    | Expresion '?' Expresion ':' Expresion {$$={gram:new TERNARIO($1.gram,$3.gram,$5.gram,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
        $$.nodo.hijos.push($1.nodo);
        $$.nodo.hijos.push(new NODO($2));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push(new NODO($4));
        $$.nodo.hijos.push($5.nodo);
    }
    | ID '[' Expresion ']'      {$$= {gram:new AccesoArr($1.toLowerCase(),$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Acceso_Arr")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO("["));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push(new NODO("]"));
    }
    | ID '[[' Expresion ']]'    {$$= {gram:new AccesLista($1.toLowerCase(),$3.gram,@1.first_line,@1.first_column), nodo:new NODO("Acceso_Lista")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO("[["));
        $$.nodo.hijos.push($3.nodo);
        $$.nodo.hijos.push(new NODO("]]"));
    } 
    | len '(' Expresion ')'     {$$={gram:new Especiales("1",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    }
    | tLow '(' Expresion ')'    {$$={gram:new Especiales("2",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    }
    | tUpp '(' Expresion ')'    {$$={gram: new Especiales("3",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    }
    | trun '(' Expresion ')'    {$$={gram: new Especiales("4",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    }
    | round '(' Expresion ')'   {$$={gram: new Especiales("5",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    }
    | typ '(' Expresion ')'     {$$={gram: new Especiales("6",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    }

    | toStr '(' Expresion ')'  {$$={gram: new Especiales("7",$3.gram,@1.first_line,@1.first_column), nodo: new NODO("Especiales")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push($3.nodo);
    } 

    
    | DECIMAL                   {$$={gram:new Literal($1,Tipo.DOUBLE,@1.first_line,@1.first_column),nodo: new NODO("Expresion")}; 
    
        $$.nodo.hijos.push(new NODO($1));
    }
    | ENTERO                    {$$={gram:new Literal($1,Tipo.INT,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
        $$.nodo.hijos.push(new NODO("INT"));
    }
    | CADENA                    {$$={gram:new Literal($1,Tipo.STRING,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push(new NODO("STRING"));
    }
    | CHAR                      {$$={gram:new Literal($1,Tipo.CHAR,@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push(new NODO("CHAR"));
    }
    | ttrue                     {$$={gram: new Literal($1,Tipo.BOOLEAN,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push(new NODO("BOOLEAN"));
    }
    | tfalse                    {$$={gram: new Literal($1,Tipo.BOOLEAN,@1.first_line,@1.first_column), nodo: new NODO("Expresion")};

        $$.nodo.hijos.push(new NODO("BOOLEAN"));   
    }
    | ID                        {$$={gram:new Acceso($1.toLowerCase(),@1.first_line,@1.first_column),nodo: new NODO("Expresion")};
    
        $$.nodo.hijos.push(new NODO("ID"));
    }
    | ID '(' ')'                {$$={gram: new Llamada($1.toLowerCase(),null,@1.first_line,@1.first_column),nodo: new NODO("Llamada")};
        $$.nodo.hijos.push(new NODO("ID"))
        $$.nodo.hijos.push(new NODO("("))
        $$.nodo.hijos.push(new NODO(")"))
    }
    | ID '(' ARG ')'            {$$={gram: new Llamada($1.toLowerCase(),$3.gram,@1.first_line,@1.first_column),nodo:new NODO("Llamda")};
    
        $$.nodo.hijos.push(new NODO("ID"));
        $$.nodo.hijos.push(new NODO("("));
        $$.nodo.hijos.push($3.nodo)
        $$.nodo.hijos.push(new NODO(")"));
    }
    | ID '--'                   {$$= {gram:new Asignacion($1.toLowerCase(),"-",false,@1.first_line,@1.first_column),nodo:new NODO("Asignacion")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
    }
    | ID '++'                   {$$= {gram:new Asignacion($1.toLowerCase(),"+",false,@1.first_line,@1.first_column),nodo:new NODO("Asignacion")};
        $$.nodo.hijos.push(new NODO($1));
        $$.nodo.hijos.push(new NODO($2));
    }
;