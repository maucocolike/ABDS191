CREATE TRIGGER DESPUES_DE_AGREGAR_TABLAENDBBANK
ON DATABASE 
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Se ha creado con éxito la tabla ';
END;

CREATE TABLE Prestamos (
    PrestamoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT,
    Monto DECIMAL(18, 2),
    TasaInteres DECIMAL(5, 2),
    FechaInicio DATE,
    FechaFin DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE PagosPrestamos (
    PagoID INT IDENTITY(1,1) PRIMARY KEY,
    PrestamoID INT,
    MontoPagado DECIMAL(18, 2),
    FechaPago DATE,
    FOREIGN KEY (PrestamoID) REFERENCES Prestamos(PrestamoID);

INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin) VALUES
(3, 10000.00, 5.50, '2023-01-10', '2025-01-10'),
(4, 15000.00, 4.50, '2023-02-20', '2023-02-20'),
(5, 20000.00, 6.00, '2023-03-30', '2027-03-30'),
(6, 12000.00, 5.00, '2023-04-15', '2026-04-15'),
(7, 18000.00, 4.80, '2023-05-25', '2023-05-25');

INSERT INTO Clientes (Nombre,Direccion,Telefono,Email) values
('karla','colinas del sol','443141313','karlacolina@gmail.com'),
('carlos','milenio','12341254','carlosmilenio@gmail.com');

INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago) VALUES
(2, 1000.00, '2023-02-10'), 
(3, 1500.00, '2023-03-15'),
(4, 2000.00, '2023-04-20'),
(5, 1200.00, '2023-05-25'),
(6, 1800.00, '2023-06-30');

CREATE TRIGGER TriggerAfterCreateProcedure
ON DATABASE
FOR CREATE_PROCEDURE
AS
BEGIN
    PRINT 'Se ha creado un Nuevo Procedimiento en DBBANK.';
END;

CREATE PROCEDURE PRESTAMOS_Y_PRIMERPAGO
    @ClienteID INT,
    @Monto DECIMAL(18, 2),
    @TasaInteres DECIMAL(5, 2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @MontoPrimerPago DECIMAL(18, 2),
    @FechaPrimerPago DATE
AS
BEGIN
    BEGIN TRANSACTION;
	BEGIN TRY
        INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin) 
        VALUES (@ClienteID, @Monto, @TasaInteres, @FechaInicio, @FechaFin);         -- Insertar el nuevo préstamo

        DECLARE @PrestamoID INT;
        SET @PrestamoID = SCOPE_IDENTITY();        -- Insertar el nuevo préstamo

        INSERT INTO PagosPrestamos(PrestamoID, MontoPagado, FechaPago)
        VALUES (@PrestamoID, @MontoPrimerPago, @FechaPrimerPago);        -- Insertar el primer pago del préstamo
	COMMIT TRANSACTION;
        PRINT 'El préstamo y el primer pago se han insertado correctamente.';    -- Mensaje de éxito
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
    END CATCH;
END;

EXEC  PRESTAMOS_Y_PRIMERPAGO
    @ClienteID = 8, 
    @Monto = 15000.00, 
    @TasaInteres = 4.5, 
    @FechaInicio = '2023-07-19', 
    @FechaFin = '2026-07-19', 
    @MontoPrimerPago = 1500.00, 
    @FechaPrimerPago = '2023-08-19';
SELECT * FROM Prestamos;
SELECT * FROM PagosPrestamos;


USE DBBank;
CREATE PROCEDURE CONSULTACOMPLETA
AS
BEGIN
    SELECT 
        c.ClienteID,
        c.Nombre,
        p.PrestamoID,
        p.Monto AS MontoPrestamo,
        p.TasaInteres,
        p.FechaInicio,
        p.FechaFin,
        pp.PagoID,
        pp.MontoPagado,
        pp.FechaPago
    FROM Clientes c
    INNER JOIN Prestamos p ON c.ClienteID = p.ClienteID
    LEFT JOIN PagosPrestamos pp ON p.PrestamoID = pp.PrestamoID;
END;

exec CONSULTACOMPLETA;


