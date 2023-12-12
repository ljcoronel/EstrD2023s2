#include <iostream>
using namespace std;

struct PersonaSt;

typedef PersonaSt* Persona;

// Propósito: Dado un nombre y una edad, devuelve una persona.
Persona consPersona(string nombre, int edad);
// Propósito: Devuelve el nombre de una persona.
string nombre(Persona p);
// Propósito: Devuelve la edad de una persona.
int edad(Persona p);
// Propósito: Aumenta en uno la edad de la persona.
void crecer(Persona p);
// Propósito: Modifica el nombre una persona.
void cambioDeNombre(string nombre, Persona p);
// Propósito: Dadas dos personas indica si la primera es mayor que la segunda.
bool esMayorQueLaOtra(Persona p1, Persona p2);
// Propósito: Dadas dos personas devuelve a la persona que sea mayor.
Persona laQueEsMayor(Persona p1, Persona p2);
