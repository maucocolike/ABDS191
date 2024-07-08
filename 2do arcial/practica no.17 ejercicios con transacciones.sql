/*CREATE PROCEDURE NUevocliente
  @nombre VARCHAR(25),
  @correo_electronico VARCHAR(39),
  @pass VARCHAR(255)
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    INSERT INTO Clientes (nombre, correo_electronico, pass)
    VALUES (@nombre, @correo_electronico, @pass);

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH;
END;

exec NUevocliente 'ayelen', 'ayelen123.com','contresena123456789'

CREATE PROCEDURE RegistrarCompra
  @id_cliente BIGINT,
  @fecha_compra DATE,
  @total DECIMAL(10,2),
  @detalles_compras TABLE (
    id_comic BIGINT,
    cantidad INT
  )
AS
BEGIN
  BEGIN TRANSACTION;

  DECLARE @id_compra BIGINT;

  BEGIN TRY
    -- Insertar la compra
    INSERT INTO Compras (id_cliente, fecha_compra, total)
    VALUES (@id_cliente, @fecha_compra, @total);

    -- Obtener el ID de la compra recién insertada
    SELECT @id_compra = SCOPE_IDENTITY();

    -- Insertar los detalles de la compra
    INSERT INTO Comic_Compras (id_compra, id_comic, cantidad)
    SELECT @id_compra, id_comic, cantidad
    FROM @detalles_compras;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH;
END;

*/
CREATE PROCEDURE Nuevacomra
  @id_cliente BIGINT,
  @fecha_compra DATE,
  @total DECIMAL(10,2),
  @id_comic BIGINT,
  @cantidad INT
AS
BEGIN
  BEGIN TRANSACTION;

  DECLARE @id_compra BIGINT;

  BEGIN TRY
    -- Insertar la compra
    INSERT INTO Compras (id_cliente, fecha_compra, total)
    VALUES (@id_cliente, @fecha_compra, @total);

    -- Obtener el ID de la compra recién insertada
    SELECT @id_compra = SCOPE_IDENTITY();

    -- Insertar los detalles de la compra
    INSERT INTO Comic_Compras (id_compra, id_comic, cantidad)
    VALUES (@id_compra, @id_comic, @cantidad);

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH;
END;

exec Nuevacomra 11,'2024-01-17', 182.3, 19, 2
select * from Comic_Compras


CREATE PROCEDURE ActualizarInven
  @id_comic BIGINT,
  @cantidad_disponible INT,
  @disponibilidad VARCHAR(25)
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    UPDATE Inventario
    SET cantidad_disponible = @cantidad_disponible,
        disponibilidad = @disponibilidad
    WHERE id_comic = @id_comic;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
  END CATCH;
END;
exec ActualizarInven 3, 12, disonible


CREATE PROCEDURE EliminarClienteee
  @id_cliente BIGINT
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    -- Eliminar los detalles de compras del cliente
    DELETE CC
    FROM Comic_Compras CC
    INNER JOIN Compras C ON CC.id_compra = C.id_compra
    WHERE C.id_cliente = @id_cliente;

    -- Eliminar las compras del cliente
    DELETE FROM Compras
    WHERE id_cliente = @id_cliente;

    -- Eliminar el cliente
    DELETE FROM Clientes
    WHERE id_clientes = @id_cliente;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH;
END;
exec EliminarClienteee 9
select * from Clientes


CREATE PROCEDURE ActualizarComic
  @id_comic BIGINT,
  @nombre VARCHAR(25),
  @anio int,
  @precio DECIMAL(10,2)
AS
BEGIN
  BEGIN TRANSACTION;

  BEGIN TRY
    UPDATE Comic
    SET nombre = @nombre,
        anio = @anio,
        precio = @precio
    WHERE id_comic = @id_comic;

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH;
END;
exec ActualizarComic 11, 'mama-ban', 2012, 19.88
select * from Comic


