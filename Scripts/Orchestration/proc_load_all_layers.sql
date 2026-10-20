CREATE OR ALTER PROCEDURE dbo.proc_load_all_layers
AS
BEGIN

    DECLARE @PipelineStartTime DATETIME = GETDATE();
    DECLARE @StepStartTime DATETIME;

    BEGIN TRY
        PRINT '=======================================================';
        PRINT 'STARTING END-TO-END MEDALLION PIPELINE EXECUTION';
        PRINT 'Started at: ' + CONVERT(VARCHAR, @PipelineStartTime, 120);
        PRINT '=======================================================';

        -----------------------------------------------------------------------
        -- 1. BRONZE LAYER LOAD
        -----------------------------------------------------------------------
        SET @StepStartTime = GETDATE();
        PRINT '--> Step 1/3: Executing Bronze Layer Load...';
        
        EXEC bronze.load_bronze;
        
        PRINT '    Bronze Layer completed in ' + CAST(DATEDIFF(SECOND, @StepStartTime, GETDATE()) AS VARCHAR) + ' second(s).';

        -----------------------------------------------------------------------
        -- 2. SILVER LAYER LOAD
        -----------------------------------------------------------------------
        SET @StepStartTime = GETDATE();
        PRINT '--> Step 2/3: Executing Silver Layer Load...';
        
        EXEC silver.load_silver;
        
        PRINT '    Silver Layer completed in ' + CAST(DATEDIFF(SECOND, @StepStartTime, GETDATE()) AS VARCHAR) + ' second(s).';

        -----------------------------------------------------------------------
        -- 3. GOLD LAYER LOAD
        -----------------------------------------------------------------------
        SET @StepStartTime = GETDATE();
        PRINT '--> Step 3/3: Executing Gold Layer Load...';
        
        EXEC gold.load_gold;
        
        PRINT '    Gold Layer completed in ' + CAST(DATEDIFF(SECOND, @StepStartTime, GETDATE()) AS VARCHAR) + ' second(s).';

        -----------------------------------------------------------------------
        -- SUMMARY LOG
        -----------------------------------------------------------------------
        PRINT '=======================================================';
        PRINT 'PIPELINE COMPLETED SUCCESSFULLY!';
        PRINT 'Total Execution Time: ' + CAST(DATEDIFF(SECOND, @PipelineStartTime, GETDATE()) AS VARCHAR) + ' second(s).';
        PRINT '=======================================================';

    END TRY
    BEGIN CATCH
        PRINT '=======================================================';
        PRINT 'PIPELINE EXECUTION FAILED!';
        PRINT 'Failed Layer / Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
        PRINT '=======================================================';
    END CATCH
END;
GO