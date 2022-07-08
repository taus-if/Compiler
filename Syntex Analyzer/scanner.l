%option noyywrap
%{

#include<stdio.h>
#include "symboltable.h"
#include "parser.tab.h"

symboltable tb;

%}

digit [0-9]
digits {digit}+
fraction \.{digits}
exponent [Ee]("+"|"-")?{digits}
letter [_A-Za-z_]
Identifier {letter}({letter}|{digit})*
Integer {digits}({exponent})?
Float {digits}({fraction})?({exponent})?|{digits}*{fraction}({exponent})?

%%

"int" {return INT;}
{Integer} {return INTEGER;}
{Float} {return FLOAT;}
[\n] {return NEWLINE;}
[;] {return SEMICOLON;}
[,] {return COMMA;}
"[" {return LTHIRD;}
"]" {return RTHIRD;}
"(" {return LPARAN;}
")" {return RPARAN;}
"%" {return MODOP;}
"/" {return DIVOP;}
"*" {return MULOP;}
"+" {return PLUS;}
"-" {return MINUS;}
"=" {return ASSOP;}
"&&" {return LAND;}
"||" {return LOR;}
"<" {return GRTTHAN;}
">" {return LESSTHAN;}
{Identifier} {
    if(tb.lookup(yytext)==0){
        tb.insert(yytext, "identifier");
        return ID1;
    }
    else{
        fprintf(yyout, "%s is already declared.\n", yytext);
        return ID2;
    }
}
%%
void print()
{
    tb.print();
}



