UPDATE sr
SET IsMatchedWithSummary = 
    CASE 
        WHEN ds.Id IS NULL THEN 'Not Found'
        WHEN 
            TRY_CAST(sr.TotalCreditAmount AS DECIMAL(18,2)) = TRY_CAST(ds.TotalCredit AS DECIMAL(18,2)) AND
            TRY_CAST(sr.TotalDebitAmount AS DECIMAL(18,2)) = TRY_CAST(ds.TotalDebit AS DECIMAL(18,2)) AND
            TRY_CAST(sr.NetPositionAmount AS DECIMAL(18,2)) = TRY_CAST(ds.NetPositions AS DECIMAL(18,2))
        THEN 'True'
        ELSE 'False'
    END
FROM [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults] sr
LEFT JOIN [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary] ds
    ON sr.[Date] = ds.[Date]
WHERE 
    sr.IsMatchedWithSummary IS NULL 
    OR sr.IsMatchedWithSummary IN ('Not Found', 'False');

