SELECT codigo_oficina, ciudad FROM oficina;
SELECT ciudad, telefono FROM oficina WHERE pais = 'España';
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_empleado = 1;
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto != 'Representante Ventas';
SELECT nombre_cliente FROM cliente WHERE pais = 'Spain';
SELECT DISTINCT estado FROM pedido;
SELECT codigo_cliente FROM pago WHERE YEAR(fecha_pago) = '2008' GROUP BY codigo_cliente HAVING COUNT(*) <= 1;
SELECT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, '%Y - %m - %d') LIKE '2008%' GROUP BY codigo_cliente HAVING COUNT(*) <= 1; 
SELECT codigo_cliente FROM pago WHERE fecha_pago LIKE '%2008%' GROUP BY codigo_cliente HAVING COUNT(*) <= 1;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_entrega, fecha_esperada) >= 1;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE ADDDATE(fecha_entrega, INTERVAL 2 DAY) <= fecha_esperada;
SELECT * FROM pedido WHERE Estado = 'Rechazado' AND YEAR(fecha_entrega) = '2009';
SELECT * FROM pedido WHERE Estado = 'Entregado' AND MONTH(fecha_entrega) = 01;
SELECT * FROM pago WHERE forma_pago = 'Paypal' AND YEAR(fecha_pago) = '2008' ORDER BY total DESC;
SELECT DISTINCT forma_pago FROM pago;
SELECT nombre, precio_venta FROM producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;
SELECT * FROM cliente WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);
SELECT c.nombre_cliente, e.nombre, e.apellido1 FROM empleado e JOIN cliente c ON e.codigo_empleado = codigo_empleado_rep_ventas;
SELECT p.id_transaccion, c.nombre_cliente, e.nombre
FROM empleado e
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

SELECT c.nombre_cliente, e.nombre 
FROM cliente c
JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente NOT IN (
	SELECT p.codigo_cliente 
    FROM pago p
    );
    
SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM oficina o
JOIN empleado e ON e.codigo_oficina = o.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM oficina o
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente NOT IN (
	SELECT p.codigo_cliente 
    FROM pago p
    );

SELECT DISTINCT c.nombre_cliente, o.linea_direccion1, c.ciudad
FROM oficina o
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';

SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM oficina o
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

SELECT e1.nombre, e1.apellido1, e.nombre, e.apellido1 
FROM empleado e
JOIN empleado e1 ON e.codigo_empleado = e1.codigo_jefe;

SELECT c.nombre_cliente, p.fecha_esperada, p.fecha_entrega
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE fecha_entrega IS NULL OR DATEDIFF(fecha_entrega, fecha_esperada) >= 1;

SELECT DISTINCT c.nombre_cliente, pro.gama
FROM cliente c
JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
JOIN detalle_pedido d ON pe.codigo_pedido = d.codigo_pedido
JOIN producto pro ON d.codigo_producto = pro.codigo_producto;

SELECT c.nombre_cliente, p.id_transaccion
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

SELECT c.nombre_cliente, p.codigo_pedido
FROM cliente c
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_pedido IS NULL;

SELECT c.nombre_cliente, pe.codigo_pedido, pa.id_transaccion
FROM cliente c
LEFT JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE pe.codigo_cliente IS NULL AND pa.codigo_cliente IS NULL;

SELECT e.nombre, e.apellido1, o.ciudad
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

SELECT e.nombre, e.apellido1, c.codigo_empleado_rep_ventas
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;

SELECT e.nombre, e.apellido1, c.codigo_empleado_rep_ventas, o.ciudad
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL;

SELECT DISTINCT pro.nombre, d.codigo_pedido
FROM producto pro
LEFT JOIN detalle_pedido d ON pro.codigo_producto = d.codigo_producto
WHERE d.codigo_pedido IS NULL;

SELECT o.codigo_oficina, o.ciudad
FROM oficina o
LEFT JOIN (
	SELECT e.codigo_oficina
	FROM empleado e
    JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
    JOIN detalle_pedido d ON pe.codigo_pedido = d.codigo_pedido
    JOIN producto pro ON d.codigo_producto = pro.codigo_producto
    WHERE pro.gama = 'Frutales'
) AS resultados_frutales ON o.codigo_oficina = resultados_frutales.codigo_oficina
WHERE resultados_frutales.codigo_oficina IS NULL;

SELECT DISTINCT c.nombre_cliente, pe.codigo_pedido, pa.id_transaccion, pa.fecha_pago
FROM cliente c
JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente
WHERE pa.id_transaccion IS NULL; 

SELECT j.nombre, j.apellido1, e.nombre, e.apellido1, c.codigo_empleado_rep_ventas
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
JOIN empleado j ON e.codigo_empleado = j.codigo_jefe
WHERE c.codigo_empleado_rep_ventas IS NULL ORDER BY j.codigo_jefe ASC;

SELECT COUNT(*) AS 'Cantidad Empleados' FROM empleado;
SELECT COUNT(*), pais AS 'Clientes por pais' FROM cliente GROUP BY pais ORDER BY pais ASC;
SELECT AVG(total) AS 'Pago medio' FROM pago WHERE YEAR(fecha_pago) = '2009';
SELECT COUNT(*) AS Cantidad, estado FROM pedido GROUP BY estado ORDER BY COUNT(*) DESC;
SELECT MAX(precio_venta) AS Mayor, MIN(precio_venta) AS Menor FROM producto;
SELECT COUNT(*) AS 'Cantidad clientes' FROM cliente;
SELECT COUNT(*), ciudad FROM cliente WHERE ciudad = 'Madrid';
SELECT COUNT(*) AS Cantidad, ciudad FROM cliente WHERE ciudad LIKE 'm%' GROUP BY ciudad ORDER BY cantidad DESC;

SELECT COUNT(c.codigo_cliente) AS Cantidad, nombre, apellido1, e.puesto 
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE e.puesto = 'Representante Ventas'
GROUP BY e.nombre, e.apellido1
ORDER BY e.nombre ASC;

SELECT COUNT(*) AS 'No tiene rep'
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;

SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, IF(MIN(fecha_pago) IS NOT NULL, MIN(fecha_pago), 'No existe pago') AS 'Primer pago', 
IF(MAX(fecha_pago) IS NOT NULL, MAX(fecha_pago), 'No existe pago') AS 'Ultimo pago'
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
GROUP BY c.nombre_cliente, c.nombre_contacto, c.apellido_contacto
ORDER BY nombre_cliente ASC;

SELECT COUNT(DISTINCT pro.codigo_producto), pe.codigo_pedido
FROM pedido pe
JOIN detalle_pedido d ON pe.codigo_pedido = d.codigo_pedido
JOIN producto pro ON d.codigo_producto = pro.codigo_producto
GROUP BY pe.codigo_pedido
ORDER BY pe.codigo_pedido ASC;

SELECT pro.nombre, pro.codigo_producto, SUM(d.cantidad) AS Cantidad
FROM producto pro
JOIN detalle_pedido d ON pro.codigo_producto = d.codigo_producto
GROUP BY pro.nombre, pro.codigo_producto
ORDER BY cantidad DESC
LIMIT 20;

SELECT 
	SUM(cantidad * precio_unidad) AS Base,
	SUM(cantidad * precio_unidad) * 0.21 AS IVA,
    SUM(cantidad * precio_unidad) * 1.21 AS Total
FROM detalle_pedido;

SELECT 
	codigo_producto,
    SUM(cantidad * precio_unidad) AS Base,
	SUM(cantidad * precio_unidad) * 0.21 AS IVA,
    SUM(cantidad * precio_unidad) * 1.21 AS Total
FROM detalle_pedido
GROUP BY codigo_producto;

SELECT 
	codigo_producto,
    SUM(cantidad * precio_unidad) AS Base,
	SUM(cantidad * precio_unidad) * 0.21 AS IVA,
    SUM(cantidad * precio_unidad) * 1.21 AS Total
FROM detalle_pedido
WHERE codigo_producto LIKE 'OR%'
GROUP BY codigo_producto;

SELECT 
	d.codigo_producto,
    p.nombre,
    SUM(cantidad) AS Cantidad,
    SUM(d.cantidad * d.precio_unidad) AS Total,
    SUM(d.cantidad * d.precio_unidad) * 1.21 AS TotalConIva
FROM detalle_pedido d
JOIN producto p ON d.codigo_producto = p.codigo_producto
GROUP BY d.codigo_producto
HAVING SUM(d.cantidad * d.precio_unidad) > 3000;

SELECT nombre_cliente, limite_credito 
FROM cliente 
WHERE limite_credito = (
	SELECT MAX(limite_credito) FROM cliente
);

SELECT nombre, precio_venta
FROM producto
WHERE precio_venta = (
	SELECT MAX(precio_venta)
    FROM producto
);

SELECT d.codigo_producto, p.nombre, SUM(d.cantidad) AS Cantidad
FROM detalle_pedido d
JOIN producto p ON d.codigo_producto = p.codigo_producto
GROUP BY d.codigo_producto
ORDER BY Cantidad DESC
LIMIT 1;

SELECT p.codigo_cliente, c.nombre_cliente, c.limite_credito, COALESCE(SUM(total), 0) AS CantidadPagos
FROM pago p
LEFT JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
GROUP BY p.codigo_cliente, c.nombre_cliente
HAVING CantidadPagos < c.limite_credito;

SELECT DISTINCT codigo_producto, nombre, cantidad_en_stock 
FROM producto
WHERE cantidad_en_stock = (
	SELECT MAX(cantidad_en_stock)
    FROM producto
);

SELECT DISTINCT codigo_producto, nombre, cantidad_en_stock 
FROM producto
WHERE cantidad_en_stock = (
	SELECT MIN(cantidad_en_stock)
    FROM producto
);

SELECT nombre, apellido1, email
FROM empleado
WHERE codigo_jefe = (
	SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);

SELECT 
	e1.nombre AS NombreEmpleado, 
	e1.apellido1 AS ApellidoEmpleado,
    e1.email,
    e.nombre AS NombreJefe,
    e.apellido1 AS ApellidoJefe
FROM empleado e1
JOIN empleado e ON e.codigo_empleado = e1.codigo_jefe
WHERE e.nombre = 'Alberto' AND e.apellido1 = 'Soria';

SELECT nombre_cliente, limite_credito
FROM cliente
WHERE limite_credito >= ALL (
	SELECT limite_credito
    FROM cliente
);

SELECT nombre, precio_venta
FROM producto
WHERE precio_venta >= ALL (
	SELECT precio_venta
    FROM producto
);

SELECT nombre, cantidad_en_stock
FROM producto
WHERE cantidad_en_stock <= ALL (
	SELECT cantidad_en_stock
    FROM producto
);

SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (
	SELECT codigo_empleado_rep_ventas
    FROM cliente
);

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (
	SELECT codigo_cliente
    FROM pago
);

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (
	SELECT codigo_cliente
    FROM pago
);

SELECT codigo_producto, nombre
FROM producto
WHERE codigo_producto NOT IN (
	SELECT codigo_producto
    FROM detalle_pedido
);

SELECT e.nombre, e.apellido1, e.apellido2, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
	SELECT codigo_empleado_rep_ventas
    FROM cliente
); 

SELECT c.nombre_cliente
FROM cliente c
WHERE NOT EXISTS (
	SELECT *
    FROM pago p
    WHERE c.codigo_cliente = p.codigo_cliente
);

SELECT c.nombre_cliente
FROM cliente c
WHERE EXISTS (
	SELECT *
    FROM pago p
    WHERE c.codigo_cliente = p.codigo_cliente
);

SELECT p.nombre
FROM producto p
WHERE NOT EXISTS (
	SELECT *
    FROM detalle_pedido d
    WHERE p.codigo_producto = d.codigo_producto
);

SELECT p.nombre
FROM producto p
WHERE EXISTS (
	SELECT *
    FROM detalle_pedido d
    WHERE p.codigo_producto = d.codigo_producto
);

