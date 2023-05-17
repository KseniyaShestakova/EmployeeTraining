WITH base AS(
SELECT contract_id, sum,
		AVG(sum) OVER(PARTITION BY contract_id) As avg_sum
FROM payment
)
SELECT contract_id, sum, ROUND(avg_sum, 2),
	CASE
	WHEN sum < ROUND(avg_sum, 2) THEN 'дешевле среднего'
	ELSE 'не дешевле среднего'
	END
	AS relative_sum
FROM base
ORDER BY contract_id, sum;
