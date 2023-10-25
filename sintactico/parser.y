%{
    void yyerror(char *str);
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern int yylineno; 

    extern int yylex(void);

    int yylex(void);
    extern FILE* yyin;
%}

%token ADD SUB MUL DIV
%token GE LE EQ ASSIGN AND OR XOR
%token OP CP OB CB SEMICOLON
%token INICIO FIN
%token IF ELSE WHILE FOR DO
%token INT FLOAT DOUBLE BOOL STRING
%token IDENTIFIER NUM

%left XOR
%left OR
%left AND
%left EQ LE GE
%left ADD SUB
%left MUL DIV

%start program

%%

program: INICIO statements FIN
;

statements: statement
          | statements statement
;

statement: declaration
         | assignment SEMICOLON
         | if_statement
         | while_loop
         | for_loop
         | do_while_loop
         | expression SEMICOLON
;

declaration: type IDENTIFIER SEMICOLON
;

type: INT
    | FLOAT
    | DOUBLE
    | BOOL
    | STRING
;

assignment: IDENTIFIER ASSIGN expression
;

if_statement: IF OP condition CP OB statements CB
            | IF OP condition CP OB statements CB ELSE OB statements CB
;

condition: expression EQ expression
         | expression LE expression
         | expression GE expression
         | expression
;

while_loop: WHILE OP condition CP OB statements CB
;

for_loop: FOR OP assignment SEMICOLON condition SEMICOLON assignment CP OB statements CB
;

do_while_loop: DO OB statements CB WHILE OP condition CP SEMICOLON
;

expression: expression ADD expression
          | expression SUB expression
          | expression MUL expression
          | expression DIV expression
          | expression XOR expression
          | expression OR expression
          | expression AND expression
          | OP expression CP
          | IDENTIFIER
          | NUM
;

%%


int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Uso: %s <archivo_de_entrada>\n", argv[0]);
        return 1;
    }

    // Abre el archivo de entrada
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error al abrir el archivo de entrada");
        return 1;
    }

    // Inicia el análisis sintáctico
    yyparse();

    // Cierra el archivo de entrada
    fclose(yyin);

    return 0;
}
void yyerror(char *str) {
    printf("\n");
    printf("Línea %d : %s\n", yylineno, str);}