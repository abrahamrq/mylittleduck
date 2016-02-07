%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
#include "bison.tab.h"
%}


%%
[ \t\n]                                     ;
programa                                    return PROGRAM;
if                                          return IF;
else                                        return ELSE;
var                                         return VAR;
print                                       return PRINT;
int                                         return INTTYPE;
float                                       return FLOATTYPE;
\;                                          return SEMICOLON;
\:                                          return COLON;
\=                                          return EQUAL;
\(                                          return OPENPARENTHESIS;
\)                                          return CLOSEPARENTHESIS;
\{                                          return OPENBRACKETS;
\}                                          return CLOSEBRACKETS;
\>                                          return GREATER;
\<                                          return LESSER;
\<>                                         return EQUALITY;
\.                                          return DOT;
\+                                          return SUM;
\-                                          return SUBSTRACT;
\*                                          return MULTIPLICATION;
\/                                          return DIVISION;
[a-zA-Z]+[0-9]*_?[a-zA-Z0-9]+               return ID;
\".*\"                                      return STRINGCONSTANT;
[0-9]+                                      return INTCONSTANT;
[0-9]+\.+[0-9]+                             return FLOATCONSTANT;
.                                           {cout << "ERROR DE LEXICO";};


%%