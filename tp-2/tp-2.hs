-- ejercicio 1.1
sumatoria :: [Int] -> Int
sumatoria []       = 0
sumatoria (n : ns) = n + sumatoria ns

-- ejercicio 1.2
longitud :: [a] -> Int
longitud []       = 0
longitud (x : xs) = 1 + longitud xs

-- ejercicio 1.3
sucesores :: [Int] -> [Int]
sucesores []       = []
sucesores (n : ns) = n + 1 : sucesores ns

-- ejercicio 1.4
conjuncion :: [Bool] -> Bool
conjuncion []       = True
conjuncion (b : bs) = b && conjuncion bs

-- ejercicio 1.5
disyuncion :: [Bool] -> Bool
disyuncion []       = False
disyuncion (b : bs) = b || disyuncion bs

-- ejercicio 1.6
aplanar :: [[a]] -> [a]
aplanar []       = []
aplanar (x : xs) = x ++ aplanar xs

-- ejercicio 1.7
pertenece :: Eq a => a -> [a] -> Bool
pertenece e []       = False
pertenece e (x : xs) = e == x || pertenece e xs

-- ejercicio 1.8
apariciones :: Eq a => a -> [a] -> Int
apariciones e []       = 0
apariciones e (x : xs) = unoSi (e == x) + apariciones e xs

unoSi :: Bool -> Int
unoSi True = 1
unoSi _    = 0

-- ejercicio 1.9
losMenoresA :: Int -> [Int] -> [Int]
losMenoresA n []       = []
losMenoresA n (x : xs) = singularSi x (n > x) ++ losMenoresA n xs

singularSi :: a -> Bool -> [a]
singularSi x True  = x : []
singularSi _ _     = []

-- ejercicio 1.10
lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
lasDeLongitudMayorA n []       = []
lasDeLongitudMayorA n (x : xs) = singularSi x (n < longitud x) ++ lasDeLongitudMayorA n xs

-- ejercicio 1.11
agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal []       a = [a]
agregarAlFinal (x : xs) a = x : agregarAlFinal xs a

-- ejercicio 1.12
agregar :: [a] -> [a] -> [a]
agregar []       ys = ys
agregar (x : xs) ys = x : agregar xs ys

-- ejercicio 1.13
reversa :: [a] -> [a]
reversa []       = []
reversa (x : xs) = reversa xs ++ [x]

-- ejercicio 1.14
zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos []       xs       = xs
zipMaximos xs        []      = xs
zipMaximos (x : xs) (y : ys) = maximoEntre x y : zipMaximos xs ys

maximoEntre :: Int -> Int -> Int
maximoEntre n1 n2 = if n1 > n2
                     then n1
                     else n2

-- ejercicio 1.15
elMinimo :: Ord a => [a] -> a
-- PRECOND: la lista no es vacía
elMinimo []       = error "Es una lista vacia"
elMinimo (x : []) = x
elMinimo (x : xs) = minimoEntre x (elMinimo xs)

minimoEntre :: Ord a => a -> a -> a
minimoEntre e1 e2 = if e1 < e2
                     then e1
                     else e2

-- ejercicio 2.1
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

-- ejercicio 2.2
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva 0 = []
cuentaRegresiva n = n : cuentaRegresiva (n-1)

-- ejercicio 2.3
repetir :: Int -> a -> [a]
repetir 0 _ = []
repetir n e = e : repetir (n-1) e

-- ejercicio 2.4
losPrimeros :: Int -> [a] -> [a]
losPrimeros 0 _        = []
losPrimeros _ []       = []
losPrimeros n (x : xs) = x : losPrimeros (n-1) xs

-- ejercicio 2.5
sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros 0 xs       = xs
sinLosPrimeros _ []       = []
sinLosPrimeros n (_ : xs) = sinLosPrimeros (n-1) xs

-- ejercicio 3.1
data Persona = ConsPersona String Int
              --           Nombre Edad
     deriving Show

-- ejercicio 3.1.a
mayoresA :: Int -> [Persona] -> [Persona]
mayoresA _ []       = []
mayoresA n (p : ps) = singularSi p (esMayorA (edad p) n) ++ mayoresA n ps

esMayorA :: Int -> Int -> Bool
esMayorA n1 n2 = n1 > n2

edad :: Persona -> Int
edad (ConsPersona _ e) = e

-- ejercicio 3.1.b
promedioEdad :: [Persona] -> Int
-- PRECOND: la lista no es vacía
promedioEdad [] = error "Es una lista vacia"
promedioEdad ps = div (sumatoria (edades ps)) (longitud ps)

edades :: [Persona] -> [Int]
edades []       = []
edades (p : ps) = edad p : edades ps

-- ejercicio 3.1.c
elMasViejo :: [Persona] -> Persona
-- PRECOND: la lista no es vacía
elMasViejo []       = error "Es una lista vacia"
elMasViejo (p : []) = p
elMasViejo (p : ps) = laPersonaMasViejaEntre p (elMasViejo ps)

laPersonaMasViejaEntre :: Persona -> Persona -> Persona
laPersonaMasViejaEntre p1 p2 = if esMayorQueLaOtra p1 p2
                                then p1
                                else p2

esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra p1 p2 = edad p1 > edad p2

-- ejercicio 3.2
data TipoDePokemon = Agua | Fuego | Planta
     deriving Show

data Pokemon = ConsPokemon TipoDePokemon Int
     deriving Show

data Entrenador = ConsEntrenador String [Pokemon]
     deriving Show

-- ejercicio 3.2.a
cantPokemon :: Entrenador -> Int
cantPokemon e = longitud (pokemonsDelEntrenador e)

pokemonsDelEntrenador :: Entrenador -> [Pokemon]
pokemonsDelEntrenador (ConsEntrenador _ ps) = ps

-- ejercicio 3.2.b
cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe t e = cantidadDePokemonTipo (pokemonsDelEntrenador e) t

cantidadDePokemonTipo :: [Pokemon] -> TipoDePokemon -> Int
cantidadDePokemonTipo []       t = 0
cantidadDePokemonTipo (p : ps) t = unoSi (sonDelMismoTipo (tipoDelPokemon p) t) + cantidadDePokemonTipo ps t

tipoDelPokemon :: Pokemon -> TipoDePokemon
tipoDelPokemon (ConsPokemon t _) = t

sonDelMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
sonDelMismoTipo Agua   Agua   = True
sonDelMismoTipo Fuego  Fuego  = True
sonDelMismoTipo Planta Planta = True
sonDelMismoTipo _      _      = False

-- ejercicio 3.2.c
cuantosDeTipo_De_LeGananATodosLosDe_ :: TipoDePokemon -> Entrenador -> Entrenador -> Int
cuantosDeTipo_De_LeGananATodosLosDe_ t e1 e2 = cantidadDePokemonQueLeGananA (pokemonsDeTipo (pokemonsDelEntrenador e1) t) (pokemonsDelEntrenador e2)

cantidadDePokemonQueLeGananA :: [Pokemon] -> [Pokemon] -> Int
cantidadDePokemonQueLeGananA []         _   = 0
cantidadDePokemonQueLeGananA (p1 : ps1) ps2 = unoSi (superaATodos p1 ps2) + cantidadDePokemonQueLeGananA ps1 ps2

pokemonsDeTipo :: [Pokemon] -> TipoDePokemon -> [Pokemon]
pokemonsDeTipo []       t = []
pokemonsDeTipo (p : ps) t = singularSi p (sonDelMismoTipo (tipoDelPokemon p) t) ++ pokemonsDeTipo ps t

superaATodos :: Pokemon -> [Pokemon] -> Bool
superaATodos _  []        = True
superaATodos p1 (p2 : ps) = (superaA p1 p2) && (superaATodos p1 ps)

superaA :: Pokemon -> Pokemon -> Bool
superaA p1 p2 = esMejorTipoQue (tipoDelPokemon p1) (tipoDelPokemon p2)

esMejorTipoQue :: TipoDePokemon -> TipoDePokemon -> Bool
esMejorTipoQue Agua   Fuego  = True
esMejorTipoQue Fuego  Planta = True
esMejorTipoQue Planta Agua   = True
esMejorTipoQue _      _      = False

-- ejercicio 3.2.d
esMaestroPokemon :: Entrenador -> Bool
esMaestroPokemon e = hayUnoDeCadaTipo (pokemonsDelEntrenador e)

hayUnoDeCadaTipo :: [Pokemon] -> Bool
hayUnoDeCadaTipo ps = hayAlMenosUnoDeAgua ps && hayAlMenosUnoDeFuego ps && hayAlMenosUnoDePlanta ps

hayAlMenosUnoDeAgua :: [Pokemon] -> Bool
hayAlMenosUnoDeAgua []       = False
hayAlMenosUnoDeAgua (p : ps) = esDeTipoAgua p || hayAlMenosUnoDeAgua ps

esDeTipoAgua :: Pokemon -> Bool
esDeTipoAgua (ConsPokemon Agua _) = True
esDeTipoAgua _                    = False

hayAlMenosUnoDeFuego :: [Pokemon] -> Bool
hayAlMenosUnoDeFuego []       = False
hayAlMenosUnoDeFuego (p : ps) = esDeTipoFuego p || hayAlMenosUnoDeFuego ps

esDeTipoFuego :: Pokemon -> Bool
esDeTipoFuego (ConsPokemon Fuego _) = True
esDeTipoFuego _                     = False

hayAlMenosUnoDePlanta :: [Pokemon] -> Bool
hayAlMenosUnoDePlanta []       = False
hayAlMenosUnoDePlanta (p : ps) = esDeTipoPlanta p || hayAlMenosUnoDePlanta ps

esDeTipoPlanta :: Pokemon -> Bool
esDeTipoPlanta (ConsPokemon Planta _) = True
esDeTipoPlanta _                      = False

-- ejercicio 3.3
data Seniority = Junior | SemiSenior | Senior
     deriving Show

data Proyecto = ConsProyecto String
     deriving Show

data Rol = Developer Seniority Proyecto | Management Seniority Proyecto
     deriving Show

data Empresa = ConsEmpresa [Rol]
     deriving Show

-- ejercicio 3.3.a
proyectos :: Empresa -> [Proyecto]
proyectos (ConsEmpresa rs) = proyectosSinRepetir (proyectosDeLosRoles rs)

proyectosDeLosRoles :: [Rol] -> [Proyecto]
proyectosDeLosRoles []       = []
proyectosDeLosRoles (r : rs) = proyectoDelRol r : proyectosDeLosRoles rs

proyectoDelRol :: Rol -> Proyecto
proyectoDelRol (Developer _ p)  = p
proyectoDelRol (Management _ p) = p

proyectosSinRepetir :: [Proyecto] -> [Proyecto]
proyectosSinRepetir []       = []
proyectosSinRepetir (p : ps) = singularSi p (not (hayProyectoConElMismoNombreEn p (proyectosSinRepetir ps))) ++ proyectosSinRepetir ps

hayProyectoConElMismoNombreEn :: Proyecto -> [Proyecto] -> Bool
hayProyectoConElMismoNombreEn _  []        = False
hayProyectoConElMismoNombreEn p1 (p2 : ps) = tienenElMismoNombre p1 p2 || hayProyectoConElMismoNombreEn p1 ps

nombreDelProyecto :: Proyecto -> [Char]
nombreDelProyecto (ConsProyecto n) = n

tienenElMismoNombre :: Proyecto -> Proyecto -> Bool
tienenElMismoNombre p1 p2 = nombreDelProyecto p1 == nombreDelProyecto p2

-- ejercicio 3.3.b
losDevSenior :: Empresa -> [Proyecto] -> Int
losDevSenior e ps = cantidadDeSeniorConProyectosEn (desarrolladoresSeniors (desarrolladoresDeLaEmpresa e)) ps

desarrolladoresDeLaEmpresa :: Empresa -> [Rol]
desarrolladoresDeLaEmpresa (ConsEmpresa rs) = rs

desarrolladoresSeniors :: [Rol] -> [Rol]
desarrolladoresSeniors []        = []
desarrolladoresSeniors (r : rs)  = singularSi r (esSenior (seniorityDelRol r) && esDeveloper r) ++ desarrolladoresSeniors rs

esDeveloper :: Rol -> Bool
esDeveloper (Developer _ _) = True
esDeveloper _               = False

seniorityDelRol :: Rol -> Seniority
seniorityDelRol (Developer  s _) = s
seniorityDelRol (Management s _) = s

esSenior :: Seniority -> Bool
esSenior Senior = True
esSenior _      = False

cantidadDeSeniorConProyectosEn :: [Rol] -> [Proyecto] -> Int
cantidadDeSeniorConProyectosEn []        _  = 0
cantidadDeSeniorConProyectosEn (r : rs)  ps = unoSi (hayProyectoConElMismoNombreEn (proyectoDelRol r) ps) + cantidadDeSeniorConProyectosEn rs ps

-- ejericio 3.3.c
cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
cantQueTrabajanEn ps e = cantidadDeRolesConProyectoEn (desarrolladoresDeLaEmpresa e) ps

cantidadDeRolesConProyectoEn :: [Rol] -> [Proyecto] -> Int
cantidadDeRolesConProyectoEn []        _  = 0
cantidadDeRolesConProyectoEn (r : rs)  ps = unoSi (hayProyectoConElMismoNombreEn (proyectoDelRol r) ps) + cantidadDeRolesConProyectoEn rs ps

-- ejericio 3.3.d

asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto e = cantidadDeEmpleadosParaCadaProyecto (proyectos e) e

cantidadDeEmpleadosParaCadaProyecto :: [Proyecto] -> Empresa -> [(Proyecto, Int)]
cantidadDeEmpleadosParaCadaProyecto []       _ = []
cantidadDeEmpleadosParaCadaProyecto (p : ps) e = (p, cantidadDeEmpleadosEnProyecto p (desarrolladoresDeLaEmpresa e)) : cantidadDeEmpleadosParaCadaProyecto ps e

cantidadDeEmpleadosEnProyecto :: Proyecto -> [Rol] -> Int
cantidadDeEmpleadosEnProyecto _ []       = 0
cantidadDeEmpleadosEnProyecto p (r : rs) = unoSi (esRolConProyecto r p) + cantidadDeEmpleadosEnProyecto p rs

esRolConProyecto :: Rol -> Proyecto -> Bool
esRolConProyecto r p = tienenElMismoNombre (proyectoDelRol r) p
