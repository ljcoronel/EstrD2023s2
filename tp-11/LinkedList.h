#include <iostream>
using namespace std;

struct NodoL;

struct LinkedListSt;

typedef LinkedListSt* LinkedList; // INV.REP.: el puntero NO es NULL

struct IteratorSt;

typedef IteratorSt* ListIterator; // INV.REP.: el puntero NO es NULL

// Propósito: Crea una lista vacía.
// Costo: O(1).
LinkedList nil();
// Propósito: Indica si la lista está vacía.
// Costo: O(1).
bool isEmpty(LinkedList xs);
// Propósito: Devuelve el primer elemento.
// Precondición: Lista no vacía.
// Costo: O(1).
int head(LinkedList xs);
// Propósito: Agrega un elemento al principio de la lista.
// Costo: O(1).
void Cons(int x, LinkedList xs);
// Propósito: Quita el primer elemento.
// Precondición: Lista no vacía.
// Costo: O(1).
void Tail(LinkedList xs);
// Propósito: Devuelve la cantidad de elementos.
// Costo: O(1).
int length(LinkedList xs);
// Propósito: Agrega un elemento al final de la lista.
// Costo: O(1).
//        O(n) en caso que no haya puntero al ultimo nodo.
void Snoc(int x, LinkedList xs);
// Propósito: Apunta el recorrido al primer elemento.
// Costo: O(1).
ListIterator getIterator(LinkedList xs);
// Propósito: Devuelve el elemento actual en el recorrido.
// Precondición: No está al fin del recorrido.
// Costo: O(1).
int current(ListIterator ixs);
// Propósito: Reemplaza el elemento actual por otro elemento.
// Precondición: No está al fin del recorrido.
// Costo: O(1).
void SetCurrent(int x, ListIterator ixs);
// Propósito: Pasa al siguiente elemento.
// Precondición: No está al fin del recorrido.
// Costo: O(1).
void Next(ListIterator ixs);
// Propósito: Indica si el recorrido ha terminado.
// Costo: O(1).
bool atEnd(ListIterator ixs);
// Propósito: Libera la memoria ocupada por el iterador.
// Costo: O(1).
void DisposeIterator(ListIterator ixs);
// Propósito: Libera la memoria ocupada por la lista.
// Costo: O(n).
void DestroyL(LinkedList xs);
// Propósito: Agrega todos los elementos de la segunda lista al final de los de la primera. La segunda lista se destruye.
// Costo: O(1).
void Append(LinkedList xs, LinkedList ys);
