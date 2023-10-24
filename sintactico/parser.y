%{
#include <stdio.h>
%}

%token IDENTIFIER NUM
%token CHAR INT FLOAT DOUBLE
%token EQ LE GE AND OR XOR ASSIGN
%token IF ELSE SWITCH BREAK WHILE CASE
%token ADD SUB MUL DIV 
%token SEMICOLON COMMA

%start program

%%
program 
	: declarations function {printf("Input accepted\n");exit(0);}
	;
declarations 
	: type variables SEMICOLON
	| 
	;
type 
	: INT
	| CHAR
	| FLOAT
	| DOUBLE
	;
variables
	: IDENTIFIER
	| IDENTIFIER COMMA variables
	;
function
	: type IDENTIFIER OP argumentlist CP OB statements CB
	;
argumentlist
	: variables
	;
statements
	: expressions SEMICOLON
	;
expressions
	: IDENTIFIER ASSIGN expressions
	| IDENTIFIER
	| NUM
	;

%%
#include "lex.yy.c"

int main()
{
	yyin=fopen("input.c","r");
	yyparse();
	fclose(yyin);
	return 0;
}