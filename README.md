# BMB BankNXT IPN Reconciliation

A UiPath automation project for reconciling IPN (Instant Payment Network) transactions with Core Banking data.

## Project Overview

This automation solution handles the reconciliation process between IPN transactions and Core Banking data. It automates the collection, parsing, and matching of transaction data from multiple sources to ensure accuracy and identify discrepancies.

## Features

- Automated retrieval of IPN files from SFTP server
- Core Banking data extraction and processing
- Parallel processing of IPN and Core Banking files
- Database integration for data storage and retrieval
- Reconciliation engine for transaction matching
- Comprehensive error handling and logging

## System Requirements

- UiPath Studio 19.10.2.0 or higher
- Windows Operating System
- Database server (for storing transaction data)
- SFTP access for IPN files

## Dependencies

- Omega.SftpClient.Activities (1.2.0)
- UiPath.Database.Activities (1.9.0)
- UiPath.Excel.Activities (2.24.4)
- UiPath.Mail.Activities (1.23.11)
- UiPath.System.Activities (24.10.6)
- UiPath.UIAutomation.Activities (24.10.6)

## Project Structure

```
├── Main.xaml              # Main workflow orchestrator
├── Process.xaml           # Core process workflow
├── Bots/                  # Individual bot workflows
│   ├── Get IPN File.xaml
│   ├── Get Core Banking File.xaml
│   ├── Load-Parsing Core Banking File-DB.xaml
│   ├── Load-Parsing IPN File.xaml
│   └── Reconciliation Engine.xaml
├── Data/                  # Data files and configurations
├── Framework/             # Framework components
└── SQL Operation/         # SQL scripts and operations
```

## Detailed Workflow Descriptions

### 1. Main Workflow (Main.xaml)

**Functionality:**

- Orchestrates the entire reconciliation process
- Manages state transitions and error handling
- Initializes configuration and applications

**Inputs:**

- Configuration file path
- Configuration sheets (Settings, Constants)
- Business process name

**Outputs:**

- Initialized system state
- Application connections
- Error logs (if any)

### 2. Process Workflow (Process.xaml)

**Functionality:**

- Coordinates the execution of all sub-workflows
- Manages parallel processing
- Handles workflow transitions

**Inputs:**

- Configuration dictionary
- Process state information

**Outputs:**

- Process execution status
- Error handling results
- Workflow completion status

### 3. Get IPN File (Bots/Get IPN File.xaml)

**Functionality:**

- Connects to SFTP server
- Downloads IPN transaction files
- Manages file organization

**Inputs:**

- SFTP host and port
- Unprocessed files path
- Processed files path
- Working date

**Outputs:**

- Downloaded IPN files
- File transfer logs
- Processing status

### 4. Get Core Banking File (Bots/Get Core Banking File.xaml)

**Functionality:**

- Retrieves transaction data from Core Banking system
- Validates file format and content
- Prepares data for processing

**Inputs:**

- Core Banking system connection details
- File retrieval parameters
- Date range for transactions

**Outputs:**

- Core Banking transaction files
- Validation results
- File retrieval logs

### 5. Load-Parsing Core Banking File-DB (Bots/Load-Parsing Core Banking File-DB.xaml)

**Functionality:**

- Parses Core Banking file contents
- Validates data structure
- Loads data into database

**Inputs:**

- Unprocessed Core Banking files
- Database connection string
- File paths (Unprocessed, Processed, Failed)

**Outputs:**

- Parsed transaction records
- Database insertion results
- Processing logs
- Failed records (if any)

### 6. Load-Parsing IPN File (Bots/Load-Parsing IPN File.xaml)

**Functionality:**

- Parses IPN file contents
- Validates transaction data
- Stores in database for reconciliation

**Inputs:**

- Unprocessed IPN files
- Database connection string
- File paths (Unprocessed, Processed, Failed)

**Outputs:**

- Parsed IPN records
- Database insertion status
- Validation results
- Error logs (if any)

### 7. Reconciliation Engine (Bots/Reconciliation Engine.xaml)

**Functionality:**

- Matches IPN and Core Banking transactions
- Identifies discrepancies
- Generates reconciliation reports
- Handles exception cases

**Inputs:**

- Database connection string
- Reconciliation mapping sheet path
- Transaction matching criteria
- Tolerance settings

**Outputs:**

- Matched transactions report
- Unmatched transactions list
- Discrepancy details
- Reconciliation summary
- Exception reports

## Configuration

The project uses a configuration file (`Data/Config.xlsx`) with the following key settings:

- SFTP connection details
- File paths for processing
- Database connection strings
- Reconciliation mapping configurations

## Input Files

1. **IPN Files**

   - Location: Retrieved from SFTP server
   - Format: As per IPN specification
   - Processing folders:
     - Unprocessed: `IPNFilesUnprocessed_Path`
     - Processed: `IPNFilesProcessed_Path`
     - Failed: `IPNFilesFailed_Path`

2. **Core Banking Files**
   - Location: Retrieved from Core Banking system
   - Processing folders:
     - Unprocessed: `CoreBankingFilesUnprocessed_Path`
     - Processed: `CoreBankingFilesProcessed_Path`
     - Failed: `CoreBankingFilesFailed_Path`

## Output

1. **Database Records**

   - Processed IPN transactions
   - Core Banking transactions
   - Reconciliation results

2. **Reconciliation Reports**
   - Matched transactions
   - Unmatched transactions
   - Discrepancy reports

## Error Handling

- Comprehensive error logging
- Failed file management
- Process recovery mechanisms
- Error notification system

## Best Practices

1. **File Management**

   - Regular cleanup of processed files
   - Maintain backup of important data
   - Follow naming conventions

2. **Database Operations**

   - Regular database maintenance
   - Index optimization
   - Data archival strategy

3. **Monitoring**
   - Monitor SFTP connectivity
   - Track processing times
   - Monitor database performance

## Support

For technical support or questions, please contact the development team.

## Version History

- Current Version: 1.0.18
- Last Updated: 2024
