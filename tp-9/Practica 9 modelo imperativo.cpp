#include <iostream>
using namespace std;

// Ejercicio 2.1
// Propósito: imprime los valores que se encuentran entre c1 y c2
// Precondición: c1 < c2
void printFromTo(char c1, char c2) {
   for(int i = 0; c1 + i <= c2; i++) {
      cout << c1 + i << ", ";
   }
   cout << endl;
}
// Ejemplos: sea c1 = 'a', c2 = 'b'; imprime 97, 98, 

// Ejercicio 2.2
// Propósito: devuelve el factorial del número dado
// Precondición: n >= 0
int fc(int n) {
   int x = 1;
   while(n > 0) {
      x = x * n;
      n--;
   }
   return x;
}
// Ejemplos: sea n = 4; retorna 24

// Ejercicio 2.3
// Propósito: devuelve la suma de n con sus sucesores hasta m
// Precondición: n <= m
int ft(int n, int m) {
   if (n == m) {
      return n;
   }
   return n + ft(n+1, m);
}
// Ejemplos: sea n = 0, m = 4; retorna 10

// Mejora
int ft(int n, int m) {
   int x = n;
   while (x < m) {
      x++;
      n += x;
   }
   return(n);
}

// Ejercicio 4.1
// Propósito: imprime n veces un string s.
// Iterativa
void printN(int n, string s) {
   while (n > 0) {
      n--;
      cout << s;
   }
   cout << endl;
}

// Recursiva
void printN(int n, string s) {
   if (n == 0)
        { cout << endl; }
   else { printN((n-1), s);
          cout << s; }
}

// Ejercicio 4.2
// Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
// Iterativa
void cuentaRegresiva(int n) {
   cout << n << endl;
   while (n > 0) {
      n--;
      cout << n << endl;
   }
}

// Recursiva
void cuentaRegresiva(int n) {
   if (n == 0)
         { cout << n << endl; }
    else { cout << n << endl;
           cuentaRegresiva(n-1); }
}

// Ejercicio 4.3
// Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
// Iterativa
void desdeCeroHastaN(int n) {
   int x = 0;
   while (n > x) {
      cout << x << endl;
      x++;
   }
   cout << n << endl;
}

// Recursiva
void desdeMHastaN(int m, int n) {
   if (n == m)
         { cout << n << endl; }
    else { cout << m << endl;
           desdeMHastaN((m+1), n); }
}

void desdeCeroHastaN(int n) {
   int m = 0;
   desdeMHastaN (m, n);
}

// Ejercicio 4.4
// Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
// Iterativa
int mult(int n, int m) {
   int x = m;
   while (n > 0) {
      m += x;
      n--;
   }
   return(m-x);
}

// Recursiva
int mult(int n, int m) {
   if (n == 0)
         { return(n); }
    else { return(m + mult((n-1),m)); }
}

// Ejercicio 4.5
// Propósito: imprime los primeros n char del string s, separados por un salto de línea.
// Precondición: el string tiene al menos n char.
// Iterativa
void primerosN(int n, string s) {
   for (int i=0; i<n; i++) {
      cout << s[i] << endl;
   }
   cout << endl;
}

// Recursiva
void primerosNDesdeI(int i, int n, string s) {
   if (n == i)
         { cout << endl; }
    else { cout << s[i] << endl;
           primerosNDesdeI((i+1), n, s); }
}

void primerosN(int n, string s) {
   int i = 0;
   primerosNDesdeI(i, n, s);
}

// Ejercicio 4.6
// Propósito: indica si un char c aparece en el string s.
// Iterativa
bool pertenece(char c, string s) {
   int i = 0;
   while (s[i] != c && s[i] != '\0') {
      i++;
   }
   return(c == s[i]);
}

// Recursiva
bool perteneceEnLongitud(char c, string s, int i) {
   if (c != s[i] && s[i] != '\0')
         { return(perteneceEnLongitud(c, s, (i+1))); }
    else { return(c == s[i]); }
}

bool pertenece(char c, string s) {
   int i = 0;
   return(perteneceEnLongitud(c, s, i));
}

// Ejercicio 4.7
// Propósito: devuelve la cantidad de apariciones de un char c en el string s.
// Iterativa
int apariciones(char c, string s) {
   int i = 0;
   int cant = 0;
   while (s[i] != '\0') {
      if (c == s[i]) {
         cant++;
      }
      i++;
   }
   return(cant);
}

// Recursiva
int aparicionesEnLongitud(char c, string s, int i) {
   if (s[i] != '\0') {
      if (c == s[i])
            { return(1 + aparicionesEnLongitud(c, s, (i+1))); }
       else { return(aparicionesEnLongitud(c, s, (i+1))); }
   }
   return(0);
}

int apariciones(char c, string s) {
   return(aparicionesEnLongitud(c, s, 0));
}

// CONSULTAS
// 5.simplificada
//euclides algoritmo
