#include<bits/stdc++.h>
using namespace std;

vector<string>code;

int hashval(string s)
{
    int total=0;
    for(int i=0; i<s.size(); i+=2)
    {
        total+=((int)s[i])<<6;
    }
    return total%10;
}

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

class symbolInfo{
public:
    string symbol;
    string catagory;
    symbolInfo(string symbol, string catagory){
        this->symbol=symbol;
        this->catagory=catagory;
    }

};

class symboltable{
public:
    vector<symbolInfo> info[11];

    void Insert(string symbol, string catagory){
        int flag=0;
        int hsh=hashval(symbol);
        for(int i=0;i<info[hsh].size();i++){
            if(symbol==info[hsh][i].symbol){
                flag=1;
                ///cout<<"Found at "<<hsh<<","<<i<<endl;
                cout<<"Already Present"<<endl;
                return;
            }
        }
        symbolInfo a(symbol,catagory);
        info[hashval(symbol)].push_back(a);
        int x=hashval(symbol);
        cout<<"Inserted at position "<<x<<", "<<info[x].size()-1<<endl;

    }

    void Lookup(string symbol){
        int flag=0;
        int hsh=hashval(symbol);
        for(int i=0;i<info[hsh].size();i++){
            if(symbol==info[hsh][i].symbol){
                flag=1;
                cout<<"Found at "<<hsh<<","<<i<<endl;
            }
        }
        if(!flag) cout<<"Not found"<<endl;
    }
    void Delete(string symbol){
        int flag=0;
        int hsh=hashval(symbol);
        for(int i=0;i<info[hsh].size();i++){
            if(symbol==info[hsh][i].symbol){
                flag=1;
                info[hsh].erase(info[hsh].begin()+i);
            }
        }
        if(!flag) cout<<"Not found"<<endl;
    }
    void Print(){
        for(int i=0;i<11;i++){
            cout<<i<<" ->";
            for(int j=0;j<info[i].size();j++){
                cout<<"<"<<info[i][j].symbol<<", "<<info[i][j].catagory<<"> ";
                /*if(info[i][j].catagory=="NUMBER"){
                    cout<<"> ";
                }
                else{
                    cout<<", "<<info[i][j].type<<"> ";
                }*/
            }
            cout<<endl;
        }
    }
};

int main()
{
    ifstream fin;
    ofstream fout;
    ofstream fout2;
    ofstream fout3;
    ofstream fout4;

    symboltable* table=new symboltable();

    fin.open("input.txt");
    fout.open("keyword.txt");
    fout2.open("function.txt");
    fout3.open("identifier.txt");
    fout4.open("operator.txt");

    string line;
    string bs="";
    bs+='"';
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
            if(code[i][j]>='a' && code[i][j]<='z' || code[i][j]>='A' && code[i][j]<='Z'){
                s+=code[i][j];
                //cout<<"sdk"<<endl;
                //cout<<i<<" "<<j<<endl;
            }
            else if(key_check(s)){
                fout<<s<<" "<<i+1<<endl;
                table->Insert(s,"keyword");
                table->Print();
                for(int k=s.size()-1;k>=0;k--){
                    code[i][k]=' ';
                }
                s="";
            }
            else if(code[i][j]=='(' && code[i][j-1]>='a' && code[i][j-1]<='z'){
                fout2<<s<<" "<<i+1<<endl;
                table->Insert(s,"function");
                table->Print();
                /*for(int k=s.size()-1;k>=0;k--){
                    //cout<<code[i][k]<<" ";
                    code[i][k]=' ';
                }*/
                s="";
            }
            else if(s[0]>='a' && s[0]<='z' || s[0]>='A' && s[0]<='Z' ||s[0]=='_'){
                cout<<code[i][j]<<endl;
                if(code[i][j]!='"'){
                    fout3<<s<<" "<<i+1<<endl;
                    table->Insert(s,"Identifier");
                    table->Print();
                }
                s="";
            }
            else{
                s="";
            }

        }
        string z="";
        for(int j=0;j<code[i].size();j++){
            if(code[i][j]=='+' || code[i][j]=='-' || code[i][j]=='!' || code[i][j]=='%' || code[i][j]=='&' || code[i][j]=='|' || code[i][j]=='='){
                z+=code[i][j];
                if(code[i][j+1]=='+' || code[i][j+1]=='-' || code[i][j+1]=='=' || code[i][j+1]=='|'){
                    z+=code[i][j+1];
                    j++;
                }
                if(z!="|" && z!="&"){
                    if(z=="%" && code[i][j-1]=='"'){
                        z="";
                    }
                    if(z!=""){
                        fout4<<z<<" "<<i+1<<endl;
                        z="";
                    }

                }
            }
            else{
                z="";
            }
        }

    }
///end of keyword check
    //codeprint();
}
