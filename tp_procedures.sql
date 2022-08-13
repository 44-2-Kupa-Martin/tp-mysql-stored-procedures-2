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

--Ejercicio 2

DROP PROCEDURE IF EXISTS jefes7;

DELIMITER ..
CREATE PROCEDURE jefes7()
main: BEGIN
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;
END main.. 

DELIMITER ;

--Ejercicio 3

DROP PROCEDURE IF EXISTS pedidostarde;

DELIMITER ..

CREATE PROCEDURE pedidostarde()

main:BEGIN
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_esperada < fecha_entrega;

END main..

DELIMITER ;

--Ejercicio 4

DROP PROCEDURE IF EXISTS 2diasantes;

DELIMITER ..

CREATE PROCEDURE 2diasantes()

main:BEGIN
SELECT  codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega  FROM pedido WHERE DATE_SUB(fecha_esperada, INTERVAL 2 DAY) > fecha_entrega;
END main..

DELIMITER ;

--Ejercicio 5

DROP PROCEDURE IF EXISTS 2009rechazados;

DELIMITER ..

CREATE PROCEDURE 2009rechazados()

main:BEGIN
SELECT * FROM pedido WHERE YEAR(fecha_pedido) = 2009 AND estado = "Rechazado";

END main..

DELIMITER ;

--Ejercicio 6

DROP PROCEDURE IF EXISTS 2008paypal;

DELIMITER ..

CREATE PROCEDURE 2008paypal()

main:BEGIN
SELECT * FROM pago WHERE YEAR(fecha_pago) = 2008 AND forma_pago = "PayPal" ORDER BY total DESC;

END main..

DELIMITER ;

--Ejercicio 7

DROP PROCEDURE IF EXISTS stocknamentales;

DELIMITER ..

CREATE PROCEDURE stocknamentales()

main:BEGIN
SELECT * FROM producto WHERE gama = "Ornamentales" AND cantidad_en_stock >= 100 ORDER BY precio_venta DESC;

END main..

DELIMITER ;

--Ejercicio 8

DROP PROCEDURE IF EXISTS madridventas;

DELIMITER ..

CREATE PROCEDURE madridventas()

main:BEGIN
SELECT * FROM cliente WHERE ciudad = "Madrid" AND codigo_empleado_rep_ventas IN (11, 30);

END main..

DELIMITER ;

CALL madridventas();

--Ej 9
DROP PROCEDURE IF EXISTS usp_ListPastClients;

DELIMITER $$

CREATE PROCEDURE usp_ListPastClients()
main:BEGIN
    SELECT 
        past_clients.nombre_cliente,
        employees_cities.nombre_empleado,
        employees_cities.oficina_ciudad
    FROM 
        (SELECT  
            cliente.nombre_cliente,
            cliente.codigo_empleado_rep_ventas
        FROM 
            cliente
        WHERE 
            EXISTS 
            (SELECT *
            FROM 
                pago 
            WHERE pago.codigo_cliente = cliente.codigo_cliente)
        GROUP BY codigo_cliente)
    AS past_clients 
    LEFT JOIN 
        (SELECT 
            empleado.codigo_empleado, 
            empleado.nombre AS nombre_empleado, 
            oficina.ciudad AS oficina_ciudad 
        FROM 
            empleado 
        LEFT JOIN 
            oficina 
        ON empleado.codigo_oficina = oficina.codigo_oficina) 
    AS employees_cities
    ON past_clients.codigo_empleado_rep_ventas = employees_cities.codigo_empleado
    ;
END main$$

DELIMITER ;

--Ej 10
DROP PROCEDURE IF EXISTS usp_ListClientsAndReps;

DELIMITER $$

CREATE PROCEDURE usp_ListClientsAndReps()
main:BEGIN
    SELECT
        cliente.nombre_cliente,
        empleado.nombre AS empleado_nombre,
        CONCAT_WS(" ", empleado.apellido1, empleado.apellido2) AS empleado_apellido
    FROM
        cliente
    LEFT JOIN
        empleado
    ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
    ;
END main$$

DELIMITER ;

--Ej 11
DROP PROCEDURE IF EXISTS usp_CountClientsByCountry;

DELIMITER $$

CREATE PROCEDURE usp_CountClientsByCountry()
main:BEGIN
    SELECT
        COUNT(cliente.codigo_cliente) AS clientes,
        pais
    FROM
        cliente
    GROUP BY
        pais
    ;
END main$$

DELIMITER ;

--Ej 12
DROP PROCEDURE IF EXISTS usp_ShowOrderStatus;

DELIMITER $$

CREATE PROCEDURE usp_ShowOrderStatus()
main:BEGIN
    SELECT
        COUNT(estado) AS cantidad,
        estado
    FROM
        pedido
    GROUP BY
        estado
    ORDER BY
        cantidad DESC
    ;
END main$$

DELIMITER ;

--Ej 13
DROP PROCEDURE IF EXISTS usp_CountClients;

DELIMITER $$

CREATE PROCEDURE usp_CountClients()
main:BEGIN
    SELECT
        COUNT(codigo_cliente) AS nro_clientes
    FROM
        cliente
    ;
END main$$

DELIMITER ;

--Ej 14
DROP PROCEDURE IF EXISTS usp_CountClientsInMadrid;

DELIMITER $$

CREATE PROCEDURE usp_CountClientsInMadrid()
main:BEGIN
    SELECT COUNT(codigo_cliente) AS "clientes" FROM cliente WHERE ciudad LIKE "Madrid";
END main$$

DELIMITER ;

--Ej 15
DROP PROCEDURE IF EXISTS usp_CountClientsInM;

DELIMITER $$

CREATE PROCEDURE usp_CountClientsInM()
main:BEGIN
    SELECT COUNT(codigo_cliente) AS "clientes" FROM cliente WHERE ciudad LIKE "M%";
END main$$

DELIMITER ;

--Ej 16
DROP PROCEDURE IF EXISTS usp_HighestCreditClient;

DELIMITER $$

CREATE PROCEDURE usp_HighestCreditClient()
main:BEGIN
    DECLARE highest DECIMAL(15, 2) DEFAULT (SELECT MAX(limite_credito) FROM cliente);
    SELECT 
        nombre_cliente 
    FROM 
        cliente 
    WHERE 
        limite_credito = highest;
END main$$

DELIMITER ;