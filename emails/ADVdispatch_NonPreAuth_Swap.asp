﻿<%
'****************************************************
'Create the email that goes to the service tech
'****************************************************

emailSubject = "Swap Without Pre-Auth - Ticket # " & SelectedMemoNumber & " - " & GetTerm("Account") & " # " & Account

 
emailBody = ""


emailBody =  emailBody & "<table width='650' border='0' cellspacing='0' align='center' style='padding:10px; border:1px solid #000000;'>"

emailBody =  emailBody & "<tr><td>"

emailBody =  emailBody & "<table width='100%' border='0' cellspacing='0' cellpadding='15'  >"

emailBody =  emailBody & "<tr><td width='650' style='font-family:Arial, Helvetica, sans-serif; font-size:21px; font-weight:normal; padding-top:15px; padding-bottom:15px; margin-left:3px margin-right:3px;' align='center'>*Swap Without Pre-Auth*<br>Ticket # " & SelectedMemoNumber & " - " & GetTerm("Account") & " # " & Account

emailBody =  emailBody & "</td></tr>"

emailBody =  emailBody & "</table>"

emailBody =  emailBody & "</tr></td>"

emailBody =  emailBody & "<table width='100%' border='0' cellspacing='0' cellpadding='15'  >"

emailBody =  emailBody & " <tr style='border-bottom:1px solid #666;' ><td width='40%' style='font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:normal;'><strong>Service Notes</strong></td><td width='60%' style='font-weight:normal; font-size:16px; font-family:Arial, Helvetica, sans-serif;' >"
emailBody =  emailBody & ServiceNotes & "</td></tr>"

emailBody =  emailBody & "<tr><td>"

emailBody =  emailBody & " <tr style='border-bottom:1px solid #666;' ><td width='40%' style='font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:normal;'><strong>" & GetTerm("Account") & " #</strong></td><td width='60%' style='font-weight:normal; font-size:16px; font-family:Arial, Helvetica, sans-serif;' >"
emailBody =  emailBody & Account

emailBody =  emailBody & " <tr style='border-bottom:1px solid #666;' ><td width='40%' style='font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:normal;'><strong>Company</strong></td><td width='60%' style='font-weight:normal; font-size:16px; font-family:Arial, Helvetica, sans-serif;' >"
emailBody =  emailBody & FormattedCustInfoByCustNum(Account)


emailBody =  emailBody & "</td></tr>"


emailBody =  emailBody & "<tr><td>"

emailBody =  emailBody & " <tr style='border-bottom:1px solid #666;' ><td width='40%' style='font-family:Arial, Helvetica, sans-serif; font-size:16px; font-weight:normal;'><strong>Technician </strong></td><td width='60%' style='font-weight:normal; font-size:16px; font-family:Arial, Helvetica, sans-serif;' >"
emailBody =  emailBody & GetUserDisplayNameByUserNo(Session("UserNo"))



emailBody =  emailBody & "</td></tr>"


emailBody =  emailBody & "</table>"

emailBody =  emailBody & "</td></tr>"


emailBody =  emailBody & "<tr><td>"

emailBody =  emailBody & "</td></tr>"
emailBody =  emailBody & "</table>"
%>