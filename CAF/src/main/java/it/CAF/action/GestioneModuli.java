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

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.CAF.BO.GestioneAnagraficheBO;
import it.CAF.BO.GestioneModuliBO;
import it.CAF.DAO.SessionFactoryDAO;
import it.CAF.DTO.AnagraficaDTO;
import it.CAF.DTO.DocumentoIdentitaDTO;
import it.CAF.DTO.ModuloDTO;
import it.CAF.Exception.CAFException;
import it.CAF.Util.Costanti;
import it.CAF.Util.Utility;

/**
 * Servlet implementation class GestioneModelli
 */
@WebServlet("/gestioneModuli.do")
public class GestioneModuli extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(GestioneModuli.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneModuli() {
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
				
				ArrayList<ModuloDTO> listaModuli = GestioneModuliBO.getListaModuli(session);
				
				String listaCostanti = Utility.getListaCostanti();
				
								
				request.getSession().setAttribute("listaModuli", listaModuli);
				request.getSession().setAttribute("listaCostanti", listaCostanti);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaModuli.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("nuovo_modulo")) {
				
				ajax = true;
				
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        
				FileItem fileItem = null;
			
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        String filename = null;
		        
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	            	 }else
	            	 {
	      
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String descrizione = ret.get("descrizione");
		        String note = ret.get("note");		
		        String numeroCampi = ret.get("numero_campi");
		        //String filename = ret.get("filename");
		        
		        Map<String, String> map = new HashMap<String, String>();
		        
		        if(numeroCampi!=null && !numeroCampi.equals("")) {
		        	for(int i = 0; i<Integer.parseInt(numeroCampi); i++) {
		        		if(ret.get("campo_corretto_"+i).equals("")) {
		        			map.put(ret.get("campo_"+i), ret.get("campo_"+i));
		        		}else {
		        			map.put(ret.get("campo_"+i), ret.get("campo_corretto_"+i));
		        		}
		        		
		        	}
		        }
		        
		        
		        ModuloDTO modulo = new ModuloDTO();
		        modulo.setDescrizione(descrizione);
		        modulo.setNote(note);
		        modulo.setNomeFile(filename);
		        
		        session.save(modulo);
		        
		        String pathOriginali = Costanti.PATH_FOLDER + "\\Moduli\\Originali\\"+modulo.getId()+"\\";
		        String pathCorretti = Costanti.PATH_FOLDER + "\\Moduli\\Corretti\\"+modulo.getId()+"\\";
		        
		        File f = new File(pathCorretti);
		        f.mkdirs();
		        File f2 = new File(pathOriginali);
		        f2.mkdirs();
		       
		        Utility.saveFile(fileItem, pathOriginali, filename);
		        
		        GestioneModuliBO.correggiCampi(pathOriginali,pathCorretti, filename, session);        

		        
		        myObj.addProperty("success", true);
		        myObj.addProperty("messaggio", "Salvato con successo");
		    
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
		        
				
			}
			
			else if(action.equals("modifica_modulo")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        
				FileItem fileItem = null;
			
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        String filename = null;
		        
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	            	 }else
	            	 {
	      
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String idModulo = ret.get("id_modulo");
		        String descrizione = ret.get("descrizione_mod");
		        String note = ret.get("note_mod");		
//		        String numeroCampi = ret.get("numero_campi");
		        //String filename = ret.get("filename");
		        
//		        Map<String, String> map = new HashMap<String, String>();
//		        
//		        if(numeroCampi!=null && !numeroCampi.equals("")) {
//		        	for(int i = 0; i<Integer.parseInt(numeroCampi); i++) {
//		        		if(ret.get("campo_corretto_"+i).equals("")) {
//		        			map.put(ret.get("campo_"+i), ret.get("campo_"+i));
//		        		}else {
//		        			map.put(ret.get("campo_"+i), ret.get("campo_corretto_"+i));
//		        		}
//		        		
//		        	}
//		        }
//		        
		        
		        ModuloDTO modulo = GestioneModuliBO.getModulo(Integer.parseInt(idModulo), session);
		        modulo.setDescrizione(descrizione);
		        modulo.setNote(note);
		        
		        if(filename!=null && !filename.equals("")) {
		        	 modulo.setNomeFile(filename);
		        	 String pathOriginali = Costanti.PATH_FOLDER + "\\Moduli\\Originali\\"+modulo.getId()+"\\";
				        String pathCorretti = Costanti.PATH_FOLDER + "\\Moduli\\Corretti\\"+modulo.getId()+"\\";
				        
				        File f = new File(pathCorretti);
				        f.mkdirs();
				        File f2 = new File(pathOriginali);
				        f2.mkdirs();
				       
				        Utility.saveFile(fileItem, pathOriginali, filename);
				        
				        GestioneModuliBO.correggiCampi(pathOriginali,pathCorretti, filename, session);    
		        }
		       
		        
		        session.update(modulo);
		        
		           

		        
		        myObj.addProperty("success", true);
		        myObj.addProperty("messaggio", "Salvato con successo");
		    
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
		        
				
			}
			
			else if(action.equals("upload_modulo")) {
				
				PrintWriter writer = response.getWriter();
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				List<FileItem> items = uploadHandler.parseRequest(request);
				
				FileItem fileUploaded = null;
				for (FileItem item : items) {
					if (!item.isFormField()) {
 
						fileUploaded = item;
 
					}
			
				}
			
				String path = Costanti.PATH_FOLDER + "\\Temp\\";
		        
		        Utility.saveFile(fileUploaded, path, fileUploaded.getName());
		        
		        ArrayList<String> listaCampi = GestioneModuliBO.getListaCampiModuli(path, fileUploaded.getName(), session);
		        
		        Gson g = new Gson();
		        
		        myObj.addProperty("success", true);
		        myObj.add("lista_campi", g.toJsonTree(listaCampi));
		        myObj.addProperty("filename", fileUploaded.getName());
		    	request.getSession().setAttribute("filename", fileUploaded.getName());
		        PrintWriter out = response.getWriter();
		        
		        out.print(myObj);
				
			}
			else if(action.equals("elimina_modulo")) {
				
				String idModulo = request.getParameter("id_modulo");
				
				ModuloDTO modulo = GestioneModuliBO.getModulo(Integer.parseInt(idModulo), session);
				modulo.setDisabilitato(1);
				
				session.update(modulo);
				
				 myObj.addProperty("success", true);
			    
			     myObj.addProperty("messaggio", "Eliminato con successo");
			     PrintWriter out = response.getWriter();
			        
			     out.print(myObj);
				
			}
			
			else if(action.equals("download_file")) {
				
				String idModulo = request.getParameter("id_modulo");
				
				ModuloDTO modulo = GestioneModuliBO.getModulo(Integer.parseInt(idModulo), session);
				
				
				String path = Costanti.PATH_FOLDER + "Moduli\\Corretti\\"+modulo.getId()+"\\"+modulo.getNomeFile();
			
				
				
				if(modulo.getNomeFile().endsWith(".pdf") || modulo.getNomeFile().endsWith(".PDF") ) {
					
					response.setContentType("application/pdf");
				}else {
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ modulo.getNomeFile());
				}
			
				
				
				Utility.downloadFile( path, response.getOutputStream());
				
			}
			
			else if(action.equals("download_file_temp")) {
				
				
				String filename = (String) request.getSession().getAttribute("filename");
				
				//String path = Costanti.PATH_FOLDER + "Moduli\\Corretti\\"+modulo.getId()+"\\"+modulo.getNomeFile();
				String path = Costanti.PATH_FOLDER + "\\Temp\\";
				
				
					response.setContentType("application/pdf");
					//response.setContentType("application/octet-stream");
			
				 GestioneModuliBO.getListaCampiFull(path, filename, session);
				
				Utility.downloadFile( path+"\\correzioni\\"+filename, response.getOutputStream());
				
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
