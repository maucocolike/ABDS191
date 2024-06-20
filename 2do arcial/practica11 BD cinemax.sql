CREATE TABLE Usuarios (
UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
Nombre NVARCHAR(100) NOT NULL,
Email NVARCHAR(100) NOT NULL UNIQUE,
Pass NVARCHAR(100) NOT NULL,
FechaRegistro DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Peliculas (
PeliculaID INT IDENTITY(1,1) PRIMARY KEY,
Titulo NVARCHAR (100) NOT NULL,
Genero NVARCHAR (50), FechaEstreno DATE
);

CREATE TABLE Suscripciones (
SuscripcionID INT IDENTITY(1,1) PRIMARY KEY,
UsuarioID INT NOT NULL,
FechaInicio DATE NOT NULL,
FechaFin DATE,
Tipo NVARCHAR( 50),
FOREIGN KEY (UsuarioID) REFERENCES Usuarios (UsuarioID)
);

CREATE TABLE HistorialVisualizacion (
HistorialID INT IDENTITY(1,1) PRIMARY KEY,
UsuarioID INT NOT NULL,
PeliculaID INT NOT NULL,
FechaVisualizacion DATETIME NOT NULL DEFAULT GETDATE(), 
FOREIGN KEY (UsuarioID) REFERENCES Usuarios (UsuarioID), 
FOREIGN KEY (PeliculaID) REFERENCES Peliculas (PeliculaID)
);

INSERT INTO Usuarios (Nombre, Email, Pass)
VALUES
('Carlos P�rez', 'carlos.perez@ejemlo.com', 'pa123'),
('Mar�a Gonz�lez', 'maria.gonzalez@ejemlo.com', 'pas123'),
('Juan L�pez', 'juan.lopez@ejemlo.com', 'password3'),
('Ana Mart�nez', 'ana.martinez@ejemlo.com', 'passw123'),
('Pedro Fern�ndez', 'pedro.fernandez@ejemlo.com', 'passwo123'),
('Luc�a Ram�rez', 'lucia.ramirez@ejemlo.com', 'passwor123'),
('Javier D�az', 'javier.diaz@ejemlo.com', 'password123'),
('Sof�a Torres', 'sofia.torres@exaejemlomple.com', 'paword123'),
('Andr�s S�nchez', 'andres.sanchez@ejemlo.com', 'passrd123'),
('Elena Morales', 'elena.morales@ejemlo.com', 'p123');

INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
VALUES
('El Gran Escape', 'Acci�n', '2023-01-15'),
('Amor en Tiempos de Guerra', 'Romance', '2022-12-12'),
('La Vida Secreta de las Mascotas', 'Animaci�n', '2019-07-08'),
('El Misterio de la Mansi�n', 'Suspenso', '2021-10-31'),
('La Venganza del Ninja', 'Acci�n', '2020-06-05'),
('Cocina con Amor', 'Comedia', '2023-03-22'),
('El �ltimo Baile', 'Drama', '2020-11-18'),
('Cazadores de Fantasmas', 'Terror', '2022-09-29'),
('El Tesoro Perdido', 'Aventura', '2018-05-20'),
('Un D�a en Par�s', 'Comedia', '2021-02-14'),
('La Carrera Imposible', 'Deporte', '2022-04-25');

INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
VALUES
(1, '2023-01-01', '2023-06-01', 'Mensual'),
(2, '2023-02-01', '2023-08-01', 'Anual'),
(3, '2023-03-01', NULL, 'Mensual'),
(4, '2023-04-01', NULL, 'Mensual'),
(5, '2023-05-01', NULL, 'Mensual'),
(6, '2023-06-01', NULL, 'Mensual'),
(7, '2023-07-01', NULL, 'Mensual');

INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
VALUES
(1, 1, '2023-06-01 20:00:00'),
(1, 2, '2023-06-02 21:00:00'),
(2, 3, '2023-06-03 22:00:00'),
(2, 4, '2023-06-04 23:00:00'),
(3, 5, '2023-06-05 20:30:00'),
(3, 6, '2023-06-06 21:30:00'),
(4, 7, '2023-06-07 22:30:00'),
(4, 8, '2023-06-08 23:30:00'),
(5, 9, '2023-06-09 20:15:00'),
(5, 10, '2023-06-10 21:15:00'),
(6, 11, '2023-06-11 22:15:00'),
(6, 1, '2023-06-12 23:15:00'),
(7, 2, '2023-06-13 20:45:00'),
(7, 3, '2023-06-14 21:45:00'),
(8, 4, '2023-06-15 22:45:00'),
(8, 5, '2023-06-16 23:45:00'),
(9, 6, '2023-06-17 20:00:00'),
(9, 7, '2023-06-18 21:00:00'),
(10, 8, '2023-06-19 22:00:00'),
(10, 9, '2023-06-20 23:00:00');


CREATE VIEW VistaGeneral AS
SELECT 
    u.UsuarioID, 
    u.Nombre AS NombreUsuario, 
    u.Email, 
    p.PeliculaID, 
    p.Titulo AS TituloPelicula, 
    p.Genero AS GeneroPelicula, 
    p.FechaEstreno, 
    s.SuscripcionID, 
    s.FechaInicio AS FechaInicioSuscripcion, 
    s.FechaFin AS FechaFinSuscripcion, 
    s.Tipo AS TipoSuscripcion, 
    hv.HistorialID, 
    hv.FechaVisualizacion
FROM 
    Usuarios u
LEFT JOIN 
    Suscripciones s ON u.UsuarioID = s.UsuarioID
JOIN 
    HistorialVisualizacion hv ON u.UsuarioID = hv.UsuarioID
JOIN 
    Peliculas p ON hv.PeliculaID = p.PeliculaID;
