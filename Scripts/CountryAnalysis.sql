--Analysing campaigns across the Countries--

SELECT
Country,
CONCAT(ROUND(CAST(SUM(Clicked) AS FLOAT) / COALESCE(SUM(Impression), 0),2),'%')AS CTR,
ROUND(CAST(SUM(Opted_in) AS FLOAT)/COALESCE(SUM(Clicked),0),2) AS LeadRate,
ROUND(CAST(SUM(Content_Consumed) AS FLOAT) /COALESCE(SUM(Opted_in),0),2) AS EngagementRate,
CONCAT(ROUND(CAST(SUM(Purchased) AS FLOAT) /COALESCE(SUM(Clicked),0),2), '%')AS SalesRate,
SUM(Cost)/SUM(Clicked)AS CPC,
SUM(Cost)/SUM(Opted_in) AS CPL,
ROUND(CAST(SUM(Cost) AS FLOAT)/SUM(Purchased),2) AS CPA,
ROUND(SUM(Revenue)/SUM(Clicked),2) AS EPC,
ROUND(SUM(Revenue)/SUM(Opted_in),2) AS EPL,
ROUND(SUM(Revenue)/SUM(Purchased) ,2) AS EPA
FROM dbo.Funnel_Data
GROUP BY Country
