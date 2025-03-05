SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],

    -- P2P Payer Transactions (Moving funds to settlement)
    'P2P - Payer' AS TransactionType,
    'IPN - Transfer OUT TRX (EGP1486100010001)' AS From_Account,
    'IPN Settlement Transactions (EGP1465866660001)' AS To_Account,
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) AS Amount,
    'Moving P2P transaction amount to settlement' AS Description

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02' -- Set date filter
GROUP BY CONVERT(DATE, SwitchDate)

UNION ALL

SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],
    'P2P - Payer Settlement',
    'IPN Settlement Transactions (EGP1465866660001)',
    'Central Bank of Egypt (9800000050150201)',
    SUM(CASE WHEN TransactionType = 'P2P' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END),
    'Settling P2P transactions with CBE'

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02'
GROUP BY CONVERT(DATE, SwitchDate)

UNION ALL

SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],
    'P2M - Payer',
    'IPN - Transfer OUT TRX (EGP1486100010001)',
    'IPN Settlement Transactions (EGP1465866660001)',
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END),
    'Moving P2M transaction amount to settlement'

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02'
GROUP BY CONVERT(DATE, SwitchDate)

UNION ALL

SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],
    'P2M - Revenue Allocation',
    'IPN Settlement Transactions (EGP1465866660001)',
    'Revenue PL (PL52450)',
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END),
    'Allocating interchange revenue'

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02'
GROUP BY CONVERT(DATE, SwitchDate)

UNION ALL

SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],
    'P2M - Payer Settlement',
    'IPN Settlement Transactions (EGP1465866660001)',
    'Central Bank of Egypt (9800000050150201)',
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END) - 
    SUM(CASE WHEN TransactionType = 'P2M' AND BankRole = 'PayerBank' THEN CAST(InterchangeAmount AS DECIMAL(18, 2)) ELSE 0 END),
    'Settling P2M transactions with CBE after interchange deduction'

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02'
GROUP BY CONVERT(DATE, SwitchDate)

UNION ALL

SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],
    'P2M - Refund',
    'IPN - Transfer IN TRX (EGP1465866660001)',
    'IPN Settlement Transactions (EGP1486100010001)',
    SUM(CASE WHEN TransactionType = 'Refund' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END),
    'Moving refunded amount to settlement'

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02'
GROUP BY CONVERT(DATE, SwitchDate)

UNION ALL

SELECT 
    CONVERT(DATE, SwitchDate) AS [Date],
    'Expenses Processing',
    'Expenses PL (PL62450)',
    'IPN Settlement Transactions (EGP1465866660001)',
    SUM(CASE WHEN TransactionType = 'Expense' THEN CAST(TransactionAmount AS DECIMAL(18, 2)) ELSE 0 END),
    'Transferring expense amount for settlement'

FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions]
WHERE SwitchDate = '2025-03-02'
GROUP BY CONVERT(DATE, SwitchDate);
