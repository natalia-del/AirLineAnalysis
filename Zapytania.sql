-- Jaka grupa ma najwi�ksz� ilo�� wydanej kaski na loty, zale�no�ci od oczekiwanych kolumn
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

