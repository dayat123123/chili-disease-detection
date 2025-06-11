-- Ini Store procedure
CREATE OR REPLACE PROCEDURE SP_INIT_PORTFOLIO_SUMMARY (p_Id varchar(15) = '')
AS $$
BEGIN 
	IF 0 = LENGTH(p_Id) THEN 
	BEGIN
		TRUNCATE TABLE PortfolioSummary;
		INSERT INTO PortfolioSummary (CustId, StockCode, StockType, HasCA, ClosePrice, AvgPrice, BeginBalance, Balance, DueBalance, BlockedVolume, Collateral, 
			TotBuyTrades, TotSellTrades, TotTNBuyTrades, TotTNSellTrades, TotOLBuyTrades, TotOLSellTrades, TotOLTNBuyTrades, TotOLTNSellTrades,
			TotBuyOrders, TotSellOrders, TotOLBuyOrders, TotOLSellOrders, OpenBuyVolume, OpenSellVolume)
			SELECT A.CustId, A.StockCode, 
				CASE B.Type 
					WHEN 'B' THEN 7
					WHEN 'O' THEN 6
					WHEN 'D' THEN 5
					WHEN 'E' THEN 4
					WHEN 'W' THEN 3
					WHEN 'R' THEN 2
					ELSE 1 END AS StockType,
				CASE WHEN D.StockCode IS NULL THEN 0 ELSE 1 END AS HasCA,
				CAST(COALESCE (B.ClosePrice, 0) AS INT) AS ClosePrice, 
				A.AvgPrice, A.Balance, A.Balance, A.DueBalance, A.BlockedVolume, 
				CAST(COALESCE (CASE WHEN 'M'=COALESCE(C.With_Depo, '') THEN B.Valuation_Mar ELSE B.Valuation_Reg END, 0) AS SMALLINT), 0, 0, 0, 0, 0, 0, 0, 0,
				TotBuyOrders, TotSellOrders, TotOLBuyOrders, TotOLSellOrders, OpenBuyVolume, OpenSellVolume
			FROM 
			(
				SELECT CustId, StockCode, CASE WHEN 0 = SUM(Balance) THEN 0 ELSE SUM(AvgPrice * Balance) / SUM(Balance) END AS AvgPrice, 
					SUM(Balance) AS Balance, SUM(DueBalance) AS DueBalance, SUM(BlockedVolume) AS BlockedVolume,
					SUM(TotBuyOrders) AS TotBuyOrders, SUM(TotSellOrders) AS TotSellOrders, SUM(TotOLBuyOrders) AS TotOLBuyOrders, SUM(TotOLSellOrders) AS TotOLSellOrders,
					SUM(OpenBuyVolume) AS OpenBuyVolume, SUM(OpenSellVolume) AS OpenSellVolume
				FROM 
				(
					SELECT ClAcNo AS CustId, PortoCode AS StockCode, 
						SUM(PortoAverage * (PortoQuantity + PortoBlock)) / SUM(PortoQuantity + PortoBlock) AS AvgPrice, 
						SUM(PortoQuantity) AS Balance, SUM(PortoKSEI)AS DueBalance, SUM(PortoBlock)AS BlockedVolume,
						0 AS TotBuyOrders, 0 AS TotSellOrders, 0 AS TotOLBuyOrders, 0 AS TotOLSellOrders, 0 AS OpenBuyVolume, 0 AS OpenSellVolume
					FROM Porto
					GROUP BY ClAcNo, PortoCode HAVING 0 <> SUM(PortoQuantity)
					--UNION ALL
					--SELECT CustId=ClientNo, StockCode=ShareNo, 
					--	AvgPrice=SUM(AvgPrice * Qty) / SUM(Qty), 
					--	Balance=SUM(Qty), DueBalance=SUM(Qty), BlockedVolume=0,
					--	TotBuyOrders=0, TotSellOrders=0, TotOLBuyOrders=0, TotOLSellOrders=0, OpenBuyVolume=0, OpenSellVolume=0
					--FROM sas_rt.dbo.StockBO 
					--WHERE CONVERT(varchar(8), DateBO, 112)=CONVERT(varchar(8), GetDate(), 112)
					--GROUP BY ClientNo, ShareNo HAVING 0 <> SUM(Qty)
				) A1 GROUP BY CustId, StockCode
			) A
			LEFT JOIN ShareOL B ON A.StockCode=B.ShareCode
			LEFT JOIN subacc C ON A.CustId=C.No_Cust
			LEFT JOIN 
			(
				SELECT DISTINCT StockCode FROM V_CorporateAction  
			) D ON A.StockCode=D.StockCode;
	END;
	ELSE 
	BEGIN
		DELETE  FROM PortfolioSummary WHERE CustId=p_Id;
		INSERT INTO PortfolioSummary (CustId, StockCode, StockType, HasCA, ClosePrice, AvgPrice, BeginBalance, Balance, DueBalance, BlockedVolume, Collateral, 
			TotBuyTrades, TotSellTrades, TotTNBuyTrades, TotTNSellTrades, TotOLBuyTrades, TotOLSellTrades, TotOLTNBuyTrades, TotOLTNSellTrades,
			TotBuyOrders, TotSellOrders, TotOLBuyOrders, TotOLSellOrders, OpenBuyVolume, OpenSellVolume)
			SELECT A.CustId, A.StockCode, 
				CASE B.Type WHEN 'B' THEN 7
					WHEN 'O' THEN 6
					WHEN 'D' THEN 5
					WHEN 'E' THEN 4
					WHEN 'W' THEN 3
					WHEN 'R' THEN 2
					ELSE 1 END AS StockType,
				CASE WHEN D.StockCode IS NULL THEN 0 ELSE 1 END AS HasCA,
				CAST(COALESCE (B.ClosePrice, 0) AS INT) AS ClosePrice, 
				A.AvgPrice, A.Balance, A.Balance, A.DueBalance, A.BlockedVolume, 
				CAST(COALESCE(CASE WHEN 'M'=COALESCE(C.With_Depo, '') THEN B.Valuation_Mar ELSE B.Valuation_Reg END, 0) AS smallint), 0, 0, 0, 0, 0, 0, 0, 0,
				TotBuyOrders, TotSellOrders, TotOLBuyOrders, TotOLSellOrders, OpenBuyVolume, OpenSellVolume
			FROM 
			(
				SELECT CustId, StockCode, CASE WHEN 0 = SUM(Balance) THEN 0 ELSE SUM(AvgPrice * Balance) / SUM(Balance) END AS AvgPrice, 
					SUM(Balance) AS Balance, SUM(DueBalance) AS DueBalance, SUM(BlockedVolume) AS BlockedVolume,
					SUM(TotBuyOrders) AS TotBuyOrders, SUM(TotSellOrders) AS TotSellOrders, SUM(TotOLBuyOrders) AS TotOLBuyOrders, SUM(TotOLSellOrders) AS TotOLSellOrders,
					SUM(OpenBuyVolume) AS OpenBuyVolume, SUM(OpenSellVolume) AS OpenSellVolume
				FROM 
				(
					SELECT ClAcNo AS CustId, PortoCode AS StockCode, 
						SUM(PortoAverage * (PortoQuantity + PortoBlock)) / SUM(PortoQuantity + PortoBlock) AS AvgPrice, 
						SUM(PortoQuantity) AS Balance, SUM(PortoKSEI) AS DueBalance, SUM(PortoBlock) AS BlockedVolume,
						0 AS TotBuyOrders, 0 AS TotSellOrders, 0 AS TotOLBuyOrders, 0 AS TotOLSellOrders, 0 AS OpenBuyVolume, 0 AS OpenSellVolume
					FROM Porto
					WHERE ClAcNo=p_Id
					GROUP BY ClAcNo, PortoCode HAVING 0 <> SUM(PortoQuantity)
					--UNION ALL
					--SELECT CustId=ClientNo, StockCode=ShareNo, 
					--	AvgPrice=SUM(AvgPrice * Qty) / SUM(Qty), 
					--	Balance=SUM(Qty), DueBalance=SUM(Qty), BlockedVolume=0,
					--	TotBuyOrders=0, TotSellOrders=0, TotOLBuyOrders=0, TotOLSellOrders=0, OpenBuyVolume=0, OpenSellVolume=0
					--FROM sas_rt.dbo.StockBO 
					--WHERE ClientNo=p_Id AND CONVERT(varchar(8), DateBO, 112)=CONVERT(varchar(8), GetDate(), 112)
					--GROUP BY ClientNo, ShareNo HAVING 0 <> SUM(Qty)
				) A1 GROUP BY CustId, StockCode
			) A
			LEFT JOIN ShareOL B ON A.StockCode=B.ShareCode
			LEFT JOIN subacc C ON A.CustId=C.No_Cust
			LEFT JOIN 
			(
				SELECT DISTINCT StockCode FROM V_CorporateAction 
			) D ON A.StockCode=D.StockCode;
	END;
	END IF;
END $$ LANGUAGE plpgsql;

-- Ini view
CREATE OR REPLACE VIEW V_STOCK_BALANCE AS
SELECT 
	CustId, 
	StockCode, 
	SUM(AvgPrice * Qty) / SUM(Qty) AS AvgPrice, 
	SUM(RVol) AS UsedVolume, 
	SUM(Qty) AS TotVolume, CASE WHEN SUM(DueQty) < 0 THEN 0 ELSE SUM(DueQty) END AS DueBalance,
	MAX(Collateral) AS Collateral
FROM 
(
	SELECT 
		CustId, 
		StockCode, 
		CAST(ROUND(AvgPrice::INT, 0) AS INT) AS AvgPrice, 
		Balance + BlockedVolume AS Qty, 
		CASE WHEN DueBalance > Balance THEN Balance ELSE DueBalance END + BlockedVolume AS DueQty, 
		BlockedVolume AS RVol, 
		Collateral 
	FROM portfoliosummary WHERE 0 <> Balance OR 0 <> DueBalance
	UNION ALL
		SELECT 
			A.CustId, 
			A.StockCode, 
			0 AS AvgPrice, 
			0 AS Qty, 
			0 AS DueQty, 
			SUM(CASE WHEN A.BS IN (1, 3) THEN CASE WHEN C.NewVolume > A.RVolume THEN C.NewVolume ELSE A.RVolume END ELSE 0 END) AS RVol,
			0 AS Collateral
		FROM texchangemarketorder A
		LEFT JOIN tamending C ON A.OrderId=C.OrderId AND 0=C.AmendStatus
		WHERE to_char(A.OTime, 'YYYYMMDD') = to_char(current_date, 'YYYYMMDD') AND A.OrderStatus IN (1, 3, 4) AND A.BS IN (1, 3)
		GROUP BY A.CustId, A.StockCode
	UNION ALL
		SELECT 
			CustId, 
			StockCode, 
			0 AS AvgPrice, 
			0 AS Qty, 
			0 AS DueQty, 
			SUM(ExerciseQuantity) AS RVol, 
			0 AS Collateral
		FROM texerciserighwarrant  WHERE Status IN (1, 2) GROUP BY CustId, StockCode
) AS C
GROUP BY CustId, StockCode HAVING 0 <> SUM(Qty);