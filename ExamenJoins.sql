CREATE TABLE Autores (
    id_autor BIGINT IDENTITY(300, 1) PRIMARY KEY,
    nombre VARCHAR(100),
    pais_origen VARCHAR(100)
);

ALTER TABLE Comic
ADD id_autor BIGINT,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);

INSERT INTO Autores (nombre, pais_origen)
VALUES
    ('Stan Lee', 'Estados Unidos'),
    ('Alan Moore', 'Reino Unido'),
    ('Frank Miller', 'Estados Unidos'),
    ('Neil Gaiman', 'Reino Unido');

update Comic
set id_autor = 300 where id_comic=11

update Comic
set id_autor = 301 where id_comic=13

update Comic
set id_autor = 302 where id_comic=15

update Comic
set id_autor = 303 where id_comic=17


update Comic
set id_autor = 300 where id_comic=19

update Comic
set id_autor = 301 where id_comic=21

update Comic
set id_autor = 302 where id_comic=23

update Comic
set id_autor = 303 where id_comic=25



update Comic
set id_autor = 300 where id_comic=27

update Comic
set id_autor = 301 where id_comic=29

update Comic
set id_autor = 302 where id_comic=31

update Comic
set id_autor = 303 where id_comic=17

select c.nombre, a.pais_origen, a.nombre, i.disponibilidad as cantidad
from Comic c
left join Autores a on a.id_autor=c.id_autor
left join Comic_Compras cc on c.id_comic = cc.id_comic
left join Compras co on cc.id_compra = co.id_compra
left join Inventario i on c.id_comic = i.id_comic;


select a.nombre, c.nombre, i.disponibilidad as cantidad
from Comic c
left join autores a on a.id_autor = c.id_autor
left join Inventario i on c.id_comic = i.id_comic;