SELECT 
    -- Date: Extracts the date from the SwitchDate column
    CONVERT(DATE, SwitchDate) AS [Date],

    -- TotalTrxCount: Counts the total number of transactions for the given date
    COUNT(*) AS TotalTrxCount,

    -- P2PPayerTrxCount: Counts the number of P2P transactions where BankRole is PayerBank
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayerBank' THEN 1 ELSE 0 END) AS P2PPayerTrxCount,

    -- P2PPayerTrxAmount: Sums the TransactionAmount for P2P transactions where BankRole is PayerBank
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) AS P2PPayerTrxAmount,

    -- P2PPayeeTrxCount: Counts the number of P2P transactions where BankRole is PayeeBank
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayeeBank' THEN 1 ELSE 0 END) AS P2PPayeeTrxCount,

    -- P2PPayeeTrxAmount: Sums the TransactionAmount for P2P transactions where BankRole is PayeeBank
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayeeBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) AS P2PPayeeTrxAmount,

    -- P2MPayerTrxCount: Counts the number of P2M transactions where BankRole is PayerBank
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN 1 ELSE 0 END) AS P2MPayerTrxCount,

    -- P2MPayerTrxAmount: Sums the TransactionAmount for P2M transactions where BankRole is PayerBank
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) AS P2MPayerTrxAmount,

    -- P2MPayerTrxInterchangeAmount: Sums the InterchangeAmount for P2M transactions where BankRole is PayerBank
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END) AS P2MPayerTrxInterchangeAmount,

    -- P2MPayeeTrxCount: Counts the number of P2M transactions where BankRole is PayeeBank
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN 1 ELSE 0 END) AS P2MPayeeTrxCount,

    -- P2MPayeeTrxAmount: Sums the TransactionAmount for P2M transactions where BankRole is PayeeBank
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) AS P2MPayeeTrxAmount,

    -- P2MPayeeTrxInterchangeAmount: Sums the InterchangeAmount for P2M transactions where BankRole is PayeeBank
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END) AS P2MPayeeTrxInterchangeAmount,

    -- TotalCreditAmount: Sum of P2PPayeeTrxAmount, P2MPayeeTrxAmount, and P2MPayerTrxInterchangeAmount
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayeeBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END) AS TotalCreditAmount,

    -- TotalDebitAmount: Sum of P2PPayerTrxAmount, P2MPayerTrxAmount, and P2MPayeeTrxInterchangeAmount
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END) AS TotalDebitAmount,

    -- NetPositionAmount: Calculated as TotalDebitAmount - TotalCreditAmount
    (SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END))
    - (SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayeeBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayeeBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) 
    + SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END)) AS NetPositionAmount
FROM 
    [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE 
    SwitchDate = '2024-11-11' -- Exact date filter
GROUP BY 
    CONVERT(DATE, SwitchDate);