USE the_environmental_ones;

-- Transacción 1: Registrar un nuevo parque natural y su entidad responsable
  START TRANSACTION;
-- Insertar la entidad responsable
INSERT INTO responsible_entity (name) VALUES ('Entidad Ambiental XYZ');
SET @entity_id = LAST_INSERT_ID();

-- Insertar el nuevo parque natural
INSERT INTO natural_park (name, declaration_date, entity_id, entry_count, areas_num)
VALUES ('Parque Natural Nuevo', '2024-07-10', @entity_id, 0, 5);
SET @park_id = LAST_INSERT_ID();

COMMIT;

-- Transacción 2: Asignar un nuevo proyecto de investigación a un equipo de investigación
START TRANSACTION;

-- Insertar un nuevo proyecto de investigación
INSERT INTO research_project (name, budget, execution_period, research_staff_id, specie_id)
VALUES ('Proyecto de Conservación de Especie X', 50000.00, '2024-07-01', 1, 1);
SET @project_id = LAST_INSERT_ID();

COMMIT;

-- Transacción 3: Registrar un nuevo visitante y asignarlo a un alojamiento

START TRANSACTION;

-- Insertar un nuevo visitante
INSERT INTO visitor (name, address, profession, accommodation_id)
VALUES ('Juan Pérez', 'Calle Principal 123', 'Biologist', 1);

COMMIT;
