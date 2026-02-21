--See our campaign's performance across different devices--

SELECT
Device,
CONCAT(ROUND(CAST(SUM(Clicked) AS FLOAT) / COALESCE(SUM(Impression), 0),2),'%')AS CTR,
ROUND(CAST(SUM(Opted_in) AS FLOAT)/COALESCE(SUM(Clicked),0),2) AS LeadRate,
ROUND(CAST(SUM(Content_Consumed) AS FLOAT) /COALESCE(SUM(Opted_in),0),2) AS EngagementRate,
CONCAT(ROUND(CAST(SUM(Purchased) AS FLOAT) /COALESCE(SUM(Clicked),0),2), '%')AS SalesRate
FROM dbo.Funnel_Data
GROUP BY Device
