%{
#include "parser.tab.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *str);

extern int yylex(void);
extern FILE* yyin;
extern FILE *output_file;
%}
%option yylineno
%%

"inicio" { fprintf(output_file,"Token: INICIO, Valor: %s\n", yytext); return(INICIO); }
"fin" { fprintf(output_file,"Token: FIN, Valor: %s\n", yytext); return(FIN); }
"+"   { fprintf(output_file,"Token: ADD, Valor: %s\n", yytext); return(ADD); }
"-"   { fprintf(output_file,"Token: SUB, Valor: %s\n", yytext); return(SUB); }
"*"   { fprintf(output_file,"Token: MUL, Valor: %s\n", yytext); return(MUL); }
"/"   { fprintf(output_file,"Token: DIV, Valor: %s\n", yytext); return(DIV); }
">="  { fprintf(output_file,"Token: GE, Valor: %s\n", yytext); return(GE); }
"<="  { fprintf(output_file,"Token: LE, Valor: %s\n", yytext); return(LE); }
"=="  { fprintf(output_file,"Token: EQ, Valor: %s\n", yytext); return(EQ); }
"="   { fprintf(output_file,"Token: ASSIGN, Valor: %s\n", yytext); return(ASSIGN); }
"&&"  { fprintf(output_file,"Token: AND, Valor: %s\n", yytext); return(AND); }
"||"  { fprintf(output_file,"Token: OR, Valor: %s\n", yytext); return(OR); }
"^"   { fprintf(output_file,"Token: XOR, Valor: %s\n", yytext); return(XOR); }
"("   { fprintf(output_file,"Token: OP, Valor: %s\n", yytext); return(OP); }
")"   { fprintf(output_file,"Token: CP, Valor: %s\n", yytext); return(CP); }
"{"   { fprintf(output_file,"Token: OB, Valor: %s\n", yytext); return(OB); }
"}"   { fprintf(output_file,"Token: CB, Valor: %s\n", yytext); return(CB); }
";"   { fprintf(output_file,"Token: SEMICOLON, Valor: %s\n", yytext); return(SEMICOLON); }
"if"  { fprintf(output_file,"Token: IF, Valor: %s\n", yytext); return(IF); }
"else" { fprintf(output_file,"Token: ELSE, Valor: %s\n", yytext); return(ELSE); }
"int" { fprintf(output_file,"Token: INT, Valor: %s\n", yytext); return(INT); }
"float" { fprintf(output_file,"Token: FLOAT, Valor: %s\n", yytext); return(FLOAT); }
"double" { fprintf(output_file,"Token: DOUBLE, Valor: %s\n", yytext); return(DOUBLE); }
"bool" { fprintf(output_file,"Token: BOOL, Valor: %s\n", yytext); return(BOOL); }
"string" { fprintf(output_file,"Token: STRING, Valor: %s\n", yytext); return(STRING); }
"while" { fprintf(output_file,"Token: WHILE, Valor: %s\n", yytext); return(WHILE); }
"for" { fprintf(output_file,"Token: FOR, Valor: %s\n", yytext); return(FOR); }
"do" { fprintf(output_file,"Token: DO, Valor: %s\n", yytext); return(DO); }
[a-zA-Z_][a-zA-Z0-9_]* { 
    if (strlen(yytext) > 32) {
        yyerror("Caracter inválido");
        exit(1);
    } else {
        fprintf(output_file,"Token: IDENTIFIER, Valor: %s\n", yytext); return(IDENTIFIER);
    }
}
[0-9]+ { 
    if(strlen(yytext)>5){
        yyerror("NUM too long");
        exit(1);
    }else{
        fprintf(output_file,"Token: NUM, Valor: %s\n", yytext); return(NUM); 
    }
    }
[0-9]{1,5}\.[0-9]{1,5} { 
        fprintf(output_file,"Token: NUMDEC, Valor: %s\n", yytext); return(NUMDEC); 
    }
[0-9]{1,5}\.[0-9]{6,100} {
    yyerror("NUM DECIMAL too long");
    exit(1);
}
[ \t\n] {;} // Ignorar espacios en blanco y saltos de línea
. { ECHO; yyerror("Caracter inválido"); }
%%

int yywrap () {
    return 1;
}