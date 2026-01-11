%{
#include <stdio.h>
#include "parser.tab.h"

extern FILE *yyin;
extern int yylineno;
%}

DIGIT    [0-9]
ID       [a-zA-Z_][a-zA-Z0-9_]*
NUMBER   {DIGIT}+
STRING   \"[^\"]*\"

%%

\n              { yylineno++; }
[ \t\r]+        { }

"//".*          { }
"/*"([^*]|\*+[^*/])*\*+"/"   { }

"bidaya"        { return BIDAYA; }
"nihaya"        { return NIHAYA; }
"fat7"          { return FAT7; }
"ighlaq"        { return IGHLAQ; }
"khtm"          { return KHTM; }

"iza"           { return IZA; }
"aw"            { return AW; }
"adkhal"        { return ADKHAL; }
"bayan"         { return BAYAN; }
"raji3"         { return RAJI3; }

"musaawi"       { return MUSAawi; }

"("             { return LPAREN; }
")"             { return RPAREN; }

"="             { return ASSIGN; }

{NUMBER}        { return NUMBER; }
{ID}            { return IDENTIFIER; }
{STRING}        { return STRING; }

.               { return yytext[0]; }

%%