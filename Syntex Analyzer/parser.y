%{
#include<iostream>
using namespace std;

extern FILE *yyin, *yyout;
void print();

int ln =1;
int yylex(void);
void yyerror(char *c){
    fprintf(yyout, "%s\n",c);
}

%}

%token INT INTEGER FLOAT NEWLINE SEMICOLON COMMA LTHIRD RTHIRD LPARAN RPARAN ID1 ID2
%token LAND LOR GRTTHAN LESSTHAN ASSOP
%token MODOP
%token DIVOP
%token MULOP
%token PLUS
%token MINUS

%%

stmt : stmt unit {}
| unit {}

unit : var_decl NEWLINE {ln++; fprintf(yyout,"\n\n");}
| expr_decl NEWLINE {ln++; fprintf(yyout,"\n\n");}
| error NEWLINE {yyerrok; ln++; fprintf(yyout,"\n\n");}

var_decl : type_spec decl_list SEMICOLON {fprintf(yyout, "Line Number: %d\n var_decl: type_spec decl_list SEMICOLON\n",ln);}

type_spec : INT {fprintf(yyout, "Line Number: %d\n type_spec: INT\n",ln);}

decl_list : decl_list COMMA term {fprintf(yyout,"Line Number: %d\n decl_list: decl_list COMMA term\n",ln);}
| decl_list COMMA term LTHIRD INTEGER RTHIRD {fprintf(yyout, "Line Number: %d\n decl_list : decl_list COMMA term LTHIRD NUM RTHIRD\n",ln);}
| term {fprintf(yyout, "Line Number: %d\n decl_list : term \n", ln);}
| term LTHIRD INTEGER RTHIRD {fprintf(yyout,"Line Number: %d\n decl_list : term LTHIRD NUM RTHIRD \n",ln);}
| term LTHIRD FLOAT RTHIRD {fprintf(yyout,".syntex error");}
|ass_list {fprintf(yyout,"Line Number: %d\n decl_list : ass_list \n",ln);}

ass_list : term ASSOP expr {fprintf(yyout,"Line Number: %d\n ass_list : term ASSOP expr \n",ln);}

expr : INTEGER {fprintf(yyout,"Line Number: %d\n expr : NUM \n",ln);}
|expr FLOAT {fprintf(yyout,"Line Number: %d\n expr : NUM \n",ln);}
| expr PLUS expr {fprintf(yyout,"Line Number: %d\n expr : expr ADDOP expr \n",ln);}
| expr DIVOP expr {fprintf(yyout,"Line Number: %d\n expr : expr DIVOP expr \n",ln);}
| expr MULOP expr {fprintf(yyout,"Line Number: %d\n expr : expr MULOP expr \n",ln);}
| expr MINUS expr {fprintf(yyout,"Line Number: %d\n expr : expr MINUS expr \n",ln);}
| expr MODOP expr {fprintf(yyout,"Line Number: %d\n expr : expr MODOP expr \n",ln);}
| expr LESSTHAN expr {fprintf(yyout,"Line Number: %d\n expr : expr LESSTHAN expr \n",ln);}
| expr GRTTHAN expr {fprintf(yyout,"Line Number: %d\n expr : expr GRTTHAN expr \n",ln);}
| LPARAN expr RPARAN {fprintf(yyout,"Line Number: %d\n expr : LPARAN expr RPARAN \n",ln);}
| expr LAND expr  {fprintf(yyout,"Line Number: %d\n expr : expr LAND expr \n",ln);}
| expr LOR expr  {fprintf(yyout,"Line Number: %d\n expr : expr LOR expr \n",ln);}
| term {fprintf(yyout,"Line Number: %d\n expr : term \n",ln);}

term : ID1 {fprintf(yyout,"Line Number: %d\n term : ID \n",ln);}
| ID2 {}

expr_decl : term ASSOP expr SEMICOLON {fprintf(yyout,"Line Number: %d\n expr_decl : term ASSOP expr SEMICOLON\n",ln);}
%%

int main(){
    yyin=fopen("in.txt", "r");
    yyout=fopen("logerror.txt", "w");
    yyparse();
    print();
}