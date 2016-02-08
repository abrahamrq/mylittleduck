%{
	#include <stdio.h>
	#include <iostream>
	using namespace std;
	#define YY_DECL extern "C" int yylex()
	#include "bison.tab.h"			
%}

%%
int 										{yylval.sint = strdup(yytext); return INT;}
float 									{yylval.sfloat = strdup(yytext); return FLOAT;}
program 								{return PROGRAM;}
\; 											{return SEMICOLON;}
\: 											{return COLON;}
var 										{return VAR;} 
\<\> 										{return DIFFERENCE;}
\< 											{return LESSER;}
\> 											{return GREATER;}
if 											{return IF;}
\{ 											{return OPENBRACKETS;}
\} 											{return CLOSEBRACKETS;}
\+ 											{return ADD;}
\- 											{return SUB;}
\* 											{return MULT;}
\/ 											{return DIV;}
\, 											{return COMMA;}
\= 											{return EQUAL;}
print 									{return PRINT;}
\( 											{return OPENPARENTHESIS;}
\) 											{return CLOSEPARENTHESIS;}
else 										{return ELSE;}
[ \t\n]									;
[0-9]+\.[0-9]+ 					{yylval.vfloat = atof(yytext); return FLOATCONST;}
[0-9]+ 									{yylval.vint = atoi(yytext); return INTCONST;}
[a-zA-Z][a-zA-Z0-9]* 		{yylval.vstring = strdup(yytext); return ID;}
\"[a-zA-Z0-9]*\" 				{yylval.vstring = strdup(yytext); return STRINGCONST;} 
%%