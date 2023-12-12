#include <iostream>
#include "Fraccion.h"
using namespace std;

Fraccion consFraccion(int numerador, int denominador) {
   Fraccion f;
   f.numerador = numerador;
   f.denominador = denominador;
   return(f);
}

int numerador(Fraccion f) {
   return(f.numerador);
}

int denominador(Fraccion f) {
   return(f.denominador);
}

float division(Fraccion f) {
   float n = f.numerador;
   float m = f.denominador;
   return(n/m);
}

Fraccion multF(Fraccion f1, Fraccion f2) {
   f1.numerador *= f2.numerador;
   f1.denominador *= f2.denominador;
   return(f1);
}

Fraccion simplificada(Fraccion p) {
   int k = p.numerador;
   int l = p.denominador;
   int m = k%l;
   while (m != 0) {
     k = l;
     l = m;
     m = k%l;
   }
   p.numerador /= l;
   p.denominador /= l;
   return(p);
}

Fraccion sumF(Fraccion f1, Fraccion f2) {
   if (f1.denominador != f2.denominador) {
      f1.numerador *= f2.denominador;
      f2.numerador *= f1.denominador;
      f1.denominador *= f2.denominador;
   }
   f1.numerador += f2.numerador;
   return(f1);
}
