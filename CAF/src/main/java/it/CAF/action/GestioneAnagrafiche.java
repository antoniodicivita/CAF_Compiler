package it.CAF.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.tomcat.util.http.fileupload.FileItem;
//import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
//import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
//import org.apache.tomcat.util.http.fileupload.*;
//import org.apache.tomcat.util.http.fileupload.FileItem;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
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
import it.CAF.DTO.TipoDocumentoIdentitaDTO;
import it.CAF.Exception.CAFException;
import it.CAF.Util.Costanti;
import it.CAF.Util.Utility;

/**
 * Servlet implementation class ListaAnagrafiche
 */
@WebServlet("/gestioneAnagrafiche.do")
public class GestioneAnagrafiche extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	static final Logger logger = Logger.getLogger(GestioneAnagrafiche.class);
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAnagrafiche() {
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
		
		 String log4jConfigFile = request.getServletContext().getInitParameter("log4j-config-location");
	        String fullPath = request.getServletContext().getRealPath("") + File.separator + "WEB-INF\\log4j.properties";
	        
	        PropertyConfigurator.configure(fullPath);
		
		//if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session = SessionFactoryDAO.get().openSession();
		session.beginTransaction();
		
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		
		try {
			
			String action = request.getParameter("action");
			
			if(action.equals("lista")) {
				
				ArrayList<AnagraficaDTO> listaAnagrafiche = GestioneAnagraficheBO.getListaAnagrafiche(session);
				
				request.getSession().setAttribute("listaAnagrafiche", listaAnagrafiche);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAnagrafiche.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuova_anagrafica")) {
				
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
		
		        String nome = ret.get("nome");
		        String cognome = ret.get("cognome");		        	
		        String cf = ret.get("cf");	
				String dataNascita = ret.get("data_nascita");				
				String luogoNascita = ret.get("luogo_nascita");
				String tipoVia = ret.get("tipo_via");
				String indirizzo = ret.get("indirizzo");
				String civico = ret.get("civico");
				String comune = ret.get("comune");
				String provincia = ret.get("provincia");
				String cap = ret.get("cap");
				String stato = ret.get("stato");
				String telefono = ret.get("telefono");
				String email = ret.get("email");
				String tipoDocumento = ret.get("tipo_documento");
				String numero = ret.get("numero");
				String dataRilascio = ret.get("data_rilascio");
				String dataScadenza = ret.get("data_scadenza");
				String rilasciatoDa = ret.get("rilasciato_da");
				String provinciaNascita = ret.get("provincia_nascita");
				String cittadinanza = ret.get("cittadinanza");
				String statoNascita = ret.get("stato_nascita");
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				
				DocumentoIdentitaDTO documento = new DocumentoIdentitaDTO();
				documento.setTipo(new TipoDocumentoIdentitaDTO(Integer.parseInt(tipoDocumento), ""));
				documento.setNumero(numero);
				documento.setDataRilascio(sdf.parse(dataRilascio));
				documento.setDataScadenza(sdf.parse(dataScadenza));
				documento.setRilasciatoDa(rilasciatoDa);
				documento.setNomeFile(fileItem.getName());

				session.save(documento);

				AnagraficaDTO anagrafica = new AnagraficaDTO();
				
				anagrafica.setNome(nome);
				anagrafica.setCognome(cognome);
				anagrafica.setCf(cf);
				anagrafica.setNominativo(nome +" "+cognome);
				anagrafica.setDataNascita(sdf.parse(dataNascita));
				anagrafica.setLuogoNascita(luogoNascita);
				anagrafica.setTipoVia(tipoVia.toUpperCase());
				anagrafica.setIndirizzo(indirizzo.toUpperCase());
				anagrafica.setCivico(civico);
				anagrafica.setComune(comune);
				anagrafica.setProvincia(provincia);
				anagrafica.setStato(stato);
				anagrafica.setTelefono(telefono);
				anagrafica.setEmail(email);
				anagrafica.setCap(cap);
				anagrafica.setProvinciaNascita(provinciaNascita);
				anagrafica.setCittadinanza(cittadinanza);
				anagrafica.setStatoNascita(statoNascita);
								
				anagrafica.setDocumento(documento);
				
				
				session.save(anagrafica);
				SimpleDateFormat df = new SimpleDateFormat("ddMMyyyyHHmmss");
				
				String timestamp = df.format(new Timestamp(System.currentTimeMillis()));
				
				String path = Costanti.PATH_FOLDER + "DocIdentita\\"+anagrafica.getId()+"\\";
				
				Utility.saveFile(fileItem,path  ,fileItem.getName());
				
				
				
				
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				
				out.print(myObj);
				
			} else if(action.equals("modifica_anagrafica")) {
				
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
		
		        String id = ret.get("id_anagrafica");
		        String nome = ret.get("nome_mod");
		        String cognome = ret.get("cognome_mod");	
		        
		        String cf = ret.get("cf_mod");	
				String dataNascita = ret.get("data_nascita_mod");				
				String luogoNascita = ret.get("luogo_nascita_mod");
				String tipoVia = ret.get("tipo_via_mod");
				String indirizzo = ret.get("indirizzo_mod");
				String civico = ret.get("civico_mod");
				String comune = ret.get("comune_mod");
				String provincia = ret.get("provincia_mod");
				String cap = ret.get("cap_mod");
				String stato = ret.get("stato_mod");
				String telefono = ret.get("telefono_mod");
				String email = ret.get("email_mod");
				String tipoDocumento = ret.get("tipo_documento_mod");
				String numero = ret.get("numero_mod");
				String dataRilascio = ret.get("data_rilascio_mod");
				String dataScadenza = ret.get("data_scadenza_mod");
				String rilasciatoDa = ret.get("rilasciato_da_mod");
				String provinciaNascita = ret.get("provincia_nascita_mod");
				String cittadinanza = ret.get("cittadinanza_mod");
				String statoNascita = ret.get("stato_nascita_mod");
				
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				
			
				AnagraficaDTO anagrafica = GestioneAnagraficheBO.getAnagrafica(Integer.parseInt(id), session);
				
				anagrafica.setNome(nome);
				anagrafica.setCognome(cognome);
				anagrafica.setCf(cf);
				anagrafica.setNominativo(nome +" "+cognome);
				anagrafica.setDataNascita(sdf.parse(dataNascita));
				anagrafica.setLuogoNascita(luogoNascita);
				anagrafica.setTipoVia(tipoVia.toUpperCase());
				anagrafica.setIndirizzo(indirizzo.toUpperCase());
				anagrafica.setCivico(civico);
				anagrafica.setComune(comune);
				anagrafica.setProvincia(provincia);
				anagrafica.setStato(stato);
				anagrafica.setTelefono(telefono);
				anagrafica.setEmail(email);
				anagrafica.setCap(cap);
				anagrafica.setProvinciaNascita(provinciaNascita);
				anagrafica.setCittadinanza(cittadinanza);
				anagrafica.setStatoNascita(statoNascita);
								
								
				DocumentoIdentitaDTO documento = anagrafica.getDocumento();
				documento.setTipo(new TipoDocumentoIdentitaDTO(Integer.parseInt(tipoDocumento), ""));
				documento.setNumero(numero);
				documento.setDataRilascio(sdf.parse(dataRilascio));
				documento.setDataScadenza(sdf.parse(dataScadenza));
				documento.setRilasciatoDa(rilasciatoDa);	
				
				
				session.save(documento);
				session.save(anagrafica);
				SimpleDateFormat df = new SimpleDateFormat("ddMMyyyyHHmmss");
				
				String timestamp = df.format(new Timestamp(System.currentTimeMillis()));
				
				if(fileItem.getName()!=null && !fileItem.getName().equals("")) {
				
				String path = Costanti.PATH_FOLDER + "DocIdentita\\"+anagrafica.getId()+"\\";
				documento.setNomeFile(fileItem.getName());
				
				Utility.saveFile(fileItem,path  ,fileItem.getName());				
				
				}
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				
				out.print(myObj);
				
			}
			
			else if(action.equals("elimina_anagrafica")) {
				
				String idAnagrafica = request.getParameter("id_anagrafica");
				AnagraficaDTO anagrafica = GestioneAnagraficheBO.getAnagrafica(Integer.parseInt(idAnagrafica), session);
				
				anagrafica.setDisabilitato(1);
				
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				
				out.print(myObj);
			}
			
			else if(action.equals("download_file")) {
				
				String idAnagrafica = request.getParameter("id_anagrafica");
				String idDoc = request.getParameter("id_documento");
				String isee = request.getParameter("isee");
				
				DocumentoIdentitaDTO documento = null;
				String path = "";
				
				if(isee==null || isee.equals("")) {
					documento = GestioneAnagraficheBO.getDocumento(Integer.parseInt(idDoc), session);
					
					path = Costanti.PATH_FOLDER + "DocIdentita\\"+idAnagrafica+"\\"+documento.getNomeFile();
				}else {
					AnagraficaDTO anagrafica = GestioneAnagraficheBO.getAnagrafica(Integer.parseInt(idAnagrafica), session);
					path = Costanti.PATH_FOLDER + "ISEE\\"+idAnagrafica+"\\"+anagrafica.getNomeFileIsee();
				}
				
				
				if((isee!=null && !isee.equals("")) || documento.getNomeFile().endsWith(".pdf") || documento.getNomeFile().endsWith(".PDF") ) {
					
					response.setContentType("application/pdf");
				}else {
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ documento.getNomeFile());
				}
			
				
				
				Utility.downloadFile( path, response.getOutputStream());
				
			}
			
			else if(action.equals("upload_isee")) {
				
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
				String idAnagrafica = request.getParameter("isee_anagrafica_id");
				AnagraficaDTO anagrafica = GestioneAnagraficheBO.getAnagrafica(Integer.parseInt(idAnagrafica), session);
				
			
				String path = Costanti.PATH_FOLDER + "\\ISEE\\"+anagrafica.getId()+"\\";
		        
		        Utility.saveFile(fileItem, path, filename);
		        
		        anagrafica.setNomeFileIsee(filename);
		        session.update(anagrafica);
		        
		        myObj.addProperty("success", true);
		        myObj.addProperty("messaggio", "ISEE caricato con successo");
		    
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
