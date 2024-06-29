CREATE PROCEDURE Insertar1
    @nombre VARCHAR(50),
    @correo_electronico VARCHAR(50),
    @pass VARCHAR(25)
AS
BEGIN
    INSERT INTO Clientes (nombre, correo_electronico, pass)
    VALUES (@nombre, @correo_electronico, @pass);
END;

exec Insertar1 'mauricio',  'maucoco@gmail.com', '123contra'
select * from Clientes

CREATE PROCEDURE Insertar2
    @nombre VARCHAR(50),
    @anio VARCHAR(4),
    @precio FLOAT
AS
BEGIN
    INSERT INTO Comic (nombre, anio, precio)
    VALUES (@nombre, @anio, @precio);
END;
exec Insertar2 'batman y la hacha fugaz', 2024, 199
select * from Comic


CREATE PROCEDURE EditarCliente
    @id_cliente BIGINT,
    @nombre VARCHAR(50),
    @correo_electronico VARCHAR(50),
    @pass VARCHAR(25)
AS
BEGIN
    UPDATE Clientes
    SET nombre = @nombre, correo_electronico = @correo_electronico, pass = @pass
    WHERE id_clientes = @id_cliente;
END;
exec EditarCliente 9, 'santibolas', 'santiagoamlpz@gmail.com', 'santi123'
select * from clientes


CREATE PROCEDURE EditarComic
    @id_comic BIGINT,
    @nombre VARCHAR(50),
    @anio VARCHAR(4),
    @precio FLOAT
AS
BEGIN
    UPDATE Comic
    SET nombre = @nombre, anio = @anio, precio = @precio
    WHERE id_comic = @id_comic;
END;
exec EditarComic 21, 'superman y robin', '2024', 25.5
select * from Comic

CREATE PROCEDURE EliminarCliente111
    @id_cliente BIGINT
AS
BEGIN
    BEGIN TRANSACTION;
	BEGIN TRY
        DELETE cc
        FROM Comic_Compras cc
        INNER JOIN Compras c ON cc.id_compra = c.id_compra
        WHERE c.id_cliente = @id_cliente;
        DELETE FROM Compras
        WHERE id_cliente = @id_cliente;
        DELETE FROM Clientes
        WHERE id_clientes = @id_cliente;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
exec EliminarCliente111 @id_cliente = 13
select * from Clientes
-- la verdad aqui hice uso de chatgpt, ya que no me dejaba borrar ninguna fila de la tabla por las FK asociadas

USE ComicsStore;
GO
CREATE PROCEDURE EliminarComic21
    @id_comic BIGINT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM Comic_Compras
        WHERE id_comic = @id_comic;
        DELETE FROM Comic
        WHERE id_comic = @id_comic;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
exec EliminarComic21 @id_comic = 25


CREATE PROCEDURE ConsultarComprasCliente
    @id_cliente BIGINT
AS
BEGIN
    SELECT c.id_compra, c.fecha_compra, c.total, cli.nombre AS cliente
    FROM Compras c
    INNER JOIN Clientes cli ON c.id_cliente = cli.id_clientes
    WHERE c.id_cliente = @id_cliente;
END;
exec ConsultarComprasCliente 31


CREATE PROCEDURE ConsultarComicsEnCompra
    @id_compra BIGINT
AS
BEGIN
    SELECT cc.id_comic, cm.nombre AS comic, cc.cantidad, cm.precio
    FROM Comic_Compras cc
    INNER JOIN Comic cm ON cc.id_comic = cm.id_comic
    WHERE cc.id_compra = @id_compra;
END;
exec ConsultarComicsEnCompra 41


CREATE PROCEDURE ConsultarInventarioComics
    @nombre_comic VARCHAR(50)
AS
BEGIN
    SELECT i.id_inventario, cm.nombre AS comic, i.cantidad_disponible, i.disponibilidad
    FROM Inventario i
    INNER JOIN Comic cm ON i.id_comic = cm.id_comic
    WHERE cm.nombre LIKE '%' + @nombre_comic + '%';
END;
exec ConsultarInventarioComics 'Sin City'
