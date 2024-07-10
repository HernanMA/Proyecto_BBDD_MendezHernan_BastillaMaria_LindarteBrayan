USE the_environmental_ones;

-- #######################################
-- ######### PROCEDIMIENTOS ##############
-- #######################################

-- Listar todos los visitantes con el nombre del parque natural y la categoría del alojamiento donde se hospedan.
DELIMITER //

CREATE PROCEDURE visitantes_parque()
BEGIN
    SELECT 
        visitor.name AS visitante, 
        natural_park.name AS parque_natural, 
        accommodation.name AS name_house,
        accommodation.category AS categoria_alojamiento
    FROM 
        visitor
    LEFT JOIN 
        accommodation ON visitor.accommodation_id = accommodation.accommodation_id
    LEFT JOIN 
        natural_park ON accommodation.park_id = natural_park.park_id;
END;
//

DELIMITER ;

CALL visitantes_parque();

-- Obtener todos los empleados (staff) con sus respectivos detalles del parque natural en el que trabajan.

DELIMITER // 
CREATE PROCEDURE parque_staff()
BEGIN
	SELECT staff.name as name_staff, natural_park.name as park_name
    FROM staff
    LEFT JOIN natural_park ON staff.staff_id = natural_park.park_id;
END;
//

DELIMITER ;

CALL parque_staff();

-- Obtener una lista de todos los visitantes y, en caso de que no tengan una profesión registrada, mostrar "Profesión no registrada".
DELIMITER // 
CREATE PROCEDURE visitantes_pro()
BEGIN 
	SELECT visitor.name
    FROM visitor
	WHERE  profession IS NULL;
END;
//
DELIMITER ;

CALL visitantes_pro();

-- Mostrar todos los proyectos de investigación junto con los nombres de los investigadores y el nombre común de la especie que están investigando.

DELIMITER //
CREATE PROCEDURE investigation()
BEGIN 
    SELECT 
        research_project.name AS project_name, 
        research_staff.staff_id AS id_staff, 
        staff.name AS staff_name, 
        species.common_name AS species_name
    FROM 
        research_project
    INNER JOIN 
        research_staff ON research_project.research_staff_id = research_staff.research_staff_id
    INNER JOIN 
        staff ON research_staff.staff_id = staff.staff_id
    INNER JOIN 
        species ON research_project.specie_id = species.species_id;
END;
// 
DELIMITER ;

CALL investigation();
	
-- Listar todos los vehículos asignados al personal de vigilancia junto con el nombre del área que supervisan.
DELIMITER //
CREATE PROCEDURE autos_staff()
BEGIN
    SELECT 
        surveillance_staff.staff_id AS id_vigilance, 
        staff.name AS name_staff, 
        vehicle.type,
        areas.name AS area_name
    FROM 
        staff
    INNER JOIN 
        surveillance_staff ON staff.staff_id = surveillance_staff.staff_id
    LEFT JOIN 
        vehicle ON surveillance_staff.vehicle_id = vehicle.vehicle_id
    LEFT JOIN 
        areas ON surveillance_staff.area_id = areas.area_id;
END;
//
DELIMITER ;

CALL autos_staff();

-- Obtener una lista de todos los parques naturales y el total de personal de cada tipo que trabaja en ellos (management, surveillance, conservation, research).

DELIMITER //

CREATE PROCEDURE parque_personal()
BEGIN
    SELECT natural_park.name, COUNT(staff.staff_id) AS staff_count
    FROM staff
    LEFT JOIN natural_park ON staff.park_id = natural_park.park_id
    GROUP BY natural_park.name;
END //

DELIMITER ;

CALL parque_personal();

-- Mostrar los parques naturales que tienen un número de áreas mayor que el promedio de áreas de todos los parques.

DELIMITER //
CREATE PROCEDURE areas()
BEGIN
	SELECT natural_park.park_id, natural_park.name, natural_park.areas_num
	FROM natural_park 
	WHERE natural_park.areas_num > (
		SELECT AVG(natural_park2.areas_num)
		FROM natural_park natural_park2
									);
END;
//

DELIMITER ;

CALL areas();

-- Listar todos los departamentos y los nombres de las entidades responsables de ellos, mostrando también aquellos departamentos que no tienen una entidad responsable asignada.

DELIMITER //
CREATE PROCEDURE depa_entities()
BEGIN
	SELECT department.department_id, department.name AS department_name, responsible_entity.name 
	FROM department 
	LEFT JOIN responsible_entity ON department.entity_id = responsible_entity.entity_id;
END;
//

CALL depa_entities();

-- ###################################
-- ######### FUNCIONES ###############
-- ###################################

-- 1. Agregar un nuevo visitante y asignarlo a un alojamiento
DELIMITER //
CREATE FUNCTION add_visitor(
    visitor_name VARCHAR(100),
    visitor_address VARCHAR(100),
    visitor_profession VARCHAR(100),
    accommodation_id INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE new_visitor_id INT;
    
    INSERT INTO visitor (name, address, profession, accommodation_id)
    VALUES (visitor_name, visitor_address, visitor_profession, accommodation_id);
    
    SET new_visitor_id = LAST_INSERT_ID();
    
    RETURN new_visitor_id;
END;
DELIMITER ;

SELECT add_visitor('John Doe', '123 Main St', 'Engineer', 1);

-- 2. Calcular el número total de visitantes en un parque específico
DELIMITER //
CREATE FUNCTION total_visitors_in_park(park_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE visitor_count INT;
    
    SELECT COUNT(*)
    INTO visitor_count
    FROM visitor v
    JOIN accommodation a ON v.accommodation_id = a.accommodation_id
    WHERE a.park_id = park_id;
    
    RETURN visitor_count;
END;
DELIMITER ;

SELECT total_visitors_in_park(1);

-- 3. Calcular el número total de especies en un parque específico
DELIMITER //
CREATE FUNCTION total_species_in_park(park_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE species_count INT;
    
    SELECT COUNT(DISTINCT i.species_id)
    INTO species_count
    FROM inventory i
    JOIN areas a ON i.area_id = a.area_id
    WHERE a.park_id = park_id;
    
    RETURN species_count;
END;

DELIMITER ;
SELECT total_species_in_park(1);

-- 4. Actualizar el salario de un empleado específico
DELIMITER //
CREATE FUNCTION update_staff_salary(staff_id INT, new_salary DECIMAL(10, 2))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
BEGIN
    UPDATE staff
    SET salary = new_salary
    WHERE staff_id = staff_id;
    
    RETURN 'Salary updated successfully';
END;

DELIMITER ;

SELECT update_staff_salary(1, 5000.00);

-- 5. Obtener el total de ingresos generados por las entradas en un parque
DELIMITER //
CREATE FUNCTION total_park_entry_revenue(park_id INT)
RETURNS DECIMAL(15, 2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(15, 2);
    
    SELECT SUM(entry_number)
    INTO total_revenue
    FROM entry
    WHERE park_id = park_id;
    
    RETURN total_revenue;
END;

DELIMITER ;
SELECT total_park_entry_revenue(1);





