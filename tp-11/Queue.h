#include <iostream>
using namespace std;

struct NodoQ;

struct QueueSt;

typedef QueueSt* Queue; // INV.REP.: el puntero NO es NULL

// Propósito: Crea una cola vacía.
// Costo: O(1).
Queue emptyQ();
// Propósito: Indica si la cola está vacía.
// Costo: O(1).
bool isEmptyQ(Queue q);
// Propósito: Devuelve el primer elemento.
// Precondición: Cola no vacía.
// Costo: O(1).
int firstQ(Queue q);
// Propósito: Agrega un elemento al final de la cola.
// Costo: O(1).
void Enqueue(int x, Queue q);
// Propósito: Quita el primer elemento de la cola.
// Precondición: Cola no vacía.
// Costo: O(1).
void Dequeue(Queue q);
// Propósito: Devuelve la cantidad de elementos de la cola.
// Costo: O(1).
int lengthQ(Queue q);
// Propósito: Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Costo: O(1).
void MergeQ(Queue q1, Queue q2);
// Propósito: Libera la memoria ocupada por la cola.
// Costo: O(n).
void DestroyQ(Queue q);
