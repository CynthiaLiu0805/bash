#include <stdio.h>

#ifdef _ABCD
   void maxer1();
   void maxer2();
   void maxer3();
#endif

int main() {
#ifdef _AB
  printf("Hamilton is a beautiful city\n");
  return 0;
#endif
#ifdef _ABC
  printf("Quite an exaggeration\n");
  return 0;
#endif
#ifdef _ABCD
  maxer1();
  maxer2();
  maxer3();
  return 0;
#endif
  printf("In Ontario, Hamilton is the best\n");
  return 0;
}
