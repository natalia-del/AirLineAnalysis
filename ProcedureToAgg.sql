-- Analiza Klientów 
SELECT * FROM CLoyaltyH;
SELECT * FROM CFlightA;

-- Procedura do grupowania 

ALTER PROCEDURE AverageGroupTables 
	@TableName NVARCHAR(MAX),
	@GroupByColumns NVARCHAR(MAX),
	@AverageVar NVARCHAR(MAX),
	@AggregationFun NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	IF @AggregationFun NOT IN ('SUM', 'AVG', 'COUNT', 'MAX', 'MIN')
		BEGIN
			RAISERROR ('It is not correct aggregation function %s.', 16,1, @AggregationFun );
			RETURN;
		END;

	DECLARE @AverageColumn NVARCHAR(MAX);	
	
	SET @AverageColumn = N'	
		WITH AvgCol AS (
			SELECT 
				' + @GroupByColumns + ',
				 '+@AggregationFun+'(NULLIF(' + @AverageVar + ',0)) AS '+@AggregationFun+'_' + @AverageVar + '
			FROM 
				' + @TableName + '
			GROUP BY 
				' + @GroupByColumns + '
		)
		SELECT *
		FROM 
			AvgCol
		ORDER BY
			'+@GroupByColumns+';
	';

	EXEC sp_executesql @AverageColumn;
END;

-- Jaka grupa ma najwiêksz¹ iloœæ wydanej kaski na loty, zale¿noœci od oczekiwanych kolumn
EXEC AverageGroupTables 
	@TableName = 'CLoyaltyH',
    @GroupByColumns = 'Gender',
    @AverageVar = 'CLV',
	@AggregationFun = 'AVG';


EXEC AverageGroupTables 
	 @TableName = 'CFlightA',
     @GroupByColumns = '[Year],[Month]',
     @AverageVar = 'Total_Flights',
	 @AggregationFun = 'MAX';


