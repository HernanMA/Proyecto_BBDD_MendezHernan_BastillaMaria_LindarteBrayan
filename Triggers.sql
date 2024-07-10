-- ##############################
-- ######## Triggers ############


show databases;
use the_environmental_ones;


-- TABLA DE AUDITORIA STAFF

 CREATE TABLE staff_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(10),
    id_staff INT,
    name VARCHAR(45),
    type_staff VARCHAR(45),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //


CREATE TRIGGER before_staff_insert
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    INSERT INTO staff_audit (action_type, id_staff, name, type_staff)
    VALUES ('INSERT', NEW.staff_id, NEW.name, NEW.type_staff);
END//



CREATE TRIGGER before_staff_update
BEFORE UPDATE ON staff
FOR EACH ROW
BEGIN
    INSERT INTO staff_audit (action_type, id_staff, name, type_staff)
    VALUES ('UPDATE', NEW.staff_id, NEW.name, NEW.type_staff);
END//


DELIMITER ;
select * from staff;
select * from staff_audit;

INSERT INTO staff (id_card, name, address, phone, mobile, salary, park_id, type_staff) 
VALUES ('123456789', 'holaaaaaaaaaa', '123 Main St', '555-555-5555', '555-555-5556', 50000.00, 1, 'management_staff');

UPDATE staff SET name = 'Jane Smith' WHERE staff_id = 1;


-- TABLA AUDITORIA VISITOR

-- TABLA DE AUDITORIA STAFF


CREATE TABLE visitor_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(10),
    visitor_id INT,
    name VARCHAR(100),
    address VARCHAR(100),
    profession VARCHAR(100),
    accommodation_id INT,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //

CREATE TRIGGER before_visitor_insert
BEFORE INSERT ON visitor
FOR EACH ROW
BEGIN
    INSERT INTO visitor_audit (action_type, visitor_id, name, address, profession, accommodation_id)
    VALUES ('INSERT', NEW.visitor_id, NEW.name, NEW.address, NEW.profession, NEW.accommodation_id);
END//


CREATE TRIGGER before_staff_insert
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    INSERT INTO staff_audit (action_type, id_staff, name, type_staff)
    VALUES ('INSERT', NEW.staff_id, NEW.name, NEW.type_staff);
END//
DELIMITER ;

DELIMITER //

CREATE TRIGGER before_visitor_update
BEFORE UPDATE ON visitor
FOR EACH ROW
BEGIN
    INSERT INTO visitor_audit (action_type, visitor_id, name, address, profession, accommodation_id)
    VALUES ('UPDATE', NEW.visitor_id, NEW.name, NEW.address, NEW.profession, NEW.accommodation_id);
END//

DELIMITER ;



select * from visitor;
select * from visitor_audit;

UPDATE visitor SET name = 'John Smith', profession = 'Senior Engineer' WHERE visitor_id = 1;













