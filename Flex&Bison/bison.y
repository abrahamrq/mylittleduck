%{
#include <cstdio>
#include <iostream>
using namespace std;
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
void yyerror(const char *s);
%}

%start program
%token PROGRAM
%token IF
%token ELSE
%token VAR
%token PRINT
%token INTTYPE
%token FLOATTYPE
%token SEMICOLON
%token COLON
%token EQUAL
%token OPENPARENTHESIS
%token CLOSEPARENTHESIS
%token OPENBRACKETS
%token CLOSEBRACKETS
%token GREATER
%token LESSER
%token EQUALITY
%token DOT
%token SUM
%token SUBSTRACT
%token MULTIPLICATION
%token DIVISION
%token ID
%token STRINGCONSTANT
%token INTCONSTANT
%token FLOATCONSTANT

%%
  program: PROGRAM ID SEMICOLON a
          ;

  a: bloque
   | vars bloque
   ;

  vars: VAR b
      ;

  b: c d
   ;

  c: ID cprima
   ;

  cprima: DOT c
        | epsilon
        ;

  d: COLON tipo SEMICOLON e
   ;

  tipo : INTTYPE
       | FLOATTYPE
       ;

  e: b
   | epsilon
   ;

  bloque: OPENBRACKETS f CLOSEBRACKETS
        ;

  f: estatuto f
   | epsilon
   ;

  estatuto: ID EQUAL expresion SEMICOLON
          | PRINT OPENPARENTHESIS g CLOSEPARENTHESIS
          | IF OPENPARENTHESIS expresion CLOSEPARENTHESIS bloque i SEMICOLON
          ;
  g: expresion h
   | STRINGCONSTANT h
   ;

  h: SEMICOLON g
   | epsilon
   ;

  i: ELSE bloque
   | epsilon
   ;

  expresion: exp j
           ;

  j: GREATER exp
   | LESSER exp
   | EQUALITY exp
   | epsilon
   ;

  exp: terminos k
     ;

  k: SUM exp
   | SUBSTRACT
   | epsilon
   ;

  terminos: factor l
          ;

  l: MULTIPLICATION terminos
   | DIVISION terminos
   | epsilon
   ;

  factor: OPENPARENTHESIS expresion CLOSEPARENTHESIS
        | m varcte
        ;

  m: SUM
   | SUBSTRACT
   | epsilon
   ;

  varcte: ID
        | INTCONSTANT
        | FLOATCONSTANT
        ;

  epsilon:
         ; 

%%

int main (int argc, char *argv[]){
  FILE *archivo = fopen(argv[1], "r");
  if (!archivo){
    cout << "Unable to read file" << endl;
    return -1;
  }

  yyin = archivo;
  do{
    yyparse();
  }while(!feof(yyin));
  cout << "Invalid Expresion" << endl;
}

void yyerror(const char *s){
  cout << "Error: " << s << endl;
  exit(-1);
}