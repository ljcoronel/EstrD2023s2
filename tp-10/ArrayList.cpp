#include <iostream>
#include "ArrayList.h"
using namespace std;

struct ArrayListSt { // INV.REP.: * cantidad <= capacidad. * la cantidad de elementos en el array de elementos es igual a cantidad.
   int cantidad;   // cantidad de elementos
   int* elementos; // array de elementos
   int capacidad;  // tamaño del array
};

ArrayList newArrayList() {
   ArrayListSt* xs = new ArrayListSt;
   xs->cantidad = 0;
   xs->elementos = new int[xs->capacidad];
   xs->capacidad = 16;
   return xs;
}

ArrayList newArrayListWith(int capacidad) {
   ArrayListSt* xs = new ArrayListSt;
   xs->cantidad = 0;
   xs->elementos = new int[capacidad];
   xs->capacidad = capacidad;
   return xs;
}

int lengthAL(ArrayList xs) {
   return(xs->cantidad);
}

int get(int i, ArrayList xs) {
   if (i < xs->cantidad)
         { return(xs->elementos[i]); }
    else { return '\0'; }
}

void set(int i, int x, ArrayList xs) {
   if (i < xs->cantidad) {
     xs->elementos[i] = x;
   }
}

void resize(int capacidad, ArrayList xs) {
   int* temp = new int[capacidad];
   if (capacidad <= xs->cantidad)
         { for (int i=0; i < capacidad; i++)
             { temp[i] = xs->elementos[i]; }
           xs->cantidad = capacidad; }
    else { for (int i=0; i < xs->cantidad; i++)
             { temp[i] = xs->elementos[i]; } }
   delete xs->elementos;
   xs->capacidad = capacidad;
   xs->elementos = temp;
}

void add(int x, ArrayList xs) {
   if (xs->cantidad == xs->capacidad) {
     int* temp = new int[xs->capacidad*2];
     for (int i=0; i < xs->capacidad; i++)
       { temp[i] = xs->elementos[i]; }
     delete xs->elementos;
     xs->capacidad = xs->capacidad*2;
     xs->elementos = temp;
   }
   xs->elementos[xs->cantidad++] = x;
}

void remove(ArrayList xs) {
   xs->elementos[xs->cantidad-1] = '\0';
   xs->cantidad--;
}
