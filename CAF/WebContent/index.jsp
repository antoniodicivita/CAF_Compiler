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

   <div class="row">
<div class="col-xs-6">
  <a href="gestioneAnagrafiche.do?action=lista" class="small-box-footer" > 
 <div class="small-box bg-success" style="background-color:#00a65a">
  <div class="inner">
    <h3 style="color:#ffffff">ANAGRAFICHE</h3>
    <p style="color:#ffffff">Anagrafiche</p>
  </div>
  <div class="icon">
    <i class="fa fa-user-plus"></i>
  </div>

  <span style="color:#ffffff">Vai alle Anagrafiche</span>   <i class="fa fa-arrow-circle-right" style="color:#ffffff"></i>

</div>
   </a>
 
<!--  
 <div class="small-box bg-primary">
  <div class="inner">
    <h3>150</h3>
    <p>New Orders</p>
  </div>
  <div class="icon">
    <i class="fa fa-shopping-cart"></i>
  </div>
  <a href="#" class="small-box-footer">
    More info <i class="fa fa-arrow-circle-right"></i>
  </a>
</div> -->
</div>


<div class="col-xs-6">
  <a href="gestionePratiche.do?action=lista" class="small-box-footer">
<div class="small-box bg-danger" style="background-color:#ff5050">
  <div class="inner">
    <h3 style="color:#ffffff">PRATICHE</h3>
   <p style="color:#ffffff">Pratiche</p>
  </div>
  <div class="icon">
    <i class="fa fa-file-text"></i>
  </div>

   <span style="color:#ffffff"> Vai alle pratiche</span> <i class="fa fa-arrow-circle-right" style="color:#ffffff"></i>

</div>
  </a>
</div>
</div>
<div class="row">

<div class="col-xs-6">
  <a href="gestioneModuli.do?action=lista" class="small-box-footer">
<div class="small-box bg-primary">
  <div class="inner">
    <h3>MODULI</h3>
      <p>Moduli</p>
  </div>
  <div class="icon">
    <i class="fa fa-file"></i>
  </div>

  <span style="color:#ffffff">    Vai ai moduli</span> <i class="fa fa-arrow-circle-right"></i>

</div>
  </a>
</div>


<div class="col-xs-6">
<a href="gestioneTemplate.do?action=lista" class="small-box-footer">
<div class="small-box bg-info" style="background-color:#f39c12">
  <div class="inner">
    <h3 style="color:#ffffff">TEMPLATE</h3>
   <p style="color:#ffffff">Template</p>
  </div>
  <div class="icon">
    <i class="fa fa-wrench"></i>
  </div>
  
   <span style="color:#ffffff">   Vai ai template pratiche </span><i class="fa fa-arrow-circle-right" style="color:#ffffff"></i>
  
</div>
</a>
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




 
  </script>
  
</jsp:attribute> 
</t:layout>

