SELECT 
    s.BankRole,
    COUNT(s.TransactionId) AS TransactionCount,  
    SUM(CAST(s.TransactionAmount AS DECIMAL(18,2))) AS TotalSettlementAmount
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] s
LEFT JOIN [UiPath Processes Data].[dbo].[IPNReconciliation_ArchivingCoreBankingRowTransactions] c
    ON s.TransactionId = LEFT(c.AdditionalInfo, 36)
    AND REPLACE(s.SwitchDate, '-', '') = c.ProcessingDate
    AND s.BankRole = REPLACE(c.GeneratedBankRole, ' ', '')
WHERE s.SwitchDate = '2025-03-02'
AND c.Id IS NULL
AND s.BankRole = 'PayerBank'
AND s.TransactionRemark <> 'Refund'
GROUP BY s.BankRole;
--------------------------------------------------------------------------------------------------------
SELECT 
    s.BankRole,
    COUNT(s.TransactionId) AS TransactionCount,  
    SUM(CAST(s.TransactionAmount AS DECIMAL(18,2))) AS TotalSettlementAmount
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] s
LEFT JOIN [UiPath Processes Data].[dbo].[IPNReconciliation_ArchivingCoreBankingRowTransactions] c
    ON s.TransactionId = LEFT(c.AdditionalInfo, 36)
    AND REPLACE(s.SwitchDate, '-', '') = c.ProcessingDate
    AND s.BankRole = REPLACE(c.GeneratedBankRole, ' ', '')
WHERE s.SwitchDate = '2025-03-02'
AND c.Id IS NULL
AND s.BankRole = 'PayeeBank'
AND s.ResponseDescription = 'Success'
GROUP BY s.BankRole;
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
SELECT 
    s.SwitchDate AS [Date],
    MAX(CASE WHEN s.BankRole = 'PayeeBank' THEN s.BankRole END) AS PayeeBankRole,
    SUM(CASE WHEN s.BankRole = 'PayeeBank' THEN 1 ELSE 0 END) AS PayeeBankRoleTrxCount,
    SUM(CASE WHEN s.BankRole = 'PayeeBank' THEN CAST(s.TransactionAmount AS DECIMAL(18,2)) ELSE 0 END) AS PayeeBankRoleTrxAmount,
    MAX(CASE WHEN s.BankRole = 'PayerBank' THEN s.BankRole END) AS PayerBankRole,
    SUM(CASE WHEN s.BankRole = 'PayerBank' THEN 1 ELSE 0 END) AS PayerBankRoleTrxCount,
    SUM(CASE WHEN s.BankRole = 'PayerBank' THEN CAST(s.TransactionAmount AS DECIMAL(18,2)) ELSE 0 END) AS PayerBankRoleTrxAmount
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] s
LEFT JOIN [UiPath Processes Data].[dbo].[IPNReconciliation_ArchivingCoreBankingRowTransactions] c
    ON s.TransactionId = LEFT(c.AdditionalInfo, 36)
    AND REPLACE(s.SwitchDate, '-', '') = c.ProcessingDate
    AND s.BankRole = REPLACE(c.GeneratedBankRole, ' ', '')
WHERE s.SwitchDate = '2025-03-02'
AND c.Id IS NULL
AND (
    (s.BankRole = 'PayerBank' AND s.TransactionRemark <> 'Refund') 
    OR 
    (s.BankRole = 'PayeeBank' AND s.ResponseDescription = 'Success')
)
GROUP BY s.SwitchDate;


