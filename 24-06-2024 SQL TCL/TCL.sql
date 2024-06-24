-- Suppose we have the following tables in our database

1. accounts
   - Stores individual account information
   - Main columns: account_id, balance, account_holder

2. transaction_log
   - Records all transfers between accounts
   - Main columns: log_id, from_account, to_account, amount, transaction_date



-- Start a new transaction
BEGIN;

-- Assume we're transferring $500 from account 1001 to account 1002

-- First, check if account 1001 has sufficient balance
SELECT balance INTO @balance FROM accounts WHERE account_id = 1001;

-- If balance is sufficient, proceed with the transfer
IF @balance >= 500 THEN
    -- Create a savepoint before making changes
    SAVEPOINT before_transfer;
    
    -- Deduct $500 from account 1001
    UPDATE accounts SET balance = balance - 500 WHERE account_id = 1001;
    
    -- Add $500 to account 1002
    UPDATE accounts SET balance = balance + 500 WHERE account_id = 1002;
    
    -- Let's say we want to log this transaction
    INSERT INTO transaction_log (from_account, to_account, amount, transaction_date)
    VALUES (1001, 1002, 500, CURRENT_DATE);
    
    -- Check if the log was successful
    IF ROW_COUNT() = 1 THEN
        -- If everything is fine, commit the transaction
        COMMIT;
    ELSE
        -- If logging failed, rollback to the savepoint
        ROLLBACK TO SAVEPOINT before_transfer;
        
        -- Then rollback the entire transaction
        ROLLBACK;
    END IF;
ELSE
    -- If balance is insufficient, rollback the transaction
    ROLLBACK;
END IF;

-- Start a new transaction with specific characteristics
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;

-- Perform some other operations...

-- Commit or rollback based on the result of these operations


