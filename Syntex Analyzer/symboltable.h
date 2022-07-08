#include<bits/stdc++.h>
using namespace std;
class SymbolInfo
{
public:
    string name;
    string cat;
    string type;

    SymbolInfo(string nm,string ct, string ty)
    {
        name=nm;
        cat=ct;
        type=ty;
    }
};
class Symboltable
{
public:
    vector<SymbolInfo>table[10];

    int hash_func(string name)
    {
        int sum=0;
        for(int i=0;i<name.size();i=i+2)
        {
            sum=(name[i]<<9)+sum;
        }
        int index=sum%10;
        return index;
    }

    void insert_table(string t,string n,string c)
    {
        if(lookup(n)==-1)
        { int idx=hash_func(n);
          table[idx].push_back(SymbolInfo(n,c,t));
          //cout<<"Inserted at position "<<idx<<", "<<table[idx].size()-1<<endl;
        }
    }

    int lookup(string n)
    {
             int flag=-1;
             int idx=hash_func(n);
             for(int i=0;i<10;i++)
             {
                 for(int k=0;k<table[idx].size();k++)
                 if(table[idx][k].name==n)
                 {
                     flag=k;
                     break;
                 }
             }
             return flag;
    }
      void Delete(string name)
    {
        int flag=lookup(name);
        int idx=hash_func(name);
       for(int i=0;i<table[idx].size();i++)
       {
          if(table[idx][i].name!=name) continue;
                cout << "Deleted from " << idx << "," << table[idx].size()-1 << endl;
                table[idx].erase(table[idx].begin()+i);
                break;
       }
    }

    void print()
    {
        ofstream file;
        file.open("log.txt");
        for(int i=0;i<10;i++)
        {
            file<<i<<" -> ";
            for(int k=0;k<table[i].size();k++)
            {
                if(table[i][k].type=="")
                file<<"<"<<table[i][k].name<<", "<<table[i][k].cat<<"> ";
                else
                    file<<"<"<<table[i][k].name<<", "<<table[i][k].type<<", "<<table[i][k].cat<<"> ";
            }
            file<<endl;

        }
        file.close();
    }


};
