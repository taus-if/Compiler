%option noyywrap

%{
#include<stdio.h>
int line=1;
%}
keyword if|else|switch|case|while|for|int|float|double|break|default|void
delim [ /t/n]
ws {delim}+
ln [\n]
letter [A-Za-z_]
digit [0-9]
digits {digit}+
exppart [Ee][+-]?{digits}
num	{digits}(\.{digits})?({exppart})?
identifier {letter}({letter}|{digits})*
bitwise_op >>|<<|&|\^|\|
assignment_op =|<<=|>>=|&=|^=|!=
parentheses \(|\)
curly_braces \{|\}
sep [,;:]
literals \".*\"
function {identifier}({ws}|{ln})*"("
%%
"\n" {line++;}
"//".*"\n" {line++;}
"/*"[^*/]*"*/" {
	/*int cnt1=0;
	int i=0;
	for(i=0;yytext[i]!='/';i++){
		if(yytext[i]=='\n'){
			cnt1++;
		}
	}
	cnt1++;
	line+=cnt1;*/
	printf()
}
{sep} {fprintf(yyout,"\n<Separator, %s> at line %d", yytext, line);}
{literals} {fprintf(yyout, "\n<literals, %s>, at line %d", yytext, line);}

"if"{ws}*"(" {fprintf(yyout, "\n<Keyword,if>, at line %d", line);}
"else" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"switch"{ws}*"(" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"case" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"while" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"for" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"int" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"float" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"double" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"break" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"default" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}
"void" {fprintf(yyout, "\n<Keyword, %s>, at line %d", yytext, line);}

{assignment_op} {fprintf(yyout, "\n<Assignment Operator, %s>, at line %d", yytext, line);}
{bitwise_op} {fprintf(yyout, "\n<Bitwise Operator, %s>, at line %d", yytext, line);}
{parentheses} {fprintf(yyout, "\n<Parentheses, %s>, at line %d", yytext, line);}
{curly_braces} {fprintf(yyout, "\n<Curly Braces, %s>, at line %d", yytext, line);}

{identifier} {fprintf(yyout, "\n<identifier, %s>, at line %d", yytext, line);}
{num} {fprintf(yyout, "\n<Number, %s>, at line %d", yytext, line);}
{function} {int i=0;
			int cnt1=0;
			fprintf(yyout,"\n<Function,");
			
			while(yytext[i]!='(')
			{
				if(yytext[i]=='\n'){cnt1++;}
				
				if((yytext[i]>='A' && yytext[i]<='Z')|| (yytext[i]>='a' && yytext[i]<='z') || (yytext[i]>='0' && yytext[i]<='9')||yytext[i]=='_')
				{
				fprintf(yyout,"%c",yytext[i]);}
				i++;
			}
			
			fprintf(yyout,">,at line Number=%d",line);line+=cnt1;}

%%

int main(){
    yyin=fopen("input.txt","r");
    yyout=fopen("output.txt","w");
    //fprintf(yyout, "Before calling yylex function");
    yylex();
    //fprintf(yyout, "Total identifiers: %d",line);
}