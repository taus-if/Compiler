#include<bits/stdc++.h>
using namespace std;

vector<string>code;

string keyword[]={"if", "else", "for", "while", "break","int",
"char", "float","double", "return", "include"};

string operate[]={"+","-","*","/","%","&&","||","==","!=","!",
"=","+=","-=","*=","/=","%="};

bool key_check(string s){
    for(int i=0;i<11;i++){
        if(s==keyword[i]) return true;
    }
    return false;
}

void codeprint(){
    for(int i=0;i<code.size();i++) cout<<code[i]<<endl;
}

int main()
{
    ifstream fin;
    ofstream fout;
    ofstream fout2;
    ofstream fout3;
    ofstream fout4;

    fin.open("input.txt");
    fout.open("keyword.txt");
    fout2.open("function.txt");
    fout3.open("identifier.txt");
    fout4.open("operator.txt");

    string line;
    int cnt=1;
    /*while(fin){
        getline(fin, line);
        //cout<<line<<endl;
        string s="";
        int ep=0;
        for(int i=ep;i<line.size();i++){
            if(line[i]>='a' && line[i]<='z'){
                s+=line[i];
            }
            else{
                if(key_check(s)){
                    fout<<s<<" "<<cnt<<endl;
                }
                s="";
            }
        }
        cnt++;
    }*/

    while(fin){
        getline(fin, line);
        //cout<<line<<endl;
        code.push_back(line);
    }

    for(int i=0;i<code.size();i++){
        //cout<<code[i]<<endl;
        string s="";
        int ep=0;
        for(int j=0;j<code[i].size();j++){
            if(code[i][j]>='a' && code[i][j]<='z'){
                s+=code[i][j];
                //cout<<"sdk"<<endl;
                //cout<<i<<" "<<j<<endl;
            }
            else{
                if(key_check(s)){
                    fout<<s<<" "<<i+1<<endl;
                    for(int k=s.size()-1;k>=0;k--){
                        code[i][k]=' ';
                    }
                }
                s="";
            }
        }
    }
///end of keyword check
    codeprint();
///function checking
    for(int i=0;i<code.size();i++){
        //cout<<code[i]<<endl;
        string s="";
        int ep=0;
        for(int j=0;j<code[i].size();j++){
            if(code[i][j]>='a' && code[i][j]<='z'){
                s+=code[i][j];
                //cout<<"sdk"<<endl;
                //cout<<i<<" "<<j<<endl;
            }
            else{
                if(code[i][j]=='(' && code[i][j-1]>='a' && code[i][j-1]<='z'){
                    fout2<<s<<" "<<i+1<<endl;
                    for(int k=s.size()-1;k>=0;k--){
                        //cout<<code[i][k]<<" ";
                        code[i][k]=' ';
                    }
                }
                s="";
            }
        }
    }
///function checking ends;
    codeprint();


    fin.close();
    fout.close();
    fout2.close();
    fout3.close();
    fout4.close();

}
