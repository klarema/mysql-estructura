
-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 1 Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre AS department_name, p.nombre, p.apellido1, p.apellido2 FROM departamento d JOIN profesor pr ON d.id = pr.id_departamento RIGHT JOIN persona p ON p.id = pr.id_profesor WHERE p.tipo='profesor'ORDER BY p.nombre, p.apellido1, p.apellido2 
-- 2 Retorna un llistat amb els professors que no estan associats a un departament. (results: zero)
SELECT p.nombre, p.apellido1, p.apellido2 FROM profesor pr JOIN persona p ON p.id=pr.id_profesor LEFT JOIN departamento d ON d.id = pr.id_departamento WHERE pr.id_profesor IS NULL
-- 3 Retorna un llistat amb els departaments que no tenen professors associats.
SELECT d.nombre AS department_name FROM profesor pr RIGHT JOIN departamento d ON d.id = pr.id_departamento WHERE pr.id_profesor IS NULL
-- 4 Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT a.nombre, a.id_profesor, p.nombre, p.apellido1, p.apellido2, p.tipo FROM asignatura a RIGHT JOIN persona p ON p.id = a.id_profesor WHERE a.id_profesor IS NULL AND p.tipo='profesor'
-- 5 Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT a.nombre, p.id_profesor FROM profesor p RIGHT JOIN asignatura a ON p.id_profesor=a.id_profesor WHERE p.id_profesor IS NULL
-- 6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre	FROM asignatura a JOIN profesor pr ON a.id_profesor=pr.id_profesor RIGHT JOIN departamento d ON d.id=pr.id_departamento WHERE a.id_profesor IS NULL

