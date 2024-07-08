SHOW DATABASES;

CREATE DATABASE the_environmental_ones;

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
    entry_count INT NOT NULL
);

CREATE TABLE accommodation (
    accommodation_id INT PRIMARY KEY AUTO_INCREMENT,
    capacity INT NOT NULL,
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

CREATE TABLE research_project (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    budget DECIMAL(15, 2) NOT NULL,
    execution_period VARCHAR(100) NOT NULL
);

ALTER TABLE research_project ADD name VARCHAR (100);


CREATE TABLE vehicle (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50),
    plate VARCHAR(10),
    type VARCHAR(50)
);

ALTER TABLE vehicle DROP COLUMN plate;

CREATE TABLE personnel (
    personnel_id INT PRIMARY KEY AUTO_INCREMENT,
    id_card VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    mobile VARCHAR(50),
    salary DECIMAL(10, 2) NOT NULL,
    park_id INT NOT NULL,
    FOREIGN KEY (park_id) REFERENCES natural_park(park_id)
);

RENAME TABLE personnel TO staff;

CREATE TABLE management_personnel (
    management_personnel_id INT PRIMARY KEY AUTO_INCREMENT,
    personnel_id INT NOT NULL,
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id),
    entry_id INT NOT NULL
);

CREATE TABLE entry (
    entry_id INT PRIMARY KEY AUTO_INCREMENT,
    entry_number INT NOT NULL,
    management_personnel_id INT NOT NULL,
    FOREIGN KEY (management_personnel_id) REFERENCES management_personnel(management_personnel_id),
    park_id INT NOT NULL,
    FOREIGN KEY (park_id) REFERENCES natural_park(park_id)
);

CREATE TABLE surveillance_personnel (
    surveillance_personnel_id INT PRIMARY KEY AUTO_INCREMENT,
    personnel_id INT NOT NULL,
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id),
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES areas(area_id),
    vehicle_id INT NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
);

CREATE TABLE conservation_personnel (
    conservation_personnel_id INT PRIMARY KEY AUTO_INCREMENT,
    personnel_id INT NOT NULL,
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id),
    area_id INT NOT NULL,
    FOREIGN KEY (area_id) REFERENCES areas(area_id),
    specialty VARCHAR(100) NOT NULL
);

CREATE TABLE research_personnel (
    research_personnel_id INT PRIMARY KEY AUTO_INCREMENT,
    personnel_id INT NOT NULL,
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id),
    project_id INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES research_project(project_id),
    degree VARCHAR(100) NOT NULL
);


SHOW TABLES;



