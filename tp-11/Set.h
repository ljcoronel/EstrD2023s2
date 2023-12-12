#include <iostream>
#include "LinkedList.h"
using namespace std;

struct NodoS;

struct SetSt;

typedef SetSt* Set; // INV.REP.: el puntero NO es NULL

// Propósito: Crea un conjunto vacío.
// Costo: O(1).
Set emptyS();
// Propósito: Indica si el conjunto está vacío.
// Costo: O(1).
bool isEmptyS(Set s);
// Propósito: Indica si el elemento pertenece al conjunto.
// Costo: O(n).
bool belongsS(int x, Set s);
// Propósito: Agrega un elemento al conjunto.
// Costo: O(n).
void AddS(int x, Set s);
// Propósito: Quita un elemento dado.
// Costo: O(n).
void RemoveS(int x, Set s);
// Propósito: Devuelve la cantidad de elementos.
// Costo: O(1).
int sizeS(Set s);
// Propósito: Devuelve una lista con los lementos del conjunto.
// Costo: O(1).
LinkedList setToList(Set s);
// Propósito: Libera la memoria ocupada por el conjunto.
// Costo: O(n).
void DestroyS(Set s);
