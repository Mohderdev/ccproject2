%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
extern FILE *yyin;

void yyerror(const char *s);
int yylex(void);
%}

%token BIDAYA NIHAYA FAT7 IGHLAQ KHTM
%token IZA AW ADKHAL BAYAN RAJI3
%token IDENTIFIER NUMBER STRING
%token ASSIGN MUSAawi
%token LPAREN RPAREN

%start Program

%%

Program
    : BIDAYA FAT7 Statements NIHAYA KHTM IGHLAQ
    ;

Statements
    : Statements Statement
    | Statement
    ;

Statement
    : ADKHAL IDENTIFIER KHTM
    | IDENTIFIER ASSIGN NUMBER KHTM
    | BAYAN LPAREN IDENTIFIER RPAREN KHTM
    | IZA LPAREN Condition RPAREN FAT7 Statements IGHLAQ
    | RAJI3 NUMBER KHTM
    ;

Condition
    : IDENTIFIER MUSAawi NUMBER
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d\n", yylineno);
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Input file error");
            return 1;
        }
    }

    if (yyparse() == 0) {
        printf("Syntax analysis successful\n");
    }

    return 0;
}
