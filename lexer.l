%{
#include <stdio.h>
%}

%%


"if"         printf("IF\n"); // PALABRAS RESERVADAS
"else"       printf("ELSE\n");
"while"      printf("WHILE\n");
"float"      printf("FLOAT\n");
"for"        printf("FOR\n");
"bool"       printf("BOOL\n");
"int"        printf("INT\n");
"do"         printf("DO\n");
"string"     printf("STRING\n");
"true"       printf("BOOLEAN: %s\n", yytext);
"false"      printf("BOOLEAN: %s\n", yytext);
"var"        printf("VAR\n");


"("          printf("OPEN PARENTHESIS\n");// OPERADORES
")"          printf("CLOSE PARENTHESIS\n");
.           printf("OPERATOR: %c\n", yytext[0]);    



[a-zA-Z_][a-zA-Z0-9_]*  {
    if(strlen(yytext)>32){
         printf("ERROR: var too long: %s\n", yytext);
        exit(1);
    }
    else{
         printf("var: %s\n", yytext);
    }
}


[0-9]{1,5}\.[0-9]{1,5} printf("FLOAT: %s\n", yytext);// delimitacion de asignacion de valores para numeros
[0-9]+       {
    if(strlen(yytext)>32){
        printf("ERROR: INT too long: %s\n", yytext);
        exit(1);
    }else{
         printf("INT: %s\n", yytext);
    }

}
[ \t\n]      ; // Skip whitespace        
%%

int main() {
    yylex();
    return 0;
}