#include <iostream>
using namespace std;

struct NodeT;

typedef NodeT* Tree;

// Propósito: Crea un árbol vacío.
Tree emptyT();
// Propósito: Crea un árbol con el elemento dado e hijos dados.
Tree nodeT(int elem, Tree left, Tree right);
// Propósito: Indica si es un árbol vacío.
bool isEmptyT(Tree t);
// Propósito: Devuelve el elemento de la raíz del árbol.
// Precondición: No es árbol vacío.
int rootT(Tree t);
// Propósito: Devuelve el hijo izquierdo.
Tree left(Tree t);
// Propósito: Devuelve el hijo derecho.
Tree right(Tree t);
