﻿<%
SQL = "DELETE FROM Settings_Reports where ReportNumber = 1500 AND UserNo = " & Session("userNo")

Set cnn8 = Server.CreateObject("ADODB.Connection")
cnn8.open (Session("ClientCnnString"))
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs= cnn8.Execute(SQL)

cnn8.Close

Set rs = Nothing
Set cnn8 = Nothing

Response.Redirect ("SalesByMonthDetail.asp")
%>

 
