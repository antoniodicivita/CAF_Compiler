<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
 <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %> 


<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

 
 <t:main-header />
<t:main-sidebar />
  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Anagrafiche
        
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/CAF"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid">
<div class="box-header with-border">
	 Lista Anagrafiche
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovaAnagrafica()"><i class="fa fa-plus"></i> Nuova Anagrafica</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAnagrafiche" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Cognome</th>
<th>Codice Fiscale</th>
<th>Data di nascita</th>
<th>Luogo di nascita</th>
<th>Residenza</th>
<th>Telefono</th>
<th>Email</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${listaAnagrafiche }" var="anagrafica" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${anagrafica.id }</td>	
	<td>${anagrafica.nome }</td>
	<td>${anagrafica.cognome }</td>
	<td>${anagrafica.cf }</td>
	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${anagrafica.dataNascita }" /></td>
	<td>${anagrafica.luogoNascita }</td>
	<td>${anagrafica.tipoVia } ${anagrafica.indirizzo } ${anagrafica.civico } - ${anagrafica.cap } - ${anagrafica.comune } (${anagrafica.provincia })</td>
	<td>${anagrafica.telefono }</td>
	<td>${anagrafica.email }</td>
	

	<td>
													<!-- modificaAnagrafica(id_anagrafica,  nome, cognome, cf, data_nascita, luogo_nascita, tipo_via, indirizzo,civico, comune, provincia, cap, stato, telefono, email, tipo_documento, numero, data_rilascio, data_scadenza, rilasciato_da, provincia_nascita){ -->
	<a class="btn btn-warning customTooltip" onClicK="modificaAnagrafica('${anagrafica.id}', '${utl:escapeJS(anagrafica.nome) }', '${utl:escapeJS(anagrafica.cognome) }', '${anagrafica.cf }', '${anagrafica.dataNascita }', '${utl:escapeJS(anagrafica.luogoNascita) }', '${anagrafica.tipoVia }', '${utl:escapeJS(anagrafica.indirizzo) }', '${anagrafica.civico }',  '${utl:escapeJS(anagrafica.comune) }', '${anagrafica.provincia }','${anagrafica.cap }', '${anagrafica.stato }', '${anagrafica.telefono }', '${anagrafica.email }', '${anagrafica.documento.tipo.id }',
	 '${anagrafica.documento.numero }','${anagrafica.documento.dataRilascio }', '${anagrafica.documento.dataScadenza }', '${utl:escapeJS(anagrafica.documento.rilasciatoDa) }','${anagrafica.provinciaNascita }','${anagrafica.documento.nomeFile }','${utl:escapeJS(anagrafica.statoNascita) }','${utl:escapeJS(anagrafica.cittadinanza) }')" title="Click per modificare l'anagrafica"><i class="fa fa-edit"></i></a>
	 
	 <a target="_blank" class="btn btn-danger customTooltip" title="Download documento"  href="gestioneAnagrafiche.do?action=download_file&id_anagrafica=${anagrafica.id }&id_documento=${anagrafica.documento.id}" ><i class="fa fa-file-pdf-o"></i></a>
	 <c:if test="${anagrafica.nomeFileIsee!=null && anagrafica.nomeFileIsee!=''}">
	 <a target="_blank" class="btn btn-info customTooltip customLink" title="VIsualizza ISEE" href="gestioneAnagrafiche.do?action=download_file&id_anagrafica=${anagrafica.id }&isee=true" ><i class="fa fa-arrow-down"></i></a>
	 </c:if>
	 <a target="_blank" class="btn btn-primary customTooltip customLink" title="Carica ISEE"  onClick="modalCaricaIsee('${anagrafica.id }')" ><i class="fa fa-arrow-up"></i></a>
	 
	 <a class="btn btn-danger customTooltip" title="Elimina anagrafica"  onClick="modalYesOrNo('${anagrafica.id}')"><i class="fa fa-trash"></i></a>
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



<form id="nuovaAnagraficaForm" name="nuovaAnagraficaForm">
<div id="myModalNuovaAnagrafica" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Anagrafica</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome" name="nome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome" name="cognome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
        
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice Fiscale</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cf" name="cf" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data di Nascita</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       	  	<div class='input-group date datepicker' id='datepicker_data_rilascio'>
               <input type='text' class="form-control input-small" id="data_nascita" name="data_nascita" required>
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
       	  	
        <input id="luogo_nascita" name="luogo_nascita" class="form-control" type="text" style="width:100%" required>
       			
       	</div> 
       	<div class="col-sm-1">     
       		<label>Provincia</label> 
       	</div>
       	<div class="col-sm-1">      
       	  
        <input id="provincia_nascita" name="provincia_nascita" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Stato di Nascita</label>
       	</div>
       	<div class="col-sm-3">      
       	  	
        <input id="stato_nascita" name="stato_nascita" class="form-control" type="text" style="width:100%" required>
       			
       	</div> 
       	<div class="col-sm-2">     
       		<label>Cittadinanza</label> 
       	</div>
       	<div class="col-sm-4">      
       	  
        <input id="cittadinanza" name="cittadinanza" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Telefono</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="telefono" name="telefono" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email" name="email" class="form-control" type="text" style="width:100%" >
       			
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
       
       	  	 
       	 <select id="tipo_via" name="tipo_via" class="form-control select2" required>
       	 <option value=""></option>
       	 <option value="VIA">VIA</option>
       	 <option value="VIALE">VIALE</option>
       	 <option value="PIAZZA">PIAZZA</option>
       	 <option value="LOCALITA">LOCALIT�</option>
       	 <option value="RIONE">RIONE</option>
       	 </select>
       	 </div>
       	  	<div class="col-sm-7"> 
       	 
       	 <label>Indirizzo</label> 	
       	 
       	 <input id="indirizzo" name="indirizzo" class="form-control" type="text" style="width:100%" required>
     </div>
       	  	<div class="col-sm-1"> 
     <label>Civico</label> 	
       	 
       	 <input id="civico" name="civico" class="form-control" type="text" style="width:100%" >
       			
       	   </div>
       	  	<div class="col-sm-2"> 
     <label>CAP</label> 	
       	 
       	 <input id="cap" name="cap" class="form-control" type="text" style="width:100%" required>
       			
       	   </div>
       	   
       	   </div><br>
       	   <div class="row">
       	  	<div class="col-sm-6"> 
       	
       	<label>Comune</label> 	
       	 
       	 <input id="comune" name="comune" class="form-control" type="text" style="width:100%" required>
       	 </div>
       	  	<div class="col-sm-2"> 
       	   	<label>Provincia</label> 	
       	 
       	 <input id="provincia" name="provincia" class="form-control" type="text" style="width:100%" required>
       	 </div>
       	  	<div class="col-sm-4"> 
       	 <label>Stato</label> 	
       	 
       	 <input id="stato" name="stato" class="form-control" type="text" style="width:100%" required>
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
       
       	  	 
       	 <select id="tipo_documento" name="tipo_documento" class="form-control select2" required>
       	 <option value=""></option>
       	 
       	 <option value="1">CARTA D'IDENTIT�</option>
       	 <option value="2">PATENTE</option>
       	 </select>
       	 </div>
       	  	<div class="col-sm-5"> 
       	 
       	 <label>Numero</label> 	
       	 
       	 <input id="numero" name="numero" class="form-control" type="text" style="width:100%" required>
     </div>
       	  	<div class="col-sm-4"> 
     <label>Data rilascio</label> 	
       	 
       	 
       			
       		<div class='input-group date datepicker' id='datepicker_data_rilascio'>
               <input id="data_rilascio" name="data_rilascio" class="form-control" type="text" style="width:100%" required>
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
                <input id="data_scadenza" name="data_scadenza" class="form-control" type="text" style="width:100%" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       	 
       	 </div>
       	  	<div class="col-sm-5"> 
       	   	<label>Rilasciato da</label> 	
       	 
       	 <input id="rilasciato_da" name="rilasciato_da" class="form-control" type="text" style="width:100%" required>
       	 </div>
       	 
       </div><br>
 <div class="row">
       	 
       		
       
       	<div class="col-sm-9">    
       	<label>File</label>  
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.jpg,.JPG, .jpeg, .JPEG, .png, .PNG"  id="fileupload" name="fileupload" type="file" required></span><label id="label_file"></label>
       	</div>       	
       	</div>
       	  	 
       	  	
       	  </div>

       
       
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
      </div>
    </div>

</div>

</form>




<form id="modificaAnagraficaForm" name="modificaAnagraficaForm">
<div id="myModalModificaAnagrafica" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Mpodifica Anagrafica</h4>
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
       		<label>Stato di Nascita</label>
       	</div>
       	<div class="col-sm-3">      
       	  	
        <input id="stato_nascita_mod" name="stato_nascita_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div> 
       	<div class="col-sm-2">     
       		<label>Cittadinanza</label> 
       	</div>
       	<div class="col-sm-4">      
       	  
        <input id="cittadinanza_mod" name="cittadinanza_mod" class="form-control" type="text" style="width:100%" required>
       			
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
       	 <option value="LOCALITA">LOCALIT�</option>
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
       	 
       	 <option value="1">CARTA D'IDENTIT�</option>
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
		<input id="id_anagrafica" name="id_anagrafica" class="form-control" type="hidden" >
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
      	Sei sicuro di voler eliminare l'anagrafica?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_anagrafica_id">
      <a class="btn btn-primary" onclick="eliminaAnagrafica()">SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="caricaIseeForm" name = "caricaIseeForm">
  <div id="myModalCaricaIsee" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	  <div class="row">
       	 
       		
       
       	<div class="col-sm-9">    
       	<label>File</label>  <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.jpg,.JPG, .jpeg, .JPEG, .png, .PNG"  id="fileupload_isee" name="fileupload_isee" type="file" ></span><label id="label_file_isee"></label>
			 <!-- <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica ISEE...</span><input accept=".pdf,.PDF,"  id="fileupload_isee" name="fileupload_isee" type="file" ></span><label id="label_file_isee"></label> -->
       	</div>
  	
       	</div>
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="isee_anagrafica_id" name="isee_anagrafica_id">
      <button class="btn btn-primary" type="submit">Salva</button>
		<a class="btn btn-primary" onclick="$('#myModalCaricaIsee').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>
</form>
</div>

   <t:dash-footer />
   
 <%--  <t:control-sidebar /> --%>
</div>
<!-- ./wrapper -->

<style>


.table th {
    background-color: #00a65a !important;
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
 
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_isee').change(function(){
	$('#label_file_isee').html($(this).val().split("\\")[2]);
	 
 });
function modalNuovaAnagrafica(){
	
	$('#myModalNuovaAnagrafica').modal();
	
}

function eliminaAnagrafica(){
	
	dataObj = {};
	dataObj.id_anagrafica = $('#elimina_anagrafica_id').val();
	
	callAjax(dataObj, "gestioneAnagrafiche.do?action=elimina_anagrafica");
	
}

/* onClicK="modificaAnagrafica('${anagrafica.id}', '${utl:escapeJS(anagrafica.nome) }', '${utl:escapeJS(anagrafica.cognome) }', '${anagrafica.cf }', '${anagrafica.dataNascita }', '${utl:escapeJS(anagrafica.luogoNascita) }', '${utl:escapeJS(anagrafica.tipo_via) }', '${utl:escapeJS(anagrafica.indirizzo) }', '${anagrafica.civico }', '${anagrafica.cap }', '${utl:escapeJS(anagrafica.comune) }', '${anagrafica.provincia }', '${anagrafica.telefono }', '${anagrafica.email }')" */
function modificaAnagrafica(id_anagrafica,  nome, cognome, cf, data_nascita, luogo_nascita, tipo_via, indirizzo,civico, comune, provincia, cap, stato, telefono, email, tipo_documento, numero, data_rilascio, data_scadenza, rilasciato_da, provincia_nascita, nome_file, stato_nascita, cittadinanza){
	
	$('#id_anagrafica').val(id_anagrafica);
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
	$('#stato_nascita_mod').val(stato_nascita);
	$('#cittadinanza_mod').val(cittadinanza);
	
	$('#label_file_mod').html(nome_file);

	$('#myModalModificaAnagrafica').modal();
}


var columsDatatables = [];

$("#tabAnagrafiche").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAnagrafiche thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAnagrafiche thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalYesOrNo(id_anagrafica){
	
	
	$('#elimina_anagrafica_id').val(id_anagrafica);
	$('#myModalYesOrNo').modal();
}


function modalCaricaIsee(id_anagrafica){
		
	$('#isee_anagrafica_id').val(id_anagrafica);
	$('#myModalCaricaIsee').modal();
	
}




$(document).ready(function() {
	
	

     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });  
  

     table = $('#tabAnagrafiche').DataTable({
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
		
		table.buttons().container().appendTo( '#tabAnagrafiche_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAnagrafiche').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaAnagraficaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaAnagraficaForm','gestioneAnagrafiche.do?action=modifica_anagrafica');
});
 

 
 $('#nuovaAnagraficaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovaAnagraficaForm','gestioneAnagrafiche.do?action=nuova_anagrafica');
	
});
 
 
 $('#caricaIseeForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#caricaIseeForm','gestioneAnagrafiche.do?action=upload_isee&isee_anagrafica_id='+$('#isee_anagrafica_id').val());
	
});


 
  </script>
  
</jsp:attribute> 
</t:layout>

