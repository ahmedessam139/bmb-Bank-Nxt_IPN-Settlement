CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TransactionId VARCHAR(36),
    TransactionType VARCHAR(32),
    SwitchDate VARCHAR(10),
    TransactionTimeStamp VARCHAR(23),
    BankRole VARCHAR(14),
    PayerPsp VARCHAR(20),
    PayerPspBank VARCHAR(20),
    PayerBank VARCHAR(20),
    PayeePsp VARCHAR(20),
    PayeePspBank VARCHAR(20),
    PayeeBank VARCHAR(20),
    TransactionAmount VARCHAR(18),
    TransactionAmountAction VARCHAR(6),
    TransactionAmountCurrency VARCHAR(3),
    PayerPspFeesAmount VARCHAR(18),
    PayerPspFeesAmountAction VARCHAR(6),
    PayerPspFeesAmountCurrency VARCHAR(3),
    PayerPspBearFeesAmount VARCHAR(18),
    PayerPspBearFeesAmountAction VARCHAR(6),
    PayerPspBearFeesAmountCurrency VARCHAR(3),
    InterchangeAmount VARCHAR(18),
    InterchangeAmountAction VARCHAR(6),
    InterchangeAmountCurrency VARCHAR(3),
    IpnProcessingFeesAmount VARCHAR(18),
    IpnProcessingFeesAmountAction VARCHAR(6),
    IpnProcessingFeesAmountCurrency VARCHAR(3),
    PayerMobileNumber VARCHAR(14),
    PayerIpa VARCHAR(100),
    PayerName VARCHAR(100),
    PayerAccountUniqueIdentifier VARCHAR(36),
    AmlPayerName VARCHAR(100),
    AmlPayerAddress VARCHAR(100),
    AmlPayerIdentificationType VARCHAR(8),
    AmlPayerIdentificationNumber VARCHAR(30),
    PayeeMobileNumber VARCHAR(14),
    PayeeIpa VARCHAR(100),
    PayeeName VARCHAR(100),
    PayeeAccountUniqueIdentifier VARCHAR(36),
    AmlPayeeName VARCHAR(100),
    AmlPayeeAddress VARCHAR(100),
    AmlPayeeIdentificationType VARCHAR(8),
    AmlPayeeIdentificationNumber VARCHAR(30),
    TerminalLocation VARCHAR(40),
    TerminalLongitude VARCHAR(15),
    TerminalLatitude VARCHAR(15),
    TransactionRemark VARCHAR(100),
    CustomerReference VARCHAR(100),
    Result VARCHAR(7),
    ResponseCode VARCHAR(5),
    ResponseDescription VARCHAR(100),
	EnteringTime DATETIME DEFAULT GETDATE(),
    SourceFileName VARCHAR(255)
);
CREATE NONCLUSTERED INDEX IDX_IPNSettlement_Transactions_TransactionType_SwitchDate_BankRole
ON [UiPath Processes Data].[dbo].[IPNSettlement_Transactions] (TransactionType, SwitchDate, BankRole);


CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Date] DATE NOT NULL,           
    TotalCredit VARCHAR(20),       
    TotalDebit VARCHAR(20),          
    NetPositions VARCHAR(20),        
    EnteringTime DATETIME DEFAULT GETDATE(), 
    SourceFileName VARCHAR(255)       
);

CREATE NONCLUSTERED INDEX IDX_IPNSettlement_DaysSummary_Date
ON [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary] ([Date]);

CREATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults] (
    Id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    [Date] DATE NOT NULL,
	TotalTrxCount VARCHAR(10), 
    P2PPayerTrxCount VARCHAR(10),
    P2PPayerTrxAmount VARCHAR(30),
    P2PPayeeTrxCount VARCHAR(10),
    P2PPayeeTrxAmount VARCHAR(30),
    P2MPayerTrxCount VARCHAR(10),
    P2MPayerTrxAmount VARCHAR(30),
    P2MPayerTrxInterchangeAmount VARCHAR(30),
    P2MPayeeTrxCount VARCHAR(10),
    P2MPayeeTrxAmount VARCHAR(30),
    P2MPayeeTrxInterchangeAmount VARCHAR(30),
    TotalCreditAmount VARCHAR(30),
    TotalDebitAmount VARCHAR(30),
    NetPositionAmount VARCHAR(30),
    IsMatchedWithSummary VARCHAR(10),
    SettltementState VARCHAR(10),
    SettlementOnCoreDate DATE,
    SettlementGeneratedresultDate DATETIME DEFAULT GETDATE()
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


*/


/*

-- Truncate IPNSettlement_Transactions
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_Transactions];

-- Truncate IPNSettlement_DaysSummary
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_DaysSummary];

-- Truncate IPNSettlement_SettlementResults
TRUNCATE TABLE [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults];

*/
update [UiPath Processes Data].[dbo].[IPNSettlement_SettlementResults]
set IsMatchedWithSummary = NULL
