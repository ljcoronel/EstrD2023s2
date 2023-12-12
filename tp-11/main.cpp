#include <iostream>
#include "LinkedList.h"
#include "Set.h"
#include "Queue.h"
#include "Arbol.h"
using namespace std;

int main() {
   Tree t1 = emptyT();
   Tree t2 = emptyT();
   Tree t3 = nodeT(7,t1,t2);
   cout <<"El resultado es: "<< rootT(t3) << endl;
}
