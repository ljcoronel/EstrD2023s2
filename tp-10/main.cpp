#include <iostream>
//#include "Pokemon.h"
//#include "Entrenador.h"
#include "ArrayList.h"
using namespace std;

int minimo(ArrayList xs) {
   if (lengthAL(xs) > 0)
         { int min = get(0,xs);
           for (int i=1; i < lengthAL(xs); i++)
             { if (min > get(i,xs))
                 { min = get(i,xs); } }
           return(min); }
    else { return('\0'); }
}

int main() {
   ArrayList xs = newArrayListWith(10);
   ArrayList ys = newArrayListWith(13);
   ArrayList zs = newArrayList();
   add(2,ys);
   add(4,ys);
   add(1,ys);
   add(3,xs);
   add(5,xs);
   add(7,xs);
   add(9,xs);
   add(4,xs);
   set(4,15,xs);
   resize(4,xs);
   remove(xs);
   //sucesores(xs);
   cout <<"El resultado es: "<< minimo(zs) << endl;
}

//int main() {
//   Pokemon p1 = consPokemon("fuego");
//   Pokemon p2 = consPokemon("planta");
//   Pokemon p3 = consPokemon("planta");
//   Pokemon p4 = consPokemon("agua");
//   Pokemon* ap = new Pokemon[2];
//   Pokemon* ep = new Pokemon[2];
//   ap[0] = p1;
//   ap[1] = p2;
//   ep[0] = p3;
//   ep[1] = p4;
//   Entrenador e1 = consEntrenador("A",2,ap);
//   Entrenador e2 = consEntrenador("B",2,ep);
//   cout <<"El resultado es: "<< leGanaATodos(e1,e2) << endl;
//}
