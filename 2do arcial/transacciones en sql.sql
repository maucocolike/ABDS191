CREATE PROCEDURE NuevaSuscripcion
    @UsuarioID int,
    @Fechaini date,
	@Fechafin date,
	@tipo nvarchar(50)
AS
BEGIN
	--iniciar transaccion
		begin transaction 
		begin try
		-- codigo de la transaccion
		INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
        VALUES (@UsuarioID, @Fechaini, @Fechafin, @Tipo);

		UPDATE Suscripciones
        SET Tipo = @tipo,
		FechaInicio = @Fechaini,
		FechaFin = @Fechafin
        WHERE UsuarioID = @UsuarioID;
		
		commit transaction;
		end try
		begin catch 
		--recoger y mostrar los errores 
		rollback transaction 
		end catch
END;

exec NuevaSuscripcion 3, '2024-07-01', '2023-07-01', 'Anual'

select * from Suscripciones





