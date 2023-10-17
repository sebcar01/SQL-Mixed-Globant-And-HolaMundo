SELECT Nombre FROM jugadores ORDER BY Nombre ASC;
SELECT Nombre FROM jugadores WHERE Posicion = 'c' AND Peso > 200 ORDER BY Nombre ASC;
SELECT Nombre FROM equipos ORDER BY Nombre ASC;
SELECT Nombre FROM equipos WHERE Conferencia = 'East';
SELECT Nombre, Ciudad FROM equipos WHERE Ciudad LIKE 'c%' ORDER BY Nombre ASC;
SELECT Nombre, Nombre_equipo FROM jugadores ORDER BY Nombre_equipo ASC;
SELECT Nombre FROM jugadores WHERE Nombre_equipo = 'Raptors' ORDER BY Nombre ASC;
SELECT e.Puntos_por_partido, j.nombre FROM jugadores j JOIN estadisticas e ON j.codigo = e.jugador WHERE j.nombre = 'Pau Gasol';
SELECT e.Puntos_por_partido, j.nombre, e.temporada FROM jugadores j JOIN estadisticas e ON j.codigo = e.jugador WHERE j.nombre = 'Pau Gasol' AND e.temporada = '04/05';
SELECT SUM(e.Puntos_por_partido), j.nombre FROM jugadores j JOIN estadisticas e ON j.codigo = e.jugador GROUP BY j.nombre ORDER BY j.nombre ASC;
SELECT Nombre_equipo, COUNT(*) FROM jugadores GROUP BY Nombre_equipo;
SELECT SUM(e.Puntos_por_partido) AS Puntos, j.nombre FROM jugadores j JOIN estadisticas e ON j.codigo = e.jugador GROUP BY j.nombre ORDER BY Puntos DESC LIMIT 1;
SELECT j.Nombre, j.Altura, e.Nombre, e.Conferencia, e.Division FROM equipos e JOIN jugadores j ON e.Nombre = j.Nombre_equipo WHERE j.Altura = (SELECT MAX(Altura) FROM jugadores);
SELECT equipo_local, equipo_visitante, ABS(puntos_visitante - puntos_local) AS Diferencia 
FROM partidos WHERE ABS(puntos_visitante - puntos_local) = (SELECT ABS(puntos_visitante - puntos_local) AS Diferencia FROM partidos ORDER BY Diferencia DESC LIMIT 1);
SELECT codigo, equipo_local, equipo_visitante,
	CASE
		WHEN puntos_local > puntos_visitante THEN equipo_local
		WHEN puntos_local < puntos_visitante THEN equipo_visitante
		ELSE 'Empate'
	END AS Ganador 
FROM partidos;