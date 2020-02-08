<!--#include file="../../inc/header.asp"-->
<!--#include file="../../inc/jquery_table_search.asp"-->
<!--#include file="../../inc/InSightFuncs.asp"-->
<!--#include file="../../inc/InSightFuncs_Service.asp"-->

 <style type="text/css">
 	.email-table{
		width:46%;
	}
	
	table.sortable th:not(.sorttable_sorted):not(.sorttable_sorted_reverse):not(.sorttable_nosort):after { 
    content: " \25B4\25BE" 
}

.nav-tabs>li>a{
	background: #f5f5f5;
	border: 1px solid #ccc;
	color: #000;
}

.nav-tabs>li>a:hover{
	border: 1px solid #ccc;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover{
	color: #000;
	border: 1px solid #ccc;
}

.container{
	max-width:600px;
	margin:0 auto;
}

.narrow-results{
	margin:0px 0px 20px 0px;
}

#filter{
	width:40%;
}

.modal-link{
	cursor:pointer;
}

.modal-content{
	max-height:360px;
	overflow-y:auto;
}

 .modal-content .row{
	 padding-bottom:20px;
 }

 .modal-content p{
	 margin-bottom:20px;
	 white-space:normal;
 }
 </style>

<!--- eof on/off scripts !-->

<h1 class="page-header">Add / Edit Parts</h1>

<div class="row">
 	<div class="col-lg-12">
	 	<p><a href="<%= BaseURL %>service/menu.asp"><button type="button" class="btn btn-primary"><i class="fas fa-arrow-left"></i>&nbsp;Back To Service Main Menu</button></a></p>
 	</div>
</div>

<br>	
	<!-- tabs start here !-->
	<div class="container">

	<div class="row">
	
		<div class="col-lg-12">
			 <div class="input-group narrow-results"> <span class="input-group-addon">Narrow Results</span>
    		 <input id="filter" type="text" class="form-control filter-search-width" placeholder="Type here...">
 			 <a href="addpart.asp"><button type="button" class="btn btn-success pull-right">Add New Parts</button></a>
		</div>
		
		<div class="table-responsive">
            <table    class="table table-striped table-condensed table-hover table-bordered sortable">
              <thead>
                <tr>
                  <th>Part Number</th>
                  <th>Part Description</th>
                  <th class="sorttable_nosort">Delete</th>
                </tr>
              </thead>
               <tbody class='searchable'>
              
				<%
			
				SQL = "SELECT * FROM FS_Parts order by PartNumber"
		
				Set cnnparts = Server.CreateObject("ADODB.Connection")
				cnnparts.open (Session("ClientCnnString"))
				Set rsparts = Server.CreateObject("ADODB.Recordset")
				rsparts.CursorLocation = 3 
				Set rsparts = cnnparts.Execute(SQL)
		
				If not rsparts.EOF Then

					Do While Not rsparts.EOF
				
			        %>
						<!-- table line !-->
						<tr>
							<%If rsparts.Fields("InternalRecordIdentifier") = 0 Then %>
								<td><%= rsparts.Fields("PartNumber")%></td>
							<% Else %>
								<td><a href='editpart.asp?i=<%= rsparts.Fields("InternalRecordIdentifier")%>'><%= rsparts.Fields("PartNumber")%></a></td>
							<% End If%>
							
							<td><%= rsparts.Fields("PartDescription")%></td>
							<%' Allow delete or display modal
							If rsparts.Fields("InternalRecordIdentifier") <> 0 Then 								
								%>
									<td><a href='deletepartQues.asp?i=<%=rsparts.Fields("InternalRecordIdentifier")%>'><i class="fas fa-trash-alt"></i></a></td>
							<%Else %>
								<td>&nbsp;</td>
							<% End If %>	
					   	</tr>
					<%
						rsparts.movenext
					loop
				End If
				set rsparts = Nothing
				cnnparts.close
				set cnnparts = Nothing
	            %>
			</tbody>
		</table>
	</div>

		</div>
 

</div>
<!-- eof row !--> 

 <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            
            <div class="modal-body"></div>
            
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- modal  ends here !-->
   

<!--#include file="../../inc/footer-main.asp"-->