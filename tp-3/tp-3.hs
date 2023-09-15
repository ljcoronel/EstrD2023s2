-- ejercicio 1.1
data Color = Azul | Rojo
     deriving Show

data Celda = Bolita Color Celda | CeldaVacia
     deriving Show

-- ejercicio 1.1.a
nroBolitas :: Color -> Celda -> Int
nroBolitas _    CeldaVacia        = 0
nroBolitas col1 (Bolita col2 cel) = unoSi (sonDelMismoColor col1 col2) + nroBolitas col1 cel

sonDelMismoColor :: Color -> Color -> Bool
sonDelMismoColor Azul Azul = True
sonDelMismoColor Rojo Rojo = True
sonDelMismoColor _    _    = False

unoSi :: Bool -> Int
unoSi True = 1
unoSi _    = 0

-- ejercicio 1.1.b
poner :: Color -> Celda -> Celda
poner col cel = Bolita col cel

-- ejercicio 1.1.c
sacar :: Color -> Celda -> Celda
sacar _    CeldaVacia        = CeldaVacia
sacar col1 (Bolita col2 cel) = if sonDelMismoColor col1 col2
                                then cel
                                else Bolita col2 (sacar col1 cel)

-- ejercicio 1.1.d
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 _   cel = cel
ponerN n col cel = ponerN (n-1) col (poner col cel)

-- ejercicio 1.2
data Objeto = Cacharro | Tesoro
     deriving Show

data Camino = Fin | Cofre [Objeto] Camino | Nada Camino
     deriving Show

-- ejercicio 1.2.a
hayTesoro :: Camino -> Bool
hayTesoro Fin          = False
hayTesoro (Cofre os c) = hayTesoroEnLosObjetos os || hayTesoro c
hayTesoro (Nada c)     = hayTesoro c

hayTesoroEnLosObjetos :: [Objeto] -> Bool
hayTesoroEnLosObjetos []       = False
hayTesoroEnLosObjetos (o : os) = esTesoro o || hayTesoroEnLosObjetos os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- ejercicio 1.2.b
pasosHastaTesoro :: Camino -> Int
-- PRECOND: tiene que haber al menos un tesoro
pasosHastaTesoro Fin          = error "es un camino sin tesoro"
pasosHastaTesoro (Nada c)     = 1 + pasosHastaTesoro c
pasosHastaTesoro (Cofre os c) = if hayTesoroEnLosObjetos os 
                                 then 0 
                                 else 1 + pasosHastaTesoro c

-- ejercicio 1.2.c
hayTesoroEn :: Int -> Camino -> Bool
hayTesoroEn 0 c           = esCofreConTesoro c
hayTesoroEn _ Fin         = False
hayTesoroEn n (Cofre _ c) = hayTesoroEn (n-1) c
hayTesoroEn n (Nada c)    = hayTesoroEn (n-1) c

esCofreConTesoro :: Camino -> Bool
esCofreConTesoro (Cofre os _) = hayTesoroEnLosObjetos os
esCofreConTesoro _            = False

-- ejercicio 1.2.d
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros 0 _            = True
alMenosNTesoros _ Fin          = False
alMenosNTesoros n (Nada c)     = alMenosNTesoros n c
alMenosNTesoros n (Cofre os c) = if cantidadDeTesoros os < n
                                  then alMenosNTesoros (n - cantidadDeTesoros os) c
                                  else alMenosNTesoros 0 c

cantidadDeTesoros :: [Objeto] -> Int
cantidadDeTesoros []       = 0
cantidadDeTesoros (o : os) = unoSi (esTesoro o) + cantidadDeTesoros os

-- ejercicio 1.2.e
cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre 0  n  c           = cantidadDeTesorosHasta n c
cantTesorosEntre n1 n2 Fin         = 0
cantTesorosEntre n1 n2 (Cofre _ c) = cantTesorosEntre (n1-1) (n2-1) c
cantTesorosEntre n1 n2 (Nada c)    = cantTesorosEntre (n1-1) (n2-1) c

cantidadDeTesorosHasta :: Int -> Camino -> Int
cantidadDeTesorosHasta 0 c            = cantidadDeTesorosDelCofreSiHay c
cantidadDeTesorosHasta n Fin          = 0
cantidadDeTesorosHasta n (Cofre os c) = (cantidadDeTesoros os) + cantidadDeTesorosHasta (n-1) c
cantidadDeTesorosHasta n (Nada c)     = cantidadDeTesorosHasta (n-1) c

cantidadDeTesorosDelCofreSiHay :: Camino -> Int
cantidadDeTesorosDelCofreSiHay (Cofre os _) = cantidadDeTesoros os
cantidadDeTesorosDelCofreSiHay _            = 0

-- ejercicio 2.1
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
     deriving Show

-- ejericicio 2.1.1
sumarT :: Tree Int -> Int
sumarT EmptyT          = 0
sumarT (NodeT n t1 t2) = n + sumarT t1 + sumarT t2

-- ejericicio 2.1.2
sizeT :: Tree a -> Int
sizeT EmptyT          = 0
sizeT (NodeT a t1 t2) = 1 + sizeT t1 + sizeT t2

-- ejericicio 2.1.3
mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT
mapDobleT (NodeT n t1 t2) = NodeT (n * 2) (mapDobleT t1) (mapDobleT t2)

-- ejericicio 2.1.4
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT _  EmptyT           = False
perteneceT a1 (NodeT a2 t1 t2) = a1 == a2 || perteneceT a1 t1 || perteneceT a1 t2

-- ejericicio 2.1.5
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT e EmptyT          = 0
aparicionesT e (NodeT a t1 t2) = unoSi (a == e) + aparicionesT e t1 + aparicionesT e t2

-- ejericicio 2.1.6
leaves :: Tree a -> [a]
leaves EmptyT          = []
leaves (NodeT a t1 t2) = a : leaves t1 ++ leaves t2

-- ejericicio 2.1.7
heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT a t1 t2) = elMayor (1 + heightT t1) (1 + heightT t2)

elMayor :: Int -> Int -> Int
elMayor n m = if n > m
               then n
               else m

-- ejericicio 2.1.8
mirrorT :: Tree a -> Tree a
mirrorT EmptyT          = EmptyT
mirrorT (NodeT a t1 t2) = NodeT a (mirrorT t2) (mirrorT t1)

-- ejericicio 2.1.9
toList :: Tree a -> [a]
toList EmptyT          = []
toList (NodeT a t1 t2) = toList t1 ++ a : [] ++ toList t2

-- ejericicio 2.1.10
levelN :: Int -> Tree a -> [a]
levelN _ EmptyT          = []
levelN 0 (NodeT a t1 t2) = a : []
levelN n (NodeT a t1 t2) = levelN (n-1) t1 ++ levelN (n-1) t2

-- ejericicio 2.1.11
listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT          = [[]]
listPerLevel (NodeT a t1 t2) = [a] : listasDelMismoNivel (listPerLevel t1) (listPerLevel t2)

listasDelMismoNivel :: [[a]] -> [[a]] -> [[a]]
listasDelMismoNivel []         yss        = yss
listasDelMismoNivel xss        []         = xss
listasDelMismoNivel (xs : xss) (ys : yss) = (xs ++ ys) : listasDelMismoNivel xss yss

-- ejericicio 2.1.12
ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT          = []
ramaMasLarga (NodeT a t1 t2) = a : elegirLaMasLarga (ramaMasLarga t1) (ramaMasLarga t2)

elegirLaMasLarga :: [a] -> [a] -> [a]
elegirLaMasLarga xs1 xs2 = if length xs1 > length xs2
                            then xs1
                            else xs2

-- ejericicio 2.1.13
todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT          = []
todosLosCaminos (NodeT a t1 t2) = agregarUnElementoACadaLista a ((todosLosCaminos t1) ++ (todosLosCaminos t2))

agregarUnElementoACadaLista :: a -> [[a]] -> [[a]]
agregarUnElementoACadaLista x []         = [[x]]
agregarUnElementoACadaLista x (xs : xss) = (x : xs) : agregarUnElementoACadaLista x xss

-- ejericicio 2.2
data ExpA = Valor Int | Sum ExpA ExpA | Prod ExpA ExpA | Neg ExpA
     deriving Show

-- ejercicio 2.2.1
eval :: ExpA -> Int
eval (Valor n)    = n
eval (Sum e1 e2)  = eval e1 + eval e2
eval (Prod e1 e2) = eval e1 * eval e2
eval (Neg e)      = - eval e

-- ejercicio 2.2.2
simplificar :: ExpA -> ExpA
simplificar (Valor n)    = Valor n
simplificar (Sum e1 e2)  = simplificarSum (simplificar e1)  (simplificar e2)
simplificar (Prod e1 e2) = simplificarProd (simplificar e1) (simplificar e2)
simplificar (Neg e)      = simplificarNeg (simplificar e)

simplificarSum :: ExpA -> ExpA -> ExpA
-- PRECOND: la expresion aritmetica debe ser suma
simplificarSum e1        (Valor 0) = e1
simplificarSum (Valor 0) e2        = e2
simplificarSum e1        e2        = Sum e1 e2

simplificarProd :: ExpA -> ExpA -> ExpA
-- PRECOND: la expresion aritmetica debe ser producto
simplificarProd (Valor 0) _         = Valor 0
simplificarProd _         (Valor 0) = Valor 0
simplificarProd (Valor 1) e2        = e2
simplificarProd e1        (Valor 1) = e1
simplificarProd e1        e2        = Prod e1 e2

simplificarNeg :: ExpA -> ExpA
-- PRECOND: la expresion aritmetica debe ser negacion
simplificarNeg (Neg e) = e
simplificarNeg e       = Neg e
