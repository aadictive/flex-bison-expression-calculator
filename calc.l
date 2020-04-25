%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"
/* Initializing Flag/Counter Variables */
int counter = 0;
int exprcnt = 1;
%}

%option nodefault
%option yylineno

digit	([0-9])
/* Line 22: We cannot define '-' as a token, because '-' should fetch us an error. So we define "(-" */
/* Line 31: Defining identifiers(Id) that starts with lower-case letters. 'x','x1' & 'xy' are identifiers */
/* Line 32: '1x' & 'A' are not identifiers */
%%
"print"      	{	return(TOK_PRINT);		}
"main()"		{	return(TOK_MAIN);		}
{digit}+     	{	yylval.o.expression[exprcnt] = 3; yylval.o.values[exprcnt] = atoi(yytext); exprcnt++; sscanf(yytext, "%d", &(yylval)); return(TOK_NUM);}
";"				{	return(TOK_SEMICOLON);	}
"(-"			{	return(TOK_NEGINT);		}
"+"				{	yylval.o.expression[exprcnt] = 1; exprcnt++; return(TOK_ADD);}
"*"				{	yylval.o.expression[exprcnt] = 2; exprcnt++; return(TOK_MUL);}
"="				{	exprcnt = 1; return(TOK_ASSIGN);}
"("				{	return(TOK_OpenBracket);			}
")"				{	return(TOK_CloseBracket);			}
"{"				{	counter++; yylval.s.tlcnt = counter; return(TOK_OpenCurly);}
"}"				{	counter--; yylval.s.tlcnt = counter; return(TOK_CloseCurly);}	
[ \t\r\n]+		{}
[a-z][a-z0-9]*	{	yylval.o.expression[exprcnt] = 4; strcpy(yylval.o.variable[exprcnt], yytext); exprcnt++; strcpy(yylval.s.temp, yytext); return(TOK_ID);}
[0-9][a-zA-Z]*	{	printf("Lexical analysis error: %s\n", yytext);}
.				{	printf("Lexical analysis error: %s\n", yytext);}
%%

