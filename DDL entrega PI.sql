-- foro
CREATE TABLE foro (
    id INT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT
);
-- usuario
CREATE TABLE usuario (
    id INT PRIMARY KEY,
    fecha_ingreso DATE,
    tipo_usuario_id INT,
    nombre VARCHAR(255),
    apellido_1 VARCHAR(255),
    apellido_2 VARCHAR(255),
    correo VARCHAR(255),
    FOREIGN KEY (tipo_usuario_id) REFERENCES tipo_usuario(id)
);
-- tipo_usuario
CREATE TABLE tipo_usuario (
    id INT PRIMARY KEY,
    clasificacion VARCHAR(50)
);
-- publicacion
CREATE TABLE publicacion (
    id INT PRIMARY KEY,
    contenido TEXT,
    fecha DATE,
    foro_id INT,
    usuario_id INT,
    FOREIGN KEY (foro_id) REFERENCES foro(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);
-- comentario
CREATE TABLE comentario (
    id INT PRIMARY KEY,
    fecha DATE,
    contenido TEXT,
    usuario_id INT,
    publicacion_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (publicacion_id) REFERENCES publicacion(id)
);
-- calculadora
CREATE TABLE calculadora (
    id INT PRIMARY KEY,
    fecha DATE,
    calcuCO2 DECIMAL(10, 2),
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);
-- inscripcion
CREATE TABLE inscripcion (
    id INT PRIMARY KEY,
    estatus VARCHAR(50),
    fecha_inscripcion DATE,
    curso_id INT,
    usuario_id INT,
    FOREIGN KEY (curso_id) REFERENCES curso(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);
-- curso
CREATE TABLE curso (
    id INT PRIMARY KEY,
    titulo VARCHAR(255),
    estatus VARCHAR(50),
    contenido TEXT,
    fecha_publicacion DATE
);
-- clases
CREATE TABLE clases (
    id INT PRIMARY KEY,
    titulo VARCHAR(255),
    contenido TEXT,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES curso(id)
);

--INSERTS
INSERT INTO tipo_usuario (id,clasificacion)
VALUES (1,'principiante'),
	(2,'avanzado'),
	(3,'experto');

INSERT INTO usuario (id, fecha_ingreso, tipo_usuario_id, nombre, apellido_1, apellido_2, correo)
VALUES (1, '2024-05-31', 1, 'Juan', 'P�rez', 'Garc�a', 'juan@gmail.com'),
	(2, '2024-06-01', 2, 'Santiago', 'Amaya', 'L�pez', 'juan@gmail.com'),
	(3, '2024-06-02', 2, 'Juan', 'Armando', 'Gallardo', 'juan@gmail.com'),
	(4, '2024-06-03', 3, 'Mar�a', 'Gonz�lez', 'Mart�nez', 'maria@gmail.com'),
    (5, '2024-06-04', 1, 'Pedro', 'Ram�rez', 'S�nchez', 'pedro@gmail.com'),
    (6, '2024-06-05', 2, 'Ana', 'L�pez', 'P�rez', 'ana@gmail.com');


insert into calculadora (id,fecha,calcuCO2,usuario_id)
values (1,'2024-06-01', 178.23, 1 ),
	   (2, '2024-06-02', 250.10, 2),
       (3, '2024-06-03', 123.45, 3),
       (4, '2024-06-04', 300.75, 1);

INSERT INTO foro (id, titulo, descripcion)
VALUES (1, 'Foro de Programaci�n', 'Discusi�n sobre lenguajes de programaci�n'),
       (2, 'Foro de Dise�o', 'Comparte tus creaciones y obt�n feedback'),
       (3, 'Foro de Ciencia', 'Debates cient�ficos y descubrimientos');

INSERT INTO publicacion (id, contenido, fecha, foro_id, usuario_id)
VALUES (1, 'Introducci�n a Python', '2024-06-01', 1, 1),
       (2, 'Dise�o de logotipos', '2024-06-02', 2, 2),
       (3, 'Avances en la f�sica cu�ntica', '2024-06-03', 3, 3);

INSERT INTO comentario (id, fecha, contenido, usuario_id, publicacion_id)
VALUES (1, '2024-06-01', '�Excelente art�culo!', 1, 1),
       (2, '2024-06-02', 'Me gustar�a colaborar en el dise�o', 2, 2),
       (3, '2024-06-03', '�Alguien m�s est� emocionado por esto?', 3, 3);

INSERT INTO curso (id, titulo, estatus, contenido, fecha_publicacion)
VALUES (1, 'Curso de SQL', 'Activo', 'Aprende a manejar bases de datos', '2024-06-01'),
       (2, 'Curso de Dise�o Gr�fico', 'Pr�ximamente', 'Herramientas y t�cnicas creativas', '2024-06-02'),
       (3, 'Curso de F�sica Cu�ntica', 'En desarrollo', 'Explorando el mundo subat�mico', '2024-06-03');

INSERT INTO clases (id, titulo, contenido, curso_id)
VALUES (1, 'Introducci�n a SQL', 'Conceptos b�sicos de consultas', 1),
       (2, 'Dise�o de logotipos avanzado', 'T�cnicas de ilustraci�n digital', 2),
       (3, 'Teor�a cu�ntica aplicada', 'Entendiendo los principios', 3);

INSERT INTO inscripcion (id, estatus, fecha_inscripcion, curso_id, usuario_id)
VALUES
    (1, 'Activa', '2024-06-01', 1, 1),
    (2, 'Pendiente', '2024-06-02', 2, 2),
    (3, 'Aprobada', '2024-06-03', 3, 3),
    (4, 'Rechazada', '2024-06-04', 1, 2),
    (5, 'En espera', '2024-06-05', 2, 3);


SELECT * FROM clases;
SELECT * FROM calculadora;
SELECT * FROM comentario;
SELECT * FROM tipo_usuario;
SELECT * FROM inscripcion;
SELECT * FROM foro;
SELECT * FROM usuario;
SELECT * FROM publicacion;
SELECT * FROM curso;

UPDATE clases
SET contenido = 'Aplicaciones pr�cticas de la teor�a cu�ntica' WHERE id = 3;
UPDATE calculadora
SET calcuCO2 = 200.50 WHERE id = 2;
UPDATE calculadora
SET calcuCO2 = 400.50 WHERE id = 3;

DELETE FROM usuario WHERE id = 6;
DELETE FROM curso WHERE id = 1;
DELETE FROM publicacion WHERE id = 1;

-- para obtener informaci�n de usuarios y sus inscripciones
SELECT u.nombre, u.apellido_1, i.estatus
FROM usuario u
INNER JOIN inscripcion i ON u.id = i.usuario_id;

-- para obtener que usuario esta en que curso
SELECT u.nombre, u.apellido_1, c.titulo
FROM usuario u
INNER JOIN inscripcion i ON u.id = i.usuario_id
INNER JOIN curso c ON i.curso_id = c.id;


-- para ver el contenido de publicaciones en algun foro
SELECT p.contenido, f.titulo
FROM publicacion p
INNER JOIN foro f ON p.foro_id = f.id;


-- para obtener informaci�n de foros y sus publicaciones
-- tomando en cuenta los foros que no tienen publicaciones
SELECT f.titulo, p.contenido
FROM foro f
LEFT JOIN publicacion p ON f.id = p.foro_id;

-- para obtener informaci�n de clases y sus cursos
-- tomando en cuenta los cursos que no tienen clases
SELECT c.titulo, cl.contenido
FROM curso c
RIGHT JOIN clases cl ON c.id = cl.curso_id;









