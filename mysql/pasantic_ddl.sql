CREATE DATABASE IF NOT EXISTS Pasantic;
use Pasantic;

CREATE TABLE IF NOT EXISTS Cuenta(
	cedula int,
	usuario varchar(20) not null,
    contraseña varchar(16),
    correo varchar(40),
    PRIMARY KEY (cedula),
    UNIQUE (contraseña,correo)
);

CREATE TABLE IF NOT EXISTS Empresa(
    ruc int,
    nombre varchar(25),
    e_descripcion varchar(500),
    direccion varchar(50),
    telefono int,
    sitio_web varchar(2083),
    PRIMARY KEY (ruc)
);

CREATE TABLE IF NOT EXISTS Puesto(
	empresa int,
    puesto_id int unsigned auto_increment,
    cargo varchar(25),
    p_descripcion varchar(500),
    modalidad varchar(15),
    conocimiento_requerido varchar(500),
    formacion_requerida varchar(500),
    vacantes int,
    salario float,
    area_de_trabajo varchar(50),
    PRIMARY KEY (puesto_id)
);

CREATE TABLE IF NOT EXISTS Curriculum(
    cedula int,
    universidad_id int,
    expectativa double,
    ultimo_ingreso double,
    empleo_id int,
    PRIMARY KEY (cedula)
);

CREATE TABLE IF NOT EXISTS Pasante(
    cedula int,
    carrera varchar(35),
    estado smallint,
	PRIMARY KEY (cedula)
);

CREATE TABLE IF NOT EXISTS Postulacion(
	id int unsigned auto_increment,
    puesto_id int unsigned,
    pasante int,
    estado smallint,
    fecha date ,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Educacion(
    estudiante int,
    institucion_id int,
    inicio date,
    graduacion date,
    promedio float,
    PRIMARY KEY (estudiante, institucion_id)
);

CREATE TABLE IF NOT EXISTS Universidad(
    universidad_id int,
    promedio float ,
    ingreso date ,
    PRIMARY KEY (universidad_id)
);

CREATE TABLE IF NOT EXISTS Institucion(
    institucion_id int ,
    nombre varchar(45) ,
    direccion varchar(50),
    telefono int,
    PRIMARY KEY (institucion_id)
);

CREATE TABLE IF NOT EXISTS Empleo(
    id int ,
    empresa varchar(45) ,
    actual boolean,
    pais varchar(50),
    inicio date,
    fin date,
    puesto varchar(25),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Perfil(
    cedula int,
    nombre varchar(45),
    segundo_nombre varchar(25),
    apellido_materno varchar(35),
    apellido_paterno varchar(35),
    sexo char(9),
    fechaNacimiento date,
    direccion varchar(50),
    telefono int,
    paisNacimiento char(35),
    nacionalidad varchar(35),
    foto blob,
    PRIMARY KEY (cedula),
    UNIQUE (nombre, apellido_paterno, apellido_materno)
);
