/*create procedure nombre_procedimiento
	@parametro1 tipo_dato,
	@parametro2 tipo_dato

	as

	begin
	-- instrucciones T-SQL aqui
	end;

-- Explorar las propiedades de las BD 
exec sp_helpdb 

-- Explorar las propiedades de UNA BD 
exec sp_helpdb 'cinemax'

-- explorar las propiedades de un objeto de la bd
exec sp_help 'Peliculas'

-- informacion de los usuarios y los procesos actuales
exec sp_who

-- rendimiento del servidor
exec sp_monitor

-- espacio usado por la BD
exec sp_spaceused

--puerto de escucha del SQL server
exec sp_readerrorlog 0,1



create procedure sp_ObtenerHistorial
	@usuarioID int 
as
begin
	select h.historialID, p.titulo, h.FechaVisualizacion
	from HistorialVisualizacion h 
	join Peliculas p on h.PeliculaID = p.PeliculaID
	where h.UsuarioID = @usuarioID
	order by h.FechaVisualizacion desc
	end;

exec sp_ObtenerHistorial 5


-- sp para insertar peliculas
create procedure sp_insertarPelicula
 @titulo nvarchar(100),
 @genero nvarchar(50),
 @FechaEstreno date
 as
 begin
	insert into Peliculas(Titulo,Genero,FechaEstreno)
	values (@titulo,@genero,@FechaEstreno);
 end
 */

 exec sp_insertarPelicula 'intesamente 2', 'infantil', '2222-06-13'

 select * from Peliculas;


