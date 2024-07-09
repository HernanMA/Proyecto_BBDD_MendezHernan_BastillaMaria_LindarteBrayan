-- #######################
-- #### Consultas ########
-- #######################



-- Consulta# 1 


SELECT a.name AS Alojamiento, COUNT(v.id_visitor) AS Numero_de_Personas
FROM accommodation a
JOIN visitor v ON a.id_accommodation = v.id_accommodation
GROUP BY a.name
ORDER BY Numero_de_Personas DESC
LIMIT 1;



-- Consulta# 2 




SELECT a.name AS Alojamiento, COUNT(v.visitor_id) AS Numero_de_Personas
FROM accommodation a
JOIN visitor v ON a.accommodation_id = v.accommodation_id
GROUP BY a.name;



-- Consulta# 3 


SELECT np.name AS Parque, e.name AS Entidad
FROM natural_park np
JOIN responsible_entity e ON np.entity_id = e.entity_id;






-- Consulta# 4 



SELECT COUNT(v.visitor_id) AS Numero_de_Personas_Sin_Alojamiento
FROM visitor v
WHERE v.accommodation_id IS NULL;


-- Consulta# 5 


SELECT COUNT(s.staff_id) AS Numero_de_Staff
FROM staff s
JOIN management_staff ms ON s.staff_id = ms.staff_id
JOIN areas a ON s.park_id = a.park_id
WHERE a.area_id = 2 AND s.park_id = 7;




-- Consulta# 6 


SELECT np.name AS Parque, COUNT(DISTINCT s.species_id) AS Numero_de_Especies
FROM natural_park np
JOIN inventory i ON np.park_id = i.area_id
JOIN species s ON i.species_id = s.species_id
WHERE s.type = 'Vegetal'
GROUP BY np.name;


select * from visitor;

