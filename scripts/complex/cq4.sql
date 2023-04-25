WITH CTE AS(
SELECT person_id, starttime, company_id, specialization,
	RANK() OVER(PARTITION BY person_id ORDER BY starttime) AS num_job
FROM instructor ORDER BY person_id, num_job)
SELECT firstname, secondname, surname, name, specialization, num_job
FROM
	(CTE JOIN person ON person.person_id=CTE.person_id) AS tmp
	JOIN company AS c
	ON c.company_id=tmp.company_id;
