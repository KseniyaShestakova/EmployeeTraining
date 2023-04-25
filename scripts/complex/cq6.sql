SELECT person_id, COUNT(*) AS  contracts_cnt
FROM contract GROUP BY person_id
HAVING MIN(status) > 0
ORDER BY person_id;
