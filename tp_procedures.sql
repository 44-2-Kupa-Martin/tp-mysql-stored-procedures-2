--Ej 1
DROP PROCEDURE IF EXISTS usp_ListOffices;

DELIMITER $$

CREATE PROCEDURE usp_ListOffices(
    IN city VARCHAR(30)
)
main:BEGIN
    SELECT ciudad, telefono FROM oficina WHERE oficina.ciudad LIKE city;
END main$$

DELIMITER ;
