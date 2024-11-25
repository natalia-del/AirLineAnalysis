-- Create copy of tables :)
SELECT * INTO CFlightA FROM CustomerFlightActivity;
SELECT * FROM CFlightA;

SELECT * INTO CLoyaltyH FROM CustomerLoyaltyHistory;
SELECT * FROM CLoyaltyH;

-- Cleaning 
-- Check duplicates - procedura
CREATE PROCEDURE CheckDuplicates
	@TableName NVARCHAR(MAX),
	@PartitionBY NVARCHAR(MAX),
	@OrderBy NVARCHAR(MAX)
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @Check NVARCHAR(MAX);

	SET @Check = N'
		WITH Duplicates AS (
			SELECT *,
			ROW_NUMBER() OVER(PARTITION BY ' + @PartitionBY + ' ORDER BY ' + @OrderBy + ') AS RowNumber
			FROM ' + QUOTENAME(@TableName) + '		
		)
		SELECT *
		FROM Duplicates
		WHERE RowNumber > 1;
	';
	EXEC sp_executesql @Check;
END;



