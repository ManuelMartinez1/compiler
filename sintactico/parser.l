%{
// Incluye los encabezados y declaraciones de los tokens definidos en parser.y
#include "parser.tab.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void);

extern FILE* yyin;
%}

%option noyywrap

%%
"+"   { return ADD; }
"-"   { return SUB; }
"*"   { return MUL; }
"/"   { return DIV; }
">="  { return GE; }
"<="  { return LE; }
"=="  { return EQ; }
"="   { return ASSIGN; }
"&&"  { return AND; }
"||"  { return OR; }
"^"   { return XOR; }
"("   { return OP; }
")"   { return CP; }
"{"   { return OB; }
"}"   { return CB; }
";"   { return SEMICOLON; }
"inicio" { return INICIO; }
"fin" { return FIN; }
"if"  { return IF; }
"else" { return ELSE; }
"int" { return INT; }
"float" { return FLOAT; }
"double" { return DOUBLE; }
"bool" { return BOOL; }
"string" { return STRING; }
"while" { return WHILE; }
"for" { return FOR; }
"do" { return DO; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[0-9]+ { return NUM; }
[ \t\n] ; // Ignorar espacios en blanco y saltos de línea
. { /* Manejo de errores */ }
%%
