package it.CAF.BO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.util.PDFMergerUtility;
import org.hibernate.Session;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.AcroFields.Item;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

import it.CAF.DAO.GestionePraticheDAO;
import it.CAF.DTO.AllegatoDTO;
import it.CAF.DTO.AnagraficaDTO;
import it.CAF.DTO.EmailConfigDTO;
import it.CAF.DTO.EmailDTO;
import it.CAF.DTO.ModuloDTO;
import it.CAF.DTO.PraticaDTO;
import it.CAF.DTO.TemplateDTO;
import it.CAF.DTO.TipoPraticaDTO;
import it.CAF.Util.Costanti;

public class GestionePraticheBO {

	public static ArrayList<PraticaDTO> getListaPratiche(Session session) {
		
		return GestionePraticheDAO.getListaPratiche(session);
	}

	public static ArrayList<TipoPraticaDTO> getListaTipiPratiche(Session session) {
		// TODO Auto-generated method stub
		return GestionePraticheDAO.getListaTipiPratiche(session);
	}

	public static PraticaDTO getPratica(int parseInt, Session session) {
		
		return GestionePraticheDAO.getPratica(parseInt, session);
	}

	public static void getFilePratica(PraticaDTO pratica, Session session) throws IOException, DocumentException, COSVisitorException {

		AnagraficaDTO anagrafica = pratica.getAnagrafica();
		TemplateDTO template = pratica.getTemplate();
		Set<ModuloDTO> listaModuli = template.getListaModuli();
		
		Iterator<ModuloDTO> iterator = listaModuli.iterator();
		
		PDFMergerUtility ut = new PDFMergerUtility();
		 SimpleDateFormat df = new SimpleDateFormat("ddMMyyyyHHmmss");
		 DateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		 ArrayList<String> listaFile = new ArrayList<String>();
		
		while(iterator.hasNext()) {
			
			ModuloDTO modulo = iterator.next();
			
			 PdfReader pdfReader = new PdfReader(Costanti.PATH_FOLDER+"Moduli\\Corretti\\"+modulo.getId()+"\\"+modulo.getNomeFile());
			 PdfReader.unethicalreading = true;
			 
				
				String timestamp = ""+System.currentTimeMillis();
			 
			    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream(Costanti.PATH_FOLDER+"Temp\\Pratiche\\"+timestamp+".pdf"));
			   
			    //AcroFields acroFields = pdfReader.getAcroFields();
			    AcroFields acroFields = stamper.getAcroFields();
			    
			    Map<String, Item> fields = acroFields.getFields();
			    Set<Entry<String, Item>> entrySet = fields.entrySet();
			    for (Entry<String, Item> entry : entrySet) {

			    	acroFields.setField(entry.getKey(), "");
			        
			    }
			    
			    AnagraficaDTO io = GestioneAnagraficheBO.getAnagrafica(28, session);
			    
			    acroFields.setField(Costanti.NOME, anagrafica.getNome());
			    acroFields.setField(Costanti.COGNOME, anagrafica.getCognome());
			    acroFields.setField(Costanti.CODICE_FISCALE, anagrafica.getCf());
			    acroFields.setField(Costanti.NOMINATIVO, anagrafica.getNominativo());
			    acroFields.setField(Costanti.DATA_NASCITA, ""+sdf.format(anagrafica.getDataNascita()));
			    acroFields.setField(Costanti.LUOGO_NASCITA, anagrafica.getLuogoNascita());
			    acroFields.setField(Costanti.PROVINCIA_NASCITA, anagrafica.getProvinciaNascita());
			    acroFields.setField(Costanti.INDIRIZZO_RESIDENZA, anagrafica.getIndirizzo());
			    acroFields.setField(Costanti.COMUNE_RESIDENZA, anagrafica.getComune());
			    acroFields.setField(Costanti.CAP, anagrafica.getCap());
			    acroFields.setField(Costanti.CIVICO, anagrafica.getCivico());
			    acroFields.setField(Costanti.PROVINCIA_RESIDENZA, anagrafica.getProvincia());
			    acroFields.setField(Costanti.STATO_RESIDENZA, anagrafica.getStato());
			    acroFields.setField(Costanti.STATO_NASCITA, anagrafica.getStatoNascita());
			    acroFields.setField(Costanti.CITTADINANZA, anagrafica.getCittadinanza());
			    acroFields.setField(Costanti.TIPO_DOCUMENTO, anagrafica.getDocumento().getTipo().getDescrizione());
			    acroFields.setField(Costanti.NUMERO_DOCUMENTO, anagrafica.getDocumento().getNumero());
			    acroFields.setField(Costanti.DATA_RILASCIO, sdf.format(anagrafica.getDocumento().getDataRilascio())+"");
			    acroFields.setField(Costanti.DATA_SCADENZA, sdf.format(anagrafica.getDocumento().getDataScadenza())+"");
			    acroFields.setField(Costanti.RILASCIATO_DA, anagrafica.getDocumento().getRilasciatoDa());
			    acroFields.setField(Costanti.TELEFONO, anagrafica.getTelefono());
			    acroFields.setField(Costanti.STATO_RESIDENZA, anagrafica.getStato());
			    acroFields.setField(Costanti.INDIRIZZO_COMPLETO, anagrafica.getIndirizzo()+" "+anagrafica.getCivico()+" - "+anagrafica.getCap()+" - "+anagrafica.getComune()+" ("+anagrafica.getProvincia()+")");
			    acroFields.setField(Costanti.TIPO_DOCUMENTO_MIO, io.getDocumento().getTipo().getDescrizione());
			    acroFields.setField(Costanti.NUMERO_DOCUMENTO_MIO, io.getDocumento().getNumero());
			    acroFields.setField(Costanti.DATA_RILASCIO_MIO, sdf.format(io.getDocumento().getDataRilascio()));
			    acroFields.setField(Costanti.DATA_SCADENZA_MIO,sdf.format(io.getDocumento().getDataScadenza()));
			    acroFields.setField(Costanti.RILASCIATO_DA_MIO, io.getDocumento().getRilasciatoDa());
			    acroFields.setField(Costanti.NOMINATIVO_MIO, io.getNominativo());
			    acroFields.setField(Costanti.DATA_NASCITA_MIO, sdf.format(io.getDataNascita()));
			    acroFields.setField(Costanti.PROVINCIA_NASCITA_MIO, io.getProvinciaNascita());
			    acroFields.setField(Costanti.LUOGO_NASCITA_MIO, io.getLuogoNascita());
			    acroFields.setField(Costanti.CF_MIO, io.getCf());
			    acroFields.setField(Costanti.INDIRIZZO_MIO, io.getIndirizzo());
			    acroFields.setField(Costanti.CIVICO_MIO, io.getCivico());
			    acroFields.setField(Costanti.CAP_MIO, io.getCap());
			    acroFields.setField(Costanti.COMUNE_MIO, io.getComune());
			    acroFields.setField(Costanti.DATA, sdf.format(new Date())+"");
			    
			    
			    stamper.close();
			    pdfReader.close();
			   
			  
			    listaFile.add(Costanti.PATH_FOLDER+"Temp\\Pratiche\\"+timestamp+".pdf");
			   // File f = new File(Costanti.PATH_FOLDER+"Temp\\Pratiche\\"+timestamp+".pdf");
			   // ut.addSource(f);
			    
			
		}
		
		  File folder = new File(Costanti.PATH_FOLDER+"Pratiche\\"+pratica.getId()+"\\");
		  if(!folder.exists()) {
			  folder.mkdirs();
		  }
		
		String timestamp = df.format(new Timestamp(System.currentTimeMillis()));
		Document document = new Document();
        PdfCopy copy = new PdfCopy(document, new FileOutputStream(Costanti.PATH_FOLDER+"Pratiche\\"+pratica.getId()+"\\"+timestamp+".pdf"));

        document.open();
        for (String file : listaFile){
            PdfReader reader = new PdfReader(file);
            copy.addDocument(reader);
            copy.freeReader(reader);
            reader.close();
        }
        document.close();
		

//		
		pratica.setNomeFile(timestamp+".pdf");
		session.update(pratica);

		
	}

	
	public static String sendEmailPratica(EmailDTO mail,EmailConfigDTO emailConfig, PraticaDTO pratica, String idAllegati, Session session) throws MessagingException {
		

		   Properties props = new Properties();



	    props.put("mail.smtps.user",emailConfig.getMittenteDefault());  
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.starttls.enable", "true");
	    props.put("mail.smtp.host", "smtp.office365.com");//This is hostname
	    props.put("mail.smtp.port", "587");
	    props.setProperty("mail.smtp.starttls.enable", "true");
	     props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
	     
	    
	    String esito ="";
	    
	    
	    javax.mail.Session mailSession =  javax.mail.Session.getDefaultInstance(props);       
	    
	 
	    MimeMessage message = new MimeMessage(mailSession); 
			
			// header field of the header. 
			message.setFrom(new InternetAddress(emailConfig.getMittenteDefault())); 	
			
			InternetAddress[] address = InternetAddress.parse(mail.getDestinatario().trim().replace(";", ","));
			
			message.addRecipients(Message.RecipientType.TO, address); 
			
			message.setSubject(mail.getOggetto()); 
				
			StringBuffer msg = new StringBuffer();
			
			msg.append("<html><body>"+mail.getMessaggio()+"</body></html>");
		

			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent(msg.toString(),"text/html");
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);

					
			BodyPart attachPdf = new MimeBodyPart();
			BodyPart attachDoc = new MimeBodyPart();
					  
			String path = Costanti.PATH_FOLDER + "\\Pratiche\\"+pratica.getId()+"\\Scansione\\"+pratica.getNomeFileScansione();
			  
			DataSource source = new FileDataSource(path);
			attachPdf.setDataHandler(new DataHandler(source));
			attachPdf.setFileName(pratica.getNomeFileScansione());		
								        
			multipart.addBodyPart(attachPdf);
			
			if(idAllegati!=null) {
				String[] ids = idAllegati.split("_");
				if(ids.length>0) {
					for (String id : ids) {
						if(!id.equals("")) {
							AllegatoDTO allegato = GestionePraticheDAO.getAllegato(Integer.parseInt(id), session);
							String pathAllegato = Costanti.PATH_FOLDER + "\\Allegati\\"+pratica.getId()+"\\"+allegato.getNomeFile();
							
							BodyPart attachAllegato = new MimeBodyPart();
							DataSource sourceAllegato = new FileDataSource(pathAllegato);
							attachAllegato.setDataHandler(new DataHandler(sourceAllegato));
							attachAllegato.setFileName(allegato.getNomeFile());		
												        
							multipart.addBodyPart(attachAllegato);
							
						}
					}
					
				}
			}
			
			
			if(pratica.getAnagrafica().getDocumento().getNomeFile() == null || pratica.getAnagrafica().getDocumento().getNomeFile().equals("")) {
			
				esito = "Attenzione! Documento d'identità mancante!";
				return esito;
			}else {
				String pathAnagrafica = Costanti.PATH_FOLDER + "\\DocIdentita\\"+pratica.getAnagrafica().getId()+"\\"+pratica.getAnagrafica().getDocumento().getNomeFile();
				  
				DataSource sourceID = new FileDataSource(pathAnagrafica);
				attachDoc.setDataHandler(new DataHandler(sourceID));
				attachDoc.setFileName(pratica.getAnagrafica().getDocumento().getNomeFile());					        
						        
				multipart.addBodyPart(attachDoc);
				
			}
			
			
			if(pratica.getTemplate().getAddIsee()==1) {
				if(pratica.getAnagrafica().getNomeFileIsee() == null || pratica.getAnagrafica().getNomeFileIsee().equals("")) {
					esito = "Attenzione! Attestazione ISEE mancante!";
					return esito;
				}else {
					BodyPart attachIsee = new MimeBodyPart();
					
					String pathIsee = Costanti.PATH_FOLDER + "\\ISEE\\"+pratica.getAnagrafica().getId()+"\\"+pratica.getAnagrafica().getNomeFileIsee();
					  
					DataSource sourceIsee = new FileDataSource(pathIsee);
					attachIsee.setDataHandler(new DataHandler(sourceIsee));
					attachIsee.setFileName(pratica.getAnagrafica().getNomeFileIsee());					        
							        
					multipart.addBodyPart(attachIsee);
				}
				
				
			}


		         message.setContent(multipart);
	   
		
		         Transport tr = mailSession.getTransport("smtp");
		         
		         tr.connect("smtp.office365.com", 587, emailConfig.getMittenteDefault(), new String(Base64.getDecoder().decode(emailConfig.getPassword())));
		         message.saveChanges();      // don't forget this
		         tr.sendMessage(message, message.getAllRecipients());
		         tr.close();
		

		         esito ="Email inviata con successo";
		         return esito;
		        	 
		}

	public static ArrayList<AllegatoDTO> getListaAllegati(String idPratica, Session session) {
		
		return GestionePraticheDAO.getListaAllegati(idPratica,session);
	}

	public static AllegatoDTO getAllegato(int idAllegato, Session session) {
		
		return GestionePraticheDAO.getAllegato(idAllegato, session);
	}

	

}
