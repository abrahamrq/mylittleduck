%{
  #include <stdio.h>
  #include <iostream>
  using namespace std;
  extern "C" int yylex();
  extern "C" int yyparse();
  extern "C" FILE *yyin;
  void yyerror(const char *s);
%}

%union{
  int vint;
  float vfloat;
  char *vstring;
  char *sint;
  char *sfloat;
}

%token <sint> INT
%token <sfloat> FLOAT 
%token <vint> INTCONST
%token <vfloat> FLOATCONST
%token <vstring> ID
%token <vstring> STRINGCONST
%token PROGRAM
%token SEMICOLON
%token COLON
%token VAR
%token DIFFERENCE
%token LESSER
%token GREATER
%token IF
%token OPENBRACKETS
%token CLOSEBRACKETS
%token ADD
%token SUB
%token MULT
%token DIV
%token COMMA
%token EQUAL
%token PRINT
%token OPENPARENTHESIS
%token CLOSEPARENTHESIS
%token ELSE

%%
program:
  PROGRAM ID SEMICOLON program2
  ;

program2:
  vars bloque
  | bloque
  ;

vars:
  VAR vars2
  ;

vars2:
  vars3 COLON tipo SEMICOLON
  ;

vars3:
  ID vars4
  ;

vars4:
  | COMMA vars3
  ;

tipo:
  INT
  | FLOAT
  ;

bloque:
  OPENBRACKETS bloque2 CLOSEBRACKETS
  ;

bloque2:
  | estatuto bloque2
  ;

estatuto:
  asignacion
  | condicion
  | escritura
  ;

asignacion:
  ID EQUAL expresion SEMICOLON
  ;

escritura:
  PRINT OPENPARENTHESIS escritura2 CLOSEPARENTHESIS SEMICOLON
  ;

escritura2:
  expresion escritura3
  | STRINGCONST escritura3
  ;

escritura3:
  | COMMA escritura2
  ;

expresion:
  exp expresion2
  ;

expresion2:
  | GREATER exp
  | LESSER exp
  | DIFFERENCE exp
  ;

condicion:
  IF OPENPARENTHESIS expresion CLOSEPARENTHESIS bloque condicion2 SEMICOLON
  ;

condicion2:
  | ELSE bloque
  ;

exp:
  termino exp2
  ;

exp2:
  | ADD exp
  | SUB exp
  ;

termino:
  factor termino2
  ;

termino2:
  | MULT termino
  | DIV termino
  ;

factor:
  OPENPARENTHESIS expresion CLOSEPARENTHESIS
  | ADD varcte
  | SUB varcte
  | varcte
  ;

varcte:
  ID
  | INTCONST
  | FLOATCONST
  ;


%%

int main (int argc, char *argv[]){
  FILE *archivo = fopen(argv[1], "r");
  if (!archivo){
    cout << "El archivo no se pudo abrir" << endl;
    return -1;
  }

  yyin = archivo;
  do{
    yyparse();
  }while(!feof(yyin));
  cout << "expresión válida" << endl;
}

void yyerror(const char *s){
  cout << "Error: " << s << endl;
  exit(-1);
}