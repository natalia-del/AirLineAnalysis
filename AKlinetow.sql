-- Jaka grupa ma najwi�ksz� ilo�� wydanej kaski na loty, zale�no�ci od oczekiwanych kolumn
EXEC AverageGroupTables 
	@TableName = 'CLoyaltyH',
    @GroupByColumns = 'Gender',
    @AverageVar = 'CLV',
	@AggregationFun = 'AVG';

-- Jacy klienci podr�uj� najcz�sciej?
SELECT * FROM CLoyaltyH;
SELECT * FROM CFlightA;

SELECT 
	Gender,
	Marital_Status,
	SUM(Total_Flights) AS SUM_Flights
FROM CLoyaltyH CH
RIGHT JOIN CFlightA CA 
	ON CA.Loyalty_Number = CH.Loyalty_Number
GROUP BY 
	Gender,
	Marital_Status
ORDER BY
	Gender,
	SUM_Flights DESC,
	Marital_Status;


-- Jak loty zmieniaj� si� wzgledem roku i miesi�ca
WITH Suma_Flights AS(
	SELECT 
		[Year],
		[Month],
		SUM(Total_Flights) AS SUM_Flights
	FROM CFlightA CA
	GROUP BY 
		[Year],
		[Month]
),
Lag_Flights AS(
	SELECT 
		[Year],
		[Month],
		SUM_Flights,
		LAG(SUM_Flights) OVER(ORDER BY [Year],[Month]) AS Pre_Sum_Flights
	FROM Suma_Flights
)
SELECT [Year],
		[Month],
		SUM_Flights,
		Pre_Sum_Flights,
		SUM_Flights - Pre_Sum_Flights AS Flights_Difference
FROM Lag_Flights;

