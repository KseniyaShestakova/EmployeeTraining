SELECT  contract_id,
		COUNT(*) AS pay_num,
		SUM(payer) AS payer_ref_sum
	FROM payment GROUP BY contract_id
	HAVING COUNT(*) >= 1 AND SUM(payer)=COUNT(*);
