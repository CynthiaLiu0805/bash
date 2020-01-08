#include <stdio.h>
#include <string.h>

#define _flush() \
  if (cci >= 0) for(int i=0, j=cci; i<=j; i++,cci=-1) putchar(cc[i])


// replaces every 
int main(int argc,char** argv) {
  int c;
  int cc[8];
  int cci=-1;

  if (argc!=2) {
    printf("usage -- %s <infile>\n",argv[0]);
    return 0;
  }
  FILE* fp=fopen(argv[1],"r");
  if (fp==0) {
    printf("can't open input file \"%s\"\n",argv[1]);
    return 0;
  }
  while(true) {
    c = fgetc(fp);
    if (feof(fp)) break;
    if (cci==-1) {
      if (c=='@') {
        cc[cci=0]='@';
        continue;
      }else{
        putchar(c);
        continue;
      }
   }else if (cci==0) {
      if (c=='s') {
        cc[++cci]='s';
        continue;
      }else{
        _flush();
        putchar(c);
        continue;
      }
   }else if (cci==1) {
      if (c=='e') {
        cc[++cci]='e';
        continue;
      }else{
        _flush();
        putchar(c);
        continue;
      }
   }else if (cci==2) {
      if (c=='m') {
        cc[++cci]='m';
        continue;
      }else{
        _flush();
        putchar(c);
        continue;
      }
   }else if (cci==3) {
      if (c=='i') {
        putchar(';');
        cci=-1;
        continue;
      }else{
        _flush();
        putchar(c);
        continue;
      }
   }
  }
  fclose(fp);
  return 0;
}

