#include<stdio.h>
#include<stdlib.h>
#include<string.h>
void pass1(char label[10],char opcode[10],char operand[10],char code[10],char mnemonic[3]);
void display();
int main()
{
    char label[10],opcode[10],operand[10];
    char code[10],mnemonic[3];
    pass1(label,opcode,operand,code,mnemonic);
    return 0;
}
void pass1(char label[10],char opcode[10],char operand[10],char code[10],char mnemonic[3])
{
    int locctr,start,length;
    FILE *fp1,*fp2,*fp3,*fp4,*fp5;
    fp1=fopen("input.txt","r");
    fp2=fopen("optab.txt","r");
    fp4=fopen("intermediate.txt","w");
    fp3=fopen("symtab.txt","w");
    fp5=fopen("length.txt","w");
    fscanf(fp1,"%s\t%s\t%s",label,opcode,operand);
    if(strcmp(opcode,"START")==0)
    {
        start=atoi(operand);
        locctr=start;
        fprintf(fp4,"\t%s\t%s\t%s\n",label,opcode,operand);
        fscanf(fp1,"%s\t%s\t%s",label,opcode,operand);
    }
    else
    {
        locctr=0;
    }
    while(strcmp(opcode,"END")!=0)
    {
        fprintf(fp4,"%d\t%s\t%s\t%s\n",locctr,label,opcode,operand);
        if(strcmp(label,"**")!=0)
        {
            fprintf(fp3,"%s\t%d\n",label,locctr);
        }
        fscanf(fp2,"%s\t%s",code,mnemonic);
        while(strcmp(code,"END")!=0)
        {
            if(strcmp(code,opcode)==0)
            {
                locctr+=3;
                break;
            }
            fscanf(fp3,"%s\t%s",code,mnemonic);
        }
        if(strcmp(opcode,"WORD")==0)
        {
            locctr+=3;
        }
        else if(strcmp(opcode,"RESW")==0)
        {
            locctr+=3*(atoi(operand));
        }
        else if(strcmp(opcode,"BYTE")==0)
        {
            locctr++;
        }
        else if(strcmp(opcode,"RESB")==0)
        {
            locctr+=1*(atoi(operand));
        }
        fscanf(fp1,"%s\t%s\t%s",label,opcode,operand);
    }
    fprintf(fp4,"%d\t%s\t%S\t%s\n",locctr,label,opcode,operand);
    fclose(fp1);
    fclose(fp2);
    fclose(fp3);
    fclose(fp4);
    display();
    length=locctr-start;
    fprintf(fp5,"%d",length);
    fclose(fp5);
    printf("\n\n length of the code : %d",length);
}

void display()
{
    char str;
    FILE *fp1,*fp2,*fp3;
    printf("\n The content of input table : \n\n");
    fp1=fopen("input.txt","r");
    str=fgetc(fp1);
    while(str!=EOF)
    {
        printf("%c",str);
        str=fgetc(fp1);
    }
}