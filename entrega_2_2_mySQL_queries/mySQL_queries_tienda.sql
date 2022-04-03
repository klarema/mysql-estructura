
-- USE tienda
-- 1 Llista el nom de tots els productos que hi ha en la taula producto
SELECT nombre FROM tienda.producto;
-- 2 Llista els noms i els preus de tots els productos de la taula producto.
SELECT nombre, precio FROM tienda.producto;
-- 3 Llista totes les columnes de la taula producto.
DESCRIBE tienda.producto;
-- 4 Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). REQUIRED: CONVERT TO CURRENCY?
SELECT nombre, concat('EUR ', format(precio, 2)) AS euro, concat('USD ', format(precio, 2))  AS dollar FROM tienda.producto;
-- 5 Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dolars.
SELECT nombre AS nom_de_producto, concat('EUR ', format(precio, 2)) AS euros, concat('USD ', format(precio, 2)) AS dolars FROM tienda.producto;
-- 6 Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre), precio FROM tienda.producto;
-- 7 Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a minúscula.
SELECT LCASE(nombre), precio FROM tienda.producto;
-- 8 Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM tienda.fabricante;
-- 9 Llista els noms i els preus de tots els productos de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio, 0) AS roundUpPrice FROM tienda.producto;
-- 10 Llista els noms i els preus de tots els productos de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS truncatedPrice FROM tienda.producto;
-- 11 Llista el codi dels fabricants que tenen productos en la taula producto.
SELECT producto.codigo_fabricante FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
-- 12 Llista el codi dels fabricants que tenen productos en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT producto.codigo_fabricante FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
-- 13- Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM tienda.fabricante ORDER BY nombre ASC
-- 14 Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM tienda.fabricante ORDER BY nombre DESC
-- 15 Llista els noms dels productos ordenats en primer lloc pel nom de manera ascendent i en segon lloc pel preu de manera descendent.  

-- 16 Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * from tienda.fabricante LIMIT 5
-- 17 Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * from tienda.fabricante LIMIT 3, 2
-- 18 Llista el nom i el preu del producto més barat. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY
SELECT nombre, precio from tienda.producto ORDER BY precio ASC LIMIT 0, 1
-- 19 Llista el nom i el preu del producto més car. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio from tienda.producto ORDER BY precio DESC LIMIT 0, 1
-- 20 Llista el nom de tots els productos del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre from tienda.producto WHERE codigo_fabricante = 2
-- 21 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo
-- 22 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordeni el resultat pel nom del fabricador, per ordre alfabètic.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre
-- 23 Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre  FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo
-- 24 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT producto.nombre, MIN(producto.precio) AS Min_preu, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo 
-- 25 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT producto.nombre, MAX(producto.precio) AS Max_preu, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo 
-- 26 Retorna una llista de tots els productes del fabricador Lenovo.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante='2'
-- 27 Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200€.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante='6 ' AND producto.precio > 200
-- 28 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Sense utilitzar l'operador IN.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante='1' OR producto.codigo_fabricante='3' OR producto.codigo_fabricante='5'
-- 29 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Utilitzant l'operador IN.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante IN ('1','3','5')
-- 30 Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT producto.nombre, producto.precio FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre REGEXP "e$" ;
-- 31 Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT producto.nombre, producto.precio FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre LIKE "%w%" ;
-- 32 Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180€. Ordeni el resultat en primer lloc pel preu (en ordre descendent) i en segon lloc pel nom (en ordre ascendent)
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.precio >= 180
-- 33 Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT DISTINCT producto.codigo_fabricante, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo
-- 34 Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT DISTINCT fabricante.nombre AS fabricante, producto.nombre FROM tienda.producto RIGHT JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo
-- 35 Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.



