package it.CAF.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.CAF.BO.GestioneModuliBO;
import it.CAF.BO.GestionePraticheBO;
import it.CAF.BO.GestioneTemplateBO;
import it.CAF.DAO.SessionFactoryDAO;
import it.CAF.DTO.ModuloDTO;
import it.CAF.DTO.PraticaDTO;
import it.CAF.DTO.TemplateDTO;
import it.CAF.DTO.TipoPraticaDTO;
import it.CAF.Exception.CAFException;
import it.CAF.Util.Costanti;
import it.CAF.Util.Utility;

/**
 * Servlet implementation class GestioneTemplate
 */
@WebServlet("/gestioneTemplate.do")
public class GestioneTemplate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestioneTemplate.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneTemplate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String fullPath = request.getServletContext().getRealPath("") + File.separator + "WEB-INF\\log4j.properties";
	        
	        PropertyConfigurator.configure(fullPath);
		
		Session session = SessionFactoryDAO.get().openSession();
		session.beginTransaction();
		
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		
		try {
			
			String action = request.getParameter("action");
			
			
			if(action.equals("lista")) {
				
				ArrayList<TemplateDTO> listaTemplate = GestioneTemplateBO.getListaTemplate(session);
				ArrayList<TipoPraticaDTO> listaTipiPratica = GestionePraticheBO.getListaTipiPratiche(session);
				ArrayList<ModuloDTO> listaModuli = GestioneModuliBO.getListaModuli(session);
				
				request.getSession().setAttribute("listaTemplate", listaTemplate);
				request.getSession().setAttribute("listaTipiPratica", listaTipiPratica);
				request.getSession().setAttribute("listaModuli", listaModuli);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaTemplate.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuovo_template")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        
				FileItem fileItem = null;
			
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        
		        
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     
	            	 }else
	            	 {
	      
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String moduli = request.getParameter("moduli");
		        String descrizione = ret.get("descrizione");
		        String tipo_pratica = ret.get("tipo_pratica");	
		        String addIsee = ret.get("add_isee");	
		        
		        String[] idModuli = moduli.split(",");
		        
		        if(addIsee==null) {
		        	addIsee = "0";
		        }
		        
		       
		       
		        TemplateDTO template = new TemplateDTO();
		        template.setDescrizione(descrizione);
		        template.setTipo(new TipoPraticaDTO(Integer.parseInt(tipo_pratica), ""));
		        template.setAddIsee(Integer.parseInt(addIsee));
		        
		        for (int i = 0; i < idModuli.length; i++) {
					String id = idModuli[i];
					ModuloDTO modulo = GestioneModuliBO.getModulo(Integer.parseInt(id), session);
					template.getListaModuli().add(modulo);
				}
		        
		        
		        session.save(template);
		      
		        myObj.addProperty("success", true);
		        myObj.addProperty("messaggio", "Salvato con successo");
		    
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
		        
			}
			
			else if(action.equals("elimina_template")) {
				
				String idTemplate = request.getParameter("id_template");
				
				TemplateDTO template = GestioneTemplateBO.getTemplate(Integer.parseInt(idTemplate), session);
				template.setDisabilitato(1);
				
				session.update(template);
				
				 myObj.addProperty("success", true);
			    
			     myObj.addProperty("messaggio", "Eliminato con successo");
			     PrintWriter out = response.getWriter();
			        
			     out.print(myObj);
				
			}
			
			else if(action.equals("download_file")) {
				
				String idTemplate = request.getParameter("id_template");				
				
				TemplateDTO template = GestioneTemplateBO.getTemplate(Integer.parseInt(idTemplate), session);
				String filename = GestioneTemplateBO.getFileTemplate(template, session);
				
				response.setContentType("application/pdf");
				
				String path = Costanti.PATH_FOLDER+"Temp\\Template\\"+filename;
				
				Utility.downloadFile(path, response.getOutputStream());
				
			}
			
			
			session.getTransaction().commit();
			session.close();
			
		}catch(Exception e) {
			
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = CAFException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",CAFException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}
		}
	}

}
