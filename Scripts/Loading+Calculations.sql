USE MASTER
GO
CREATE DATABASE Funnel
GO
USE funnel;
truncate table Funnel_Data;
CREATE TABLE Funnel_Data
(User_id INT,
Traffic_source	NVARCHAR(50),
Device	NVARCHAR(50),
Country	NVARCHAR(50),
Impression INT,
Clicked	INT,
Opted_in	INT,
Content_consumed INT,
Purchased INT,
Revenue	FLOAT,
Cost	DECIMAL(3, 2),
Date DATE);

SELECT @@LANGUAGE;
SET LANGUAGE British;

BULK INSERT Funnel_Data
FROM 'C:\Users\HP\Dropbox\My PC (DESKTOP-BT38IV3)\Desktop\XLSTART\Funnel Data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
/*Now we start conducting our funnel analysis, and get the number of users in each stage*/
SELECT
COUNT(User_id) AS TotalUsers,
SUM(Impression) AS TotalImpressions,
SUM(Clicked) AS TotalClicked,
SUM(Opted_in) AS TotalOptIns,
SUM(Content_Consumed) AS TotalConsumers,
SUM(Purchased) AS TotalPurchases
FROM dbo.Funnel_Data
;
/* Calculate the COST PE IMPRESSON*/
CPM = (Total Cost / Total Impressions) * 1000
SELECT
SUM(Cost) AS TotalCost,
SUM(Impression) AS TotalImpressions,
SUM(Cost)/SUM(Impression)*1000 AS CPM
FROM dbo.Funnel_Data

/* Calculate the CLICK THROUGH RATE*/
CTR= Total clicks/Total Impressions
SELECT
    SUM(Impression) AS TotalImpressions,
    SUM(Clicked) AS TotalClicked,
	CONCAT(ROUND(CAST(SUM(Clicked) AS FLOAT) / COALESCE(SUM(Impression), 0),2),'%')AS CTR
FROM dbo.Funnel_Data;

/* Calculate the COST PER CLICK*/
CPC Total Cost/Total Clicks
SELECT
SUM(Cost) AS TotalCost,
SUM(Clicked) AS TotalClicked,
SUM(Cost)/SUM(Clicked)AS CPC
FROM dbo.Funnel_Data;

/* Calculate the COST PER LEAD*/
CPL Total Cost/Total OptInS
SELECT
SUM(Cost) AS TotalCost,
SUM(Opted_in) AS TotalOptIns,
SUM(Cost)/SUM(Opted_in) AS CPL
FROM dbo.Funnel_Data;

/*Calcylate the ENGAGEMENT RATE*/
Engagement Rate = Content Consumed / OptIns
SELECT
SUM(Opted_in) AS TotalOptIns,
SUM(Content_Consumed) AS TotalConsumers,
ROUND(CAST(SUM(Content_Consumed) AS FLOAT) /COALESCE(SUM(Opted_in),0),2) AS EngagementRate
FROM dbo.Funnel_Data;

/*CalcUlate the COST PER ACQUISTION*/
CPA= TotalCosts/TotalPurchases
SELECT
SUM(Cost) AS TotalCost,
SUM(Purchased) AS TotalPurchases,
ROUND(CAST(SUM(Cost) AS FLOAT)/SUM(Purchased),2) AS CPA
FROM dbo.Funnel_Data;

/*Earnings Per Clicks*/
SELECT
SUM(Revenue) AS TotalRevenus,
SUM(Clicked) AS TotalClicked,
ROUND(SUM(Revenue)/SUM(Clicked),2) AS EPC
FROM dbo.Funnel_Data;

/*Earnings Per Lead*/
SELECT
SUM(Revenue) AS TotalRevenus,
SUM(Opted_in) AS TotalOptIns,
ROUND(SUM(Revenue)/SUM(Opted_in),2) AS EPL
FROM dbo.Funnel_Data;

/*Earnings Per acquisition*/
SELECT
SUM(Revenue) AS TotalRevenus,
SUM(Purchased) AS TotalPurchases,
ROUND(SUM(Revenue)/SUM(Purchased) ,2) AS EPA
FROM dbo.Funnel_Data;

/* Get the Optin Rate*/
SELECT
SUM(Clicked) AS TotalClicked,
SUM(Opted_in) AS TotalOptIns,
CONCAT(ROUND(CAST(SUM(Opted_in) AS FLOAT) /COALESCE(SUM(Clicked),0),2), '%') AS OptinRate
FROM dbo.Funnel_Data;

/*Get the Sales Rate*/
SELECT
SUM(Clicked) AS TotalClicked,
SUM(Purchased) AS TotalPurchases,
CONCAT(ROUND(CAST(SUM(Purchased) AS FLOAT) /COALESCE(SUM(Clicked),0),2), '%')AS SalesRate
FROM dbo.Funnel_Data;
