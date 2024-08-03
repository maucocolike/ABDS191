-- mensaje de aviso para el ingreso de un nuevo cliente
CREATE TRIGGER DespuesInsertarCliente
ON Clientes
AFTER INSERT
AS
BEGIN
    PRINT 'Un nuevo cliente ha sido agregado';
END;

-- mensaje de aviso para la eliminacion de un cliente
CREATE TRIGGER DespuesEliminarCliente
ON Clientes
AFTER DELETE
AS
BEGIN
    PRINT 'Se ha eliminado con exito un cliente';
END;

-- si exite el cliente no se podra volver a registrar
CREATE TRIGGER AnterInsertCuenta
ON Cuentas
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ClienteID int;
    DECLARE @ExisteCliente int;
    -- Obtener el ClienteID de la nueva cuenta
    SELECT @ClienteID = ClienteID FROM inserted;
    -- Verificar si el cliente existe en la tabla Clientes
    SELECT @ExisteCliente = COUNT(*) 
    FROM Clientes
    WHERE ClienteID = @ClienteID;

    IF @ExisteCliente = 0
    BEGIN
        -- si Cliente no existe, desplegar mensaje de aviso
        PRINT 'Error: No se puede crear la cuenta. El cliente con ID ' + CAST(@ClienteID AS nvarchar) + ' no existe.';
    END
    ELSE
    BEGIN
        -- si Cliente existe, insertar la nueva cuenta
        INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura)
        SELECT ClienteID, TipoCuenta, Saldo, FechaApertura
        FROM inserted;

        PRINT 'Cuenta creada exitosamente para el cliente con ID ' + CAST(@ClienteID AS nvarchar) + '.';
    END
END;
