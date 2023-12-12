#include <iostream>
#include "LinkedList.h"
#include "Arbol.h"
#include "ArrayList.h"
#include "Queue.h"
using namespace std;

// Ejercicio 2.1
// Propósito: Devuelve la suma de todos los elementos.
// Costo: O(n)
int sumatoria(LinkedList xs) {
   int total = 0;
   ListIterator ixs = getIterator(xs);
   while (!atEnd(ixs)) {
     total += current(ixs);
     Next(ixs);
   }
   DisposeIterator(ixs);
   return total;
}

// Ejercicio 2.2
// Propósito: Incrementa en uno todos los elementos.
// Costo: O(n)
void Sucesores(LinkedList xs) {
   ListIterator ixs = getIterator(xs);
   while (!atEnd(ixs)) {
     SetCurrent(current(ixs) + 1,ixs);
     Next(ixs);
   }
   DisposeIterator(ixs);
}

// Ejercicio 2.3
// Propósito: Indica si el elemento pertenece a la lista.
// Costo: O(n)
bool pertenece(int x, LinkedList xs) {
   ListIterator ixs = getIterator(xs);
   while (!atEnd(ixs) && (x != current(ixs))) {
     Next(ixs);
   }
   bool b = !atEnd(ixs);
   DisposeIterator(ixs);
   return b;
}

// Ejercicio 2.4
// Propósito: Indica la cantidad de elementos iguales a x.
// Costo: O(n)
int apariciones(int x, LinkedList xs) {
   int total = 0;
   ListIterator ixs = getIterator(xs);
   while (!atEnd(ixs)) {
     if (x == current(ixs)) {
       total++;
     }
     Next(ixs);
   }
   DisposeIterator(ixs);
   return total;
}

// Ejercicio 2.5
// Propósito: Devuelve el elemento más chico de la lista.
// Precondición: Lista no vacía.
// Costo: O(n)
int minimo(LinkedList xs) {
   ListIterator ixs = getIterator(xs);
   int min = current(ixs);
   while (!atEnd(ixs)) {
     if (min > current(ixs)) {
       min = current(ixs);
     }
     Next(ixs);
   }
   DisposeIterator(ixs);
   return min;
}

// Ejercicio 2.6
// Propósito: Dada una lista genera otra con los mismos elementos, en el mismo orden.
// Costo: O(n) siendo Snoc O(1)
//        O(n^2) siendo Snoc O(n)
LinkedList copy(LinkedList xs) {
   LinkedList ys = nil();
   ListIterator ixs = getIterator(xs);
   while (!atEnd(ixs)) {
     Snoc(current(ixs),ys);
     Next(ixs);
   }
   DisposeIterator(ixs);
   return ys;
}

// Ejercicio 2.7
// Propósito: Agrega todos los elementos de la segunda lista al final de los de la primera. La segunda lista se destruye.
// Costo: O(n) siendo Snoc O(1)
//        O(n^2) siendo Snoc O(n)
void Append(LinkedList xs, LinkedList ys) {
   ListIterator iys = getIterator(ys);
   while (!atEnd(iys)) {
     Snoc(current(iys),xs);
     Next(iys);
   }
   DisposeIterator(iys);
   DestroyL(ys);
}

// Ejercicio 7.1
// Propósito: Dado un árbol binario de enteros devuelve la suma entre sus elementos.
int sumarT(Tree t) {
   if (isEmptyT(t)) {
     return 0;
   } else {
     return(rootT(t) + sumarT(left(t)) + sumarT(right(t)));
   }
}

// Ejercicio 7.2
// Propósito: Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
int sizeT(Tree t) {
   if (isEmptyT(t)) {
     return 0;
   } else {
     return(1 + sizeT(left(t)) + sizeT(right(t)));
   }
}

// Ejercicio 7.3
// Propósito: Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
bool perteneceT(int e, Tree t) {
   if (isEmptyT(t)) {
     return false;
   } else {
     return((e == rootT(t)) || perteneceT(e,left(t)) || perteneceT(e,right(t)));
   }
}

// Ejercicio 7.4
int unoSi(bool c) {
   if (c) { return 1; }
   else   { return 0; }
}

// Propósito: Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
int aparicionesT(int e, Tree t) {
   if (isEmptyT(t)) {
     return 0;
   } else {
     return(unoSi(e == rootT(t)) + aparicionesT(e,left(t)) + aparicionesT(e,right(t)));
   }
}

// Ejercicio 7.5
// Propósito: Dado un árbol devuelve su altura.
int heightT(Tree t) {
   if (isEmptyT) {
     return 0;
   } else {
     return(1 + max(heightT(left(t)), heightT(right(t))));
   }
}

// Ejercicio 7.6
void AgregarElementosEn(Tree t, ArrayList xs) {
   if (!isEmptyT(t)) {
     add(rootT(t),xs);
     AgregarElementosEn(left(t),xs);
     AgregarElementosEn(right(t),xs);
   }
}

// Propósito: Dado un árbol devuelve una lista con todos sus elementos.
ArrayList toList(Tree t) {
   ArrayList vistosHastaAhora = newArrayList();
   AgregarElementosEn(t, vistosHastaAhora);
   return vistosHastaAhora;
}

// Ejercicio 7.7
void AgregarElementosDeHojasEn(Tree t, ArrayList xs) {
   if (!isEmptyT(t)) {
     if (isEmptyT(left(t)) && isEmptyT(right(t))) {
       add(rootT(t),xs);
     } else {
       AgregarElementosDeHojasEn(left(t),xs);
       AgregarElementosDeHojasEn(right(t),xs);
     }
   }
}

// Propósito: Dado un árbol devuelve los elementos que se encuentran en sus hojas.
ArrayList leaves(Tree t) {
   ArrayList vistosHastaAhora = newArrayList();
   AgregarElementosDeHojasEn(t, vistosHastaAhora);
   return vistosHastaAhora;
}

// Ejercicio 7.8
void AgregarElementosDeNivelEn(int n, Tree t, ArrayList xs) {
   if (!isEmptyT(t) && (n != 0)) {
     AgregarElementosDeNivelEn((n-1),left(t),xs);
     AgregarElementosDeNivelEn((n-1),right(t),xs);
   } else {
     add(rootT(t),xs);
   }
}

// Propósito: Dados un número n y un árbol devuelve una lista con los nodos de nivel n.
ArrayList levelN(int n, Tree t) {
   ArrayList vistosHastaAhora = newArrayList();
   AgregarElementosDeNivelEn(n,t,vistosHastaAhora);
   return vistosHastaAhora;
}

// Ejercicio 8.1
void EncolarArbol(Tree t, Queue q) {
   if (!isEmptyT(t)) {
     Enqueue(t,q);
   }
}

// Propósito: Dado un árbol binario de enteros devuelve la suma entre sus elementos.
int sumarT(Tree t) {
   int total = 0;
   Queue q = emptyQ();
   EncolarArbol(t,q);
   while (!isEmptyQ(q)) {
     total += rootT(firstQ(q));
     Dequeue(q);
     EncolarArbol(left(firstQ(q)),q);
     EncolarArbol(right(firstQ(q)),q);
   }
   DestroyQ(q);
   return total;
}

// Ejercicio 8.2
// Propósito: Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size en inglés).
int sizeT(Tree t) {
   int cant = 0;
   Queue q = emptyQ();
   EncolarArbol(t,q);
   while (!isEmptyQ(q)) {
     cant ++;
     Dequeue(q);
     EncolarArbol(left(firstQ(q)),q);
     EncolarArbol(right(firstQ(q)),q);
   }
   DestroyQ(q);
   return cant;
}

// Ejercicio 8.3
// Propósito: Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
bool perteneceT(int e, Tree t) {
   Queue q = emptyQ();
   EncolarArbol(t,q);
   while (!isEmptyQ(q) && (e != rootT(firstQ(q)))) {
     Dequeue(q);
     EncolarArbol(left(firstQ(q)),q);
     EncolarArbol(right(firstQ(q)),q);
   }
   bool b = !isEmptyQ() && (e == rootT(firstQ(q)));
   DestroyQ(q);
   return b;
}

// Ejercicio 8.4
// Propósito: Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son iguales a e.
int aparicionesT(int e, Tree t) {
   int cant = 0;
   Queue q = emptyQ();
   EncolarArbol(t,q);
   while (!isEmptyQ(q)) {
     if (e == rootT(firstQ(q))) { cant++; }
     Dequeue(q);
     EncolarArbol(left(firstQ(q)),q);
     EncolarArbol(right(firstQ(q)),q);
   }
   DestroyQ(q);
   return cant;
}

// Ejercicio 8.5
// Propósito: Dado un árbol devuelve una lista con todos sus elementos.
ArrayList toList(Tree t) {
   ArrayList xs = newArrayList();
   Queue q = emptyQ();
   EncolarArbol(t,q);
   while (!isEmptyQ(q)) {
     add(rootT(firstQ(q)),xs);
     Dequeue(q);
     EncolarArbol(left(firstQ(q)),q);
     EncolarArbol(right(firstQ(q)),q);
   }
   DestroyQ(q);
   return xs;
}


//Consultas

// Linked Lists
// Snoc SIN PUNTERO AL ULTIMO:
void Snoc(int x, LinkedList xs) {
   NodoL* nodo = new NodoL;
   nodo->elem = x;
   nodo->siguiente = NULL;
   NodoL* current = xs->primero;
   while (current != NULL) {
     current = current->siguiente;
   }
   current = nodo;
   xs->cantidad++;
}
// operaciones parciales
// head, Tail, current, SetCurrent, Next, minimo(usuario)

// Set
// addS (usa belongsS)
// RemovesS (usa dos variables)

// Queue
// operaciones parciales
// firstQ, Dequeue

// Arbol
// rootT parcial