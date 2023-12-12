#include <iostream>
using namespace std;

struct Tree {
   NodeL* root;
};

struct NodeL {
   NodeL* left;
   NodeL* right;
   int elem;
};

bool perteneceT(int x, Tree t) {
   bool res = false;
   Stack current = empty();
   Push(t->root, current);
   while (!isEmpty(current) && !res) {
     NodeL* temp = top(current);
     res = temp->elem == x;
     Pop(current);
     if (temp->right != NULL) { Push(temp->right,current); }
     if (temp->left != NULL) { Push(temp->left,current); }
   }
   deleteS(current);
   return res;
}

// las iteraciones se contemplan en el stack frame
