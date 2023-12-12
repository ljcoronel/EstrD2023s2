#include <iostream>
#include "Queue.h"
using namespace std;

struct NodoQ {
   int elem;         // valor del nodo
   NodoQ* siguiente; // puntero al siguiente nodo
};

struct QueueSt {
   // INV.REP.:
   //          * Cantidad indica la cantidad de nodos que se pueden recorrer desde primero por siguiente hasta alcanzar a NULL.
   //          * Si primero es NULL entonces ultimo es NULL.
   //          * Si ultimo es NULL entonces primero es NULL.
   int cantidad;   // cantidad de elementos
   NodoQ* primero; // puntero al primer nodo
   NodoQ* ultimo;  // puntero al ultimo nodo
};

Queue emptyQ() {
   QueueSt* q = new QueueSt;
   q->cantidad = 0;
   q->primero = NULL;
   q->ultimo = NULL;
   return q;
}

bool isEmptyQ(Queue q) {
   return(q->cantidad == 0);
}

int firstQ(Queue q) {
   return(q->primero->elem);
}

void Enqueue(int x, Queue q) {
   NodoQ* nodo = new NodoQ;
   nodo->elem = x;
   nodo->siguiente = NULL;
   if (q->ultimo == NULL)
         { q->primero = nodo; }
    else { q->ultimo->siguiente = nodo; }
   q->ultimo = nodo;
   q->cantidad++;
}

void Dequeue(Queue q) {
   NodoQ* temp = q->primero;
   q->primero = q->primero->siguiente;
   if (q->primero == NULL) {
     q->ultimo = NULL;
   }
   q->cantidad--;
   delete temp;
}

int lengthQ(Queue q) {
   return(q->cantidad);
}

void MergeQ(Queue q1, Queue q2) {
   if (q1->ultimo == NULL)
         { q1->primero = q2->primero;
           q1->ultimo = q2->ultimo; }
    else { q1->ultimo->siguiente = q2->primero; }
   q1->cantidad += q2->cantidad;
   delete q2;
}

void DestroyQ(Queue q) {
   NodoQ* temp = q->primero;
   while (q->primero != NULL) {
     q->primero = q->primero->siguiente;
     delete temp;
     temp = q->primero;
   }
   delete q;
}
