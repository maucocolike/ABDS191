create view Vista_ComprasComic as
select cc.id_CC, cc.cantidad as cantidad, c.nombre as nombre_comic, cc.id_compra, com.fecha_compra, com.total
from Comic_Compras cc
inner join comic c on c.id_comic = cc.id_comic 
inner join Compras com on com.id_compra = cc.id_compra

select * from Vista_ComprasComic

create view Vista_ComicsComprados as
select cli.id_clientes, cli.nombre, cc.cantidad as cantidad_comprada
from Clientes cli
inner join Compras c on cli.id_clientes = c.id_cliente
inner join Comic_Compras cc on  cc.id_compra = c.id_compra;

select * from Vista_ComicsComprados;

