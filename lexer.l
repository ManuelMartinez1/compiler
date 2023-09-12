%{
#include <stdio.h>
%}

%%
"if"         printf("IF\n");
"else"       printf("ELSE\n");
"while"      printf("WHILE\n");
[a-zA-Z]+    printf("IDENTIFIER: %s\n", yytext);
[0-9]+       printf("NUMBER: %s\n", yytext);
[ \t\n]      ; // Skip whitespace
.            printf("OPERATOR: %c\n", yytext[0]);
%%

int main() {
    yylex();
    return 0;
}