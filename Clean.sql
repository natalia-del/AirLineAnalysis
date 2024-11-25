SELECT * FROM CLoyaltyH;
SELECT * FROM CFlightA;
EXEC CheckDuplicates
	@TableName = 'CFlightA',
	@PartitionBY = 'Loyalty_Number',
	@OrderBy = '[Year]';

-- zmiana typów danych
ALTER TABLE CLoyaltyH
ALTER COLUMN  Postal_Code VARCHAR(50);


Select 
	Country,Province,City, Postal_Code,Gender,Education, Marital_Status
FROM CLoyaltyH
GROUP BY Country,Province,City, Postal_Code,Gender,Education, Marital_Status;

