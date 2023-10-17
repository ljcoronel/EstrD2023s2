-- ejercicio 1
data Pizza = Prepizza | Capa Ingrediente Pizza
     deriving Show

data Ingrediente = Salsa | Queso | Jamon | Aceitunas Int
     deriving Show

-- ejercicio 1.a
cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza   = 0
cantidadDeCapas (Capa _ p) = 1 + cantidadDeCapas p

-- ejercicio 1.b
armarPizza :: [Ingrediente] -> Pizza
armarPizza []     = Prepizza
armarPizza (i:is) = Capa i (armarPizza is)

-- ejercicio 1.c
sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza   = Prepizza
sacarJamon (Capa i p) = agregarIngredienteSiNoEsJamon (sacarJamon p) i

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False

agregarIngredienteSiNoEsJamon :: Pizza -> Ingrediente -> Pizza
agregarIngredienteSiNoEsJamon p i = if not (esJamon i)
                                     then Capa i p
                                     else p

-- ejercicio 1.d
tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso Prepizza   = True
tieneSoloSalsaYQueso (Capa i p) = esSalsaOQueso i && tieneSoloSalsaYQueso p

esSalsaOQueso :: Ingrediente -> Bool
esSalsaOQueso Salsa = True
esSalsaOQueso Queso = True
esSalsaOQueso _     = False

-- ejercicio 1.e
duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza   = Prepizza
duplicarAceitunas (Capa i p) = Capa (duplicarSiEsAceitunas i) (duplicarAceitunas p)

duplicarSiEsAceitunas :: Ingrediente -> Ingrediente
duplicarSiEsAceitunas (Aceitunas n) = (Aceitunas (n*2))
duplicarSiEsAceitunas i             = i

-- ejercicio 1.f
cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = (cantidadDeCapas p, p) : cantCapasPorPizza ps

-- ejercicio 2
data Dir = Izq | Der
     deriving Show

data Objeto = Tesoro | Chatarra
     deriving Show

data Cofre = Cofre [Objeto]
     deriving Show

data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa
     deriving Show

-- ejercicio 2.1
hayTesoro :: Mapa -> Bool
hayTesoro (Fin c)               = esCofreConTesoro c
hayTesoro (Bifurcacion c m1 m2) = esCofreConTesoro c || hayTesoro m1 || hayTesoro m2

esCofreConTesoro :: Cofre -> Bool
esCofreConTesoro (Cofre os) = hayAlMenosUnTesoroEn os

hayAlMenosUnTesoroEn :: [Objeto] -> Bool
hayAlMenosUnTesoroEn []     = False
hayAlMenosUnTesoroEn (o:os) = esTesoro o || hayAlMenosUnTesoroEn os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- ejercicio 2.2
hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn []     (Fin c)               = esCofreConTesoro c
hayTesoroEn []     (Bifurcacion c _ _)   = esCofreConTesoro c
hayTesoroEn _      (Fin _)               = False
hayTesoroEn (d:ds) (Bifurcacion _ m1 m2) = hayTesoroEn ds (elegirSegunLaDireccion d m1 m2)

elegirSegunLaDireccion :: Dir -> Mapa -> Mapa -> Mapa
elegirSegunLaDireccion Izq m1 _ = m1
elegirSegunLaDireccion _   _ m2 = m2

-- ejercicio 2.3
caminoAlTesoro :: Mapa -> [Dir]
-- PRECOND: existe un tesoro y es único
caminoAlTesoro (Fin c)               = if esCofreConTesoro c
                                        then []
                                        else error "No hay tesoro en el camino"
caminoAlTesoro (Bifurcacion c m1 m2) = if esCofreConTesoro c
                                        then []
                                        else haciaDondeIr m1 : caminoAlTesoro (devolverCaminoConTesoro m1 m2)

haciaDondeIr :: Mapa -> Dir
haciaDondeIr m = if hayTesoro m
                  then Izq
                  else Der

devolverCaminoConTesoro :: Mapa -> Mapa -> Mapa
devolverCaminoConTesoro m1 m2 = if hayTesoro m1
                                 then m1
                                 else m2

-- ejercicio 2.4
caminoDeLaRamaMasLarga :: Mapa -> [Dir]
caminoDeLaRamaMasLarga (Fin _)               = []
caminoDeLaRamaMasLarga (Bifurcacion _ m1 m2) = elegirLaMasLarga (Izq : caminoDeLaRamaMasLarga m1) (Der : caminoDeLaRamaMasLarga m2)

elegirLaMasLarga :: [a] -> [a] -> [a]
elegirLaMasLarga xs ys = if length xs > length ys
                          then xs
                          else ys

-- ejercicio 2.5
tesorosPorNivel :: Mapa -> [[Objeto]]
tesorosPorNivel (Fin c)               = tesorosDelCofre c : []
tesorosPorNivel (Bifurcacion c m1 m2) = tesorosDelCofre c : juntarElementos (tesorosPorNivel m1) (tesorosPorNivel m2)

tesorosDelCofre :: Cofre -> [Objeto]
tesorosDelCofre (Cofre os) = tesorosDeLosObjetos os

tesorosDeLosObjetos :: [Objeto] -> [Objeto]
tesorosDeLosObjetos []     = []
tesorosDeLosObjetos (o:os) = singularSi o (esTesoro o) ++ tesorosDeLosObjetos os

singularSi :: a -> Bool -> [a]
singularSi x True = x : []
singularSi _ _    = []

juntarElementos :: [[a]] -> [[a]] -> [[a]]
juntarElementos []       yss      = yss
juntarElementos xss      []       = xss
juntarElementos (xs:xss) (ys:yss) = (xs ++ ys) : juntarElementos xss yss

-- ejercicio 2.6
todosLosCaminos :: Mapa -> [[Dir]]
todosLosCaminos (Fin c)               = [[]]
todosLosCaminos (Bifurcacion c m1 m2) = consACada Izq (todosLosCaminos m1) ++ consACada Der (todosLosCaminos m2)

consACada :: a -> [[a]] -> [[a]]
consACada x []       = []
consACada x (xs:xss) = (x : xs) : consACada x xss

-- ejercicio 3
data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
     deriving Show

data Barril = Comida | Oxigeno | Torpedo | Combustible
     deriving Show

data Sector = S SectorId [Componente] [Tripulante]
     deriving Show

type SectorId = String

type Tripulante = String

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
     deriving Show

data Nave = N (Tree Sector)
     deriving Show

-- ejercicio 3.1
sectores :: Nave -> [SectorId]
sectores (N t) = sectoresT t

sectoresT :: Tree Sector -> [SectorId]
sectoresT EmptyT          = []
sectoresT (NodeT s t1 t2) = sectorIdDe s : sectoresT t1 ++ sectoresT t2

sectorIdDe :: Sector -> SectorId
sectorIdDe (S s _ _) = s

-- ejercicio 3.2
poderDePropulsion :: Nave -> Int
poderDePropulsion (N t) = poderDePropulsionT t

poderDePropulsionT :: Tree Sector -> Int
poderDePropulsionT EmptyT          = 0
poderDePropulsionT (NodeT s t1 t2) = poderDePropulsionDeSector s + poderDePropulsionT t1 + poderDePropulsionT t2

poderDePropulsionDeSector :: Sector -> Int
poderDePropulsionDeSector s = poderDePropulsionDeComponentes (componentesDeSector s)

componentesDeSector :: Sector -> [Componente]
componentesDeSector (S _ cs _) = cs

poderDePropulsionDeComponentes :: [Componente] -> Int
poderDePropulsionDeComponentes []     = 0
poderDePropulsionDeComponentes (c:cs) = poderDePropulsionDeMotor c + poderDePropulsionDeComponentes cs

poderDePropulsionDeMotor :: Componente -> Int
poderDePropulsionDeMotor (Motor n) = n
poderDePropulsionDeMotor _         = 0

-- ejercicio 3.3
barriles :: Nave -> [Barril]
barriles (N t) = barrilesT t

barrilesT :: Tree Sector -> [Barril]
barrilesT EmptyT          = []
barrilesT (NodeT s t1 t2) = barrilesDelSector s ++ barrilesT t1 ++ barrilesT t2

barrilesDelSector :: Sector -> [Barril]
barrilesDelSector s = barrilesDeLosComponentes (componentesDeSector s)

barrilesDeLosComponentes :: [Componente] -> [Barril]
barrilesDeLosComponentes []     = []
barrilesDeLosComponentes (c:cs) = barrilesDelAlmacen c ++ barrilesDeLosComponentes cs

barrilesDelAlmacen :: Componente -> [Barril]
barrilesDelAlmacen (Almacen bs) = bs
barrilesDelAlmacen _            = []

-- ejercicio 3.4
agregarASector :: [Componente] -> SectorId -> Nave -> Nave
agregarASector cs si (N t) = N (agregarASectorT cs si t)

agregarASectorT :: [Componente] -> SectorId -> Tree Sector -> Tree Sector
agregarASectorT _  _  EmptyT          = EmptyT
agregarASectorT cs si (NodeT s t1 t2) = if sectorIdDe s == si
                                         then NodeT (agregarComponentesASector cs s) t1 t2
                                         else NodeT s (agregarASectorT cs si t1) (agregarASectorT cs si t2)

agregarComponentesASector :: [Componente] -> Sector -> Sector
agregarComponentesASector cs1 (S s cs2 ts) = S s (cs1 ++ cs2) ts

-- ejercicio 3.5
asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave
-- PRECOND: todos los id de la lista existen en la nave
asignarTripulanteA tri sis (N tree) = N (asignarTripulanteAT tri sis tree)

asignarTripulanteAT :: Tripulante -> [SectorId] -> Tree Sector -> Tree Sector
asignarTripulanteAT _ _   EmptyT          = EmptyT
asignarTripulanteAT t sis (NodeT s t1 t2) = NodeT (asignarTripulanteAlSectorId t sis s) (asignarTripulanteAT t sis t1) (asignarTripulanteAT t sis t2)

asignarTripulanteAlSectorId :: Tripulante -> [SectorId] -> Sector -> Sector
asignarTripulanteAlSectorId _ []       s = s
asignarTripulanteAlSectorId t (si:sis) s = if sectorIdDe s == si
                                            then asignarTripulanteASector t s
                                            else asignarTripulanteAlSectorId t sis s

asignarTripulanteASector :: Tripulante -> Sector -> Sector
asignarTripulanteASector t (S si cs ts) = S si cs (t : ts)

-- ejercicio 3.6
sectoresAsignados :: Tripulante -> Nave -> [SectorId]
sectoresAsignados tri (N tree) = sectoresAsignadosT tri tree

sectoresAsignadosT :: Tripulante -> Tree Sector -> [SectorId]
sectoresAsignadosT t  EmptyT          = []
sectoresAsignadosT tr (NodeT s t1 t2) = sectorIdDelTripulante tr s ++ sectoresAsignadosT tr t1 ++ sectoresAsignadosT tr t2

sectorIdDelTripulante :: Tripulante -> Sector -> [SectorId]
sectorIdDelTripulante t s = singularSi (sectorIdDe s) (existeTripulanteEn t (tripulantesDelSector s))

tripulantesDelSector :: Sector -> [Tripulante]
tripulantesDelSector (S _ _ ts) = ts

existeTripulanteEn :: Tripulante -> [Tripulante] -> Bool
existeTripulanteEn _  []      = False
existeTripulanteEn t1 (t2:ts) = t1 == t2 || existeTripulanteEn t1 ts

-- ejercicio 3.7
tripulantes :: Nave -> [Tripulante]
tripulantes (N t) = sinTripulantesRepetidos (tripulantesT t)

tripulantesT :: Tree Sector -> [Tripulante]
tripulantesT EmptyT          = []
tripulantesT (NodeT s t1 t2) = tripulantesDelSector s ++ tripulantesT t1 ++ tripulantesT t2

sinTripulantesRepetidos :: [Tripulante] -> [Tripulante]
sinTripulantesRepetidos []     = []
sinTripulantesRepetidos (t:ts) = agregarTripulanteSiNoEsRepetido t (sinTripulantesRepetidos ts)

agregarTripulanteSiNoEsRepetido :: Tripulante -> [Tripulante] -> [Tripulante]
agregarTripulanteSiNoEsRepetido t ts = if not (existeTripulanteEn t (sinTripulantesRepetidos ts))
                                        then t : ts
                                        else ts

-- ejercicio 4
type Presa = String
          -- nombre de presa

type Territorio = String
               -- nombre de territorio

type Nombre = String
           -- nombre de lobo

data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo | Explorador Nombre [Territorio] Lobo Lobo | Cria Nombre
     deriving Show

data Manada = M Lobo
     deriving Show

-- ejercicio 4.1
manada = M (Cazador "" ["", ""] (Explorador "" ["", ""] (Cria "") (Cria "")) (Explorador "" ["", ""] (Cria "") (Cria "")) (Cria ""))

-- ejercicio 4.2
buenaCaza :: Manada -> Bool
buenaCaza (M l) = cantidadDePresas l > cantidadDeCrias l

cantidadDePresas :: Lobo -> Int
cantidadDePresas (Cria _)                = 0
cantidadDePresas (Explorador _ _ l1 l2)  = cantidadDePresas l1 + cantidadDePresas l2
cantidadDePresas (Cazador _ ps l1 l2 l3) = alimentoEnPresas ps + cantidadDePresas l1 + cantidadDePresas l2 + cantidadDePresas l3

alimentoEnPresas :: [Presa] -> Int
alimentoEnPresas ps = length ps

cantidadDeCrias :: Lobo -> Int
cantidadDeCrias (Cria _)               = 1
cantidadDeCrias (Explorador _ _ l1 l2) = cantidadDeCrias l1 + cantidadDeCrias l2
cantidadDeCrias (Cazador _ _ l1 l2 l3) = cantidadDeCrias l1 + cantidadDeCrias l2 + cantidadDeCrias l3

-- ejercicio 4.3
elAlfa :: Manada -> (Nombre, Int)
elAlfa (M l) = elAlfaDeLosLobos l

elAlfaDeLosLobos :: Lobo -> (Nombre, Int)
elAlfaDeLosLobos (Cria n)                = (n, 0)
elAlfaDeLosLobos (Explorador n _ l1 l2)  = loboConMasPresas [(n, 0), elAlfaDeLosLobos l1, elAlfaDeLosLobos l2]
elAlfaDeLosLobos (Cazador n ps l1 l2 l3) = loboConMasPresas [(n, alimentoEnPresas ps), elAlfaDeLosLobos l1, elAlfaDeLosLobos l2, elAlfaDeLosLobos l3]

loboConMasPresas :: [(Nombre, Int)] -> (Nombre, Int)
-- PRECOND: la lista no es vacia
loboConMasPresas []             = error "Es una lista vacia"
loboConMasPresas ((nom,num):[]) = (nom, num)
loboConMasPresas ((nom,num):xs) = elegirElMejorLobo (nom, num) (loboConMasPresas xs)

elegirElMejorLobo :: (Nombre, Int) -> (Nombre, Int) -> (Nombre, Int)
elegirElMejorLobo (nom1,num1) (nom2,num2) = if num1 > num2
                                             then (nom1, num1)
                                             else (nom2, num2)

-- ejercicio 4.4
losQueExploraron :: Territorio -> Manada -> [Nombre]
losQueExploraron t (M l) = lobosQueExploraron t l

lobosQueExploraron :: Territorio -> Lobo -> [Nombre]
lobosQueExploraron t (Cria _)                = []
lobosQueExploraron t (Explorador n ts l1 l2) = singularSi n (territorioSeEncuentraEn t ts) ++ lobosQueExploraron t l1 ++ lobosQueExploraron t l2
lobosQueExploraron t (Cazador _ _ l1 l2 l3)  = lobosQueExploraron t l1 ++ lobosQueExploraron t l2 ++ lobosQueExploraron t l3

territorioSeEncuentraEn :: Territorio -> [Territorio] -> Bool
territorioSeEncuentraEn t  []      = False
territorioSeEncuentraEn t1 (t2:ts) = t1 == t2 || territorioSeEncuentraEn t1 ts

-- ejercicio 4.5
exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
exploradoresPorTerritorio (M l) = lobosPorTerritorio l

lobosPorTerritorio :: Lobo -> [(Territorio, [Nombre])]
lobosPorTerritorio (Cria _)                = [] 
lobosPorTerritorio (Explorador n ts l1 l2) = sinTerritoriosRepetidos (tuplasDeTerritorios n ts) (sinTerritoriosRepetidos (lobosPorTerritorio l1) (lobosPorTerritorio l2))
lobosPorTerritorio (Cazador _ _ l1 l2 l3)  = sinTerritoriosRepetidos (sinTerritoriosRepetidos (lobosPorTerritorio l1) (lobosPorTerritorio l2)) (lobosPorTerritorio l3)

tuplasDeTerritorios :: Nombre -> [Territorio] -> [(Territorio, [Nombre])]
tuplasDeTerritorios n []     = []
tuplasDeTerritorios n (t:ts) = (t,[n]) : tuplasDeTerritorios n ts

sinTerritoriosRepetidos :: [(Territorio, [Nombre])] -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
sinTerritoriosRepetidos []          ys = ys
sinTerritoriosRepetidos ((t,ns):xs) ys = if not (territorioSeEncuentraEnTupla t ys)
                                          then (t,ns) : sinTerritoriosRepetidos xs ys
                                          else agregarListaDeNombre ns t (sinTerritoriosRepetidos xs ys)

agregarListaDeNombre :: [Nombre] -> Territorio -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
agregarListaDeNombre [] t xs     = xs
agregarListaDeNombre (n:ns) t xs = agregarNombreATupla n t (agregarListaDeNombre ns t xs)

territorioSeEncuentraEnTupla :: Territorio -> [(Territorio, [Nombre])] -> Bool
territorioSeEncuentraEnTupla _  []          = False
territorioSeEncuentraEnTupla t1 ((t2,_):xs) = t1 == t2 || territorioSeEncuentraEnTupla t1 xs

incluirLobo :: Nombre -> [Territorio] -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
incluirLobo n []     ys = ys
incluirLobo n (t:ts) ys = if territorioSeEncuentraEnTupla t ys      
                           then agregarNombreATupla n t (incluirLobo n ts ys)
                           else (t,[n]) : incluirLobo n ts ys

agregarNombreATupla :: Nombre -> Territorio -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
agregarNombreATupla n t  []           = (t,[n]) : []
agregarNombreATupla n t1 ((t2,ns):ys) = if t1 == t2
                                         then (t2, (n : ns)) : ys
                                         else (t2,ns) : agregarNombreATupla n t1 ys

-- ejercicio 4.6
superioresDelCazador :: Nombre -> Manada -> [Nombre]
-- PRECOND: hay un cazador con dicho nombre y es único
superioresDelCazador n (M l) = lobosSuperioresDelCazador n l

lobosSuperioresDelCazador :: Nombre -> Lobo -> [Nombre]
-- PRECOND: hay un cazador con dicho nombre y es único
lobosSuperioresDelCazador n  (Cria _)                = error "No existe el cazador con el nombre dado"
lobosSuperioresDelCazador n  (Explorador _ _ l1 l2)  = lobosSuperioresDelCazador n (loboQueContieneAlNombre n l1 l2)
lobosSuperioresDelCazador n1 (Cazador n2 _ l1 l2 l3) = if n1 == n2
                                                        then []
                                                        else n2 : lobosSuperioresDelCazador n1 (loboQueContieneAlNombre n1 (loboQueContieneAlNombre n1 l1 l2) l3)

loboQueContieneAlNombre :: Nombre -> Lobo -> Lobo -> Lobo
loboQueContieneAlNombre n l1 l2 = if nombreDelCazadorSeEncuentraEn n l1
                                   then l1
                                   else l2

nombreDelCazadorSeEncuentraEn :: Nombre -> Lobo -> Bool
nombreDelCazadorSeEncuentraEn n  (Cria _)                = False
nombreDelCazadorSeEncuentraEn n  (Explorador _ _ l1 l2)  = nombreDelCazadorSeEncuentraEn n l1 || nombreDelCazadorSeEncuentraEn n l2
nombreDelCazadorSeEncuentraEn n1 (Cazador n2 _ l1 l2 l3) = n1 == n2 || nombreDelCazadorSeEncuentraEn n1 l1 || nombreDelCazadorSeEncuentraEn n1 l2 || nombreDelCazadorSeEncuentraEn n1 l3
