%{
#include <stdio.h>
%}

%option noyywrap  // Disables the default yywrap function

%%


"fin"        {fprintf(yyout, "1\n"); }
"inicio"     {fprintf(yyout, "2\n"); }
"if"         {fprintf(yyout, "3\n"); } // PALABRAS RESERVADAS
"else"       {fprintf(yyout, "4\n"); }
"while"      {fprintf(yyout, "5\n"); }
"float"      {fprintf(yyout, "6\n"); }
"for"        {fprintf(yyout, "7\n"); }
"bool"       {fprintf(yyout, "8\n"); }
"int"        {fprintf(yyout, "9\n"); }
"do"         {fprintf(yyout, "10\n"); }
"string"     {fprintf(yyout, "11\n"); }
"true"       {fprintf(yyout,"12: %s\n", yytext); }
"false"      {fprintf(yyout,"13: %s\n", yytext); }
"var"        {fprintf(yyout, "14\n"); }
"("          {fprintf(yyout, "15\n"); }// OPERADORES
")"          {fprintf(yyout, "16\n"); }
"+"             {fprintf(yyout, "17\n"); }
"-"             {fprintf(yyout, "18\n"); }
"*"             {fprintf(yyout, "19\n"); }
"/"             {fprintf(yyout, "20\n"); }
"="             {fprintf(yyout, "21\n"); }
"%"             {fprintf(yyout, "22\n"); }
"!"             {fprintf(yyout, "23\n"); }
";"             {fprintf(yyout, "24\n"); }


[a-zA-Z_][a-zA-Z0-9_]*  {
    if(strlen(yytext)>32){
         printf("ERROR: var too long: %s\n", yytext);
        exit(1);
    }
    else{
         printf("25: %s\n", yytext);
    }
}




[0-9]{1,5}\.[0-9]{1,5} {
    printf("25: %s\n", yytext);
}

[0-9]+ {
    if(strlen(yytext) > 5) {
        printf("ERROR: INT too long: %s\n", yytext);
        exit(1);
    } else {
        printf("26: %s\n", yytext);
    }
}

[ \t\n]      ; // Skip whitespace        




%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s filename\n", argv[0]);
        return 1;
    }
    
    FILE* fileIn = fopen("input.txt", "r");
    FILE* fileOut = fopen("Output.txt", "w")
    if (fileIn == NULL) {
        perror("No se pudo abrir el archivo");
        return 1;
    }

    yyin = fileIn; // Set the input source to the file
    yyout = fileOut;

    yylex();
    
    fclose(fileIn);
    fclose(fileOut);
    return 0;
}