#include <iostream>
#include "ArrayList.h"
using namespace std;

// Ejercicio 4.1
// Propósito: Devuelve la suma de todos los elementos.
int sumatoria(ArrayList xs) {
   int cant = 0;
   for (int i=0; i < lengthAL(xs); i++) {
     cant += get(i,xs);
   }
   return cant;
}

// Ejercicio 4.2
// Propósito: Incrementa en uno todos los elementos.
void sucesores(ArrayList xs) {
   for (int i=0; i < lengthAL(xs); i++) {
     set(i,get(i,xs) + 1,xs);
   }
}

// Ejercicio 4.3
// Propósito: Indica si el elemento pertenece a la lista.
bool pertenece(int x, ArrayList xs) {
   int i = 0;
   while (i < lengthAL(xs) && x != get(i,xs)) {
     i++;
   }
   return(x == get(i,xs));
}

// Ejercicio 4.4
// Propósito: Indica la cantidad de elementos iguales a x.
int apariciones(int x, ArrayList xs) {
   int cant = 0;
   for (int i=0; i < lengthAL(xs); i++) {
     if (x == get(i,xs))
      { cant++; }
   }
   return cant;
}

// Ejercicio 4.5
// Propósito: Crea una nueva lista a partir de la primera y la segunda (en ese orden).
ArrayList append(ArrayList xs, ArrayList ys) {
   ArrayList zs = newArrayListWith(lengthAL(xs) + lengthAL(ys));
   for (int i=0; i < lengthAL(xs); i++) {
     add(get(i,xs),zs);
   }
   for (int i=0; i < lengthAL(ys); i++) {
     add(get(i,ys),zs);
   }
   return zs;
}

// Ejercicio 4.6
// Propósito: Devuelve el elemento más chico de la lista.
int minimo(ArrayList xs) {
   if (lengthAL(xs) > 0)
         { int min = get(0,xs);
           for (int i=1; i < lengthAL(xs); i++)
             { if (min > get(i,xs))
                 { min = get(i,xs); } }
           return min; }
    else { return '\0'; }
}

// Consultas
// ejercicio 3/4 "int get(int i, ArrayList xs)" da 0 cuando no existe el numero en el array
//               "void remove(ArrayList xs)" da 0 cuando se elimina el numero en el array
//               "int minimo(ArrayList xs)" da 0 cuando no hay numeros en el array
//               NULL    '\0'