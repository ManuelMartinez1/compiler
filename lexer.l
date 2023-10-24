%{
#include <stdio.h>
int line_number = 1;
%}

%%


"fin"        printf("1\n");
"inicio:"    printf("2\n");
"if"         printf("3\n"); // PALABRAS RESERVADAS
"else"       printf("4\n");
"while"      printf("5\n");
"float"      printf("6\n");
"for"        printf("7\n");
"bool"       printf("8\n");
"int"        printf("9\n");
"do"         printf("10\n");
"string"     printf("11\n");
"true"       printf("12: %s\n", yytext);
"false"      printf("13: %s\n", yytext);
"var"        printf("14\n");
"("          printf("15\n");// OPERADORES
")"          printf("16\n");
"+"             printf("17\n");
"-"             printf("18\n");
"*"             printf("19\n");
"/"             printf("20\n");
"="             printf("21\n");
"%"             printf("22\n");
"!"             printf("23\n");
";"             printf("24\n");
">"             printf("25\n");
"<"             printf("26\n");
[\n\r]+      { line_number++; } // Actualizar el contador de líneas al encontrar saltos de línea o retorno de carro

[a-zA-Z_][a-zA-Z0-9_]*  {
    if (strlen(yytext) > 32) {
        printf("ERROR (linea %d): var too long: %s\n", line_number, yytext);
        exit(1);
    } else {
        printf("27: %s\n", yytext);
    }
}


[0-9]{1,5}\.[0-9]{1,5} printf("28: %s\n", yytext);// delimitacion de asignacion de valores para numeros
[0-9]+       {
    if(strlen(yytext)>5){
        printf("ERROR: INT too long: %s\n", yytext);
        exit(1);
    }else{
         printf("28: %s\n", yytext);
    }

}
[ \t]        ;  
%%
int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s filename\n", argv[0]);
        return 1;
    }

    FILE *inputFile = fopen(argv[1], "r");
    if (inputFile == NULL) {
        perror("Error opening file");
        return 1;
    }

    yyin = inputFile; 

    yylex();

    fclose(inputFile);

    return 0;
}