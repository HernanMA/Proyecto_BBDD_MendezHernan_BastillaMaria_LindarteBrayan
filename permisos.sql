-- #############################
-- #### Permisos y accesos #####
-- #############################


-- User management_staff

create user 'management_staff'@'%' identified by 'management_staff236';

-- permisos de management_staff depedendiendo de las consultas que el puede hacer 
GRANT SELECT ON the_environmental_ones.natural_park TO 'management_staff'@'%';
GRANT SELECT ON the_environmental_ones.areas TO 'management_staff'@'%';
GRANT SELECT ON the_environmental_ones.visitor TO 'management_staff'@'%';
GRANT SELECT ON the_environmental_ones.entry TO 'management_staff'@'%';



-- el management tiene el permiso de visualizar las personas que van a entrar al parque con el fin de que las personas que entren 
-- sea en el parque correcto , tiene el permiso de visualizar la tabla de entradas y areas y finalmente la infrormacion del 
-- parque donde labora para brindarle informacion del parque a los vistante 


-- User surveillance_staff

create user 'surveillance_staff'@'%' identified by 'surveillance_staff356';

-- permisos de surveillance_staff depedendiendo de las consultas que el puede hacer 
GRANT SELECT ON the_environmental_ones.natural_park TO 'surveillance_staff'@'%';
GRANT SELECT ON the_environmental_ones.areas TO 'surveillance_staff'@'%';
GRANT SELECT ON the_environmental_ones.visitor TO 'surveillance_staff'@'%';
GRANT SELECT ON the_environmental_ones.entry TO 'surveillance_staff'@'%';
GRANT SELECT ON the_environmental_ones.vehicles TO 'surveillance_staff'@'%';

--  El surveillance staff tiene el permiso de visualizar la informacion de los parques y areas para brindarle a los viistantes 
-- esta informacion si la necesitan , puede visualizar tambien la tabla de visitantes de su parque para que pueda tener control 
-- en caso de alguna emergencia , puede visualizar la tabla de su vehiculo para obtener la informacion de este.


-- User conservation_staff

create user 'conservation_staff'@'%' identified by 'conservation_staff895';

-- permisos de conservation_staff895 depedendiendo de las consultas que el puede hacer 
GRANT SELECT ON the_environmental_ones.areas TO 'surveillance_staff'@'%';
GRANT SELECT ON the_environmental_ones.entry TO 'surveillance_staff'@'%';


-- el personal de conservacion tiene el permiso de visualizar las areas del parque y las etradas de este 


-- User research_staff

create user 'research_staff'@'%' identified by 'research_staff';

-- permisos de research_staff depedendiendo de las consultas que el puede hacer 
GRANT SELECT, INSERT, UPDATE ON the_environmental_ones.species TO 'research_staff'@'%';
GRANT SELECT ON the_environmental_ones.research_staff TO 'research_staff'@'%';
GRANT SELECT ON the_environmental_ones.research_project TO 'research_staff'@'%';


-- El personal de investigancion tiene el permiso de visualizar los datos de los proyectos , puede mirar  las especies dentro del parque en caso de encontrar una nueva 
-- puede insertar los datos de la especie y actualizar esta tabla  y los investigadores

