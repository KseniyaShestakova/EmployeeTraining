---insert-запросы лежат в файле inserts.sql---

---проверим, что все корректно вставилось---
SELECT * FROM program_type_ref
SELECT * FROM payer_ref
SELECT * FROM contract_status_ref

SELECT * FROM person
SELECT * FROM company
SELECT * FROM instructor
SELECT * FROM course
SELECT * FROM program
SELECT * FROM program_course
SELECT * FROM contract
SELECT * FROM payment

---более осмысленные select-запросы---
---1) найдем все курсы по направлению бухгалтерский учет---
SELECT course_id, course_nm FROM course WHERE direction='Бухгалтерский учет';
---2) найдем все курсы, существовавшие хотя бы 2 года---
SELECT course_id, course_nm,
	extract(year from starttime) AS start_year,
	extract(year from endtime) AS end_year
FROM course
	WHERE (extract(year from endtime) - extract(year from starttime) >= 2
		   OR (endtime IS NULL 
			   AND extract(year from CURRENT_DATE) - extract(year from starttime) >= 2));
---3) найдем все договоры, которые ни разу не были оплачены---
SELECT c.contract_id
	FROM contract AS c LEFT JOIN payment AS p
		ON c.contract_id = p.contract_id
WHERE p.sum IS NULL
ORDER BY c.contract_id;
---4) для всех оплаченных хоть раз договоров найдем, сколько за них суммарно заплатили---
SELECT contract_id, SUM(sum) AS total FROM payment GROUP BY contract_id
	ORDER BY contract_id;
---5) найдем ФИО всех, кто учился и был отчислен---
SELECT firstname, secondname, surname
	FROM person AS p JOIN contract AS c
	ON p.person_id=c.person_id
WHERE c.status=0;
---6) найдем ФИО всех инструкторов, проработавших хотя бы 2 года---
SELECT DISTINCT firstname, secondname, surname 
FROM person AS p JOIN (
SELECT person_id, EXTRACT(DAYS FROM endtime - starttime) AS diff FROM instructor) AS i
ON p.person_id=i.person_id
WHERE diff >= 365 * 2;
---7) найдем все (московские) компании с ИНН, начинающимся на 77---
SELECT company_id, name FROM company WHERE inn LIKE '77%';
---8) найдем всех физических лиц с датой рождения до 2000 года---
SELECT person_id, birthdate FROM person
	WHERE birthdate < '2000-01-01';
	
---update запросы---
---единственные поля, которые кажется честным менять в этой БД - endtime---
---поэтому будем менять другие поля с осознанием того, что это не вполне легально---
---1) ---
UPDATE person
	SET firstname='Лилия', secondname='Юрьевна', surname='Брик'
WHERE person_id=0;
---2) ---
UPDATE instructor
	SET endtime='2024-10-01' WHERE (starttime='2022-10-01' AND endtime IS NULL);
---3) ---
UPDATE instructor
	SET endtime=CURRENT_DATE + INTERVAL '1 year' WHERE endtime IS NULL;
--4) ---
UPDATE course
	SET endtime=CURRENT_DATE + INTERVAL '1 year' WHERE endtime IS NULL;
---5) ---
UPDATE instructor
	SET is_current=(endtime > CURRENT_DATE)::INT ;
--6) ---
UPDATE course
	SET is_current=(endtime > CURRENT_DATE)::INT ;
---7) ---
UPDATE program
	SET description=CONCAT('[Продв.]', description) WHERE type=0;
---8) ---
UPDATE person 
	SET secondname='' WHERE secondname IS NULL;
---9) ---
UPDATE course 
	SET description=CONCAT('Проверено временем: ', description)
WHERE starttime <= '2005-01-01';
---10) ---
UPDATE course 
	SET description=CONCAT('NEW: ', description)
WHERE starttime >= '2020-01-01';

