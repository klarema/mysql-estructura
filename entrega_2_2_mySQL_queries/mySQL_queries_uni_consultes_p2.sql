
-- Consultes resum:
-- 1 Retorna el nombre total d'alumnes que hi ha.
SELECT persona.nombre FROM universidad.persona WHERE persona.tipo='alumno'
-- 2 Calcula quants alumnes van néixer en 1999.
SELECT Count(persona.nombre) FROM universidad.persona WHERE persona.fecha_nacimiento REGEXP "^1999" AND persona.tipo='alumno'
-- 3 Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
SELECT d.nombre, p.nombre FROM universidad.profesor pr JOIN universidad.departamento d  ON pr.id_departamento=d.id JOIN persona p ON pr.id_profesor=p.id ORDER BY p.nombre
-- 4 Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS dept, p.nombre AS prof FROM universidad.persona p JOIN universidad.profesor pr ON pr.id_profesor=p.id RIGHT JOIN universidad.departamento d ON pr.id_departamento=d.id
-- 5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS grado, a.nombre AS asignaura FROM universidad.grado g LEFT JOIN universidad.asignatura a ON a.id_grado=g.id ORDER BY a.nombre
-- 6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
-- TO FIX to show all asignaturas
SELECT g.nombre AS grado_name, a.nombre AS asignaura FROM universidad.grado g JOIN universidad.asignatura a ON a.id_grado=g.id HAVING COUNT(a.nombre) > 40
-- 7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

-- 8 Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

-- 9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

-- 10 Retorna totes les dades de l'alumne més jove.

-- 11 Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.


