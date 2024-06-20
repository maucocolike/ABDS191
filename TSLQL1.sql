--TSQL
/*
--DECLARAR VARIABLE 

declare @idCliente int

--inicializar o asignar valor

set @idCliente = 8

--if

-- IF @idCliente = 8
-- select * from Clientes where id_cliente = @idCliente

declare @edad int 
set @idCliente = 9 

IF @idCliente = 9 
set @edad = 25
select * from Clientes where id_clientes = @idCliente
print @edad

	if EXISTS(select * from Clientes where id_clientes = @idCliente)
	print 'si existe'
END

ELSE BEGIN 
	print 'error:'
	print 'id no autorizado para la consulta'
	end


--while 

declare @contador int = 0

while @contador <=10
begin
	print @contador
	set @contador = @contador + 1
	if @contador = 3
		break

	print 'hola'
end
print 'aqui continua el flujo'
begin try
set @contador = 'maucoco'		
end try
begin catch
print ('la variable del contador solo acepta enteros')

end catch

print ('soy otra consulta')
*/

declare @valor int
declare @resultado char(11) = ''
set @valor = 110;

set @resultado = (case when @valor=10 then 'rojo' 
						when @valor = 20 then 'morado'
						when @valor = 30 then 'negro'
						else 'gris'
						end); 
print @resultado


select * ,(case when disponibilidad= 'disponible' then 'verde'
				when disponibilidad= 'no disponible' then 'rojo'
				else 'negro') as indicador 
				from inventario;




