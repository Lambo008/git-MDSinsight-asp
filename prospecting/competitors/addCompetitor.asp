<!--#include file="../../inc/header.asp"-->


<link rel="stylesheet" type="text/css" href="<%= BaseURL %>css/tabs.css" />

<SCRIPT LANGUAGE="JavaScript">
<!--
    function validateCompetitorForm()
    {

        if (document.frmAddCompetitor.txtCompetitorName.value == "") {
            swal("Competitor name cannot be blank.");
            return false;
        }

        if (document.frmAddCompetitor.txtCompetitorAddressInfo.value == "") {
            swal("Please enter address information for competitor.");
            return false;
        }
		/*
		if (document.frmAddCompetitor.txtCompetitorWebsite.value == "") {
            swal("Competitor web site cannot be blank.");
            return false;
        }

        if (document.frmAddCompetitor.txtCompetitorAdditionalNotes.value == "") {
            swal("Please enter additional notes for competitor.");
            return false;
        }
        */		
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

.checkboxrow {
    border: 0px;
    overflow: hidden;
    padding: 5px;
}

.checkboxcol {
 	border: 1px solid #ccc;
    border-radius: 4px;
    /*float: left;*/
    padding: 5px;
    margin-top:10px;
    margin-right: 5px;
}

</style>
<!-- eof password strength meter !-->

<h1 class="page-header"> Add New Competitor</h1>

<div class="custom-container">

	<form method="POST" action="addCompetitor_submit.asp" name="frmAddCompetitor" id="frmAddCompetitor" onsubmit="return validateCompetitorForm();">

		<div class="row row-line">

			<div class="form-group col-lg-12">
				<label for="txtCompetitorName" class="col-sm-3 control-label">Competitor Name</label>	
    			<div class="col-sm-9">
    				<input type="text" class="form-control required" id="txtCompetitorName" name="txtCompetitorName">
    			</div>
			</div>
			<div class="form-group col-lg-12">
				<label for="txtCompetitorAddressInfo" class="col-sm-3 control-label">Address Information</label>	
    			<div class="col-sm-9">
    				<textarea class="form-control textarea required" rows="4" id="txtCompetitorAddressInfo" name="txtCompetitorAddressInfo"></textarea>
    				<strong>Enter full mailing address or city/state/zip.</strong>
    			</div>
 			</div>
            <div class="form-group col-lg-12">
				<label for="txtCompetitorWebsite" class="col-sm-3 control-label">Competitor Web site</label>	
    			<div class="col-sm-9">
    				<input type="text" class="form-control" id="txtCompetitorWebsite" name="txtCompetitorWebsite">
    			</div>
			</div>
			<div class="form-group col-lg-12">
				<label for="txtCompetitorAdditionalNotes" class="col-sm-3 control-label">Additional Notes</label>	
    			<div class="col-sm-9">
    				<textarea class="form-control textarea" rows="4" id="txtCompetitorAdditionalNotes" name="txtCompetitorAdditionalNotes"></textarea>    				
    			</div>
 			</div>
 						
		</div>
		
	    <!-- cancel / submit !-->
		<div class="row row-line">
			<div class="col-lg-12 alertbutton">
				<div class="col-lg-12">
					<a href="<%= BaseURL %>filemaint/prospecting/competitors/main.asp">
	    				<button type="button" class="btn btn-default">&lsaquo; Cancel &amp; Go Back To Competitor List</button>
					</a>
					<button type="submit" class="btn btn-primary"><i class="far fa-save"></i> Save</button>
				</div>
		    </div>
		</div>
		
	</form>
</div>

<!--#include file="../../inc/footer-main.asp"-->
