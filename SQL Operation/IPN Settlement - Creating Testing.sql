CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TransactionId NVARCHAR(36),
    TransactionType NVARCHAR(32),
    SwitchDate NVARCHAR(10),
    TransactionTimeStamp NVARCHAR(23),
    BankRole NVARCHAR(14),
    PayerPsp NVARCHAR(20),
    PayerPspBank NVARCHAR(20),
    PayerBank NVARCHAR(20),
    PayeePsp NVARCHAR(20),
    PayeePspBank NVARCHAR(20),
    PayeeBank NVARCHAR(20),
    TransactionAmount NVARCHAR(18),
    TransactionAmountAction NVARCHAR(6),
    TransactionAmountCurrency NVARCHAR(3),
    PayerPspFeesAmount NVARCHAR(18),
    PayerPspFeesAmountAction NVARCHAR(6),
    PayerPspFeesAmountCurrency NVARCHAR(3),
    PayerPspBearFeesAmount NVARCHAR(18),
    PayerPspBearFeesAmountAction NVARCHAR(6),
    PayerPspBearFeesAmountCurrency NVARCHAR(3),
    InterchangeAmount NVARCHAR(18),
    InterchangeAmountAction NVARCHAR(6),
    InterchangeAmountCurrency NVARCHAR(3),
    IpnProcessingFeesAmount NVARCHAR(18),
    IpnProcessingFeesAmountAction NVARCHAR(6),
    IpnProcessingFeesAmountCurrency NVARCHAR(3),
    PayerMobileNumber NVARCHAR(14),
    PayerIpa NVARCHAR(100),
    PayerName NVARCHAR(100),
    PayerAccountUniqueIdentifier NVARCHAR(36),
    AmlPayerName NVARCHAR(100),
    AmlPayerAddress NVARCHAR(100),
    AmlPayerIdentificationType NVARCHAR(8),
    AmlPayerIdentificationNumber NVARCHAR(30),
    PayeeMobileNumber NVARCHAR(14),
    PayeeIpa NVARCHAR(100),
    PayeeName NVARCHAR(100),
    PayeeAccountUniqueIdentifier NVARCHAR(36),
    AmlPayeeName NVARCHAR(100),
    AmlPayeeAddress NVARCHAR(100),
    AmlPayeeIdentificationType NVARCHAR(8),
    AmlPayeeIdentificationNumber NVARCHAR(30),
    TerminalLocation NVARCHAR(40),
    TerminalLongitude NVARCHAR(15),
    TerminalLatitude NVARCHAR(15),
    TransactionRemark NVARCHAR(100),
    CustomerReference NVARCHAR(100),
    Result NVARCHAR(7),
    ResponseCode NVARCHAR(5),
    ResponseDescription NVARCHAR(100),
	EnteringTime DATETIME DEFAULT GETDATE(),
    SourceFileName NVARCHAR(255)
);
CREATE NONCLUSTERED INDEX IDX_IPNSettlement_Transactions_TransactionType_SwitchDate_BankRole
ON [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] (TransactionType, SwitchDate, BankRole);


CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Date] DATE NOT NULL,           
    TotalCredit NVARCHAR(20),       
    TotalDebit NVARCHAR(20),          
    NetPositions NVARCHAR(20),        
    EnteringTime DATETIME DEFAULT GETDATE(), 
    SourceFileName NVARCHAR(255)       
);

CREATE NONCLUSTERED INDEX IDX_IPNSettlement_DaysSummary_Date
ON [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary] ([Date]);

CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults] (
    Id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    [Date] DATE NOT NULL,
	TotalTrxCount NVARCHAR(10), 
    P2PPayerTrxCount NVARCHAR(10),
    P2PPayerTrxAmount NVARCHAR(30),
    P2PPayeeTrxCount NVARCHAR(10),
    P2PPayeeTrxAmount NVARCHAR(30),
    P2MPayerTrxCount NVARCHAR(10),
    P2MPayerTrxAmount NVARCHAR(30),
    P2MPayerTrxInterchangeAmount NVARCHAR(30),
    P2MPayeeTrxCount NVARCHAR(10),
    P2MPayeeTrxAmount NVARCHAR(30),
    P2MPayeeTrxInterchangeAmount NVARCHAR(30),
    TotalCreditAmount NVARCHAR(30),
    TotalDebitAmount NVARCHAR(30),
    NetPositionAmount NVARCHAR(30),
    IsMatchedWithSummary NVARCHAR(10),
    SettltementState NVARCHAR(10),
    SettlementOnCoreDate DATE,
    SettlementGeneratedresultDate DATETIME DEFAULT GETDATE()
);


CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_UnderSettlement] ( 
    Id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    [Date] DATE NOT NULL,
    UnderSettlementState NVARCHAR(50),
    UndersettlementCalculationDate DATE,
    PayeeBankTrxCount NVARCHAR(10),
    PayeeBankTrxAmount NVARCHAR(30),
    PayerBankTrxCount NVARCHAR(10),
    PayerBankTrxAmount NVARCHAR(30)
);


/*
-- Count rows in IPNReconciliation_StagingIPNTransactions
SELECT COUNT(*) AS IPNSettlementTrx
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions];

-- Count rows in [IPNSettlement_DaysSummary]
SELECT COUNT(*) AS IPNSettlemntSummary
FROM [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary];

-- Count rows in [IPNSettlement_SettlementResults]
SELECT COUNT(*) AS IPNSettlement_SettlementResults
FROM [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults];

-- Count rows in [IPNSettlement_UnderSettlement]
SELECT COUNT(*) AS IPNSettlement_UnderSettlement
FROM [UiPath Processes Data].[dbo].[IPNSettlement_UnderSettlement];

*/

/*
--  rows in IPNSettlement_Transactions
SELECT *
FROM [UiPath Processes Data].[dbo].[IPNSettlement_Transactions];

--  rows in IPNSettlement_Summary
SELECT *
FROM [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary];

--  rows in IPNSettlement_SettlementResults
SELECT *
FROM [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults];

--  rows in IPNSettlement_UnderSettlement
SELECT *
FROM [UiPath Processes Data].[dbo].[IPNSettlement_UnderSettlement];


*/


/*

-- Truncate IPNSettlement_Transactions
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_Transactions];

-- Truncate IPNSettlement_DaysSummary
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary];

-- Truncate IPNSettlement_SettlementResults
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults];

-- Truncate IPNSettlement_UnderSettlement
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_UnderSettlement];

*/
update [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults]
set IsMatchedWithSummary = NULL
