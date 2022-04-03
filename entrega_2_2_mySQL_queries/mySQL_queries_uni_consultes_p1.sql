
-- Base de dades Universidad
-- USE Universidad
-- 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM universidad.persona WHERE persona.tipo='alumno' ORDER BY persona.apellido1, persona.apellido2, persona.nombre
-- 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM universidad.persona WHERE persona.telefono IS NULL AND persona.tipo='alumno'
-- 3 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM universidad.persona WHERE persona.fecha_nacimiento REGEXP "^1999" AND persona.tipo='alumno'
-- 4 Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM universidad.persona WHERE persona.telefono IS NULL AND persona.tipo='profesor'
-- 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT asignatura.nombre FROM universidad.asignatura WHERE asignatura.cuatrimestre='1' AND asignatura.curso='3' AND asignatura.id_grado='7'
-- 6 Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, profesor.id_departamento FROM universidad.persona JOIN universidad.profesor ON persona.id=profesor.id_profesor 
-- 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
SELECT a.nombre AS asignaturaName, ce.anyo_inicio, ce.anyo_fin FROM universidad.alumno_se_matricula_asignatura ama JOIN universidad.curso_escolar ce ON ce.id=ama.id_curso_escolar JOIN universidad.asignatura a ON a.id=ce.id JOIN universidad.persona p ON p.id=ama.id_alumno WHERE p.nif='26902806M'
-- 8 Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre AS dept FROM universidad.departamento d JOIN universidad.profesor pr ON pr.id_departamento=d.id JOIN universidad.asignatura a ON a.id_profesor=pr.id_profesor JOIN universidad.grado gr ON gr.id=a.id_grado WHERE gr.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
-- 9 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.nombre FROM universidad.persona p JOIN universidad.alumno_se_matricula_asignatura ama	ON p.id=id_alumno JOIN universidad.curso_escolar ce ON ama.id_curso_escolar=ce.id WHERE ce.anyo_inicio='2018'




