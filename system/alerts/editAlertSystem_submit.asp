<!--#include file="../../inc/subsandfuncs.asp"-->
<!--#include file="../../inc/InsightFuncs.asp"-->

<%
InternalAlertRecNumber = Request.Form("txtInternalAlertRecNumber")

'*******************************************************************
'Lookup the record as it exists now so we can fillin the audit trail

SQL = "SELECT * FROM SC_Alerts where InternalAlertRecNumber = " & InternalAlertRecNumber 
	
Set cnn8 = Server.CreateObject("ADODB.Connection")
cnn8.open (Session("ClientCnnString"))
Set rs = Server.CreateObject("ADODB.Recordset")
rs.CursorLocation = 3 
Set rs = cnn8.Execute(SQL)
	
If not rs.EOF Then
	Orig_AlertName = rs("AlertName")
	Orig_Enabled = rs("Enabled")
	Orig_Condition = rs("Condition")
	Orig_Minutes = rs("NBMinutes")
	Orig_Emailto = rs("EmailToUserNos") 
	Orig_AdditionalEmails = rs("AdditionalEmails")
	Orig_VerbiageEmail = rs("EmailVerbiage")
	Orig_Textto = rs("TextToUserNos")
	Orig_AdditionalTexts = rs("AdditionalText")
	Orig_TextVerbiage = rs("TextVerbiage") 
	Orig_IncludeLog = rs("NBIncludeLog")
	Orig_NotificationType  = rs("NotificationType")
	Orig_PublicOrPrivate  = rs("PublicOrPrivate")
	Orig_TimeOfDay  = rs("TimeOfDay")
	Orig_NumberOfDays = rs("NumberOfDays")
End If

set rs = Nothing
cnn8.close
set cnn8 = Nothing
'***********************************************************************
'End Lookup the record as it exists now so we can fillin the audit trail
'***********************************************************************

AlertName = Request.Form("txtAlertName")
Enabled = Request.Form("chkEnabled")
Condition = Request.Form("selCond")
Minutes = Request.Form("selMinutes")
Emailto = Request.Form("selEmailto") 
AdditionalEmails = Request.Form("txtaAdditionalEmails")
VerbiageEmail = Request.Form("txtaVerbiageEmail")
Textto = Request.Form("selTextto")
AdditionalTexts = Request.Form("txtaAdditionalTexts")
TextVerbiage = Request.Form("txtAlertTextVerbiage") 
IncludeLog = Request.Form("chkLog")
InternalAlertRecNumber = Request.Form("txtInternalAlertRecNumber")
LimitMinutes = Request.Form("selLimitMinutes")
LimitMaxTimes = Request.Form("selLimitMaxTimes")
NotificationType = Request.Form("optNotificationType")
PublicOrPrivate = Request.Form("optPublicOrPrivate")
TimeOfDay = Request.Form("selTimeOfDay")
NumberOfDays = Request.Form("selDays")

'Response.Write("LimitMinutes " & LimitMinutes & "<br>")
'Response.Write("Request.Form(selLimitMinutes) " & Request.Form("selLimitMinutes") & "<br>")
'Response.Write("LimitMaxTimes " & LimitMaxTimes & "<br>")
'Response.Write("Request.Form(selLimitMaxTimes) " & Request.Form("selLimitMaxTimes") & "<br>")
'Response.End

If Enabled = "on" then Enabled = vbTrue Else Enabled = vbFalse
If IncludeLog = "on" then IncludeLog = vbTrue Else IncludeLog = vbFalse

SQL = "UPDATE SC_Alerts SET "
SQL = SQL &  "AlertName = '" & AlertName & "',"
SQL = SQL &  "Enabled = " & Enabled & ","
SQL = SQL &  "Condition = '" & Condition & "',"
SQL = SQL &  "NBMinutes = " & Minutes & ","
SQL = SQL &  "NumberOfDays = " & NumberOfDays & ","
SQL = SQL &  "EmailToUserNos = '" & Emailto & "',"
SQL = SQL &  "AdditionalEmails = '" & AdditionalEmails & "',"
SQL = SQL &  "EmailVerbiage = '" & VerbiageEmail & "',"
SQL = SQL &  "TextToUserNos = '" & Textto & "',"
SQL = SQL &  "AdditionalText = '" & AdditionalTexts & "',"
SQL = SQL &  "TextVerbiage = '" & TextVerbiage & "',"
SQL = SQL &  "NBIncludeLog = " & IncludeLog  & ","
SQL = SQL &  "NBLimitMiniutes = " & LimitMinutes & ","
SQL = SQL &  "NBLimitMaxTimes = " & LimitMaxTimes & ","
SQL = SQL &  "NotificationType = '" & NotificationType & "',"
SQL = SQL &  "TimeOfDay = '" & TimeOfDay & "',"
SQL = SQL &  "PublicOrPrivate = '" & PublicOrPrivate & "'"
SQL = SQL &  " WHERE InternalAlertRecNumber = " & InternalAlertRecNumber 
	
Set cnn8 = Server.CreateObject("ADODB.Connection")
cnn8.open (Session("ClientCnnString"))

Set rs8 = Server.CreateObject("ADODB.Recordset")
rs8.CursorLocation = 3 
Set rs8 = cnn8.Execute(SQL)
set rs8 = Nothing

Description = ""
If Orig_AlertName <> AlertName Then
	Description = Description & "Alert name changed from " & Orig_AlertName & " to " & AlertName 
End If
If Orig_Enabled = vbTrue Then Orig_Enabled = "on" else Orig_Enabled = "off"
If Enabled = vbTrue Then Enabled = "on" else Enabled = "off"
If Orig_Enabled <> Enabled Then
	Description = Description & "  Enabled changed from " & Orig_Enabled & " to " & Enabled 
End If
If Orig_Condition <> Condition Then
	Description = Description & "  Condition changed from " & Orig_Condition  & " to " & Condition 
End If
If cint(Orig_Minutes) <> cint(Minutes) Then
	Description = Description & "  Minutes changed from " & Orig_Minutes  & " to " & Minutes 
End If
If IsNumeric(Orig_NumberOfDays) and IsNumeric(NumberOfDays) Then ' Else it is just null
	If cint(Orig_NumberOfDays) <> cint(NumberOfDays) Then
		Description = Description & "  Number of days changed from " & Orig_NumberOfDays  & " to " & NumberOfDays
	End If
End If
If Orig_Emailto <> Emailto Then
	Description = Description & "  Users to send emails to changed from " & Orig_Emailto & " to " & Emailto 
End If
If Orig_AdditionalEmails <> AdditionalEmails Then
	Description = Description & "  Additional emails changed from " & Orig_AdditionalEmails & " to " & AdditionalEmails
End If
If Orig_VerbiageEmail <> VerbiageEmail Then
	Description = Description & "  Email verbiage changed from " & Orig_VerbiageEmail & " to " & VerbiageEmail
End If
If Orig_Textto <> Textto Then
	Description = Description & "  Users to send texts to changed from " & Orig_Orig_Textto& " to " & Textto
End If
If Orig_AdditionalTexts <> AdditionalTexts Then
	Description = Description & "  Additional text messages changed from " & Orig_AdditionalTexts & " to " & AdditionalTexts
End If
If Orig_TextVerbiage <> TextVerbiage Then
	Description = Description & " Text verbiage changed from " & Orig_TextVerbiage & " to " & TextVerbiage
End If
If Orig_IncludeLog = vbTrue Then Orig_IncludeLog = "on" else Orig_IncludeLog = "off"
If IncludeLog = vbTrue Then IncludeLog = "on" else IncludeLog = "off"
If Orig_IncludeLog <> IncludeLog Then
	Description = Description & " Include log in email changed from " & Orig_IncludeLog & " to " & IncludeLog
End If
If cint(Orig_LimitMiniutes) <> cint(LimitMiniutes) Then
	Description = Description & "  Limit this alert to sending only once every X changed from " & Orig_LimitMiniutes & " to " & LimitMiniutes & " minutes"
End If
If cint(Orig_NBLimitMaxTimes) <> cint(NBLimitMaxTimes) Then
	Description = Description & "  The maximum # of times to send this alert  changed from " & Orig_NBLimitMaxTimes & " to " & NBLimitMaxTimes 
End If
If Orig_NotificationType <> NotificationType Then
	Description = Description & " Notification type changed from " & Orig_NotificationType & " to " & NotificationType 
End If
If Orig_PublicOrPrivate <> PublicOrPrivate Then
	Description = Description & " Public or private changed from " & Orig_PublicOrPrivate  & " to " & PublicOrPrivate 
End If

If Orig_TimeOfDay <> TimeOfDay Then
	Description = Description & " TimeOfDay changed from " & Orig_TimeOfDay& " to " & TimeOfDay
End If



CreateAuditLogEntry "System Alert Edited","System Alert Edited","Major",0,Description

Response.Redirect("main.asp#System")

%>















