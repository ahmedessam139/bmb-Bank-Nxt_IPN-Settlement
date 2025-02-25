SELECT *  
FROM [UiPath Processes Data].[dbo].[IPNReconciliation_ReconciliationResultsTransactions]  
WHERE (IPNTransactionId = '1213213' AND IPNBankRole = 'PayerBank')  
   OR (IPNTransactionId = '4943848' AND IPNBankRole = 'PayeeBank')  
   OR (IPNTransactionId = '9384890' AND IPNBankRole = 'PayerBank');


UPDATE [UiPath Processes Data].[dbo].[IPNReconciliation_ReconciliationResultsTransactions]  
SET [ReconciliationResult] = 'Check Return'  
WHERE (IPNTransactionId = '1213213' AND IPNBankRole = 'PayerBank')  
   OR (IPNTransactionId = '4943848' AND IPNBankRole = 'PayeeBank')  
   OR (IPNTransactionId = '9384890' AND IPNBankRole = 'PayerBank');
---------------------------------------------------------------------------------------------------------------

SELECT 
    s.Id AS SettlementId,
    s.TransactionId,
    s.TransactionType,
    s.SwitchDate,
    s.TransactionTimeStamp,
    s.BankRole,
    s.TransactionAmount AS SettlementTransactionAmount,
    c.Id AS CoreId,
    c.ProductId,
    c.RecId,
    c.PartyType,
    c.TransactionCurrency,
    c.DebitAccountNumber,
    c.CreditAccountNumber,
    c.GeneratedBankRole,
    c.TransactionAmount AS CoreTransactionAmount,
    c.AdditionalInfo,
    c.PaymentId,
    c.OrderingCustomer,
    c.StatusCode,
    c.StatusDescription,
    c.ValueDate,
    c.ProcessingDate,
    c.DateTime AS CoreDateTime
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] s
 Left JOIN [UiPath Processes Data].[dbo].[IPNReconciliation_StagingCoreBankingTransactions] c
    ON s.TransactionId = LEFT(c.AdditionalInfo, 36)
    --AND s.BankRole = c.GeneratedBankRole
WHERE s.SwitchDate = '2024-11-24';
--------------------------------------------------------------
SELECT 
    s.Id AS SettlementId,
    s.TransactionId,
    s.TransactionType,
    s.SwitchDate,
    s.TransactionTimeStamp,
    s.BankRole,
    s.TransactionAmount AS SettlementTransactionAmount
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] s
LEFT JOIN [UiPath Processes Data].[dbo].[IPNReconciliation_StagingCoreBankingTransactions] c
    ON s.TransactionId = LEFT(c.AdditionalInfo, 36)
    --AND s.BankRole = c.GeneratedBankRole
WHERE s.SwitchDate = '2024-11-24'
AND c.Id IS NULL;

------------------------------------------------------------
SELECT 
    s.BankRole, 
    SUM(CAST(s.TransactionAmount AS DECIMAL(18,2))) AS TotalAmount
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] s
LEFT JOIN [UiPath Processes Data].[dbo].[IPNReconciliation_StagingCoreBankingTransactions] c
    ON s.TransactionId = LEFT(c.AdditionalInfo, 36)
    --AND s.BankRole = c.GeneratedBankRole
WHERE s.SwitchDate = '2024-11-24'
AND c.Id IS NULL
GROUP BY s.BankRole;


