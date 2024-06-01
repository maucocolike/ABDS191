-- ejercicio 1
SELECT  i.id_comic, c.nombre, i.disponibilidad
FROM inventario i
INNER JOIN comic c ON c.id_comic = i.id_comic 
WHERE i.disponibilidad = 'Disponible';

--ejercicio 2
SELECT cl.nombre AS Cliente, com.id_compra, c.nombre AS Comic, cc.cantidad
FROM Clientes cl
INNER JOIN Compras com ON cl.id_clientes = com.id_cliente
INNER JOIN Comic_Compras cc ON com.id_compra = cc.id_compra
INNER JOIN Comic c ON cc.id_comic = c.id_comic

WHERE cc.cantidad != 0;

--ejercicio 3
SELECT c.id_comic, c.nombre AS Comic, co.id_compra, co.id_cliente, cc.cantidad AS Cantidad_Comprada, i.disponibilidad AS Cantidad_Disponible
FROM Comic c
LEFT JOIN Comic_Compras cc ON c.id_comic = cc.id_comic
LEFT JOIN Compras co ON cc.id_compra = co.id_compra
LEFT JOIN Inventario i ON c.id_comic = i.id_comic;

--ejercicio 4
SELECT c.id_comic, c.nombre AS Comic, i.disponibilidad AS Cantidad_Disponible
FROM Comic c
INNER JOIN Inventario i ON c.id_comic = i.id_comic;

--ejercicio 5
SELECT c.*, cc.*, i.*
FROM Comic c
inner JOIN Comic_Compras cc ON c.id_comic = cc.id_comic
inner JOIN Inventario i ON c.id_comic = i.id_comic;

--ejercicio 6
SELECT cl.id_clientes, cl.nombre AS Cliente, co.id_compra, c.nombre AS Comic, cc.cantidad AS Cantidad_Comprada, i.disponibilidad AS Cantidad_Disponible
FROM Clientes cl
INNER JOIN Compras co ON cl.id_clientes = co.id_cliente
INNER JOIN Comic_Compras cc ON co.id_compra = cc.id_compra
INNER JOIN Comic c ON cc.id_comic = c.id_comic
INNER JOIN Inventario i ON c.id_comic = i.id_comic;

