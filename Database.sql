SHOW DATABASES;

CREATE DATABASE Los_Ambientales;
DROP DATABASE Los_Ambientales;
USE Los_Ambientales;

CREATE TABLE entidad_responsable (
    id_entidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE parque (
    id_parque INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fecha_declaracion DATE NOT NULL,
    id_entidad INT NOT NULL,
    FOREIGN KEY (id_entidad) REFERENCES entidad_responsable(id_entidad)
);

CREATE TABLE alojamiento (
    id_alojamiento INT PRIMARY KEY AUTO_INCREMENT,
    capacidad INT NOT NULL,
    id_parque INT NOT NULL,
    FOREIGN KEY (id_parque) REFERENCES parque(id_parque)
);

CREATE TABLE visitante (
    id_visitante INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    profesion VARCHAR(100),
    id_alojamiento INT NOT NULL,
    FOREIGN KEY (id_alojamiento) REFERENCES alojamiento(id_alojamiento)
);

CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    id_entidad INT,
    FOREIGN KEY (id_entidad) REFERENCES entidad_responsable(id_entidad)
);

CREATE TABLE areas (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    extension DECIMAL(10, 2) NOT NULL,
    id_parque INT NOT NULL,
    FOREIGN KEY (id_parque) REFERENCES parque(id_parque)
);

CREATE TABLE especie (
    id_especie INT PRIMARY KEY AUTO_INCREMENT,
    denominacion_cientifica TEXT NOT NULL,
    denominacion_vulgar TEXT NOT NULL,
    tipo ENUM('Vegetal', 'Animal', 'Mineral') NOT NULL
);

CREATE TABLE inventario (
    id_inventario INT PRIMARY KEY AUTO_INCREMENT,
    id_area INT NOT NULL,
    FOREIGN KEY (id_area) REFERENCES areas(id_area),
    id_especie INT NOT NULL,
    FOREIGN KEY (id_especie) REFERENCES especie(id_especie),
    numero_individuos INT NOT NULL
);

CREATE TABLE proyecto_investigacion (
    id_proyecto INT PRIMARY KEY AUTO_INCREMENT,
    presupuesto DECIMAL(15, 2) NOT NULL,
    periodo_realizacion VARCHAR(100) NOT NULL
);

CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY AUTO_INCREMENT,
    marca VARCHAR(50),
    placa VARCHAR(10),
    tipo VARCHAR(50)
);

CREATE TABLE personal (
    id_personal INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    movil VARCHAR(50),
    sueldo DECIMAL(10, 2) NOT NULL,
    id_parque INT NOT NULL,
    FOREIGN KEY (id_parque) REFERENCES parque(id_parque)
);

CREATE TABLE personal_gestion (
    id_personal_gestion INT PRIMARY KEY AUTO_INCREMENT,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    id_entrada INT NOT NULL
);

CREATE TABLE personal_vigilancia (
    id_personal_vigilancia INT PRIMARY KEY AUTO_INCREMENT,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    id_area INT NOT NULL,
    FOREIGN KEY (id_area) REFERENCES areas(id_area),
    id_vehiculo INT NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
);

CREATE TABLE personal_conservacion (
    id_personal_conservacion INT PRIMARY KEY AUTO_INCREMENT,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    id_area INT NOT NULL,
    FOREIGN KEY (id_area) REFERENCES areas(id_area),
    especialidad VARCHAR(100) NOT NULL
);

CREATE TABLE personal_investigador (
    id_personal_investigador INT PRIMARY KEY AUTO_INCREMENT,
    id_personal INT NOT NULL,
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    id_proyecto INT NOT NULL,
    FOREIGN KEY (id_proyecto) REFERENCES proyecto_investigacion(id_proyecto),
    titulacion VARCHAR(100) NOT NULL
);

SHOW TABLES;



