package it.CAF.BO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

import org.apache.pdfbox.exceptions.COSVisitorException;
import org.apache.pdfbox.util.PDFMergerUtility;
import org.hibernate.Session;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfReader;

import it.CAF.DAO.GestioneTemplateDAO;
import it.CAF.DTO.ModuloDTO;
import it.CAF.DTO.TemplateDTO;
import it.CAF.Util.Costanti;

public class GestioneTemplateBO {

	public static ArrayList<TemplateDTO> getListaTemplate(Session session) {
	
		return GestioneTemplateDAO.getListaTemplate(session);
	}

	public static TemplateDTO getTemplate(int id, Session session) {
		
		return GestioneTemplateDAO.getTemplate(id, session);
	}

	public static String getFileTemplate(TemplateDTO template, Session session) throws  IOException, DocumentException {
	
		Set<ModuloDTO> listaModuli = template.getListaModuli();
		ArrayList<String> listaFile = new ArrayList<String>();
		
		SimpleDateFormat df = new SimpleDateFormat("ddMMyyyyHHmmss");
				 
		 
		for (ModuloDTO modulo : listaModuli) {
			listaFile.add(Costanti.PATH_FOLDER+"Moduli\\Corretti\\"+modulo.getId()+"\\"+modulo.getNomeFile());
		}
		String timestamp = df.format(new Date());

		
		Document document = new Document();
        PdfCopy copy = new PdfCopy(document, new FileOutputStream(Costanti.PATH_FOLDER+"Temp\\Template\\"+timestamp+".pdf"));

        document.open();
        PdfReader.unethicalreading = true;
        for (String file : listaFile){
            PdfReader reader = new PdfReader(file);
            copy.addDocument(reader);
            copy.freeReader(reader);
            reader.close();
        }
        document.close();
		
			

		return timestamp+".pdf";
			
		}


		

}
