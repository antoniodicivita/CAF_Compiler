<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%-- <%@tag import="it.portalECI.DTO.UtenteDTO"%> --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% 
	/* UtenteDTO user =(UtenteDTO)request.getSession().getAttribute("userObj"); */
%>


<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

	<!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

    	<!-- Sidebar Menu -->
      	<ul class="sidebar-menu">
	        <li class="header">Menu</li>
        
    	     <li class="treeview">
    	
        	 	<a href="gestioneAnagrafiche.do?action=lista">
        	 		<i class="fa fa-link"></i> 
        	 		<span>ANAGRAFICHE</span>
            		<span class="pull-right-container">
              			<i class="fa fa-angle-left pull-right"></i>
            		</span>
          		</a>
          		
          			
        	</li>
        	
        	<li class="treeview">
    	
        	 	<a href="gestionePratiche.do?action=lista">
        	 		<i class="fa fa-link"></i> 
        	 		<span>PRATICHE</span>
            		<span class="pull-right-container">
              			<i class="fa fa-angle-left pull-right"></i>
            		</span>
          		</a>
          		
          			
        	</li>
        	<li class="treeview">
    	
        	 	<a href="gestioneModuli.do?action=lista">
        	 		<i class="fa fa-link"></i> 
        	 		<span>MODULI</span>
            		<span class="pull-right-container">
              			<i class="fa fa-angle-left pull-right"></i>
            		</span>
          		</a>
          		
          			
        	</li>
        	<li class="treeview">
    	
        	 	<a href="gestioneTemplate.do?action=lista">
        	 		<i class="fa fa-link"></i> 
        	 		<span>TEMPLATE</span>
            		<span class="pull-right-container">
              			<i class="fa fa-angle-left pull-right"></i>
            		</span>
          		</a>
          		
          			
        	</li>
        	
        	 	
        	  	
        	
        		      		
      	</ul>
      	<!-- /.sidebar-menu -->
      	
      	
      	
      	 
    </section>
    <!-- /.sidebar -->
 </aside>