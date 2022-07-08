%option noyywrap
%{
#include<bits/stdc++.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo
#include "assign.tab.h"

void yyerror(const char* msg);
SymbolTable table;



%}
DIGITS  [0-9]+
DOUBLE	{DIGITS}(\.{DIGITS})?
LETTER [_a-zA-Z]
BR [\n]
NAME	[a-zA-Z]
%%
[ \t]+ 	 { }
{DOUBLE} {
			SymbolInfo ob(string(yytext), "DOUBLE");
			//strcpy(yylval.cvar,yytext);
			yylval = (YYSTYPE) ob;
			return DOUBLE;
		 }
[-+*/=]  {
		    return *yytext;
	     }
"(" 	 {
			return *yytext;
		 }
")" 	 {
			return *yytext;
		 }
{NAME} 	 {
			SymbolInfo ob(string(yytext), "ID");
			//strcpy(yylval.cvar,yytext); // if use union
			yylval = (YYSTYPE) ob;
			if(table.LookUp(yytext)==-1){
				table.INSERT(yytext, "Identifier");
			}
			else{
				printf("already inserted\n");
			}
			return NAME;
		 }
{BR} 	     {
			return BR;
		 }	 

exit     {
			return 0;
		 }
.        {
			char msg[25];
			sprintf(msg," <%s>","invalid character",yytext);
			yyerror(msg);
		 }
%%

void display(){
	table.print();
}

