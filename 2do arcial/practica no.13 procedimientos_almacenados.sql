CREATE PROCEDURE insertarUsuarios 
@nom nvarchar(100),
@email nvarchar(100),
@contra nvarchar(100),
@fecha date
as
BEGIN
	Insert into Usuarios(Nombre, Email, Pass, FechaRegistro)
	values(@nom,@email,@contra,@fecha);
END;

exec insertarUsuarios @nom = 'maucoco', @email = 'mauricioaleman@gmail.com', @contra = 'maucocon', @fecha = '2024-06-19'

select * from Usuarios



create procedure actualizarSuscrip 
@id int,
@tipo nvarchar(50)
as
begin
update Suscripciones
set Tipo = @tipo
where SuscripcionID = @id
end;

exec actualizarSuscrip @id = '3', @tipo = 'suscrip premium'

select * from Suscripciones



create procedure eliminarHistorial
@id int
as
begin
delete from HistorialVisualizacion where HistorialID = @id
end;

exec eliminarHistorial 3

select * from HistorialVisualizacion;



create procedure consultarSuscrip
@tipoS nvarchar(50)
as
begin
select u.Nombre as nombre_usuario, s.Tipo as tipo_suscripcion
from Usuarios u
left join Suscripciones s on u.UsuarioID = s.UsuarioID
where @tipoS = Tipo
end;

exec consultarSuscrip @tipoS = 'Anual'



CREATE PROCEDURE ConsultarPeliGenero
    @Genero nvarchar(50)
AS
BEGIN
    SELECT u.Nombre, p.PeliculaID, p.Titulo, p.Genero, hv.FechaVisualizacion
    FROM HistorialVisualizacion hv
    JOIN Peliculas p ON hv.PeliculaID = p.PeliculaID
	join Usuarios u on u.UsuarioID = hv.UsuarioID
    WHERE p.Genero = @Genero;
END;

exec ConsultarPeliGenero comedia


