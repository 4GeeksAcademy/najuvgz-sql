-- queries.sql
-- Complete each mission by writing your SQL query below the instructions.
-- Don't forget to end each query with a semicolon ;

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;
-- regions.name, regions.country
-- MISSION 1 Queremos conocer la biodiversidad de cada región. ¿Qué regiones tienen más especies registradas?
-- Your query here;
SELECT r.name, COUNT(DISTINCT o.species_id) AS contador 
FROM observations o JOIN regions r ON o.region_id = r.id 
GROUP BY r.name ORDER BY contador DESC ;



-- MISSION 2 ¿Qué meses tienen mayor actividad de observación? Agrupa por mes a partir de las fechas de observación reales. Es útil para detectar estacionalidad;
-- Your query here;
SELECT strftime('%m', observation_date) AS meses, COUNT(*) AS num_observations 
FROM observations 
GROUP BY meses ORDER BY num_observations DESC;

-- MISSION 3  Detecta las especies con pocos individuos registrados (posibles casos raros);
-- Your query here;
SELECT s.common_name, s.scientific_name, SUM(o.count) AS total_individuals 
FROM observations o JOIN species s ON o.species_id = s.id
GROUP BY s.id, s.common_name, s.scientific_name HAVING total_individuals BETWEEN 1 AND 5
ORDER BY total_individuals ASC;

-- MISSION 4 ¿Qué región tiene el mayor número de especies distintas observadas?;
-- Your query here;
SELECT r.name, COUNT(DISTINCT o.species_id) AS contador 
FROM observations o JOIN regions r ON o.region_id = r.id 
GROUP BY r.name ORDER BY contador DESC
LIMIT 1;


-- MISSION 5 ¿Qué especies han sido observadas con mayor frecuencia?;
-- Your query here;
SELECT s.common_name, s.scientific_name, COUNT(o.id) AS observation_frequency
FROM observations o JOIN species s ON o.species_id = s.id
GROUP BY s.id, s.common_name, s.scientific_name
ORDER BY observation_frequency DESC;

-- MISSION 6 Queremos identificar a los observadores más activos. ¿Quiénes son las personas que más registros de observación han realizado?;
-- Your query here;
SELECT o.observer, count(o.id) AS observer_frequency
FROM observations o
GROUP BY o.observer
ORDER BY observer_frequency DESC;

-- MISSION 7 ¿Qué especies no han sido observadas nunca? Comprueba si existen especies en la tabla species que no aparecen en observations;
-- Your query here;

SELECT s.common_name, s.scientific_name
FROM species s
LEFT JOIN observations o ON s.id = o.species_id
WHERE o.species_id IS NULL;


-- MISSION 8 ¿En qué fechas se observaron más especies distintas? Esta informacion es ideal para explorar la biodiversidad máxima en días específicos.;
-- Your query here;
SELECT observation_date, COUNT(DISTINCT species_id) AS distinct_species_count
FROM observations
GROUP BY observation_date
ORDER BY distinct_species_count DESC;