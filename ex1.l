%{
    #include "ex1.tab.h"
    #include "yy_readline.h"
%}

%option noyywrap

blank       [ \t]+
letter      [a-zA-Z]+
special     [$&,:;?@#|'<>_!]+
digit		[0-9]
integer     {digit}+
real        ({integer}("."{integer})?|"."{integer})

%%

{blank}      { /* Skip blanks. */ }

{real}       {
                yylval.f = atof(yytext);
                return NUM;
            }

{letter}     { printf("Only numbers are allowed!\n"); }

{special}    { printf("Please provide valid operators -> + - * / ^ only!\n"); }

"="          { printf("Assignment operator not allowed!\n"); }
"("          { return LBRAC; }
")"          { return RBRAC; }
"*"          { return MULTI; }
"/"          { return DIVIDE; }
"%"          { return MODULO; }
"^"          { return POWER; }
"+"          { return PLUS; }
"-"          { return MINUS; }
                
"exit()"		 { return EXIT; }

\n           { return EOL; }

%%




