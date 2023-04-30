%{
    //codigo js

%}

%lex

%options case-insensitive

     


%%
//Expresiones a ignorar
[ \r\t]+                //Espacios en blanco
"//"[^\n]*              //Comentarios de linea
"/*"[^\/]*"*/"         //Comentarios multilinea
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
([0-9]+\.[0-9]+)              {return "DECIMAL";}
(\b[a-zA-Z_]\w*\b)          {return "ID";}
([0-9]+)                        {return "ENTERO";}
\"[^\"]*\"                      {return "CADENA";}
\'[^\']\'                      {return "CHAR";}
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

INICIO: instrucciones EOF {return $1;}
;

instrucciones: 
    instrucciones instruccion   {$1.push($2); $$=$1;}
    | instruccion               {$$=[$1];}
;

instruccion: 
    iIF
    | iwhile        {$$=$1;}
    | asignacion    {$$=$1;}
    | declaracion   {$$=$1;}
    | fPRINT        {$$=$1;}
    | ifor          {$$=$1;}
    | switch        {$$=$1;}
    | BREAK ';'     {$$=new BREAK("1",@1.first_line,@1.first_column);}
    | CONTIN ';'    {$$=new BREAK("2",@1.first_line,@1.first_column);}
    | dowhile       {$$=$1;}
    | decArray      {$$=$1;}
    | asignarArr    {$$=$1;}
    | FUNCION       {$$=$1;}
    | Llamada       {$$=$1;}
    | RETORNO       {$$=$1;}
    | Listas        {$$=$1;}
    | AsignList     {$$=$1;}
    | MAIN Llamada  {$$=new Main($2,@1.first_line,@1.first_column);}
    | NewAsignacion {$$=$1;}
    | LENG
    | TOLOW
    | TOUPP
    | TRUNC
    | ROUN
    | TYPE
;

LENG: len '(' Expresion ')' ';'   {$$=new Especiales("1",$3,@1.first_line,@1.first_column);}
;

TOLOW: tLow '(' Expresion ')' ';' {$$=new Especiales("2",$3,@1.first_line,@1.first_column);}
;

TOUPP: tUpp '(' Expresion ')' ';' {$$=new Especiales("3",$3,@1.first_line,@1.first_column);}
;

TRUNC: trun '(' Expresion ')' ';' {$$=new Especiales("4",$3,@1.first_line,@1.first_column);}
;

ROUN: round '(' Expresion ')' ';' {$$=new Especiales("5",$3,@1.first_line,@1.first_column);}
;

TYPE: typ '(' Expresion ')' ';'   {$$=new Especiales("6",$3,@1.first_line,@1.first_column);}
;

RETORNO: RETN Expresion ';'  {$$=new BREAK("3",$2,@1.first_line,@1.first_column);}
;

BSENTENCIAS: 
    '{' instrucciones '}'   {$$=new Instrucciones($2,@1.first_line,@1.first_column);}
    | '{' '}'
;

iIF:  
    IF '(' Expresion ')' BSENTENCIAS            {$$=new IF($3,$5,null,@1.first_line,@1.first_column);}
    | IF '(' Expresion ')' BSENTENCIAS ELSE     {$$=new IF($3,$5,$6,@1.first_line,@1.first_column);}
;

ELSE: 
    tELSE iIF           {$$ =$2;}     
    | tELSE BSENTENCIAS {$$=$2;}
;

switch: SWITCH '(' Expresion ')' '{' BLOQSWITCH fDEFAULT '}' {$$= new SWITCH($3,$6,$7,@1.first_line,@1.first_column);}
;

BLOQSWITCH: BLOQSWITCH fcase                {$1.push($2); $$=$1;}
    | fcase                                 {$$=[$1];}
;

fcase: CASE Expresion ':' instrucciones     {$$=new CASE($2,$4);}
;

fDEFAULT: DEFAULT ':' instrucciones                  {$$= $3;}
    | 
;


iwhile: WHILE '(' Expresion ')' BSENTENCIAS  {$$=new While($3,$5,@1.first_line,@1.first_column);}
;

ifor: 
    FOR '(' AssignFor ';' Expresion ';' Actualiz ')' BSENTENCIAS {$$=new FOR($3,$5,$7,$9,@1.first_line,@1.first_column);} 
;

AssignFor: 
    TIPO ID '=' Expresion               {$$=new Declaracion($1,$2.toLowerCase(),$4,@1.first_line,@1.first_column);}
    | ID  '=' Expresion                 {$$= new Asignacion($1,$3,@1.first_line,@1.first_column);}
;

Actualiz: 
    ID '=' Expresion                   {$$=new Asignacion($1,$3,@1.first_line,@1.first_column);}
    | ID '++'                          {$$= new Asignacion($1,"+",false,@1.first_line,@1.first_column);}
    | ID '--'                          {$$= new Asignacion($1,"-",false,@1.first_line,@1.first_column);}
;

dowhile: DO BSENTENCIAS WHILE '(' Expresion ')' ';'  {$$=new DOWHile($2,$5,@1.first_line,@1.first_column);}
;

declaracion: TIPO ID '=' Expresion ';' {$$=new Declaracion($1,$2.toLowerCase(),$4,@1.first_line,@1.first_column);}
    | TIPO ID ';'                      {$$=new Declaracion($1,$2.toLowerCase(),null,@1.first_line,@1.first_column);}
;

asignacion: ID '=' Expresion ';'       {$$= new Asignacion($1.toLowerCase(),$3,@1.first_line,@1.first_column);}
    | ID '++' ';'                      {$$= new Asignacion($1.toLowerCase(),"+",false,@1.first_line,@1.first_column);}
    | ID '--' ';'                      {$$= new Asignacion($1.toLowerCase(),"-",false,@1.first_line,@1.first_column);}
;

decArray: TIPO '[' ']' ID '=' NEW TIPO '[' Expresion ']' ';'  {$$=new DeclaArray($1,$4,$7,$9,@1.first_line,@1.first_column);}
    | TIPO '[' ']' ID '=' '{' VALORES '}' ';'                 {$$=new DeclaArray($1,$4,null,$7,@1.first_line,@1.first_column);}
;

VALORES: VALORES ',' Expresion      {$1.push($3); $$=$1;}
    | Expresion                     {$$=[$1];}
;

asignarArr: ID '[' Expresion ']' '=' Expresion ';'            {$$=new AsignarA($1,$3,$6,@1.first_line,@1.first_column);}
;

TIPO: 
    DOUBLE    {$$=Tipo.DOUBLE;}
    | INT       {$$=Tipo.INT;}
    | STRING    {$$=Tipo.STRING;}
    | CHAR      {$$=Tipo.CHAR;}
    | BOOLEAN   {$$=Tipo.BOOLEAN;}
    | VOID      {$$=Tipo.VOID;}
;

fPRINT: PRINT '(' Expresion ')' ';' {$$= new Print($3,@1.first_line,@1.first_column);}
;


FUNCION: TIPO ID '(' ')' BSENTENCIAS        {$$=new Funciones($1,$2.toLowerCase(),null,$5,@1.first_line,@1.first_column);}
    | TIPO ID '(' PARAMS ')' BSENTENCIAS    {$$=new Funciones($1,$2.toLowerCase(),$4,$6,@1.first_line,@1.first_column);}
;

PARAMS: PARAMS ',' PARAM                {$1.push($3); $$=$1;}
    | PARAM                               {$$=[$1];}
;

PARAM: TIPO ID                              {$$=new Params($1,$2);}
;

Llamada: ID '(' ')' ';'                     {$$=new Llamada($1.toLowerCase(),null,@1.first_line,@1.first_column);}
    | ID '(' ARG ')' ';'                    {$$=new Llamada($1.toLowerCase(),$3,@1.first_line,@1.first_column);}
;

ARG: ARG ',' Expresion                  {$1.push($3);$$=$1;}
    | Expresion                         {$$=[$1];}
;


Listas: LIST '<' TIPO '>' ID '=' NEW LIST '<' TIPO '>' ';'     {$$=new Lista($3,$5,$10,@1.first_line,@1.first_column);}
;

AsignList: ID '.' ADD '(' Expresion ')' ';'         {$$=new AsignLista($1,null,$5,@1.first_line,@1.first_column);} 
;

NewAsignacion: ID '[[' Expresion ']]' '=' Expresion ';'  {$$=new AsignLista($1,$3,$6,@1.first_line,@1.first_column);}
;


Expresion: 
    '(' Expresion ')'                          {$$=$2;}
    //| '(' TIPO ')' Expresion 
    | Expresion '*' Expresion                  {$$= new Aritmeticas($1,"*",$3,@1.first_line,@1.first_column);}
    | '-' Expresion      %prec UMENOS        {$$=new Aritmeticas(new Literal(0,Tipo.INT,@1.first_line,@1.first_column),"NEG",$2,@1.first_line,@1.first_column);}
    | Expresion '+' Expresion   {$$= new Aritmeticas($1,"+",$3,@1.first_line,@1.first_column);}
    | Expresion '-' Expresion   {$$= new Aritmeticas($1,"-",$3,@1.first_line,@1.first_column);}
    | Expresion '/' Expresion   {$$= new Aritmeticas($1,"/",$3,@1.first_line,@1.first_column);}
    | Expresion '%' Expresion   {$$= new Aritmeticas($1,"%",$3,@1.first_line,@1.first_column);}
    | Expresion '^' Expresion   {$$= new Aritmeticas($1,"^",$3,@1.first_line,@1.first_column);}
    | Expresion '==' Expresion  {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '!=' Expresion  {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '<=' Expresion  {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '>=' Expresion  {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '<' Expresion   {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);} 
    | Expresion '>' Expresion   {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '||' Expresion  {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '&&' Expresion  {$$= new Logicas($1,$2,$3,@1.first_line,@1.first_column);}
    | Expresion '?' Expresion ':' Expresion {$$=new TERNARIO($1,$3,$5,@1.first_line,@1.first_column);}
    | ID '[' Expresion ']'      {$$= new AccesoArr($1.toLowerCase(),$3,@1.first_line,@1.first_column);}
    | ID '[[' Expresion ']]'    {$$= new AccesLista($1,$3,@1.first_line,@1.first_column);} 
    | len '(' Expresion ')'     {$$=new Especiales("1",$3,@1.first_line,@1.first_column);}
    | tLow '(' Expresion ')'    {$$=new Especiales("2",$3,@1.first_line,@1.first_column);}
    | tUpp '(' Expresion ')'    {$$=new Especiales("3",$3,@1.first_line,@1.first_column);}
    | trun '(' Expresion ')'    {$$=new Especiales("4",$3,@1.first_line,@1.first_column);}
    | round '(' Expresion ')'   {$$=new Especiales("5",$3,@1.first_line,@1.first_column);}
    | typ '(' Expresion ')'     {$$=new Especiales("6",$3,@1.first_line,@1.first_column);}
    | F
;

F:  
    DECIMAL                     {$$=new Literal($1,Tipo.DOUBLE,@1.first_line,@1.first_column);}
    | ENTERO                    {$$=new Literal($1,Tipo.INT,@1.first_line,@1.first_column);}
    | CADENA                    {$$=new Literal($1,Tipo.STRING,@1.first_line,@1.first_column);}
    | CHAR                      {$$=new Literal($1,Tipo.CHAR,@1.first_line,@1.first_column);}
    | ttrue                     {$$=new Literal($1,Tipo.BOOLEAN,@1.first_line,@1.first_column);}
    | tfalse                    {$$=new Literal($1,Tipo.BOOLEAN,@1.first_line,@1.first_column);}
    | ID                        {$$=new Acceso($1.toLowerCase(),@1.first_line,@1.first_column);}
    | ID '(' ')'                {$$=new Llamada($1.toLowerCase(),null,@1.first_line,@1.first_column);}
    | ID '(' ARG ')'            {$$=new Llamada($1.toLowerCase(),$3,@1.first_line,@1.first_column);}
    | ID '--'                   {$$= new Asignacion($1.toLowerCase(),"-",true,@1.first_line,@1.first_column);}
    | ID '++'                   {$$= new Asignacion($1.toLowerCase(),"+",true,@1.first_line,@1.first_column);}
;
