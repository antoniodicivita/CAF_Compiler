<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
 <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %> 


<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

 
 <t:main-header />
<t:main-sidebar />
  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Moduli
        
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/CAF"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	 Lista Moduli
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-6">

<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Modulo Da Correggere...</span><input accept=".pdf,.PDF,"  id="fileupload" name="fileupload" type="file" ></span><label id="label_file"></label>

</div>

<div class="col-xs-6">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalnuovoModulo()"><i class="fa fa-plus"></i> Nuovo Modulo</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabModuli" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Descrizione</th>
<th>Note</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${listaModuli }" var="modulo" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${modulo.id }</td>	
	<td>${modulo.descrizione }</td>
	<td>${modulo.note }</td>


	<td>
												
<a class="btn btn-info customLink customTooltip" onClicK="dettaglioModulo('${modulo.id}')" title="Click per aprire il dettaglio del Modulo"><i class="fa fa-search"></i></a>												
	<a class="btn btn-warning customTooltip" onClicK="modificaModulo('${modulo.id}', '${utl:escapeJS(modulo.descrizione) }', '${utl:escapeJS(modulo.note) }')" title="Click per modificare il Modulo"><i class="fa fa-edit"></i></a>
	 
	 <a target="_blank" class="btn btn-danger customTooltip" title="Download modulo"  href="gestioneModuli.do?action=download_file&id_modulo=${modulo.id }" ><i class="fa fa-file-pdf-o"></i></a>
	 
	 <a class="btn btn-danger customTooltip" title="Elimina Modulo"  onClick="modalYesOrNo('${modulo.id}')"><i class="fa fa-trash"></i></a>
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


</section>



<form id="nuovoModuloForm" name="nuovoModuloForm">
<div id="myModalnuovoModulo" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Modulo</h4>
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
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="5" style="width:100%" id="note" name="note"></textarea>
       			
       	</div>       	
       </div><br>
       
 <div class="row">
       	 
       		
       
       	<div class="col-sm-9">    
       	<label>File</label>  
			 <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File Corretto...</span><input accept=".pdf,.PDF,"  id="fileupload_corr" name="fileupload_corr" type="file" ></span><label id="label_file_corr"></label>
       	</div>
  	
       	</div><br>
       	  	 
       	  	 
       	  	 
       	  	 <div id="content_campi" style="display:none">
       	  	 
       	  	 
       	  	 </div>
       	  	 
       	  
       	  	
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




<form id="modificaModuloForm" name="modificaModuloForm">
<div id="myModalModificaModulo" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
      <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Modulo</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="5" style="width:100%" id="note_mod" name="note_mod"></textarea>
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       	 
       		
       
       	<div class="col-sm-9">    
       	<label>File</label>  
			 <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File Corretto...</span><input accept=".pdf,.PDF,"  id="fileupload_corr_mod" name="fileupload_corr_mod" type="file" ></span><label id="label_file_corr_mod"></label>
       	</div>
  	
       	</div><br>
       
  	  	 
       	  	 <div id="content_campi_mod" style="display:none">
       	  	 
       	  	 
       	  	 </div>
       	  	
       	  </div>

  		 
      <div class="modal-footer">

 <input id="id_modulo" name="id_modulo" class="form-control" type="hidden" style="width:100%" >
		<button class="btn btn-primary" type="submit" >Salva</button> 
       
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
      	Sei sicuro di voler eliminare l'Modulo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_modulo_id">
      <a class="btn btn-primary" onclick="eliminaModulo()">SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>




  <div id="modalPdf" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalsaveStato" ">

<div class="modal modal-dialog modal-lg " role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Correggi i campi del file</h4>
      </div>
       <div class="modal-body">   
       <div class="row">
       <div class="col-xs-10">
       <div id="frame_pdf"></div>
       </div> 
       <div class="col-xs-2">
       <textarea style="width:100%" rows="40" disabled>${utl:escapeHTML(listaCostanti) }</textarea>
       </div>       
       </div>    
      	
      	</div>
      <div class="modal-footer">
  

		<a class="btn btn-primary" onclick="$('#modalPdf').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div> 

</div>
 -


<!-- <div id="myModalConsuntivaModulo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabelTipoDevice"> </h4>
      </div>
       <div class="modal-body">      
       
       
       <div class="row">

	<div class="col-xs-8">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDate()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	


</div>

<div class="row">
<div class="col-xs-12">

<div id="content_consuntivo"></div>

</div>

</div>
    
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="Modulo_id">
   
		<a class="btn btn-primary" onclick="$('#myModalConsuntivaModulo').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>

 -->

</div>
   <t:dash-footer />
   
 <%--  <t:control-sidebar /> --%>
</div>
<!-- ./wrapper -->

<style>


.table th {
    background-color: #3c8dbc !important;
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


<script type="text/javascript">

$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
 
$('#fileupload_corr').change(function(){
	$('#label_file_corr').html($(this).val().split("\\")[2]);
	 
 });
 
$('#fileupload_corr_mod').change(function(){
	$('#label_file_corr_mod').html($(this).val().split("\\")[2]);
	 
 });
function modalnuovoModulo(){
	
	$('#myModalnuovoModulo').modal();
	
}

function eliminaModulo(){
	
	dataObj = {};
	dataObj.id_modulo = $('#elimina_modulo_id').val();
	
	callAjax(dataObj, "gestioneModuli.do?action=elimina_modulo");
	
}


function dettaglioModulo(id_modulo){
	
	str =' <iframe src="gestioneModuli.do?action=download_file&id_modulo='+id_modulo+'" id="iframe-pdf" width="100%" height="800px"></iframe>'
		 
		 $('#frame_pdf').html(str);
		 
		
		$('#modalPdf').modal();
	
}

/* onClicK="modificaModulo('${Modulo.id}', '${utl:escapeJS(Modulo.nome) }', '${utl:escapeJS(Modulo.cognome) }', '${Modulo.cf }', '${Modulo.dataNascita }', '${utl:escapeJS(Modulo.luogoNascita) }', '${utl:escapeJS(Modulo.tipo_via) }', '${utl:escapeJS(Modulo.indirizzo) }', '${Modulo.civico }', '${Modulo.cap }', '${utl:escapeJS(Modulo.comune) }', '${Modulo.provincia }', '${Modulo.telefono }', '${Modulo.email }')" */
function modificaModulo(id_modulo,  descrizione, note){
	
	$('#id_modulo').val(id_modulo);
	$('#descrizione_mod').val(descrizione);
	$('#note_mod').val(note);

	$('#myModalModificaModulo').modal();
}


var columsDatatables = [];

$("#tabModuli").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabModuli thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabModuli thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalYesOrNo(id_Modulo){
	
	
	$('#elimina_modulo_id').val(id_Modulo);
	$('#myModalYesOrNo').modal();
}


function previewFile() {
    const preview = document.querySelector('iframe');
    const file = document.querySelector('input[type=file]').files[0];
    const reader = new FileReader();
    var filename = file.name;

    reader.addEventListener("load", function () {
      // convert file to base64 string
      preview.src = reader.result;
    }, false);

    if (file) {
      reader.readAsDataURL(file);
    }

  }

$(document).ready(function() {
 
	
  	$('#fileupload').fileupload({
        url: "gestioneModuli.do?action=upload_modulo",
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
        		
        			 
        			/*  var lista_campi = data.result.lista_campi;
        			 var str = "<div class='row'><div class='col-md-4'><label>Campi pdf</label></div></div><br>";
        			 for (var i = 0; i<lista_campi.length; i++){
        				 str += "<div class='row'><div class='col-md-4'><input class=form-control id=campo_"+i+" name=campo_"+i+" value="+lista_campi[i]+"></div><div class='col-xs-4'><input class=form-control id=campo_corretto_"+i+" name=campo_corretto_"+i+" value=''></div></div><br>"
        			 } */
        			
        			str =' <iframe src="gestioneModuli.do?action=download_file_temp" id="iframe-pdf" width="100%" height="800px"></iframe>'
        			 
        			 $('#frame_pdf').html(str);
        			 
        			
        			$('#modalPdf').modal();
        		
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
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });  
  

     table = $('#tabModuli').DataTable({
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
		
		table.buttons().container().appendTo( '#tabModuli_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabModuli').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaModuloForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaModuloForm','gestioneModuli.do?action=modifica_modulo');
});
 

 
 $('#nuovoModuloForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovoModuloForm','gestioneModuli.do?action=nuovo_modulo');
	
});
 
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>

