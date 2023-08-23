-- ejercicio 2.1.a
sucesor :: Int -> Int
sucesor n = n + 1

-- ejercicio 2.1.b
sumar :: Int -> Int -> Int
sumar n m = n + m

-- ejercicio 2.1.c
divisionYResto :: Int -> Int -> (Int, Int)
-- PRECOND: el número es distinto de cero
divisionYResto n m = (div n m, mod n m)

-- ejercicio 2.1.d
maxDelPar :: (Int,Int) -> Int
maxDelPar (n,m) = if n > m
                   then n
                   else m

{- ejercicio 2.2
sumar (maxDelPar (divisionYResto 10 2)) (sucesor 4)
sucesor (sumar (maxDelPar (divisionYResto 2 3)) 7)
maxDelPar (divisionYResto (sucesor 99) (sumar 7 3))
sumar (sucesor (maxDelPar (divisionYResto 12 7))) 4
-}

-- ejercicio 3.1
data Dir = Norte | Este | Sur | Oeste
     deriving Show

-- ejercicio 3.1.a
opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Este  = Oeste
opuesto Sur   = Norte
opuesto Oeste = Este

-- ejercicio 3.1.b
iguales :: Dir -> Dir -> Bool
iguales Norte Norte = True
iguales Este Este   = True
iguales Sur Sur     = True
iguales Oeste Oeste = True
iguales _ _         = False

-- ejercicio 3.1.c
siguiente :: Dir -> Dir
-- PRECOND: la dirección no es Oeste
siguiente Norte = Este
siguiente Este  = Sur
siguiente Sur   = Oeste
siguiente _     = error "La direccion no tiene siguiente"
-- es una función parcial ya que Oeste no tiene siguiente

-- ejercicio 3.2
data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo
     deriving Show

-- ejercicio 3.2.a
primeroYUltimoDia :: (DiaDeSemana, DiaDeSemana)
primeroYUltimoDia = (primerDia, ultimoDia)

primerDia :: DiaDeSemana
primerDia = Lunes

ultimoDia :: DiaDeSemana
ultimoDia = Domingo

-- ejercicio 3.2.b
empiezaConM :: DiaDeSemana -> Bool
empiezaConM Martes    = True
empiezaConM Miercoles = True
empiezaConM _         = False

-- ejercicio 3.2.c
vieneDespues :: DiaDeSemana -> DiaDeSemana -> Bool
vieneDespues d1 d2 = posicionDelDia d1 > posicionDelDia d2

posicionDelDia :: DiaDeSemana -> Int
posicionDelDia Lunes     = 1
posicionDelDia Martes    = 2
posicionDelDia Miercoles = 3
posicionDelDia Jueves    = 4
posicionDelDia Viernes   = 5
posicionDelDia Sabado    = 6
posicionDelDia Domingo   = 7

-- ejercicio 3.2.d
estaEnElMedio :: DiaDeSemana -> Bool
estaEnElMedio Lunes   = False
estaEnElMedio Domingo = False
estaEnElMedio _       = True

-- ejercicio 3.3.a
negar :: Bool -> Bool
negar True = False
negar _    = True

-- ejercicio 3.3.b
implica :: Bool -> Bool -> Bool
implica True b = b
implica _    _ = True

-- ejercicio 3.3.c
yTambien :: Bool -> Bool -> Bool
yTambien True b = b
yTambien _    _ = False

-- ejercicio 3.3.d
oBien :: Bool -> Bool -> Bool
oBien True _    = True
oBien _    True = True
oBien _    _    = False

-- ejercicio 4.1
data Persona = P String Int
              -- Nombre Edad
     deriving Show

-- ejercicio 4.1.a
nombre :: Persona -> String
nombre (P n _) = n

-- ejercicio 4.1.b
edad :: Persona -> Int
edad (P _ e) = e

-- ejercicio 4.1.c
crecer :: Persona -> Persona
crecer (P n e) = P n (e + 1)

-- ejercicio 4.1.d
cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre n (P _ e) = P n e

-- ejercicio 4.1.e
esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra (P _ e1) (P _ e2) = e1 > e2

-- ejercicio 4.1.f
laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor (P n1 e1) (P n2 e2) = if esMayorQueLaOtra (P n1 e1) (P n2 e2)
                                  then P n1 e1
                                  else P n2 e2

-- ejercicio 4.2
data Pokemon = Poke TipoDePokemon Int
              --    Tipo          Energia
     deriving Show

data TipoDePokemon = Agua | Fuego | Planta
     deriving Show

data Entrenador = E String Pokemon Pokemon
                 -- Nombre Pokemon Pokemon
     deriving Show

-- ejercicio 4.2.a
superaA :: Pokemon -> Pokemon -> Bool
superaA (Poke t1 _) (Poke t2 _) = esMejorTipoQue t1 t2

esMejorTipoQue :: TipoDePokemon -> TipoDePokemon -> Bool
esMejorTipoQue Agua Fuego   = True
esMejorTipoQue Fuego Planta = True
esMejorTipoQue Planta Agua  = True
esMejorTipoQue _      _     = False

-- ejercicio 4.2.b
cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe t (E _ p1 p2) = cantidadDelMismoTipo t p1 p2

cantidadDelMismoTipo :: TipoDePokemon -> Pokemon -> Pokemon -> Int
cantidadDelMismoTipo t p1 p2 = unoSi (sonDelMismoTipo t (tipoPokemonDe p1)) + unoSi (sonDelMismoTipo (tipoPokemonDe p2) t)

unoSi :: Bool -> Int
unoSi True  = 1
unoSi False = 0

sonDelMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
sonDelMismoTipo Agua   Agua   = True
sonDelMismoTipo Fuego  Fuego  = True
sonDelMismoTipo Planta Planta = True
sonDelMismoTipo _      _      = False

tipoPokemonDe :: Pokemon -> TipoDePokemon
tipoPokemonDe (Poke t _) = t

-- ejercicio 4.2.c
juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (E _ p1 p2,E _ p3 p4) = [p1, p2, p3, p4]

-- ejercicio 5.1.a
loMismo :: a -> a
loMismo a = a

-- ejercicio 5.1.b
siempreSiete :: a -> Int
siempreSiete a = 7

-- ejercicio 5.1.c
swap :: (a,b) -> (b, a)
swap (a,b) = (b,a)
-- Porque son de distinto tipo

-- ejercicio 5.2
-- Son funciones polimórficas porque no requieren parámetros ni resultados de un tipo específico

-- ejercicio 6.1.2
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia _  = False

-- ejercicio 6.1.3
elPrimero :: [a] -> a
-- PRECOND: la lista no puede ser vacia
elPrimero (x : _) = x
elPrimero _       = error "Es una lista vacia"

-- ejercicio 6.1.4
sinElPrimero :: [a] -> [a]
-- PRECOND: la lista no puede ser vacia
sinElPrimero (_ : xs) = xs
sinElPrimero _        = error "Es una lista vacia"

-- ejercicio 6.1.5
splitHead :: [a] -> (a, [a])
-- PRECOND: la lista no puede ser vacia
splitHead (x : xs) = (x, xs)
splithead _        = error "Es una lista vacia"
