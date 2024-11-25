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

