<!--#include file="../../inc/InsightFuncs_AR_AP.asp"-->
<!--#include file="../../inc/InSightFuncs.asp"-->
<!--#include file="../../inc/InSightFuncs_Users.asp"-->
<%
CustTypeToBeDeletedIntRecID = Request.Form("txtTypeCodeToBeDeletedIntRecID")
CustTypeToReplaceWithIntRecID = Request.Form("selDeleteTypeCodeFromModal")

'CustTypeToBeDeleted = GetClassCodeByIntRecID(CustTypeToBeDeletedIntRecID)
CustTypeToBeDeleted = CustTypeToBeDeletedIntRecID
'CustTypeToBeReplacedWith = GetClassCodeByIntRecID(CustTypeToReplaceWithIntRecID)
CustTypeToBeReplacedWith = CustTypeToReplaceWithIntRecID

CustTypeToBeDeletedDescription = GetCustTypeDescByIntRecID(CustTypeToBeDeletedIntRecID)


If CustTypeToBeDeleted <> "" AND CustTypeToBeReplacedWith <> "" Then

	'We need to loop through all the records so we can make entries in the PR_Activty table
	
	SQLDelete = "SELECT CustNum, Name FROM AR_Customer WHERE CustType = '" & CustTypeToBeDeleted & "'"
	Set cnnDelete = Server.CreateObject("ADODB.Connection")
	cnnDelete.open (Session("ClientCnnString"))
	Set rsDelete = Server.CreateObject("ADODB.Recordset")
	rsDelete.CursorLocation = 3 
	Set rsDelete = cnnDelete.Execute(SQLDelete)

	If not rsDelete.Eof Then
		Do
			CustAcctNo = rsDelete("CustNum")
			CustName = rsDelete("Name")
			Description = "The Cust Type for customer " & CustAcctNo & " (" & CustName & ") was changed from ''" & CustTypeToBeDeleted & "'' to ''" & CustTypeToBeReplacedWith & "'' to allow for the deletion of ''" & CustTypeToBeDeleted & "'' by " & GetUserDisplayNameByUserNo(Session("UserNo"))
			CreateAuditLogEntry GetTerm("Accounts Receivable") & " customer type code updated",GetTerm("Accounts Receivable") & " customer type code updated","Major",0,Description
			rsDelete.movenext
		Loop Until rsDelete.Eof
	End If
	rsDelete.Close
	
	'Now replace all records with the new type code
	
	SQLDelete = "UPDATE AR_Customer SET CustTYpe = '" & CustTypeToBeReplacedWith & "' WHERE CustType = '" & CustTypeToBeDeleted & "'"
	rsDelete.CursorLocation = 3 
	Set rsDelete = cnnDelete.Execute(SQLDelete)
	'Response.write(SQLDelete & "<br>")
	
	'Now Do the deletion
	
	SQLDelete = "DELETE FROM AR_CustomerType WHERE InternalRecordIdentifier = '" & CustTypeToBeDeleted & "'"
	rsDelete.CursorLocation = 3 
	Set rsDelete = cnnDelete.Execute(SQLDelete)
	'Response.write(SQLDelete & "<br>")
	
	Description = "The " & GetTerm("Accounts Receivable") & " customer type named " & CustTypeToBeDeletedDescription & " (" & CustTypeToBeDeleted & ") was deleted by " & GetUserDisplayNameByUserNo(Session("UserNo")) 
	CreateAuditLogEntry GetTerm("Accounts Receivable") & " customer type deleted",GetTerm("Accounts Receivable") & " customer type deleted","Major",0,Description
	
	set rsDelete = Nothing
	cnnDelete.Close
	set cnnDelete = Nothing
	
End If

Response.Redirect ("main.asp")
%>