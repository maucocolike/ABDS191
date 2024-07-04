CREATE PROCEDURE InsertarPeliculaYHistorial
    @Titulo NVARCHAR(100),
    @Genero NVARCHAR(50),
    @FechaEstreno DATE,
    @UsuarioID INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @NewPeliculaID INT

        INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
        VALUES (@Titulo, @Genero, @FechaEstreno);

        SET @NewPeliculaID = SCOPE_IDENTITY();

        INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
        VALUES (@UsuarioID, @NewPeliculaID, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
       
        ROLLBACK TRANSACTION;
    END CATCH
END;
EXEC InsertarPeliculaYHistorial 'mi villano fav 2', 'infantil', '2024-07-07', 4
SELECT * FROM Peliculas;
SELECT * FROM HistorialVisualizacion;


CREATE PROCEDURE InsertarUsuSusVisualiza
    @Nombre NVARCHAR(100),
    @Email NVARCHAR(100),
    @Pass NVARCHAR(100),
    @FechaInicioSuscripcion DATE,
    @FechaFinSuscripcion DATE,
    @Fechare DATE,
    @Fechasus DATE,
    @TipoSuscripcion NVARCHAR(50),
    @PeliculaID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DECLARE @NewUsuarioID INT;

        INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro)
        VALUES (@Nombre, @Email, @Pass, @Fechare);

        SET @NewUsuarioID = SCOPE_IDENTITY();

        INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
        VALUES (@NewUsuarioID, @FechaInicioSuscripcion, @FechaFinSuscripcion, @TipoSuscripcion);

        INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
        VALUES (@NewUsuarioID, @PeliculaID, @Fechasus);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
    END CATCH
END;


EXEC InsertarUsuSusVisualiza
    @Nombre = 'Luis Herrera', 
    @Email = 'luis.herrera@ejemplo.com', 
    @Pass = 'password123', 
    @FechaInicioSuscripcion = '2024-07-01', 
    @FechaFinSuscripcion = '2025-07-01', 
    @Fechare = '2024-07-07',
    @Fechasus = '2024-07-16',    
    @TipoSuscripcion = 'Anual', 
    @PeliculaID = 1;
 
 SELECT * FROM HistorialVisualizacion;
 SELECT * FROM Usuarios;
 SELECT * FROM Suscripciones;

 CREATE PROCEDURE ActualizarCorreoSiu 
    @UsuarioID INT,
    @NuevoEmail NVARCHAR(100)
AS
BEGIN 
	BEGIN TRANSACTION;

	BEGIN TRY
	UPDATE Usuarios
	SET Email = @NuevoEmail
	WHERE UsuarioID = @UsuarioID;

    UPDATE Suscripciones
    SET Tipo = 'SUSCRIPCION PREMIUM'
	WHERE UsuarioID = @UsuarioID;

	COMMIT	TRANSACTION;
	END TRY
    BEGIN CATCH
    
	ROLLBACK TRANSACTION;
    END CATCH
END;

EXEC ActualizarCorreoSiu 5, 'correo123@ejemplo.com'
SELECT * FROM Usuarios;
SELECT * FROM Suscripciones;


CREATE PROCEDURE EliminaPeliHisto
    @PeliculaID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM HistorialVisualizacion
        WHERE PeliculaID = @PeliculaID;

        DELETE FROM Peliculas
        WHERE PeliculaID = @PeliculaID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
    END CATCH
END;

EXEC EliminaPeliHisto 5

SELECT * FROM Peliculas
SELECT * FROM HistorialVisualizacion


CREATE PROCEDURE EliminarUsuarioYSusDatos
    @UsuarioID INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        DELETE FROM HistorialVisualizacion
        WHERE UsuarioID = @UsuarioID;

        DELETE FROM Suscripciones
        WHERE UsuarioID = @UsuarioID;

        DELETE FROM Usuarios
        WHERE UsuarioID = 7;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

    END CATCH
END;
EXEC EliminarUsuarioYSusDatos 7

SELECT * FROM HistorialVisualizacion
SELECT * FROM Suscripciones
SELECT * FROM Usuarios

