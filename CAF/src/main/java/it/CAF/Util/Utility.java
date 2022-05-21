package it.CAF.Util;

import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringEscapeUtils;

import org.apache.commons.fileupload.FileItem;

public class Utility {
	
	public static void saveFile(FileItem item, String path_folder, String filename) {

	 	
		File folder=new File(path_folder);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
	
		
		while(true)
		{
			File file=null;
			
			
			file = new File(path_folder+filename);					
			
				try {
					item.write(file);
					break;

				} catch (Exception e) 
				{

					e.printStackTrace();
					break;
				}
		}
	
	}
 
 public static void  downloadFile( String path, ServletOutputStream outp) throws Exception {
	 

	 File file = new File(path);
		
		FileInputStream fileIn = new FileInputStream(file);


		    byte[] outputByte = new byte[1];
		    
		    while(fileIn.read(outputByte, 0, 1) != -1)
		    {
		    	outp.write(outputByte, 0, 1);
		    }
		    				    
		 
		    fileIn.close();
		    outp.flush();
		    outp.close();
 }
 
 
// public static boolean validateSession(HttpServletRequest request,HttpServletResponse response, ServletContext servletContext) throws ServletException, IOException {
//
//		
//		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
//	
//		if (utente == null ) 
//		{
//			
//		RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/sessionDown.jsp");
//  	dispatcher.forward(request,response);
//  	
//  	return true;
//		}
//		
//		if(checkPermesso(request.getRequestURI().toString(),utente)==false)
//		{
//			request.getSession().setAttribute("exception", new STIException("Errore permesso Accesso"));
//			RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/notAuthorization.jsp");
//	     	dispatcher.forward(request,response);
//	     	
//	     	return true;
//		}
//		
//		
//		return false;
//	}

 
 
 public static String escapeHTML(String value) {
     return StringEscapeUtils.escapeHtml4(value);
 }
 
 public static String escapeJS(String value) {
     return StringEscapeUtils.escapeEcmaScript(StringEscapeUtils.escapeHtml4(value));
 }

public static String getListaCostanti() {
	
	String ret = "";
	
	
	ret += "NOME  = "+Costanti.NOME+"\n";
	ret += "COGNOME  = "+Costanti.COGNOME+"\n";
	ret += "CODICE_FISCALE  = "+Costanti.CODICE_FISCALE+"\n";
	ret += "NOMINATIVO  = "+Costanti.NOMINATIVO+"\n";
	ret += "DATA_NASCITA  = "+Costanti.DATA_NASCITA+"\n";
	ret += "LUOGO_NASCITA  = "+Costanti.LUOGO_NASCITA+"\n";
	ret += "PROVINCIA_NASCITA  = "+Costanti.PROVINCIA_NASCITA+"\n"; 
	ret += "INDIRIZZO_RESIDENZA  = "+Costanti.INDIRIZZO_RESIDENZA+"\n";
	ret += "COMUNE_RESIDENZA  = "+Costanti.COMUNE_RESIDENZA+"\n";
	ret += "CAP  = "+Costanti.CAP+"\n";
	ret += "CIVICO  = "+Costanti.CIVICO+"\n";
	ret += "PROVINCIA_RESIDENZA  = "+Costanti.PROVINCIA_RESIDENZA+"\n";
	ret += "STATO_RESIDENZA  = "+Costanti.STATO_RESIDENZA+"\n";
	ret += "STATO_NASCITA  = "+Costanti.STATO_NASCITA+"\n";
	ret += "CITTADINANZA  = "+Costanti.CITTADINANZA+"\n";
	ret += "TIPO_DOCUMENTO  = "+Costanti.TIPO_DOCUMENTO+"\n";
	ret += "NUMERO_DOCUMENTO  = "+Costanti.NUMERO_DOCUMENTO+"\n";
	ret += "RILASCIATO_DA  = "+Costanti.RILASCIATO_DA+"\n";
    ret += "DATA_SCADENZA  = "+Costanti.DATA_SCADENZA+"\n";
    ret += "DATA_RILASCIO  = "+Costanti.DATA_RILASCIO+"\n";
    ret += "TIPO_DOCUMENTO_MIO  = "+Costanti.TIPO_DOCUMENTO_MIO+"\n";
    ret += "NUMERO_DOCUMENTO_MIO  = "+Costanti.NUMERO_DOCUMENTO_MIO+"\n";
    ret += "DATA_RILASCIO_MIO  = "+Costanti.DATA_RILASCIO_MIO+"\n";
    ret += "DATA_SCADENZA_MIO  = "+Costanti.DATA_SCADENZA_MIO+"\n";
    ret += "RILASCIATO_DA_MIO  = "+Costanti.RILASCIATO_DA_MIO+"\n";
    ret += "NOMINATIVO_MIO  = "+Costanti.NOMINATIVO_MIO+"\n";
    ret += "LUOGO_NASCITA_MIO  = "+Costanti.LUOGO_NASCITA_MIO+"\n";
    ret += "PROVINCIA_NASCITA_MIO  = "+Costanti.PROVINCIA_NASCITA_MIO+"\n";
    ret += "DATA_NASCITA_MIO  = "+Costanti.DATA_NASCITA_MIO+"\n";
    ret += "COMUNE_MIO  = "+Costanti.COMUNE_MIO+"\n";
    ret += "INDIRIZZO_MIO  = "+Costanti.INDIRIZZO_MIO+"\n";
    ret += "CF_MIO  = "+Costanti.CF_MIO+"\n";
    

	
	return ret;
}
 
}
