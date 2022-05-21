package it.CAF.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

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

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.CAF.BO.GestioneAnagraficheBO;
import it.CAF.BO.GestioneModuliBO;
import it.CAF.BO.GestionePraticheBO;
import it.CAF.BO.GestioneTemplateBO;
import it.CAF.DAO.GestionePraticheDAO;
import it.CAF.DAO.SessionFactoryDAO;
import it.CAF.DTO.AllegatoDTO;
import it.CAF.DTO.AnagraficaDTO;
import it.CAF.DTO.EmailConfigDTO;
import it.CAF.DTO.EmailDTO;
import it.CAF.DTO.ModuloDTO;
import it.CAF.DTO.PraticaDTO;
import it.CAF.DTO.TemplateDTO;
import it.CAF.DTO.TipoPraticaDTO;
import it.CAF.Exception.CAFException;
import it.CAF.Util.Costanti;
import it.CAF.Util.Utility;

/**
 * Servlet implementation class GestionePratiche
 */
@WebServlet("/gestionePratiche.do")
public class GestionePratiche extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static final Logger logger = Logger.getLogger(GestionePratiche.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePratiche() {
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
				
				ArrayList<PraticaDTO> listaPratiche = GestionePraticheBO.getListaPratiche(session);
				ArrayList<TemplateDTO> listaTemplate = GestioneTemplateBO.getListaTemplate(session);
				ArrayList<TipoPraticaDTO> listaTipiPratica = GestionePraticheBO.getListaTipiPratiche(session);
				ArrayList<AnagraficaDTO> listaAnagrafiche = GestioneAnagraficheBO.getListaAnagrafiche(session);
				
				EmailConfigDTO emailConfig = GestionePraticheDAO.getEmailConfig(session);
				
				request.getSession().setAttribute("listaTemplate", listaTemplate);
				request.getSession().setAttribute("listaTipiPratica", listaTipiPratica);
				request.getSession().setAttribute("listaPratiche", listaPratiche);
				request.getSession().setAttribute("listaAnagrafiche", listaAnagrafiche);
				request.getSession().setAttribute("listaAnagrafiche", listaAnagrafiche);
				request.getSession().setAttribute("emailConfig", emailConfig);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPratiche.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuova_pratica")) {
				
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
		
		        
		        String descrizione = ret.get("descrizione");
		        String tipo_pratica = ret.get("tipo_pratica");	
		        String id_template = ret.get("template");	
		        String id_anagrafica = ret.get("anagrafica");
		        
		   
		       
		        PraticaDTO pratica = new PraticaDTO();
		        pratica.setNote(descrizione);
		        pratica.setTipo(new TipoPraticaDTO(Integer.parseInt(tipo_pratica), ""));
		        pratica.setDataCreazione(new Date());
		        
		        TemplateDTO template = GestioneTemplateBO.getTemplate(Integer.parseInt(id_template), session);
		        pratica.setTemplate(template);
		        
		        AnagraficaDTO anagrafica = GestioneAnagraficheBO.getAnagrafica(Integer.parseInt(id_anagrafica), session);
		       
		        pratica.setAnagrafica(anagrafica);
		        
		        session.save(pratica);
		      
		        myObj.addProperty("success", true);
		        myObj.addProperty("messaggio", "Salvato con successo");
		    
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
		        
			}
			
			else if(action.equals("download_file")) {
				
				String idPratica = request.getParameter("id_pratica");
				String scansione = request.getParameter("scansione");
				
				
				PraticaDTO pratica = GestionePraticheBO.getPratica(Integer.parseInt(idPratica), session);
				
				GestionePraticheBO.getFilePratica(pratica, session);
				
				response.setContentType("application/pdf");
				
				String path = Costanti.PATH_FOLDER+"Pratiche\\"+pratica.getId()+"\\"+pratica.getNomeFile();
				
				if(scansione!=null && !scansione.equals("")) {
					path = Costanti.PATH_FOLDER+"Pratiche\\"+pratica.getId()+"\\Scansione\\"+pratica.getNomeFileScansione();
				}
				
				
				Utility.downloadFile(path, response.getOutputStream());
				
			}
			
			else if(action.equals("elimina_pratica")) {
				
				String idPratica = request.getParameter("id_pratica");
				
				PraticaDTO pratica = GestionePraticheBO.getPratica(Integer.parseInt(idPratica), session);
				pratica.setDisabilitato(1);
				
				session.update(pratica);
				
				 myObj.addProperty("success", true);
			    
			     myObj.addProperty("messaggio", "Eliminato con successo");
			     PrintWriter out = response.getWriter();
			        
			     out.print(myObj);
				
			}
			
			else if(action.equals("upload_scansione")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        
		        
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	      
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
				String idPratica = request.getParameter("scansione_pratica_id");
				PraticaDTO pratica = GestionePraticheBO.getPratica(Integer.parseInt(idPratica), session);
				
			
				String path = Costanti.PATH_FOLDER + "\\Pratiche\\"+pratica.getId()+"\\Scansione\\";
		        
		        Utility.saveFile(fileItem, path, filename);
		        
		        pratica.setNomeFileScansione(filename);
		        session.update(pratica);
		        
		        myObj.addProperty("success", true);
		        myObj.addProperty("messaggio", "Scansione caricata con successo");
		    
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
				
			}
			
			else if(action.equals("invia_pratica")) {
								
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
		
		        String idPratica = request.getParameter("email_pratica_id");
		        String destinatario = ret.get("destinatario");
		        String messaggio = ret.get("messaggio");	
		        String oggetto = ret.get("oggetto");
		        String idAllegati = ret.get("id_allegati");
		        
		        		        
		        EmailDTO email = new EmailDTO();
				
				email.setDestinatario(destinatario);
				email.setMessaggio(messaggio);
				email.setIdPratica(Integer.parseInt(idPratica));
				email.setOggetto(oggetto);
				email.setDataInvio(new Date());
				
				PraticaDTO pratica = GestionePraticheBO.getPratica(Integer.parseInt(idPratica), session);				
				EmailConfigDTO emailConfig = (EmailConfigDTO) request.getSession().getAttribute("emailConfig");
				String esito = GestionePraticheBO.sendEmailPratica(email, emailConfig, pratica, idAllegati, session);
				
				
				if(esito.equals("Email inviata con successo")) {
					myObj.addProperty("success", true);
					session.save(email);
				}else {
					myObj.addProperty("success", false);
				}
				
		        myObj.addProperty("messaggio", esito);
		    
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
				
			}
			
			else if(action.equals("lista_allegati")) {
				ajax = true;
				
				String idPratica = request.getParameter("id_pratica");
				
				ArrayList<AllegatoDTO> lista_allegati = GestionePraticheBO.getListaAllegati(idPratica, session);
				
				Gson g = new Gson();
				
				myObj.addProperty("success", true);
				myObj.add("lista_allegati", g.toJsonTree(lista_allegati));
				PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
				
			}
			
			else if(action.equals("upload_allegato")) {
				
				String idPratica = request.getParameter("id_pratica");
				PraticaDTO pratica = GestionePraticheBO.getPratica(Integer.parseInt(idPratica), session);
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				List<FileItem> items = uploadHandler.parseRequest(request);
				
				FileItem fileUploaded = null;
				for (FileItem item : items) {
					if (!item.isFormField()) {
 
						fileUploaded = item;
 
					}
					
					String path = Costanti.PATH_FOLDER + "\\Allegati\\"+idPratica+"\\";
					
					Utility.saveFile(fileUploaded, path, fileUploaded.getName());
					AllegatoDTO allegato = new AllegatoDTO();
					allegato.setNomeFile(fileUploaded.getName());
					allegato.setPratica(pratica);
					session.save(allegato);
				}
				
				 myObj.addProperty("success", true);
			     
			        myObj.addProperty("messaggio", "Allegati caricati con successo!");
			        PrintWriter out = response.getWriter();
			        
			        out.print(myObj);
			}
			else if(action.equals("download_allegato")) {
				
				String idAllegato = request.getParameter("id_allegato");				
				
				AllegatoDTO allegato = GestionePraticheBO.getAllegato(Integer.parseInt(idAllegato), session);
				
				
				response.setContentType("application/pdf");
				
				String path = Costanti.PATH_FOLDER+"Allegati\\"+allegato.getPratica().getId()+"\\"+allegato.getNomeFile();
				
				
				Utility.downloadFile(path, response.getOutputStream());
				
			}
			
			else if(action.equals("elimina_allegato")) {
				
				String idAllegato = request.getParameter("id_allegato");				
				
				AllegatoDTO allegato = GestionePraticheBO.getAllegato(Integer.parseInt(idAllegato), session);
				
				allegato.setDisabilitato(1);
				
				session.update(allegato);
				
				 myObj.addProperty("success", true);
			    
			     myObj.addProperty("messaggio", "Eliminato con successo");
			     PrintWriter out = response.getWriter();
			        
			     out.print(myObj);
				
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
