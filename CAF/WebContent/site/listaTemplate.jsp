<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
 <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %> 


<t:layout title="Dashboard" bodyClass="skin-yellow-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

 
 <t:main-header />
<t:main-sidebar />
  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Template
        
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/CAF"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid" style="border:#f39c12">
<div class="box-header with-border" style="background-color:#f39c12; background:#f39c12">
	 Lista Template
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalnuovoTemplate()"><i class="fa fa-plus"></i> Nuovo Template</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabTemplate" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Descrizione</th>
<th>Tipo Pratica</th>
<th>Moduli</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${listaTemplate }" var="template" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${template.id }</td>	
	<td>${template.descrizione }</td>
	<td>${template.tipo.descrizione }</td>
	
	
	<td>
	<c:forEach items="${template.getListaModuli() }" var="item">
	${item.descrizione }
	</c:forEach>
	</td>


	<td>
												
	<%-- <a class="btn btn-warning customTooltip" onClicK="modificaTemplate('${template.id}', '${utl:escapeJS(template.descrizione) }', '${utl:escapeJS(template.note) }')" title="Click per modificare il Template"><i class="fa fa-edit"></i></a> --%>
	 
	 <a target="_blank" class="btn btn-danger customTooltip" title="Download template"  href="gestioneTemplate.do?action=download_file&id_template=${template.id }" ><i class="fa fa-file-pdf-o"></i></a>
	 
	 <a class="btn btn-danger customTooltip" title="Elimina Template"  onClick="modalYesOrNo('${template.id}')"><i class="fa fa-trash"></i></a>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>
</div>


</section>



<form id="nuovoTemplateForm" name="nuovoTemplateForm">
<div id="myModalnuovoTemplate" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Template</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione" name="descrizione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Pratica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select class="form-control select2" id="tipo_pratica" data-placeholder="Seleziona tipo pratica..." name="tipo_pratica" style="width:100%">
        <option value=""><option/>
        <c:forEach items="${listaTipiPratica}" var="tipo">
         <option value="${tipo.id }">${tipo.descrizione }<option/>
        </c:forEach>
        </select>
        
       			
       	</div>       	
       </div><br>
       
<div class="row">
       
       	<div class="col-sm-3">
       		<label>Moduli</label>
       	</div>
       	<div class="col-sm-9">    
        
        <select class="form-control select2" id="moduli" multiple data-placeholder="Seleziona tipo pratica..." name="moduli[]" style="width:100%">
        <option value=""><option/>
        <c:forEach items="${listaModuli}" var="modulo">
         <option value="${modulo.id }">${modulo.descrizione }<option/>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>

       	  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Aggiungi ISEE</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <input id="add_isee" name="add_isee"  type="checkbox"  >
        
       			
       	</div>       	
       </div><br>
       	  	
       	  </div>

       
       
  		 
      <div class="modal-footer">

<input type="hidden" id="numero_campi" name="numero_campi">
<input type="hidden" id="filename" name="filename">
		<button class="btn btn-primary" type="submit" >Salva</button> 
       
      </div>
      </div>
    </div>

</div>

</form>




<form id="modificaTemplateForm" name="modificaTemplateForm">
<div id="myModalModificaTemplate" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Mpodifica Template</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_mod" name="nome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome_mod" name="cognome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
        
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice Fiscale</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cf_mod" name="cf_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data di Nascita</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       	  	<div class='input-group date datepicker' id='datepicker_data_rilascio'>
               <input type='text' class="form-control input-small" id="data_nascita_mod" name="data_nascita_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 

       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Luogo di Nascita</label>
       	</div>
       	<div class="col-sm-7">      
       	  	
        <input id="luogo_nascita_mod" name="luogo_nascita_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div> 
       	<div class="col-sm-1">     
       		<label>Provincia</label> 
       	</div>
       	<div class="col-sm-1">      
       	  
        <input id="provincia_nascita_mod" name="provincia_nascita_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Telefono</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="telefono_mod" name="telefono_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_mod" name="email_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       <div class="col-sm-5"></div>
       
       	<div class="col-sm-4">
       		<label style="text-align:center"><H3>Residenza</H3></label>
       	</div>
       	<div class="col-sm-3"></div>
       	</div><br>
       	<div class="row">
       	<div class="col-sm-2">      
       	 <label>Tipo indirizzo</label> 	
       
       	  	 
       	 <select id="tipo_via_mod" name="tipo_via_mod" class="form-control select2" required>
       	 <option value=""></option>
       	 <option value="VIA">VIA</option>
       	 <option value="VIALE">VIALE</option>
       	 <option value="PIAZZA">PIAZZA</option>
       	 <option value="LOCALITA">LOCALITÀ</option>
       	 <option value="RIONE">RIONE</option>
       	 </select>
       	 </div>
       	  	<div class="col-sm-7"> 
       	 
       	 <label>Indirizzo</label> 	
       	 
       	 <input id="indirizzo_mod" name="indirizzo_mod" class="form-control" type="text" style="width:100%" required>
     </div>
       	  	<div class="col-sm-1"> 
     <label>Civico</label> 	
       	 
       	 <input id="civico_mod" name="civico_mod" class="form-control" type="text" style="width:100%" >
       			
       	   </div>
       	  	<div class="col-sm-2"> 
     <label>CAP</label> 	
       	 
       	 <input id="cap_mod" name="cap_mod" class="form-control" type="text" style="width:100%" required>
       			
       	   </div>
       	   
       	   </div><br>
       	   <div class="row">
       	  	<div class="col-sm-6"> 
       	
       	<label>Comune</label> 	
       	 
       	 <input id="comune_mod" name="comune_mod" class="form-control" type="text" style="width:100%" required>
       	 </div>
       	  	<div class="col-sm-2"> 
       	   	<label>Provincia</label> 	
       	 
       	 <input id="provincia_mod" name="provincia_mod" class="form-control" type="text" style="width:100%" required>
       	 </div>
       	  	<div class="col-sm-4"> 
       	 <label>Stato</label> 	
       	 
       	 <input id="stato_mod" name="stato_mod" class="form-control" type="text" style="width:100%" required>
       			</div>
       	  	</div>
       	  	
       	  	<br>


       	  <div class="row">
       <div class="col-sm-5"></div>
       
       	<div class="col-sm-4">
       		<label style="text-align:center"><H3>Documento</H3></label>
       	</div>
       	<div class="col-sm-3"></div>
       	</div><br>
       	<div class="row">
       	<div class="col-sm-3">      
       	 <label>Tipo documento</label> 	
       
       	  	 
       	 <select id="tipo_documento_mod" name="tipo_documento_mod" class="form-control select2" required>
       	 <option value=""></option>
       	 
       	 <option value="1">CARTA D'IDENTITÀ</option>
       	 <option value="2">PATENTE</option>
       	 </select>
       	 </div>
       	  	<div class="col-sm-5"> 
       	 
       	 <label>Numero</label> 	
       	 
       	 <input id="numero_mod" name="numero_mod" class="form-control" type="text" style="width:100%" required>
     </div>
       	  	<div class="col-sm-4"> 
     <label>Data rilascio</label> 	
       	 
       	 
       			
       		<div class='input-group date datepicker' id='datepicker_data_rilascio'>
               <input id="data_rilascio_mod" name="data_rilascio_mod" class="form-control" type="text" style="width:100%" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 		
       			
       	   </div></div><br>
       	   <div class="row">
       	  	<div class="col-sm-4"> 
       	
       	<label>Data scadenza</label> 	
       	 
       
       	 <div class='input-group date datepicker' id='datepicker_data_rilascio'>
                <input id="data_scadenza_mod" name="data_scadenza_mod" class="form-control" type="text" style="width:100%" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       	 
       	 </div>
       	  	<div class="col-sm-5"> 
       	   	<label>Rilasciato da</label> 	
       	 
       	 <input id="rilasciato_da_mod" name="rilasciato_da_mod" class="form-control" type="text" style="width:100%" required>
       	 </div>
       	 
       </div><br>
 <div class="row">
       	 
       		
       
       	<div class="col-sm-9">    
       	<label>File</label>  
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.jpg,.JPG, .jpeg, .JPEG, .png, .PNG"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_file_mod"></label>
       	</div>       	
       	</div>
       	  	 
       	  	
       	  </div>

       
       
  		 
      <div class="modal-footer">
		<input id="id_Template" name="id_Template" class="form-control" type="hidden" >
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
      </div>
    </div>

</div>

</form>




  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'Template?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_template_id">
      <a class="btn btn-primary" onclick="eliminaTemplate()">SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>




</div>
   <t:dash-footer />
   
 <%--  <t:control-sidebar /> --%>
</div>
<!-- ./wrapper -->

<style>


.table th {
    background-color: #f39c12 !important;
  }</style>

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>

    <script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript">

$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
 
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });
function modalnuovoTemplate(){
	
	$('#myModalnuovoTemplate').modal();
	
}

function eliminaTemplate(){
	
	dataObj = {};
	dataObj.id_template = $('#elimina_template_id').val();
	
	callAjax(dataObj, "gestioneTemplate.do?action=elimina_template");
	
}


$('#add_isee').on('click', function(){
	
	if($(this).attr("checked") == true){
		$(this).attr("checked", false);
		$(this).val(0);
	}else{
		$(this).attr("checked", true);
		$(this).val(1);
	}
	
});

/* onClicK="modificaTemplate('${Template.id}', '${utl:escapeJS(Template.nome) }', '${utl:escapeJS(Template.cognome) }', '${Template.cf }', '${Template.dataNascita }', '${utl:escapeJS(Template.luogoNascita) }', '${utl:escapeJS(Template.tipo_via) }', '${utl:escapeJS(Template.indirizzo) }', '${Template.civico }', '${Template.cap }', '${utl:escapeJS(Template.comune) }', '${Template.provincia }', '${Template.telefono }', '${Template.email }')" */
function modificaTemplate(id_Template,  nome, cognome, cf, data_nascita, luogo_nascita, tipo_via, indirizzo,civico, comune, provincia, cap, stato, telefono, email, tipo_documento, numero, data_rilascio, data_scadenza, rilasciato_da, provincia_nascita, nome_file){
	
	$('#id_Template').val(id_Template);
	$('#nome_mod').val(nome);
	$('#cognome_mod').val(cognome);
	$('#cf_mod').val(cf);
	$('#data_nascita_mod').val(Date.parse(data_nascita).toString("dd/MM/yyyy"));
	$('#luogo_nascita_mod').val(luogo_nascita);
	$('#tipo_via_mod').val(tipo_via);
	$('#tipo_via_mod').change();
	$('#indirizzo_mod').val(indirizzo);
	$('#civico_mod').val(civico);
	$('#comune_mod').val(comune);
	$('#provincia_mod').val(provincia);
	$('#cap_mod').val(cap);
	$('#stato_mod').val(stato);
	$('#telefono_mod').val(telefono);
	$('#email_mod').val(email);
	$('#tipo_documento_mod').val(tipo_documento);
	$('#tipo_documento_mod').change();
	$('#numero_mod').val(numero);
	$('#data_rilascio_mod').val(Date.parse(data_rilascio).toString("dd/MM/yyyy"));
	$('#rilasciato_da_mod').val(rilasciato_da);
	$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	$('#provincia_nascita_mod').val(provincia_nascita);
	
	$('#label_file_mod').html(nome_file);

	$('#myModalModificaTemplate').modal();
}


var columsDatatables = [];

$("#tabTemplate").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabTemplate thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabTemplate thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalYesOrNo(id_Template){
	
	
	$('#elimina_template_id').val(id_Template);
	$('#myModalYesOrNo').modal();
}


$(document).ready(function() {
 
	
  	$('#fileupload').fileupload({
        url: "gestioneTemplate.do?action=upload_template",
        dataType: 'json',
        maxNumberOfFiles : 1,
        getNumberOfFiles: function () {
            return this.filesContainer.children()
                .not('.processing').length;
        },
        start: function(e){
        	pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
        },
        add: function(e, data) {
            var uploadErrors = [];
            var acceptFileTypes = /(\.|\/)(pdf)$/i;
            if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
                uploadErrors.push('Tipo File non accettato. ');
            }
            if(data.originalFiles[0]['size'] > 30000000) {
                uploadErrors.push('File troppo grande, dimensione massima 30mb');
            }
            if(uploadErrors.length > 0) {
            	//$('#files').html(uploadErrors.join("\n"));
            	$('#myModalErrorContent').html(uploadErrors.join("\n"));
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				
				$('#myModalError').modal('show');
			
            } else {
                data.submit();
            }
    	},
        done: function (e, data) {
			
        	pleaseWaitDiv.modal('hide');
        	
        	if(data.result.success)
			{
        		
        		$('#filename').val(data.result.filename);
        		
        			 
        			 var lista_campi = data.result.lista_campi;
        			 var str = "<div class='row'><div class='col-md-4'><label>Campi pdf</label></div></div><br>";
        			 for (var i = 0; i<lista_campi.length; i++){
        				 str += "<div class='row'><div class='col-md-4'><input class=form-control id=campo_"+i+" name=campo_"+i+" value="+lista_campi[i]+"></div><div class='col-xs-4'><input class=form-control id=campo_corretto_"+i+" name=campo_corretto_"+i+" value=''></div></div><br>"
        			 }
        			
        			 $('#content_campi').html(str);
        			 
        			 $('#content_campi').show();
        			 
        			 $("#numero_campi").val(lista_campi.length);
        		 
        		
/*         			$('#myModalErrorContent').html("CARICATO CON SUCCESSO <input type='hidden' id='uploadSuccess' value='12'>");
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				$('#progress .progress-bar').css(
	                    'width',
	                    '0%'
	                ); */
			
			}else{
				
				$('#myModalErrorContent').html(uploadErrors.join("\n"));
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				
				$('#myModalError').modal('show');
				
				$('#progress .progress-bar').css(
	                    'width',
	                    '0%'
	                );

			}


        },
        fail: function (e, data) {
        	pleaseWaitDiv.modal('hide');
        	$('#files').html("");
        	var errorMsg = "";
            $.each(data.messages, function (index, error) {

            	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
       

            });
        		$('#myModalErrorContent').html(uploadErrors.join("\n"));
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').find('.modal-footer').append('<button type="button" class="btn btn-outline" id="report_button" onClick="sendReport($(this).parents(\'.modal\'))">Invia Report</button>');
			$('#myModalError').modal('show');
			$('#progress .progress-bar').css(
                    'width',
                    '0%'
                );
			$('#myModal').on('hidden.bs.modal', function(){
				$('#myModal').find('#report_button').remove();
			});
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );

        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled'); 
	
	
/*  	$('#fileupload').bind('fileuploadsubmit', function (e, data) {
	    // The example input, doesn't have to be part of the upload form:
	    var date = $('#dataVerifica').val();

	    if(date==null){
	    	date='';
	    }
	    data.formData = {dataVerifica: date, idStrumento: strumento_id};
	    

	});  */
	 

     $('.dropdown-toggle').dropdown();
	$('.select2').select2();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });  
  

     table = $('#tabTemplate').DataTable({
			language: {
		        	emptyTable : 	"Nessun dato presente nella tabella",
		        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
		        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
		        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
		        	infoPostFix:	"",
		        infoThousands:	".",
		        lengthMenu:	"Visualizza _MENU_ elementi",
		        loadingRecords:	"Caricamento...",
		        	processing:	"Elaborazione...",
		        	search:	"Cerca:",
		        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
		        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
		        	},
		        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
		        }
	        },
	        pageLength: 25,
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabTemplate_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      table
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
		table.columns.adjust().draw();
		

	$('#tabTemplate').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaTemplateForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaTemplateForm','gestioneTemplate.do?action=modifica_template');
});
 

 
 $('#nuovoTemplateForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovoTemplateForm','gestioneTemplate.do?action=nuovo_template&moduli='+$('#moduli').val());
	
});
 
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>

