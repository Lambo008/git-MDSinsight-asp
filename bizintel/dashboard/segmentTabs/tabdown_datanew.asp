<!--#include file="../../../inc/InSightFuncs.asp"-->
<!--#include file="../../../inc/InSightFuncs_BizIntel.asp"--> 
<!--#include file="../../../inc/InSightFuncs_Equipment.asp"--> 
<!--#include file="../../../inc/InSightFuncs_AR_AP.asp"-->


<%
	Segment = Request.QueryString("p")
	ShowPercentageColumns = False
	
	Set cnn8 = Server.CreateObject("ADODB.Connection")
	cnn8.ConnectionTimeout = 120
	cnn8.open (Session("ClientCnnString"))
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.CursorLocation = 3

	JSON=""
	
	Select Case MUV_READ("LOHVAR")
		Case "Secondary"
			
			SQL = "SELECT * FROM BI_DashboardSegmentTabs WHERE Tab = 'DOWN' AND SecondarySalesmanNumber = " & Segment 
			
		Case "Primary"

			SQL = "SELECT Distinct CustCatPeriodSales_ReportData.CustNum,LCPTotSalesAllCats as LCPSales, Total3PPAvgAllCats, TotalCostAllCats, TotalTPLYAllCats "
			SQL = SQL & ",Total3PPSalesAllCats AS ThreePPSales "
			SQL = SQL & ", Total12PPSalesAllCats As TwelvePPSales "
			SQL = SQL & " FROM CustCatPeriodSales_ReportData "
			SQL = SQL & " WHERE ThisPeriodSequenceNumber = " & PeriodSeqBeingEvaluated 
			SQL = SQL & " AND  LCPTotSalesAllCats <= (Total3PPSalesAllCats /3) "
			SQL = SQL & " AND  PrimarySalesman = " & Segment 
			SQL = SQL & " AND TotalSales < [3PriorPeriodsAeverage] "
			SQL = SQL & " AND [3PriorPeriodsAeverage] - TotalSales > " & FilterSalesDollars 
			SQL = SQL & " AND (CASE WHEN [3PriorPeriodsAeverage] <> 0 THEN (((TotalSales - [3PriorPeriodsAeverage] ) / [3PriorPeriodsAeverage]) * 100) * -1 END) >= " & FilterPercentage 

		Case "CustType"

			SQL = "SELECT Distinct CustCatPeriodSales_ReportData.CustNum,LCPTotSalesAllCats as LCPSales, Total3PPAvgAllCats, TotalCostAllCats, TotalTPLYAllCats "
			SQL = SQL & ",Total3PPSalesAllCats AS ThreePPSales "
			SQL = SQL & ", Total12PPSalesAllCats As TwelvePPSales "
			SQL = SQL & " FROM CustCatPeriodSales_ReportData "
			SQL = SQL & " WHERE ThisPeriodSequenceNumber = " & PeriodSeqBeingEvaluated 
			SQL = SQL & " AND  LCPTotSalesAllCats <= (Total3PPSalesAllCats /3) "
			SQL = SQL & " AND  CustType = " & Segment 
			SQL = SQL & " AND TotalSales < [3PriorPeriodsAeverage] "
			SQL = SQL & " AND [3PriorPeriodsAeverage] - TotalSales > " & FilterSalesDollars 
			SQL = SQL & " AND (CASE WHEN [3PriorPeriodsAeverage] <> 0 THEN (((TotalSales - [3PriorPeriodsAeverage] ) / [3PriorPeriodsAeverage]) * 100) * -1 END) >= " & FilterPercentage 


		End Select

	'Response.write(SQL)
	
	Set rs = cnn8.Execute(SQL)
	
		Do While Not rs.EOF

							
			IF LEN(JSON)>0 Then
				JSON=JSON+","
			END If
			JSON=JSON+"{"
			JSON=JSON & """SelectedCustomerID"":""" & rs("CustID") & """"
			JSON=JSON+","
			JSON=JSON & """CustName"":""" & rs("CustName") & """"
			JSON=JSON+","
			JSON=JSON & """LCPvs3PAvgSales"":""" & FormatCurrency(rs("LCPv3PAvg"),0,-2,0) & """"
			JSON=JSON+","
			JSON=JSON & """LCPvs3PAvgPercent"":""" & FormatNumber(0,0) & """"
			JSON=JSON+","
			JSON=JSON & """DayImpact"":""" & FormatCurrency(rs("DayImpact"),0) & """"
			JSON=JSON+","
			JSON=JSON & """ADS_Variance"":""" & FormatCurrency(rs("ADS"),0) & """"
			JSON=JSON+","
			JSON=JSON & """LCPvs12PAvgSales"":""" & FormatCurrency(rs("LCPv12PAvg"),0) & """"
			JSON=JSON+","
			JSON=JSON & """LCPvs12PAvgPercent"":""" & FormatNumber(0,0)  & """"
			JSON=JSON+","
			JSON=JSON & """PP1Sales"":""" & FormatCurrency(rs("PP1Sales"),0,-2,0)  & """"
			JSON=JSON+","
			JSON=JSON & """PP2Sales"":""" & FormatCurrency(rs("PP2Sales"),0,-2,0)  & """"
			JSON=JSON+","
			JSON=JSON & """LCPSales"":""" & FormatCurrency(rs("LCPSales"),0,-2,0)  & """"
			JSON=JSON+","
			JSON=JSON & """ThreePPAvgSales"":""" & FormatCurrency(rs("ThreePAvgSales"),0,-2,0)  & """"
			JSON=JSON+","
			JSON=JSON & """TwelvePPAvgSales"":""" & FormatCurrency(rs("TwelvePAvgSales"),0,-2,0)  & """"
			JSON=JSON+","
			JSON=JSON & """CurrentPSales"":""" & FormatCurrency(rs("CPSales"),0,-2,0)  & """"
			JSON=JSON+","
			JSON=JSON & """SamePLYSales"":""" & FormatCurrency(rs("SPLYSales"),0,-2,0)  & """"
			JSON=JSON+","
			If Not IsNull(rs("MCS")) Then
				JSON=JSON & """MCS"":""" &  FormatCurrency(rs("MCS"),0)  & """"
				JSON=JSON+","
			Else
				JSON=JSON & """MCS"":""0"""
				JSON=JSON+","
			End If
			If Not IsNull(rs("LCPvMCS")) Then
				JSON=JSON & """LCPvsMCS"":""" &  FormatCurrency(rs("LCPvMCS"),0,-2,0)  & """"
				JSON=JSON+","
			Else
				JSON=JSON & """LCPvsMCS"":"""""
				JSON=JSON+","
			End If
			If Not IsNull(rs("ThreePAvgvMCS")) Then
				JSON=JSON & """3PavgvsMCS"":""" &  FormatCurrency(rs("ThreePAvgvMCS"),0,-2,0)  & """"
				JSON=JSON+","
			Else
				JSON=JSON & """3PavgvsMCS"":"""""
				JSON=JSON+","
			End If
			If Not IsNull(rs("TwelvePAvgvMCS")) Then
				JSON=JSON & """12PavgvsMCS"":""" &  FormatCurrency(rs("TwelvePAvgvMCS"),0,-2,0)  & """"
				JSON=JSON+","
			Else
				JSON=JSON & """12PavgvsMCS"":"""""
				JSON=JSON+","
			End If
			If Not IsNull(rs("CPvMCS")) Then
				JSON=JSON & """CurrentvsMCS"":""" &  FormatCurrency(rs("CPvMCS"),0,-2,0)  & """"
				JSON=JSON+","
			Else
				JSON=JSON & """CurrentvsMCS"":"""""
				JSON=JSON+","
			End If
			If rs("EqpValue")> 0 Then	
				If IsNumeric(rs("LCPROI")) Then
					JSON=JSON & """LCP_ROI"":""" &   FormatNumber(rs("LCPROI"),1)  & """"
					JSON=JSON+","
				Else
					JSON=JSON & """LCP_ROI"":""No Sales"""
					JSON=JSON+","
				End If
				If IsNumeric(rs("ThreePAvgROI")) Then
					JSON=JSON & """PavgROI"":""" & FormatNumber(rs("ThreePAvgROI"),1) & """"
					JSON=JSON+","
				Else
					JSON=JSON & """PavgROI"":"""""
					JSON=JSON+","
				End If
				' Write equipment value regardless of ROI
				JSON=JSON & """TotalEquipmentValue"":""" & FormatCurrency(rs("EqpValue"),0) & """"
				JSON=JSON+","
			Else
				JSON=JSON & """LCP_ROI"":"""""
				JSON=JSON+","
				JSON=JSON & """PavgROI"":"""""
				JSON=JSON+","
				JSON=JSON & """TotalEquipmentValue"":"""""
				JSON=JSON+","
			End If
			Select Case MUV_READ("LOHVAR")
					Case "Secondary"
					    If Instr(rs("PrimarySalesmanName") ," ") <> 0 Then
							JSON=JSON & """PrimarySalesPerson"":""" & Left(rs("PrimarySalesmanName"),Instr(rs("PrimarySalesmanName")," ")+1) & """"
							JSON=JSON+","
						Else
							JSON=JSON & """PrimarySalesPerson"":""" & rs("PrimarySalesmanName")& """"
							JSON=JSON+","
						End If
					Case "Primary"
					    If Instr(rs("SecondarySalesmanName")," ") <> 0 Then
							JSON=JSON & """SecondarySalesPerson"":""" & Left(rs("SecondarySalesmanName"),Instr(rs("SecondarySalesmanName")," ")+1) & """"
							JSON=JSON+","
						Else
							JSON=JSON & """SecondarySalesPerson"":""" & rs("SecondarySalesmanName")& """"
							JSON=JSON+","
						End If
					Case "CustType"
					    If Instr(rs("SecondarySalesmanName")," ") <> 0 Then
							JSON=JSON & """SecondarySalesPerson"":""" & Left(rs("SecondarySalesmanName"),Instr(rs("SecondarySalesmanName")," ")+1) & """"
							JSON=JSON+","
						Else
							JSON=JSON & """SecondarySalesPerson"":""" & rs("SecondarySalesmanName")& """"
							JSON=JSON+","
						End If
			End Select	
			JSON=JSON & """CustomerType"":""" & rs("CustomerTypeName")& """"
			JSON=JSON+","
			JSON=JSON & """CustomerNotes"":""" & UserHasAnyUnviewedNotes(rs("CustID")) & """"
			JSON=JSON+","
			JSON=JSON & """rules"":""" & "123abc" & """"
            JSON=JSON & "}"
		    
			rs.movenext
				
		Loop
		'retData="{""orderby"":""" & orderValue & """,""draw"": " & CLng(Request.QueryString("draw")) & ",""recordsTotal"": " & nRecordCount & ",""recordsFiltered"": " & nRecordCount & ",""data"": [" & JSONdata & "],""byRegionData"":"+GetQtyCustByRegion()+"}"
		JSON="{""data"":[" & JSON & "]}"
		
		Response.AddHeader "Content-Type", "application/json"
		response.write JSON

%>

