#include <iostream>
#include "Set.h"
using namespace std;

struct NodoS {
   int elem;         // valor del nodo
   NodoS* siguiente; // puntero al siguiente nodo
};

struct SetSt {     // INV.REP.: Cantidad indica la cantidad de nodos que se pueden recorrer desde primero por siguiente hasta alcanzar a NULL.
   int cantidad;   // cantidad de elementos diferentes
   NodoS* primero; // puntero al primer nodo
};

Set emptyS() {
   SetSt* s = new SetSt;
   s->cantidad = 0;
   s->primero = NULL;
   return s;
}

bool isEmptyS(Set s) {
   return(s->cantidad == 0);
}

bool belongsS(int x, Set s) {
   NodoS* current = s->primero;
   while ((current != NULL) && (x != current->elem)) {
     current = current->siguiente;
   }
   return(current != NULL);
}

void AddS(int x, Set s) {
   if (!belongsS(x,s)) {
     NodoS* nodo = new NodoS;
     nodo->elem = x;
     nodo->siguiente = s->primero;
     s->primero = nodo;
     s->cantidad++;
   }
}

void RemoveS(int x, Set s) {
   NodoS* temp = s->primero;
   NodoS* current;
   while ((temp != NULL) && (x != temp->elem)) {
     current = temp;
     temp = temp->siguiente;
   }
   if (temp != NULL) {
     current = temp->siguiente;
     delete temp;
     s->primero = current;
     s->cantidad--;
   }
}

int sizeS(Set s) {
   return(s->cantidad);
}

LinkedList setToList(Set s) {
   LinkedList xs = nil();
   NodoS* current = s->primero;
   while (current != NULL) {
     Cons(current->elem,xs);
     current = current->siguiente;
   }
   return xs;
}

void DestroyS(Set s) {
   NodoS* temp = s->primero;
   while (s->primero != NULL) {
     s->primero = s->primero->siguiente;
     delete temp;
     temp = s->primero;
   }
   delete s;
}
