CREATE OR REPLACE FUNCTION get_actual_contracts(full_nm TEXT)
returns TABLE (id INTEGER)
language plpgsql
AS
$$
BEGIN
	RETURN QUERY
	WITH person_info AS(
		SELECT person_id  FROM person WHERE 
			(surname=SPLIT_PART(full_nm, ' ', 1) AND
			 firstname=SPLIT_PART(full_nm, ' ', 2) AND
			 (secondname IS NULL OR secondname=SPLIT_PART(full_nm, ' ', 3))))
	SELECT contract_id  AS id FROM
	(person_info pi JOIN contract c ON pi.person_id=c.person_id) AS base
	WHERE status=1;
END;
$$;

CREATE OR REPLACE FUNCTION get_program_info(full_nm TEXT)
returns TABLE(course_id_ INTEGER,
			 course_nm_ VARCHAR(100),
			 direction_ VARCHAR(100),
			 duration_ INTEGER,
			 direct_duration_ BIGINT,
			 rel_duration_ DECIMAL)
language plpgsql
AS
$$
BEGIN
	RETURN QUERY
	WITH primary_info AS(
		WITH course_ids AS(
		SELECT course_id FROM
		(SELECT program_id FROM program WHERE program_nm=full_nm) AS pr
		JOIN program_course pc ON pr.program_id=pc.program_id)
	SELECT c.course_id AS course_id, course_nm, direction, duration,
		   SUM(duration) OVER(PARTITION BY direction) AS direct_duration,
		   SUM(duration) OVER() AS total_duration
	FROM course_ids ci JOIN course c ON c.course_id=ci.course_id)
		SELECT course_id, course_nm, direction, duration, direct_duration,
		CAST(duration AS DECIMAL) / total_duration AS rel_duration
	FROM primary_info;
END;
$$;


---пример использования:
SELECT * FROM get_program_info('Продвинутая финансовая отчетность');
SELECT get_actual_contracts('Аленькин Петр Валерьевич')

