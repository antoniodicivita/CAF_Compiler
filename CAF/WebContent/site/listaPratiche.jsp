<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
 <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %> 


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

 
 <t:main-header />
<t:main-sidebar />
  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Pratiche
        
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/CAF"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Pratiche
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 


<a class="btn btn-primary pull-right" onClick="modalNuovaPratica()"><i class="fa fa-plus"></i> Nuova Pratica</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabPratiche" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Anagrafica</th>
<th>Codice Fiscale</th>
<th>Tipo Pratica</th>
<th>Data Creazione</th>
<th>Note</th>

<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${listaPratiche }" var="pratica" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${pratica.id }</td>	
	<td>${pratica.anagrafica.nome } ${pratica.anagrafica.cognome }</td>
		<td>${pratica.anagrafica.cf } </td>
	<td>${pratica.tipo.descrizione }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pratica.dataCreazione }" /></td>
	<td>${pratica.note }</td>
	


	<td>

	 <a target="_blank" class="btn btn-danger customTooltip" title="Download documento da firmare"  href="gestionePratiche.do?action=download_file&id_pratica=${pratica.id }" ><i class="fa fa-file-pdf-o"></i></a>
	 <a target="_blank" class="btn btn-primary customTooltip customLink" title="Carica Scansione"  onClick="modalCaricaScansione('${pratica.id }')" ><i class="fa fa-arrow-up"></i></a>
	<c:if test="${pratica.nomeFileScansione!=null && pratica.nomeFileScansione!=''}">
	 <a target="_blank" class="btn btn-danger customTooltip" title="Download Scansione"  href="gestionePratiche.do?action=download_file&id_pratica=${pratica.id }&scansione=true" ><i class="fa fa-arrow-down"></i></a>
	 </c:if> 
	 <a class="btn btn-danger customTooltip" title="Elimina pratica"  onClick="modalYesOrNo('${pratica.id}')"><i class="fa fa-trash"></i></a>
	 
	 <c:if test="${pratica.nomeFileScansione!=null && pratica.nomeFileScansione!=''}">
	 <a target="_blank" class="btn btn-info customTooltip" title="Invia pratica al CAF"  onclick="modalEmail('${pratica.id}', '${utl:escapeJS(pratica.tipo.descrizione) }','${utl:escapeJS(pratica.anagrafica.nominativo) }')" ><i class="fa fa-paper-plane"></i></a>
	 </c:if> 
	 
	  <a target="_blank" class="btn btn-primary customTooltip" title="Apri allegati"  onclick="modalAllegati('${pratica.id}')"><i class="fa fa-archive"></i></a>
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


<form id="nuovaPraticaForm" name="nuovaPraticaForm">
<div id="myModalNuovaPratica" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Pratica</h4>
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
       		<label>Anagrafica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select class="form-control select2" id="anagrafica" data-placeholder="Seleziona anagrafica..." name="anagrafica" style="width:100%">
        <option value=""><option/>
        <c:forEach items="${listaAnagrafiche}" var="anag">
         <option value="${anag.id }">${anag.nome } ${anag.cognome} - ${anag.cf }<option/>
        </c:forEach>
        </select>
        
       			
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
       		<label>Template</label>
       	</div>
       	<div class="col-sm-9">    
        
        <select class="form-control select2" id="template"  data-placeholder="Seleziona template..." name="template" style="width:100%">
        <option value=""><option/>
        <c:forEach items="${listaTemplate}" var="template">
         <option value="${template.id }">${template.descrizione }<option/>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div>

       	  
       	  	
       	  </div>

       
       
  		 
      <div class="modal-footer">


		<button class="btn btn-primary" type="submit" >Salva</button> 
       
      </div>
      </div>
    </div>

</div>

</form>

<!-- 
<form id="nuovaPraticaForm" name="nuovaPraticaForm">
<div id="myModalNuovaPratica" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Pratica</h4>
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
       	 <option value="LOCALITA">LOCALITÀ</option>
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
       	 
       	 <option value="1">CARTA D'IDENTITÀ</option>
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

 -->


<form id="modificaPraticaForm" name="modificaPraticaForm">
<div id="myModalModificaPratica" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Mpodifica Pratica</h4>
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
		<input id="id_pratica" name="id_pratica" class="form-control" type="hidden" >
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
      </div>
    </div>

</div>

</form>




  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">

 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>

		   	 <br><br>

       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_pratica_allegato" name="id_pratica_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
      </div>
   
  </div>
  </div>
</div>


  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare la pratica?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_pratica_id">
      <a class="btn btn-primary" onclick="eliminaPratica()">SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>



  <div id="myModalYesOrNoAllegato" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_allegato_id">
      <a class="btn btn-primary" onclick="eliminaAllegato()">SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNoAllegato').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>



<form id="caricaScansioneForm" name = "caricaScansioneForm">
  <div id="myModalCaricaScansione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	  <div class="row">
       	 
       		
       
       	<div class="col-sm-9">    
       	<label>File</label>  <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload_scansione" name="fileupload_scansione" type="file" ></span><label id="label_file_scansione"></label>
			 <!-- <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica ISEE...</span><input accept=".pdf,.PDF,"  id="fileupload_isee" name="fileupload_isee" type="file" ></span><label id="label_file_isee"></label> -->
       	</div>
  	
       	</div>
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="scansione_pratica_id" name="scansione_pratica_id">
      <button class="btn btn-primary" type="submit">Salva</button>
		<a class="btn btn-primary" onclick="$('#myModalCaricaScansione').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>
</form>



<form id="emailForm" name = "emailForm">
  <div id="myModalEmail" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Invia Pratica</h4>
      </div>
       <div class="modal-body">       
      	  <div class="row">
       	 
       		
       
       	<div class="col-sm-12">    
       	<label>Destinatario</label>  
       	<input id="destinatario" name="destinatario" value="${emailConfig.destinatarioDefault }" class="form-control">
       	</div>
       	
       	
  	
       	</div><br>
       	<div class="row">
       	 
       		
       
       	<div class="col-sm-12">    
       	<label>Oggetto</label>  
       	<input id="oggetto" name="oggetto"  class="form-control">
       	</div>
       	
       	
  	
       	</div><br>
       	 <div class="row">
       	<div class="col-sm-12">    
       	<label>Messaggio</label>  
       	<textarea id="messaggio" name="messaggio" rows="5" style="width:100%" class="form-control"></textarea>
       	</div>
       	</div><br>
       	
       	
       	<div class="row">
       	<div class="col-sm-12">    
       	<div id="content_allegati_email"></div>
       	</div>
       	</div>
       	
       	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="email_pratica_id" name="email_pratica_id">
      <input type="hidden" id="id_allegati" name="id_allegati">
      
      <button class="btn btn-primary" type="submit">Invia</button>
		<a class="btn btn-primary" onclick="$('#myModalEmail').modal('hide')" >Chiudi</a>
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
 
$('#fileupload_scansione').change(function(){
	$('#label_file_scansione').html($(this).val().split("\\")[2]);
	 
 });
function modalNuovaPratica(){
	
	$('#myModalNuovaPratica').modal();
	
}

function eliminaPratica(){
	
	dataObj = {};
	dataObj.id_pratica = $('#elimina_pratica_id').val();
	
	callAjax(dataObj, "gestionePratiche.do?action=elimina_pratica");
	
}


function eliminaAllegato(){
	
	dataObj = {};
	dataObj.id_allegato = $('#elimina_allegato_id').val();
	
	callAjax(dataObj, "gestionePratiche.do?action=elimina_allegato", function(datab, textStatusb){
		
		modalAllegati($('#id_pratica_allegato').val())
		
	});
	
}

/* onClicK="modificaPratica('${pratica.id}', '${utl:escapeJS(pratica.nome) }', '${utl:escapeJS(pratica.cognome) }', '${pratica.cf }', '${pratica.dataNascita }', '${utl:escapeJS(pratica.luogoNascita) }', '${utl:escapeJS(pratica.tipo_via) }', '${utl:escapeJS(pratica.indirizzo) }', '${pratica.civico }', '${pratica.cap }', '${utl:escapeJS(pratica.comune) }', '${pratica.provincia }', '${pratica.telefono }', '${pratica.email }')" */
function modificaPratica(id_pratica,  nome, cognome, cf, data_nascita, luogo_nascita, tipo_via, indirizzo,civico, comune, provincia, cap, stato, telefono, email, tipo_documento, numero, data_rilascio, data_scadenza, rilasciato_da, provincia_nascita, nome_file){
	
	$('#id_pratica').val(id_pratica);
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

	$('#myModalModificaPratica').modal();
}


var columsDatatables = [];

$("#tabPratiche").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabPratiche thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabPratiche thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalYesOrNo(id_pratica){
	
	
	$('#elimina_pratica_id').val(id_pratica);
	$('#myModalYesOrNo').modal();
}

function modalEmail(id_pratica, tipo_pratica, anagrafica){
	
	$('#oggetto').val("Invio pratica di "+tipo_pratica+" per "+anagrafica);
	
	const d = new Date();
	var hour = d.getHours();
	var message = ""
	if(hour<=12){
		message += "Buongiorno,\n";
	}else if(hour>12 && hour<18){
		message += "Buon pomeriggio,\n";
	}else{
		message += "Buonasera,\n";
	}
	
	message += "allego pratica di "+tipo_pratica+" per "+anagrafica+"\nGrazie"
	
	
	
	$('#messaggio').val(message);
	$('#email_pratica_id').val(id_pratica);
	
	
	
	dataString ="action=lista_allegati&id_pratica="+ id_pratica;
    exploreModal("gestionePratiche.do",dataString,null,function(datab,textStatusb){
    	
    	var result = JSON.parse(datab);
    	
    	if(result.success){
    		
    		var lista_allegati = result.lista_allegati;
    		var html = '<ul class="list-group list-group-bordered"><div class="row"><div class="col-xs-9">Inserisci allegati</div></div>';
    		if(lista_allegati.length>0){
    			for(var i= 0; i<lista_allegati.length;i++){
       			 html= html + '<li class="list-group-item"><div class="row"><div class="col-xs-9"><b>'+lista_allegati[i].nomeFile+'</b></div><div class="col-xs-3 pull-right">' 	
       			 +'<input type="checkbox" id="check_'+lista_allegati[i].id+'"  name="check_'+lista_allegati[i].id+'" onchange="checkAllegati('+lista_allegati[i].id+')">'
               
    	           +'<a target="_blank" class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="gestionePratiche.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>'
    	           +'</div></div></li>';
       		}
    		}else{
    			 html= html + '<li class="list-group-item"> Nessun file allegato alla pratica! </li>';
    		}
    		
    		$("#content_allegati_email").html(html+"</ul>");
    	}
    	
    	
    	
    });
	
	
	$('#myModalEmail').modal();
	
}


function checkAllegati(id){
	
	var id_allegati = $('#id_allegati').val();
	
	if($('#check_'+id).is(":checked") == true){
		id_allegati = id_allegati +id + "_";
	}else{
		id_allegati = id_allegati.replace(id+"_", "");
	}
		
	
	$('#id_allegati').val(id_allegati);
	
}


function modalCaricaScansione(id_pratica){
	
		$('#scansione_pratica_id').val(id_pratica);
	$('#myModalCaricaScansione').modal();
}

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });  
  

     table = $('#tabPratiche').DataTable({
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
		
		table.buttons().container().appendTo( '#tabPratiche_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabPratiche').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaPraticaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaPraticaForm','gestionePratiche.do?action=modifica_pratica');
});
 

 
 $('#nuovaPraticaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovaPraticaForm','gestionePratiche.do?action=nuova_pratica');
	
});
 
 $('#caricaScansioneForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#caricaScansioneForm','gestionePratiche.do?action=upload_scansione&scansione_pratica_id='+$('#scansione_pratica_id').val());
	
});



 $('#emailForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#emailForm','gestionePratiche.do?action=invia_pratica&email_pratica_id='+$('#email_pratica_id').val());
	
});
 
 
 
 function eliminaAllegatoModal(id_allegato){
		
		$('#elimina_allegato_id').val(id_allegato);
		
		$('#myModalYesOrNoAllegato').modal();
	}
 
 
 function modalAllegati(id_pratica){

		$('#id_pratica_allegato').val(id_pratica);
		 $('#tab_archivio').html("");
		 
		 dataString ="action=lista_allegati&id_pratica="+ id_pratica;
	    exploreModal("gestionePratiche.do",dataString,null,function(datab,textStatusb){
	    	
	    	var result = JSON.parse(datab);
	    	
	    	if(result.success){
	    		
	    		var lista_allegati = result.lista_allegati;
	    		var html = '<ul class="list-group list-group-bordered">';
	    		if(lista_allegati.length>0){
	    			for(var i= 0; i<lista_allegati.length;i++){
	       			 html= html + '<li class="list-group-item"><div class="row"><div class="col-xs-10"><b>'+lista_allegati[i].nomeFile+'</b></div><div class="col-xs-2 pull-right">' 	           
	                +'<a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegatoModal(\''+lista_allegati[i].id+'\')"><i class="fa fa-trash"></i></a>'
	    	           +'<a target="_blank" class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="gestionePratiche.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>'
	    	           +'</div></div></li>';
	       		}
	    		}else{
	    			 html= html + '<li class="list-group-item"> Nessun file allegato alla pratica! </li>';
	    		}
	    		
	    		$("#tab_allegati").html(html+"</ul>");
	    	}
	    	
	    	
	    	
	    });
	    
	    
	    
	    
	    $('#fileupload').fileupload({
	    	 url: "gestionePratiche.do?action=upload_allegato&id_pratica="+$('#id_pratica_allegato').val(),
	    	 dataType: 'json',	 
	    	 getNumberOfFiles: function () {
	    	     return this.filesContainer.children()
	    	         .not('.processing').length;
	    	 }, 
	    	 start: function(e){
	    	 	pleaseWaitDiv = $('#pleaseWaitDialog');
	    	 	pleaseWaitDiv.modal();
	    	 	
	    	 },
	    	 singleFileUploads: false,
	    	  add: function(e, data) {
	    	     var uploadErrors = [];
	    	     var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx)$/i;
	    	   
	    	     for(var i =0; i< data.originalFiles.length; i++){
	    	    	 if(data.originalFiles[i]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
	    		         uploadErrors.push('Tipo del File '+data.originalFiles[i]['name']+' non accettato. ');
	    		         break;
	    		     }	 
	    	    	 if(data.originalFiles[i]['size'] > 50000000) {
	    		         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 50mb');
	    		         break;
	    		     }
	    	     }	     		     
	    	     if(uploadErrors.length > 0) {
	    	     	$('#myModalErrorContent').html(uploadErrors.join("\n"));
	    	 			$('#myModalError').removeClass();
	    	 			$('#myModalError').addClass("modal modal-danger");
	    	 			$('#myModalError').modal('show');
	    	     } 
	    	     else {
	    	         data.submit();
	    	     }  
	    	 },
	    	
	    	 done: function (e, data) {
	    	 		
	    	 	pleaseWaitDiv.modal('hide');
	    	 	
	    	 	if(data.result.success){
	    	 		//$('#myModalAllegatiArchivio').modal('hide');
	    	 		$('#myModalAllegati').hide();
	    	 		$('#myModalErrorContent').html(data.result.messaggio);
	    			$('#myModalError').removeClass();
	    			$('#myModalError').addClass("modal modal-success");
	    			$('#myModalError').modal('show');
	    			
	    			
	    			$('#myModalError').on("hidden.bs.modal",function(){
	    				
	    		 	
	    				 dataString ="action=lista_allegati&id_pratica="+ id_pratica;
	    				    exploreModal("gestionePratiche.do",dataString,null,function(datab,textStatusb){
	    				    	
	    				    	var result = JSON.parse(datab);
	    				    	
	    				    	if(result.success){
	    				    		
	    				    		var lista_allegati = result.lista_allegati;
	    				    		var html = '<ul class="list-group list-group-bordered">';
	    				    		if(lista_allegati.length>0){
	    				    			for(var i= 0; i<lista_allegati.length;i++){
	    				       			 html= html + '<li class="list-group-item"><div class="row"><div class="col-xs-10"><b>'+lista_allegati[i].nomeFile+'</b></div><div class="col-xs-2 pull-right">' 	           
	    				                +'<a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegatoModal(\''+lista_allegati[i].id+'\')"><i class="fa fa-trash"></i></a>'
	    				    	           +'<a target="_blank" class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="gestionePratiche.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>'
	    				    	           +'</div></div></li>';
	    				       		}
	    				    		}else{
	    				    			 html= html + '<li class="list-group-item"> Nessun file allegato alla pratica! </li>';
	    				    		}
	    				    		
	    				    		$("#tab_allegati").html(html+"</ul>");
	    				    	}
	    				    	
	    				    	
	    				    	
	    				    });
	    				  
	    				   
	    			});
	    	 	}else{		 			
	    	 			$('#myModalErrorContent').html(data.result.messaggio);
	    	 			$('#myModalError').removeClass();
	    	 			$('#myModalError').addClass("modal modal-danger");
	    	 			$('#report_button').show();
	    	 			$('#visualizza_report').show();
	    	 			$('#myModalError').modal('show');
	    	 		}
	    	 },
	    	 fail: function (e, data) {
	    	 	pleaseWaitDiv.modal('hide');

	    	     $('#myModalErrorContent').html(errorMsg);
	    	     
	    	 		$('#myModalError').removeClass();
	    	 		$('#myModalError').addClass("modal modal-danger");
	    	 		$('#report_button').show();
	    	 		$('#visualizza_report').show();
	    	 		$('#myModalError').modal('show');

	    	 		$('#progress .progress-bar').css(
	    	                'width',
	    	                '0%'
	    	            );
	    	 },
	    	 progressall: function (e, data) {
	    	     var progress = parseInt(data.loaded / data.total * 100, 10);
	    	     $('#progress .progress-bar').css(
	    	         'width',
	    	         progress + '%'
	    	     );

	    	 }
	    });		
	    
	    
	    $('#myModalArchivio').modal();
	    
 }
 
  </script>
  
</jsp:attribute> 
</t:layout>

