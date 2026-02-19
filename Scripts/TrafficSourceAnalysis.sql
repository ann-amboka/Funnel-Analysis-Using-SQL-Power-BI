
/* Performance of all our Traffic Sources*/
SELECT 
COUNT(User_id) AS TotalUsers,
Traffic_source,
SUM(Impression) AS TotalImpressions,
SUM(Clicked) AS TotalClicked,
SUM(Opted_in) AS TotalOptIns,
SUM(Content_Consumed) AS TotalConsumers,
SUM(Purchased) AS TotalPurchases
FROM dbo.Funnel_Data
GROUP BY Traffic_source
ORDER BY TotalUsers DESC

/* Calculate the COST PER IMPRESSION*/
SELECT
Traffic_source,
SUM(Cost)/SUM(Impression)*1000 AS CPM
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/* Calculate the CLICK THROUGH RATE*/
SELECT
	Traffic_source,
	CONCAT(ROUND(CAST(SUM(Clicked) AS FLOAT) / COALESCE(SUM(Impression), 0),2),'%')AS CTR
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/* Calculate the COST PER CLICK*/
SELECT
Traffic_source,
SUM(Cost)/SUM(Clicked)AS CPC
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/* Calculate the COST PER LEAD*/
SELECT
Traffic_source,
SUM(Cost)/SUM(Opted_in) AS CPL
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/*Calculate the ENGAGEMENT RATE*/
SELECT
Traffic_source,
ROUND(CAST(SUM(Content_Consumed) AS FLOAT) /COALESCE(SUM(Opted_in),0),2) AS EngagementRate
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/*Calculate the COST PER ACQUISTION*/

SELECT
Traffic_source,
ROUND(CAST(SUM(Cost) AS FLOAT)/SUM(Purchased),2) AS CPA
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/*Earnings Per Clicks*/
SELECT
Traffic_source,
ROUND(SUM(Revenue)/SUM(Clicked),2) AS EPC
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/*Earnings Per Lead*/
SELECT
Traffic_source,
ROUND(SUM(Revenue)/SUM(Opted_in),2) AS EPL
FROM dbo.Funnel_Data
GROUP BY Traffic_source;

/*Earnings Per acquisition*/
SELECT
Traffic_source,
ROUND(SUM(Revenue)/SUM(Purchased) ,2) AS EPA
FROM dbo.Funnel_Data
GROUP BY Traffic_source;
