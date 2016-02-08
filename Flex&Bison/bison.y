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
  PROGRAM ID SEMICOLON vars bloque
  ;

vars:
  | VAR declaration
  ;

ids:
  ID idsloop
  ;

idsloop:
  | COMMA idsloop2
  ;

idsloop2:
  ID COMMA idsloop2
  | ID

tipo:
  INT
  | FLOAT
  ;

declaration:
  ids COLON tipo SEMICOLON declarationloop
  ;

declarationloop:
  | declaration
  ;

bloque:
  OPENBRACKETS statuteloop CLOSEBRACKETS
  ;

statuteloop:
  | statute statuteloop
  ;

statute:
  assignment
  | condition
  | writing
  ;

expression:
  exp expressionaux
  ;

expressionaux:
  | comparer exp
  ;

comparer:
  GREATER
  | LESSER
  | DIFFERENCE
  ;

exp:
  term expaux
  ;

expaux:
  |operation exp
  ;

operation:
  ADD
  |SUB
  ;

term:
  factor termaux
  ;

termaux:
  | operation2 term
  ;

operation2:
  MULT
  | DIV
  ;

factor:
  OPENBRACKETS expression CLOSEBRACKETS
  | optionaloperation ctevar
  ;

optionaloperation:
  | operation
  ;

ctevar:
  ID
  | INTCONST
  | FLOATCONST
  ;

assignment:
  ID EQUAL expression SEMICOLON
  ;

writing:
  PRINT OPENPARENTHESIS expstring writingloop CLOSEPARENTHESIS SEMICOLON
  ;

expstring:
  expression
  | STRINGCONST
  ;

writingloop: 
  | COMMA expstring writingloop
  ;

condition:
  IF OPENPARENTHESIS expression CLOSEPARENTHESIS bloque conditionelse SEMICOLON
  ;

conditionelse:
  | ELSE bloque
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