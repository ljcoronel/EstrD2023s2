#include <iostream>
using namespace std;

struct ArrayListSt;

typedef ArrayListSt* ArrayList;

// Propósito: Crea una lista con 0 elementos.
ArrayList newArrayList();
// Propósito: Crea una lista con 0 elementos y una capacidad dada por parámetro.
ArrayList newArrayListWith(int capacidad);
// Propósito: Devuelve la cantidad de elementos existentes.
int lengthAL(ArrayList xs);
// Propósito: Devuelve el iésimo elemento de la lista.
int get(int i, ArrayList xs);
// Propósito: Reemplaza el iésimo elemento por otro dado.
void set(int i, int x, ArrayList xs);
// Propósito: Decrementa o aumenta la capacidad del array.
void resize(int capacidad, ArrayList xs);
// Propósito: Agrega un elemento al final de la lista.
void add(int x, ArrayList xs);
// Propósito: Borra el último elemento de la lista.
void remove(ArrayList xs);
