%{
// Incluimos las librerías necesarias
#include <stdio.h>
#include <stdlib.h>
%}

// Definimos los tokens
%token SEC_SEQUENCIAL
%token SEC_SELECTION
%token SEC_LOOP
%token SEC_READ
%token SEC_WRITE
%token SEC_DECLARE
%token SEC_FLOAT

%token IDENTIFIER
%token CONSTANT

%token ADDOP
%token SUBOP
%token MULOP
%token DIVOP

%token ENDLINE

// Definimos los patrones para los tokens
%%
"Secuencial"    { return SEC_SEQUENCIAL; }
"Seleccion"     { return SEC_SELECTION; }
"Ciclos"        { return SEC_LOOP; }
"Lectura"       { return SEC_READ; }
"Escritura"     { return SEC_WRITE; }
"Como"          { return SEC_DECLARE; }
"PuntoFlotante" { return SEC_FLOAT; }

[a-zA-Z][a-zA-Z0-9_]{0,31} { yylval.str = strdup(yytext); return IDENTIFIER; }
[0-9]+\.[0-9]{5}           { yylval.str = strdup(yytext); return CONSTANT; }

"+" { return ADDOP; }
"-" { return SUBOP; }
"*" { return MULOP; }
"/" { return DIVOP; }

\n { return ENDLINE; }
[ \t] { }

. { printf("Caracter no reconocido: %s\n", yytext); exit(1); }
%%

int main() {
    yylex();
    return 0;
}
