#include <iostream>
#include "Pokemon.h"
using namespace std;

struct EntrenadorSt;

typedef EntrenadorSt* Entrenador;

// Propósito: Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve un entrenador.
Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon);
// Propósito: Devuelve el nombre del entrenador.
string nombreDeEntrenador(Entrenador e);
// Propósito: Devuelve la cantidad de pokémon que posee el entrenador.
int cantidadDePokemon(Entrenador e);
// Propósito: Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.
int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e);
// Propósito: Devuelve el pokémon número i de los pokémon del entrenador.
// Precondición: existen al menos i − 1 pokémon.
Pokemon pokemonNro(int i, Entrenador e);
// Propósito: Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero posee al menos un pokémon que le gane.
bool leGanaATodos(Entrenador e1, Entrenador e2);
