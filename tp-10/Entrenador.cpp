#include <iostream>
#include "Entrenador.h"
using namespace std;

struct EntrenadorSt { // INV.REP.: la cantidad de pokemon en el array de pokemon es igual a cantPokemon.
   string nombre;
   Pokemon* pokemon;
   int cantPokemon;
};

Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon) {
   EntrenadorSt* e = new EntrenadorSt;
   e->nombre = nombre;
   e->cantPokemon = cantidad;
   e->pokemon = pokemon;
   return e;
}

string nombreDeEntrenador(Entrenador e) {
   return(e->nombre);
}

int cantidadDePokemon(Entrenador e) {
   return(e->cantPokemon);
}

int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e) {
   int cant = 0;
   for (int i=0; i < e->cantPokemon; i++) {
     if (tipoDePokemon(e->pokemon[i]) == tipo) {
       cant++;
     }
   }
   return cant;
}

Pokemon pokemonNro(int i, Entrenador e) {
   return(e->pokemon[i-1]);
}

bool superaATodos(Pokemon p, Entrenador e) {
   int t = 0;
   while (t < e->cantPokemon && superaA(p, e->pokemon[t])) {
     t++;
   }
   return(t == e->cantPokemon && superaA(p, e->pokemon[t-1]));
}

bool leGanaATodos(Entrenador e1, Entrenador e2) {
   int i = 0;
   if (e1->cantPokemon > 0 && e2->cantPokemon > 0) {
     while (i < e1->cantPokemon && not superaATodos(e1->pokemon[i], e2)) {
        i++;
     }   
   }
   return(i < e1->cantPokemon);
}
