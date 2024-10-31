USE azuredataeng_udacity;

-- Drop table if exists
IF OBJECT_ID('dbo.dim_Rider') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_Rider

-- Create dim_Rider table using the corresponding staging one
CREATE EXTERNAL TABLE dbo.dim_Rider WITH (
    LOCATION = 'starSchema/dim_Rider',
    DATA_SOURCE = [blobStorage],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        [rider_id],
        [address],
        [first],
        [last],
        CONVERT(varchar(10), [birthday], 111) AS [birthday],
        CONVERT(varchar(10), [account_start_date], 111) AS [account_start_date],
        LEFT([account_end_date], 10) AS [account_end_date],
        [is_member]
    FROM
        dbo.stagingRider
);

-- Check
SELECT TOP 100 * FROM dbo.dim_Rider