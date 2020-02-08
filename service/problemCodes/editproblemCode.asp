<!--#include file="../../inc/header.asp"-->

<% InternalRecordIdentifier = Request.QueryString("i") 
If InternalRecordIdentifier = "" Then Response.Redirect("main.asp")
%>

<link rel="stylesheet" type="text/css" href="<%= BaseURL %>css/tabs.css" />


<SCRIPT LANGUAGE="JavaScript">
<!--
    function validateEditProblemCodeForm()
    {

        if (document.frmEditproblemCode.txtproblemDescription.value == "") {
            swal("Problem description can not be blank.");
            return false;
        }

        return true;

    }
// -->
</SCRIPT>          

<!-- password strength meter !-->

<style type="text/css">

.pass-strength h5{
	margin-top: 0px;
	color: #000;
}
.popover.primary {
    border-color:#337ab7;
}
.popover.primary>.arrow {
    border-top-color:#337ab7;
}
.popover.primary>.popover-title {
    color:#fff;
    background-color:#337ab7;
    border-color:#337ab7;
}
.popover.success {
    border-color:#d6e9c6;
}
.popover.success>.arrow {
    border-top-color:#d6e9c6;
}
.popover.success>.popover-title {
    color:#3c763d;
    background-color:#dff0d8;
    border-color:#d6e9c6;
}
.popover.info {
    border-color:#bce8f1;
}
.popover.info>.arrow {
    border-top-color:#bce8f1;
}
.popover.info>.popover-title {
    color:#31708f;
    background-color:#d9edf7;
    border-color:#bce8f1;
}
.popover.warning {
    border-color:#faebcc;
}
.popover.warning>.arrow {
    border-top-color:#faebcc;
}
.popover.warning>.popover-title {
    color:#8a6d3b;
    background-color:#fcf8e3;
    border-color:#faebcc;
}
.popover.danger {
    border-color:#ebccd1;
}
.popover.danger>.arrow {
    border-top-color:#ebccd1;
}
.popover.danger>.popover-title {
    color:#a94442;
    background-color:#f2dede;
    border-color:#ebccd1;
}

.select-line{
	margin-bottom: 15px;
}

.enable-disable{
	margin-top:20px;
}

.row-line{
	margin-bottom: 25px;
}

.table th, tr, td{
	font-weight: normal;
}

.table>thead>tr>th{
	border: 0px;
}
.table thead>tr>th,.table tbody>tr>th,.table tfoot>tr>th,.table thead>tr>td,.table tbody>tr>td,.table tfoot>tr>td{
border:0px;
}

.when-col{
	width: 10%;
}

.reference-col{
	width: 45%;
}

.has-more-col{
	width: 12%;
}

.form-control{
	min-width: 100px;
}

.textarea-box{
	min-width: 260px;
}

.custom-container{
	max-width:600px;
	margin:0 auto;
}

.control-label{
	font-size:12px;
	font-weight:normal;
	padding-top:10px;
}
.control-label-last{
	padding-top:0px;
}

.required{
	border-left:3px solid red;
}
	</style>
<!-- eof password strength meter !-->



<%
SQL = "SELECT * FROM FS_ProblemCodes where InternalRecordIdentifier = " & InternalRecordIdentifier 

Set cnnproblemCodes = Server.CreateObject("ADODB.Connection")
cnnproblemCodes.open (Session("ClientCnnString"))
Set rsproblemCodes = Server.CreateObject("ADODB.Recordset")
rsproblemCodes.CursorLocation = 3 
Set rsproblemCodes = cnnproblemCodes.Execute(SQL)
	
If not rsproblemCodes.EOF Then
	ProblemDescription = rsproblemCodes("ProblemDescription")
	ShowOnWeb = rsproblemCodes("ShowOnWebsite")	
End If
set rsproblemCodes = Nothing
cnnproblemCodes.close
set cnnproblemCodes = Nothing

%>


<h1 class="page-header"> Edit Problem Code</h1>

<div class="custom-container">

	<form method="POST" action="editproblemCode_submit.asp" name="frmeditproblemCode" id="frmeditproblemCode" onsubmit="return validateEditproblemCodeForm();">

		<div class="row row-line">

			<input type="hidden" id="txtInternalRecordIdentifier" name="txtInternalRecordIdentifier" value="<%=InternalRecordIdentifier%>">
    				
			<div class="form-group col-lg-12">
				<label for="txtProblemDescription" class="col-sm-3 control-label">Problem Description</label>	
    			<div class="col-sm-6">
    				<input type="text" class="form-control required" id="txtProblemDescription" name="txtProblemDescription" value="<%=ProblemDescription%>">
    			</div>
			</div>

		</div>

		<div class="form-group col-lg-12">
			<label for="txtProblemDescription" class="col-sm-3 control-label">Show On Website</label>
			<div class="row row-line col-lg-4">
	   				<select class="form-control" name="selShowOnWeb" id="selShowOnWeb">
	   					<option value=1 <%If ShowOnWeb = 1 Then Response.Write(" selected ") %>>Yes</option>
	   					<option value=0 <%If ShowOnWeb = 0 Then Response.Write(" selected ") %>>No</option>
	   				</select>
			</div>
		</div>
		
	    <!-- cancel / submit !-->
		<div class="row row-line">
			<div class="col-lg-12 alertbutton">
				<div class="col-lg-12">
					<a href="<%= BaseURL %>service/problemCodes/main.asp">
	    				<button type="button" class="btn btn-default">&lsaquo; Cancel &amp; Go Back To Problem Code List</button>
					</a>
					<button type="submit" class="btn btn-primary"><i class="far fa-save"></i> Save</button>
				</div>
		    </div>
		</div>
		
	</form>
</div>

<!--#include file="../../inc/footer-main.asp"-->
