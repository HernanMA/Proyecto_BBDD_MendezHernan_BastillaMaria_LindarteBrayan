SHOW DATABASES;

CREATE DATABASE the_environmental_ones;
DROP DATABASE the_environmental_ones;

USE the_environmental_ones;

CREATE TABLE responsible_entity (
    entity_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE natural_park (
    park_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    declaration_date DATE NOT NULL,
    entity_id INT NOT NULL,
    FOREIGN KEY (entity_id) REFERENCES responsible_entity(entity_id),
    entry_count INT NOT NULL,
    areas_num INT NOT NULL
);

CREATE TABLE accommodation (
    accommodation_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category ENUM('3_Estrellas', '4_Estrellas', '5_Estrellas') NOT NULL,
    park_id INT NOT NULL,
    limit_cap INT NOT NULL,
    FOREIGN KEY (park_id) REFERENCES natural_park(park_id)
);

CREATE TABLE visitor (
    visitor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    address VARCHAR(100),
    profession VARCHAR(100),
    accommodation_id INT NOT NULL,
    FOREIGN KEY (accommodation_id) REFERENCES accommodation(accommodation_id)
);

CREATE TABLE department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    entity_id INT,
    creation_date DATE NOT NULL,
    FOREIGN KEY (entity_id) REFERENCES responsible_entity(entity_id)
);

CREATE TABLE areas (
    area_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    extension DECIMAL(10, 2) NOT NULL,
    park_id INT NOT NULL,
    FOREIGN KEY (park_id) REFERENCES natural_park(park_id)
);

CREATE TABLE species (
    species_id INT PRIMARY KEY AUTO_INCREMENT,
    scientific_name TEXT NOT NULL,
    common_name TEXT NOT NULL,
    type ENUM('Vegetal', 'Animal', 'Mineral') NOT NULL
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES areas(area_id),
    species_id INT NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    individual_count INT NOT NULL
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    id_card VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    mobile VARCHAR(50),
    salary DECIMAL(10, 2) NOT NULL,
    park_id INT NOT NULL,
    FOREIGN KEY (park_id) REFERENCES natural_park(park_id),
    type_staff ENUM('management_staff', 'surveillance_staff', 'conservation_staff', 'research_staff')
);

CREATE TABLE entry (
    entry_id INT PRIMARY KEY AUTO_INCREMENT,
    entry_number INT NOT NULL,
    park_id INT NOT NULL,
    FOREIGN KEY (park_id) REFERENCES natural_park(park_id)
);

CREATE TABLE management_staff (
    management_staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    entry_id INT NOT NULL,
    FOREIGN KEY (entry_id) REFERENCES entry(entry_id)
);

CREATE TABLE vehicle (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50),
    type VARCHAR(50)
);

CREATE TABLE surveillance_staff (
    surveillance_staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES areas(area_id),
    vehicle_id INT NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
);

CREATE TABLE conservation_staff (
    conservation_staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES areas(area_id),
    specialty VARCHAR(100) NOT NULL
);

CREATE TABLE research_staff (
    research_staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    degree VARCHAR(100) NOT NULL
);

CREATE TABLE research_project (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL, 
    budget DECIMAL(15, 2) NOT NULL,
    execution_period DATE NOT NULL,
    research_staff_id INT NOT NULL,
    FOREIGN KEY (research_staff_id) REFERENCES research_staff(research_staff_id),
    specie_id INT NOT NULL,
    FOREIGN KEY (specie_id) REFERENCES species(species_id)
);

SHOW TABLES;

SELECT *  FROM responsible_entity;

SELECT * FROM natural_park;

SELECT * FROM accommodation;

SELECT * FROM visitor;

SELECT * FROM department;

SELECT * FROM areas;

SELECT * FROM species;

SELECT * FROM inventory;

SELECT * FROM staff;

SELECT * FROM entry;

SELECT * FROM management_staff;

SELECT * FROM vehicle;

SELECT * FROM surveillance_staff;

SELECT * FROM conservation_staff;

SELECT * FROM research_staff;

SELECT * FROM research_project;