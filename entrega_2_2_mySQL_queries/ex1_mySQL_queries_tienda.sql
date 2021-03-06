SELECT nombre FROM tienda.producto;
SELECT nombre, precio FROM tienda.producto;
DESCRIBE tienda.producto;
SELECT nombre, concat('EUR ', format(precio, 2)) AS euro, concat('USD ', format(precio, 2))  AS dollar FROM tienda.producto;
SELECT nombre AS nom_de_producto, concat('EUR ', format(precio, 2)) AS euros, concat('USD ', format(precio, 2)) AS dolars FROM tienda.producto;
SELECT UPPER(nombre), precio FROM tienda.producto;
SELECT LCASE(nombre), precio FROM tienda.producto;
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM tienda.fabricante;
SELECT nombre, ROUND(precio, 0) AS roundUpPrice FROM tienda.producto;
SELECT nombre, TRUNCATE(precio, 0) AS truncatedPrice FROM tienda.producto;
SELECT producto.codigo_fabricante FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT DISTINCT producto.codigo_fabricante FROM tienda.producto INNER JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT nombre FROM tienda.fabricante ORDER BY nombre ASC;
SELECT nombre FROM tienda.fabricante ORDER BY nombre DESC;
SELECT * from tienda.fabricante LIMIT 5;
SELECT * from tienda.fabricante LIMIT 3, 2;
SELECT nombre, precio from tienda.producto ORDER BY precio ASC LIMIT 0, 1;
SELECT nombre, precio from tienda.producto ORDER BY precio DESC LIMIT 0, 1;
SELECT nombre from tienda.producto WHERE codigo_fabricante = 2;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT producto.nombre, producto.precio, fabricante.nombre FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre;
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre  FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT producto.nombre, MIN(producto.precio) AS Min_preu, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT producto.nombre, MAX(producto.precio) AS Max_preu, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante='2';
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante='6 ' AND producto.precio > 200;
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante='1' OR producto.codigo_fabricante='3' OR producto.codigo_fabricante='5';
SELECT producto.nombre, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.codigo_fabricante IN ('1','3','5');
SELECT producto.nombre, producto.precio FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre REGEXP "e$" ;
SELECT producto.nombre, producto.precio FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre LIKE "%w%" ;
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.precio >= 180;
SELECT DISTINCT producto.codigo_fabricante, fabricante.nombre AS fabricante FROM tienda.producto JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;
SELECT DISTINCT fabricante.nombre AS fabricante, producto.nombre FROM tienda.producto RIGHT JOIN tienda.fabricante ON producto.codigo_fabricante=fabricante.codigo;