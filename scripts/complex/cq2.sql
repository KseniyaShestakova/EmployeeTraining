WITH base AS(
SELECT contract_id, sum,
		AVG(sum) OVER(PARTITION BY contract_id) As avg_sum
FROM payment
)
SELECT contract_id, sum, avg_sum,
	CASE
	WHEN sum < avg_sum THEN 'дешевле среднего'
	ELSE 'не дешевле среднего'
	END
	AS relative_sum
FROM base
ORDER BY contract_id, sum;
