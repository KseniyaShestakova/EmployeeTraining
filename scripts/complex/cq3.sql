WITH global_base AS(
WITH base AS(
SELECT program_id, c.course_id, duration
FROM program_course AS pc JOIN course AS c
ON pc.course_id=c.course_id)
SELECT program_id, course_id, duration,
	SUM(duration) OVER(PARTITION BY program_id) AS prog_duration
FROM base
)
SELECT program_id, course_id, duration, prog_duration, 
	CAST(duration AS NUMERIC) / CAST(prog_duration AS NUMERIC) AS rel_duration
FROM global_base;
