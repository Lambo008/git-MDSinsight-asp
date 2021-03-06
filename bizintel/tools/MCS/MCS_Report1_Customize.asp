<%

'************************
'Read Settings_Reports
'************************
SQL = "SELECT * from Settings_Reports where ReportNumber = 2101 AND UserNo = " & Session("userNo")
Set cnn8 = Server.CreateObject("ADODB.Connection")
cnn8.open (Session("ClientCnnString"))
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs= cnn8.Execute(SQL)
UseSettings_Reports = False
If NOT rs.EOF Then
	UseSettings_Reports = True
	FilterSlsmn1 = rs("ReportSpecificData1")
	FilterSlsmn2 = rs("ReportSpecificData2")
	If FilterSlsmn1 <> "All" Then FilterSlsmn1 = CInt(FilterSlsmn1)
	If FilterSlsmn2 <> "All" Then FilterSlsmn2 = CInt(FilterSlsmn2)
End If


'****************************
'End Read Settings_Reports
'****************************
%>
<style type="text/css">
	 .ativa-scroll{
	 max-height: 150px;
 }
</style>

<!-- modal scroll !-->
<script type="text/javascript">
	$(document).ready(ajustamodal);
	$(window).resize(ajustamodal);
	function ajustamodal() {
	var altura = $(window).height() - 200; //value corresponding to the modal heading + footer
	$(".ativa-scroll").css({"height":altura,"overflow-y":"auto"});
	}
</script>
<!-- eof modal scroll !-->
	
<div class="modal fade bs-example-modal-lg-customize" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-height">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel" align="center">Customize MCS Analysis</h4>
			</div>

		<form method="post" action="MCS_Report1_Customize_SaveValues.asp" name="frmMCSAnalysisSummary_Customize">

			<div class="modal-body ativa-scroll">
 	      	
	 	      	<!-- filtering !-->
		      	<div class="container-fluid">
			      	<div class="row">
 		      	
				      	<!-- left column !-->
				      	<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12 left-column">
			 		      	<h4><br>Filtering</h4>
				      	</div>
				      	<!-- eof left column !-->
 		      	
		 		      	<!-- right column !-->
		 		      	<div class="col-lg-10 col-md-9 col-sm-12 col-xs-12 right-column">
	 		      	
				      	<!-- row !-->
				      	<div class="row">
		     	
				      	<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
					      	<strong>Slsmn 1</strong>
				      	</div>

		      		<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				      	<select class="form-control" name="selFilterSlsmn1">
						<% If UseSettings_Reports = False OR (UseSettings_Reports = True AND FilterSlsmn1="All") Then %>
					      	<option selected value="All">All</option>
					    <% Else %>
				      	  	<option value="All">All</option>
					    <% End IF %>  	
				      	<% 'Get all Slsmn 1 options
				      	  	SQL = "SELECT DISTINCT SalesmanSequence, Salesman.Name FROM Salesman "
				      	  	SQL = SQL & "Inner Join AR_Customer on Salesman = SalesmanSequence "
				      	  	SQL = SQL & "order by SalesmanSequence "
		
							Set cnn8 = Server.CreateObject("ADODB.Connection")
							cnn8.open (Session("ClientCnnString"))
							Set rs = Server.CreateObject("ADODB.Recordset")
							rs.CursorLocation = 3 
							Set rs = cnn8.Execute(SQL)
								
							If not rs.EOF Then
								Do
									Response.Write("<option ")
									If UseSettings_Reports = True Then
									 	If FilterSlsmn1 <> "All" Then
											If FilterSlsmn1 = rs("SalesmanSequence") Then Response.Write("selected ")
										End If
									End If
									Response.Write("value='" & rs("SalesmanSequence") & "'>" & rs("SalesmanSequence") & " - " & rs("Name") & "</option>")
									rs.movenext
								Loop until rs.eof
							End If
							set rs = Nothing
							cnn8.close
							set cnn8 = Nothing
				      	%>
						</select>
			      	</div>
		      	</div>
		      	<!-- eof row !-->
		      	
		      	<!-- row !-->
		      	<div class="row">
			      	<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
			      		<strong>Slsmn 2</strong>
		     	 	</div>
		      	
		      		<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
				      	<select class="form-control" name="selFilterSlsmn2">
						<% If UseSettings_Reports = False OR (UseSettings_Reports = True AND FilterSlsmn2="All") Then %>
					      	<option selected value="All">All</option>
					    <% Else %>
				      	  	<option value="All">All</option>
					    <% End IF %> 
				      	<% 'Get all Slsmn 2 options
				      	  	SQL = "SELECT DISTINCT SalesmanSequence, Salesman.Name FROM Salesman "
				      	  	SQL = SQL & "Inner Join AR_Customer on SecondarySalesman = SalesmanSequence "
				      	  	SQL = SQL & "order by SalesmanSequence "
	
		
							Set cnn8 = Server.CreateObject("ADODB.Connection")
							cnn8.open (Session("ClientCnnString"))
							Set rs = Server.CreateObject("ADODB.Recordset")
							rs.CursorLocation = 3 
							Set rs = cnn8.Execute(SQL)
								
							If not rs.EOF Then
								Do
									Response.Write("<option ")
									If UseSettings_Reports = True Then
									 	If FilterSlsmn2 <> "All" Then
											If FilterSlsmn2 = rs("SalesmanSequence") Then Response.Write("selected ")
										End If
									End If
									Response.Write("value='" & rs("SalesmanSequence") & "'>" & rs("SalesmanSequence") & " - " & rs("Name") & "</option>")
									rs.movenext
								Loop until rs.eof
							End If
							set rs = Nothing
							cnn8.close
							set cnn8 = Nothing
				      	%>
					    </select>
		      		</div>
		      	</div>
		      	<!-- eof row !-->
		      			      	
	      	</div>
	      	<!-- eof right column !-->
      	</div>
   	</div>

	</div>
      
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		<a href="#" onClick="document.frmMCSAnalysisSummary_Customize.submit()"><button type="button" class="btn btn-primary">Run Report</button></a>     
	</div>
</form>

</div>
</div>
</div>

