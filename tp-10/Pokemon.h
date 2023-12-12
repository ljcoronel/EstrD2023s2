#include <iostream>
using namespace std;

typedef string TipoDePokemon;

struct PokeSt;

typedef PokeSt* Pokemon;

// Propósito: Dado un tipo devuelve un pokémon con 100 % de energía.
Pokemon consPokemon(TipoDePokemon tipo);
// Propósito: Devuelve el tipo de un pokémon.
TipoDePokemon tipoDePokemon(Pokemon p);
// Propósito: Devuelve el porcentaje de energía.
int energia(Pokemon p);
// Propósito: Le resta energía al pokémon.
void perderEnergia(int energia, Pokemon p);
// Propósito: Dados dos pokémon indica si el primero, en base al tipo, es superior al segundo. Agua supera a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
bool superaA(Pokemon p1, Pokemon p2);
