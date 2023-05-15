CREATE OR REPLACE VIEW person_with_hidden_passnum
AS (SELECT person_id, secondname, surname, birthdate,
   CONCAT(LEFT(pass_num, 2), REPEAT('*', LENGTH(pass_num) - 4),RIGHT(pass_num, 2))
	AS hidden_pass_num
	FROM person);


CREATE OR REPLACE VIEW name_forms_person AS(
SELECT person_id, secondname, surname,
	CASE RIGHT(firstname, 1)
		WHEN 'я' THEN CONCAT(LEFT(firstname, LENGTH(firstname) - 1), 'и')
		WHEN 'а' THEN CONCAT(LEFT(firstname, LENGTH(firstname) - 1), 'ы')
		WHEN 'ь' THEN CONCAT(LEFT(firstname, LENGTH(firstname) - 1), 'я')
		WHEN 'й' THEN CONCAT(LEFT(firstname, LENGTH(firstname) - 1), 'я')
		ELSE CONCAT(firstname, 'а')
	END
	AS rod_name,
	CASE RIGHT(secondname, 1)
		WHEN 'а' THEN CONCAT(LEFT(secondname, LENGTH(secondname) - 1), 'ы')
		ELSE CONCAT(secondname, 'а')
	END
	AS rod_secondname,
	CASE RIGHT(surname, 2)
		WHEN 'ов' THEN CONCAT(surname, 'а')
		WHEN 'ин' THEN CONCAT(surname, 'а')
		WHEN 'ой' THEN CONCAT(LEFT(surname, LENGTH(surname) - 1), 'го')
		WHEN 'ий' THEN CONCAT(LEFT(surname, LENGTH(surname) - 1), 'ого')
		WHEN 'ая' THEN CONCAT(LEFT(surname, LENGTH(surname) - 2), 'ой')
		WHEN 'ва' THEN CONCAT(LEFT(surname, LENGTH(surname) - 1), 'ой')
		WHEN 'на' THEN CONCAT(LEFT(surname, LENGTH(surname) - 1), 'ой')
		ELSE surname
	END
	AS rod_surname
FROM person);

CREATE OR REPLACE VIEW full_contract_information AS(
SELECT contract_id, base.person_id, base.company_id, program.program_id,
	CONCAT(firstname, ' ', secondname, ' ', surname) AS ФИО,
	company_nm AS Компания,
	program.program_nm AS Программа
FROM
(SELECT contract_id, person_id, firstname, secondname, surname, 
 TMP.company_id, program_id, company.name as company_nm FROM(
	(SELECT contract_id, contract.person_id, firstname, secondname, surname, 
 company_id, program_id
 	FROM(contract JOIN person ON person.person_id=contract.person_id)) AS tmp
JOIN company ON tmp.company_id=company.company_id)) AS base
JOIN program on program.program_id=base.program_id);


CREATE OR REPLACE VIEW program_course_duration AS(
SELECT program_id, pc.course_id, duration
FROM (program_course pc JOIN course c ON pc.course_id=c.course_id ));

CREATE OR REPLACE VIEW program_info AS(
SELECT DISTINCT program_id,
	COUNT(course_id) OVER(PARTITION BY program_id) AS num_courses,
	SUM(duration) OVER(PARTITION BY program_id) AS total_duration
FROM program_course_duration
ORDER BY program_id);


CREATE OR REPLACE VIEW current_instructors AS(
SELECT course_id, instructor_id, endtime FROM course
WHERE (endtime IS NULL OR endtime > CURRENT_TIMESTAMP));

CREATE OR REPLACE VIEW curr_instr_person AS (
SELECT course_id, instructor_id, person_id, ci.endtime
FROM current_instructors ci JOIN instructor i ON ci.instructor_id=i.instr_id);

CREATE OR REPLACE VIEW course_instr_info AS (
SELECT course_id, instructor_id, p.person_id, endtime,
	CONCAT(firstname, ' ', secondname, ' ', surname) AS ФИО 
FROM curr_instr_person cip  JOIN person p ON cip.person_id=p.person_id);
	

CREATE OR REPLACE VIEW studying_num AS(
SELECT DISTINCT person_id,
	COUNT(status) OVER(PARTITION BY person_id) AS num
FROM
(SELECT person_id, status FROM contract WHERE status=1) AS tmp);


CREATE OR REPLACE VIEW fired_num AS(
SELECT DISTINCT person_id,
	COUNT(status) OVER(PARTITION BY person_id) AS num
FROM
(SELECT person_id, status FROM contract WHERE status=0) AS tmp);


CREATE OR REPLACE VIEW graduated_num AS(
SELECT DISTINCT person_id,
	COUNT(status) OVER(PARTITION BY person_id) AS num
FROM
(SELECT person_id, status FROM contract WHERE status=2) AS tmp);

CREATE OR REPLACE VIEW students AS(
SELECT DISTINCT person_id FROM contract);

CREATE OR REPLACE VIEW tmp AS(
SELECT base.person_id AS person_id, fired, num AS studying FROM(
(SELECT s.person_id, num AS fired
FROM students s LEFT JOIN fired_num f ON s.person_id=f.person_id) AS base
LEFT JOIN studying_num s ON base.person_id=s.person_id
) );

CREATE OR REPLACE VIEW contract_status_info AS(
SELECT tmp.person_id, fired, studying, num AS graduated
FROM 
tmp LEFT JOIN graduated_num g
ON tmp.person_id=g.person_id );
