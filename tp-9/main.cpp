#include <iostream>
#include "Par.h"
#include "Fraccion.h"
using namespace std;

int main() {
   int x = 3;
   int y = 8;
   Fraccion f1 = consFraccion(x,y);
   Fraccion f2 = consFraccion(50,13);
   Fraccion m = multF(f1,f2);
   Fraccion s = sumF(f1,f2);
   cout <<"El resultado es: "<< denominador(simplificada(f2)) << endl;
}
