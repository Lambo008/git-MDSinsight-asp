﻿<!--#include file="../../inc/header.asp"-->
<!--#include file="../../inc/InsightFuncs.asp"-->


<%

InternalRecordNumber = Request.QueryString("i")
InternalRecordNumber = Hacker_Filter1(InternalRecordNumber)
InternalRecordNumber = Hacker_Filter2(InternalRecordNumber)

currentEmailCategory1ViewedID = Request.QueryString("cat1")
currentEmailCategory1ViewedID = Hacker_Filter1(currentEmailCategory1ViewedID)
currentEmailCategory1ViewedID = Hacker_Filter2(currentEmailCategory1ViewedID)

currentEmailCategory2ViewedIDTab = Request.QueryString("cat2")
currentEmailCategory2ViewedIDTab = Hacker_Filter1(currentEmailCategory2ViewedIDTab)
currentEmailCategory2ViewedIDTab = Hacker_Filter2(currentEmailCategory2ViewedIDTab)


If InternalRecordNumber <> "" Then
	
	SQL7 = "UPDATE SC_EmailLog SET Archived= 0 WHERE InternalRecordNumber = " & InternalRecordNumber 
	
	Set cnn7 = Server.CreateObject("ADODB.Connection")
	cnn7.open (Session("ClientCnnString"))
	Set rs7 = Server.CreateObject("ADODB.Recordset")
	rs7.CursorLocation = 3 
	Set rs7 = cnn7.Execute(SQL7)
	set rs7 = Nothing
	set cnn7  = Nothing


	SQL10 = "SELECT * FROM SC_EmailLog WHERE InternalRecordNumber = " & InternalRecordNumber 
	
	Set cnn10 = Server.CreateObject("ADODB.Connection")
	cnn10.open (Session("ClientCnnString"))
	Set rs10 = Server.CreateObject("ADODB.Recordset")
	rs10.CursorLocation = 3 
	Set rs10 = cnn10.Execute(SQL10)
	
	If not rs10.eof then
	
		EmailTo = rs10("EmailTo")
		EmailFrom = rs10("EmailFrom")
		EmailFromName = rs10("EmailFromName")
		EmailDate = rs10("EmailDate")
		EmailTime = FormatDateTime(rs10("EmailTime"),3)
		Subject = rs10("Subject")
		Body = rs10("Body")
		CCs = rs10("CCs")
		BCCs = rs10("BCCs")
		Attachment = rs10("Attachment")

	End If	
	
	set rs10 = Nothing
	set cnn10  = Nothing


	Description = "Email with subject, " & Subject & ", sent on " & EmailDate & " at " & EmailTime & " was un-archived. "

	CreateAuditLogEntry "Email Archived From Admin","Email Archived From Admin","Minor",0,Description 

	Response.Redirect ("allSentEmails.asp?cat1ID=" & currentEmailCategory1ViewedID & "&tab=" & currentEmailCategory2ViewedIDTab)

Else

	%><div><br />
	Unable to archive email, could not parse querystring for unqiue email identifier.
	</div>
	<%
	
End If


%><!--#include file="../../inc/footer-main.asp"-->