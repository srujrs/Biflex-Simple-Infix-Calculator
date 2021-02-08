/* Infix notation calculator. */

%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yyerror(const char* errstr)
    {
      printf("Error: %s\n\n", errstr);
      return EXIT_FAILURE;
    }

    extern int yylex();
%}

%union {
  float f;
}

/* Bison declarations. */

%define parse.error verbose

%token NUM EQUALS LBRAC RBRAC
%token EOL
%left MINUS PLUS
%left MULTI DIVIDE MODULO
%precedence NEG   /* negation--unary minus */
%right POWER        /* exponentiation */
%right EXIT

%type <f> exp NUM;

%% /* The grammar follows. */

line:   /* empty */
| line exp EOL  { printf ("\t%f\n", $2); }
| line EXIT EOL {return EXIT_SUCCESS;}
;

exp:
  NUM
| exp PLUS exp         { $$ = $1 + $3; }
| exp MINUS exp        { $$ = $1 - $3; }
| exp MULTI exp        { $$ = $1 * $3; }
| exp DIVIDE exp       { $$ = $1 / $3; }
| exp MODULO exp       { $$ = ((int)$1) % ((int)$3); }
| MINUS exp  %prec NEG { $$ = -$2; }
| exp POWER exp        { $$ = pow ($1, $3); }
| LBRAC exp RBRAC        { $$ = $2; }
;

%%

int main ()
{
  return yyparse ();
}