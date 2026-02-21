--We are analyzing all the traffic sources that we used, and see how each of them performed and identify the best platform and the weak one--
/* Performance of all our Traffic Sources*/
SELECT
    Traffic_source,
    COUNT(User_id) AS TotalUsers,
    SUM(Impression) AS TotalImpressions,
    SUM(Clicked) AS TotalClicked,
    SUM(Opted_in) AS TotalOptIns,
    SUM(Content_Consumed) AS TotalConsumers,
    SUM(Purchased) AS TotalPurchases,
    
    -- Cost per Impression
    ROUND(SUM(Cost)/NULLIF(SUM(Impression),0)*1000,2) AS CPM,
    
    -- Click Through Rate
    ROUND(CAST(SUM(Clicked) AS FLOAT)/NULLIF(SUM(Impression),0),2) AS CTR,
    
    -- Cost per Click
    ROUND(SUM(Cost)/NULLIF(SUM(Clicked),0),2) AS CPC,
    
    -- Cost per Lead
    ROUND(SUM(Cost)/NULLIF(SUM(Opted_in),0),2) AS CPL,
    
    -- Engagement Rate
    ROUND(CAST(SUM(Content_Consumed) AS FLOAT)/NULLIF(SUM(Opted_in),0),2) AS EngagementRate,
    
    -- Cost per Acquisition
    ROUND(CAST(SUM(Cost) AS FLOAT)/NULLIF(SUM(Purchased),0),2) AS CPA,
    
    -- Earnings Per Click
    ROUND(SUM(Revenue)/NULLIF(SUM(Clicked),0),2) AS EPC,
    
    -- Earnings Per Lead
    ROUND(SUM(Revenue)/NULLIF(SUM(Opted_in),0),2) AS EPL,
    
    -- Earnings Per Acquisition
    ROUND(SUM(Revenue)/NULLIF(SUM(Purchased),0),2) AS EPA

FROM dbo.Funnel_Data
GROUP BY Traffic_source
ORDER BY TotalUsers DESC;
