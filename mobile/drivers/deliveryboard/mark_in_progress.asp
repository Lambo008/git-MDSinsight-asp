﻿<!--#include file="../../../inc/InsightFuncs.asp"-->
<!--#include file="../../../inc/InSightFuncs_routing.asp"-->
<%
IvsNum = Request.QueryString("i")
CustNum = Request.QueryString("c")

If  IvsNum <> "" Then
	
	SQLDeliveryBoard = "Update RT_DeliveryBoard Set DeliveryInProgress = 1 Where IvsNum = " & IvsNum
	
	Set cnnDeliveryBoard = Server.CreateObject("ADODB.Connection")
	cnnDeliveryBoard.open (Session("ClientCnnString"))
	Set rsDeliveryBoard = Server.CreateObject("ADODB.Recordset")
	Set rsDeliveryBoard = cnnDeliveryBoard.Execute(SQLDeliveryBoard)
	
	'Write audit trail for delivery
	'*******************************
	Description = GetUserDisplayNameByUserNo(Session("UserNo")) & " set delivery to In Progress for invoice " & IvsNum  & " for customer " & CustNum & " at " & NOW()
	CreateAuditLogEntry "Delivery Status Changed","Delivery Status Changed","Minor",0,Description 
	
	Set rsDeliveryBoard = Nothing
	cnnDeliveryBoard.Close
	Set cnnDeliveryBoard = Nothing

End If

Response.redirect("viewInvoices.asp?c=" & CustNum)
%>