#include "UFSet.h"

/*
 * UFSet.cpp contiene la implementación de la interfaz para UFSet declarada en UFSet.h. 
 * Deben implementarse las operaciones de acuerdo a la representación elegida para el tipo UFSet.
 */

/* El tipo UFNode* representa:
 *  1. un elemento de un UFSet (o sea, un nodo del árbol que contiene a todos los elementos del conjunto)
 *  2. al conjunto en su totalidad, si el nodo es la raíz del arbol
 *
 *  El nodo tiene un puntero a su elemento asociado en el campo element. 
 *  Deberán agregarse los campos necesarios para completar la representación.
 */

/* Primera implementación
struct UFNode {
   // INV.REP.:
   //          * parent es un puntero hacia un UFNode de mayor rango.
   //          * Si el UFNode es la raíz del árbol entonces el puntero a su padre es el mismo nodo.
   ELEM_TYPE element; // valor del nodo
   UFNode* parent;    // puntero al padre del nodo
};


// * Inicializa el UFSet ufset, cuyo valor asociado será value 

UFSet createUFS(ELEM_TYPE value) {
   UFNode* ufset = new UFNode;
   ufset->element = value;
   ufset->parent = ufset;
   return ufset;
}

ELEM_TYPE elemUFS(UFSet ufset) {
   return(ufset->element);
}


// * Encuentra el elemento distinguido para el UFSet dado. 
// * Esta operación puede ser optimizada con la técnica de compresión de camino.

UFSet findUFS(UFSet elem) {
   while (elem->parent != elem) {
     elem = elem->parent;
   }
   return elem;
}


// * Calcula la unión entre los conjuntos ufset1 y ufset2. 
// * Esta operación puede ser optimizada con la técnica de unión por rango.

void unionUFS(UFSet ufset1, UFSet ufset2) {
   ufset1 = findUFS(ufset1);
   ufset2 = findUFS(ufset2);
   ufset2->parent = ufset1;
}
 */

// Optimizada
struct UFNode {
   // INV.REP.:
   //          * parent es un puntero hacia un UFNode de mayor rango.
   //          * Si el UFNode es la raíz del árbol entonces el puntero a su padre es el mismo nodo.
   //          * El rango es la cantidad de hijos que hay desde el nodo distinguido hasta la hoja de su rama más larga.
   //          * Si el conjunto se compone de un solo UFNode el rango del nodo distinguido es 0.
   ELEM_TYPE element; // valor del nodo
   UFNode* parent;    // puntero al padre del nodo
   int rank;          // distancia al nodo distinguido
};

/* 
 * Inicializa el UFSet ufset, cuyo valor asociado será value 
 */
UFSet createUFS(ELEM_TYPE value) {
   UFNode* ufset = new UFNode;
   ufset->element = value;
   ufset->parent = ufset;
   ufset->rank = 0;
   return ufset;
}

ELEM_TYPE elemUFS(UFSet ufset) {
   return(ufset->element);
}

/*
 * Encuentra el elemento distinguido para el UFSet dado. 
 * Esta operación puede ser optimizada con la técnica de compresión de camino.
 * OBS: no se puede ajustar el rango puesto que un UFNode no conoce a sus hijos, por lo tanto no hay forma de determinar si la rama que estoy recorriendo es la rama mas larga.
 */
UFSet findUFS(UFSet elem) {
   UFNode* currentRaiz = elem;
   while (currentRaiz->parent != currentRaiz) {
     currentRaiz = currentRaiz->parent;
   }
   UFNode* currentPadre;
   while (elem->parent != elem) {
     currentPadre = elem->parent;
     elem->parent = currentRaiz;
     elem = currentPadre;
   }
   return elem;
}

/*
 * Calcula la unión entre los conjuntos ufset1 y ufset2. 
 * Esta operación puede ser optimizada con la técnica de unión por rango.
 */
void unionUFS(UFSet ufset1, UFSet ufset2) {
   ufset1 = findUFS(ufset1);
   ufset2 = findUFS(ufset2);
   if (ufset1 != ufset2) {
     if (ufset1->rank == ufset2->rank) {
       ufset2->parent = ufset1;
       ufset1->rank++;
     } else { if (ufset1->rank > ufset2->rank) {
                ufset2->parent = ufset1;
              } else {
                ufset1->parent = ufset2;
              } }
   }
}

/* FORMA RECURSIVA
// PRIMERA IMPLEMENTACIÓN
UFSet findUFS(UFSet elem) {
   if (elem->parent != elem) {
      return(findUFS(elem->parent));
   }
   return elem;
}

// OPTIMIZADA
UFSet findUFS(UFSet elem) {
   if (elem->parent != elem) {
      elem->parent = findUFS(elem-parent);
   }
   return elem;
}
*/
