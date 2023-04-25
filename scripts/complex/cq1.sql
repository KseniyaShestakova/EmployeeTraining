SELECT  contract_id,
		COUNT(*) AS pay_num,
		SUM(sum) AS total
	FROM payment GROUP BY contract_id
	HAVING COUNT(*) >= 2 AND SUM(sum) > 200000;
