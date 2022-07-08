%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "SymbolTable.h"
#define YYSTYPE SymbolInfo
extern FILE *yyin, *yyout;
extern SymbolTable table;

int yylex(void);
int t_count = 1;
char * str;
FILE *outFile;
ofstream of;

void yyerror(const char *s)
{
	fprintf(stderr,"%s\n",s);
	return;
}

char* getTemp(int i)
{
    char *ret = (char*) malloc(15);
    sprintf(ret, "t%d", i);
	return ret;
}

%}

%error-verbose
%token  DOUBLE
%token NAME
%token BR



%right '='
%left '+' '-'
%left '*' 
%left '/'
%left '(' ')'  


%%
program: program line		{ fprintf(yyout,"\n\n");}
	| line					{ fprintf(yyout,"\n\n");  }
	;
line:
	expr 	BR 		    {	
								t_count = 1;	
								fprintf(outFile,"\t\n");
							}
	| NAME '=' expr BR 	{				
								t_count-=1;
								str = getTemp(t_count);
								SymbolInfo 	obj1(string(str), "");					
								$$=obj1; 
                                fprintf(outFile,"%s = %s\n",$1.getSymbol().c_str(),$3.getSymbol().c_str());
                                //fprintf(yyout, "ST %s\n", $1.getSymbol().c_str(), $3.getSymbol().c_str());
								fprintf(yyout, "MOV AX, %s\nMOV %s,AX\n", $3.getSymbol().c_str(), $1.getSymbol().c_str());

								/* following code for using union
								str = getTemp(t_count);
								strcpy($$, str);
								printf("%s = %s", $$, $1);
								*/

								t_count=1;
								
								
							}
	;
expr:
	expr '+' expr 			{ 
								str = getTemp(t_count);
								SymbolInfo 	obj1(string(str), "");			
								$$=obj1;
								// cout<<$$.getSymbol()<<" = "<<$1.getSymbol()<<" + "<<$3.getSymbol()<<endl;
								fprintf(outFile,"%s = %s + %s\n",$$.getSymbol().c_str(),$1.getSymbol().c_str(),$3.getSymbol().c_str());
								
								/*
								// 3 Address code using union {char cvar[10];}
								
								str = getTemp(t_count);
								strcpy($$,str);
								printf("%s = %s + %s\n",$$,$1,$3);
								*/
								// asm code
								fprintf(yyout, "MOV ax, %s\n", $1.getSymbol().c_str()); // check documentation for c_str() function
								fprintf(yyout, "MOV bx, %s\n", $3.getSymbol().c_str()); // c_str() used to have fprintf compatible string
								fprintf(yyout, "ADD ax, bx\n");
								fprintf(yyout, "MOV %s, ax\n", $$.getSymbol().c_str());
								

								t_count++;
								
								

							}
    
    |   expr '-' expr       {
                                str = getTemp(t_count);
								SymbolInfo 	obj1(string(str), "");			
								$$=obj1;
								// cout<<$$.getSymbol()<<" = "<<$1.getSymbol()<<" + "<<$3.getSymbol()<<endl;
								fprintf(outFile,"%s = %s - %s\n",$$.getSymbol().c_str(),$1.getSymbol().c_str(),$3.getSymbol().c_str());
								
								/*
								// 3 Address code using union {char cvar[10];}
								
								str = getTemp(t_count);
								strcpy($$,str);
								printf("%s = %s + %s\n",$$,$1,$3);
								*/
								// asm code
								fprintf(yyout, "MOV ax, %s\n", $1.getSymbol().c_str()); // check documentation for c_str() function
								fprintf(yyout, "MOV bx, %s\n", $3.getSymbol().c_str()); // c_str() used to have fprintf compatible string
								fprintf(yyout, "SUB ax, bx\n");
								fprintf(yyout, "MOV %s, ax\n", $$.getSymbol().c_str());
								

								t_count++;
                            }

    |   expr '*' expr       {
                                str = getTemp(t_count);
								SymbolInfo 	obj1(string(str), "");			
								$$=obj1;
								// cout<<$$.getSymbol()<<" = "<<$1.getSymbol()<<" + "<<$3.getSymbol()<<endl;
								fprintf(outFile,"%s = %s * %s\n",$$.getSymbol().c_str(),$1.getSymbol().c_str(),$3.getSymbol().c_str());
								
								/*
								// 3 Address code using union {char cvar[10];}
								
								str = getTemp(t_count);
								strcpy($$,str);
								printf("%s = %s * %s\n",$$,$1,$3);
								*/
								// asm code
								fprintf(yyout, "MOV ax, %s\n", $1.getSymbol().c_str()); // check documentation for c_str() function
								fprintf(yyout, "MOV bx, %s\n", $3.getSymbol().c_str()); // c_str() used to have fprintf compatible string
								fprintf(yyout, "MUL bx\n");
								fprintf(yyout, "MOV %s, ax\n", $$.getSymbol().c_str());
								

								t_count++;
                            }


    |   expr '/' expr       {
                                str = getTemp(t_count);
								SymbolInfo 	obj1(string(str), "");			
								$$=obj1;
								// cout<<$$.getSymbol()<<" = "<<$1.getSymbol()<<" + "<<$3.getSymbol()<<endl;
								fprintf(outFile,"%s = %s / %s\n",$$.getSymbol().c_str(),$1.getSymbol().c_str(),$3.getSymbol().c_str());
								
								/*
								// 3 Address code using union {char cvar[10];}
								
								str = getTemp(t_count);
								strcpy($$,str);
								printf("%s = %s * %s\n",$$,$1,$3);
								*/
								// asm code
								fprintf(yyout, "MOV ax, %s\n", $1.getSymbol().c_str()); // check documentation for c_str() function
								fprintf(yyout, "MOV bx, %s\n", $3.getSymbol().c_str()); // c_str() used to have fprintf compatible string
								fprintf(yyout, "DIV bx\n");
								fprintf(yyout, "MOV %s, ax\n", $$.getSymbol().c_str());
								

								t_count++;
                            }

		| '(' expr ')'		{
								$$=$1;

		}


	|term				 {
							$$=$1;
							//strcpy($$, $1);
						}
;
term: NAME 				{
							$$=$1;
							//strcpy($$, $1);
						}
	| DOUBLE            {
                            $$=$1;
                        }
	
	;

%%


int main(void)
{
	yyin=fopen("input.txt", "r");
    yyout=fopen("code.asm", "w");
	outFile=fopen("code.ir","w");
	of.open("table.txt");

	
    yyparse();
	table.print();
    fclose(yyin);
    fclose(yyout);
	fclose(outFile);
    return 0;
}