use ComicsStore

create table Clientes (
  id_clientes bigint identity(9,2) Primary key,
  nombre varchar(25),
  correo_electronico varchar(39),
  pass varchar(25)
);

create table Compras (
  id_compra bigint identity(9,2) primary key,
  id_cliente bigint,
  foreign key (id_cliente) references Clientes(id_clientes),
  fecha_compra date,
  total float 
);

create table Comic (
  id_comic bigint identity(9,2) primary key,
  nombre varchar(25),
  anio varchar(25),
  precio float
);


create table Comic_Compras (
  id_CC bigint identity(9,2) primary key,
  cantidad int,
  id_compra bigint,
  id_comic bigint,
  foreign key (id_compra) references Compras(id_compra),
  foreign key (id_comic) references Comic(id_comic)
);


create table Inventario (
  id_inventario bigint identity(9,2) primary key,
  id_comic int,
  cantidad_disponible int,
  disponibilidad varchar(25)
);

