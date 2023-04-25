SELECT person_id, company_id, starttime,
	LEAD(company_id, 1, NULL) OVER(PARTITION BY person_id ORDER BY starttime)
		AS next_workplace,
	LEAD(starttime, 1, NULL) OVER(PARTITION BY person_id ORDER BY starttime)
		AS next_worktime
FROM instructor;
