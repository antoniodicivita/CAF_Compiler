package it.CAF.BO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.hibernate.Session;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.AcroFields.Item;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

import it.CAF.DAO.GestioneModuliDAO;
import it.CAF.DTO.ModuloDTO;

public class GestioneModuliBO {

	public static ArrayList<ModuloDTO> getListaModuli(Session session) {
		
		return GestioneModuliDAO.getListaModuli(session);
	}

	public static void scanFields(String path) throws IOException, DocumentException {
	    PdfReader pdfReader = new PdfReader(path);
	    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream("C:\\Users\\antonio.dicivita\\Desktop\\2.pdf"));
	    AcroFields acroFields = pdfReader.getAcroFields();
	    AcroFields acroFields1 = stamper.getAcroFields();
	    Map<String, Item> fields = acroFields.getFields();
	    Set<Entry<String, Item>> entrySet = fields.entrySet();
	    for (Entry<String, Item> entry : entrySet) {
	        String key = entry.getKey();
	        System.out.println(key);
	    }
	    acroFields1.setField("Cognome", "PAOLINO");
	    acroFields1.setField("nome", "PAPERINO");
	
	    stamper.setFormFlattening(true);
	    stamper.close();
	    pdfReader.close();
	}
	
	
	public static ArrayList<String> getListaCampiModuli(String path, String filename, Session session) throws IOException, DocumentException {
		
		ArrayList<String> listaCampi = new ArrayList<String>();
		
		PdfReader pdfReader = new PdfReader(path+"\\"+filename);	  
	    AcroFields acroFields = pdfReader.getAcroFields();
	    Map<String, Item> fields = acroFields.getFields();
	    Set<Entry<String, Item>> entrySet = fields.entrySet();
	    for (Entry<String, Item> entry : entrySet) {
	        String key = entry.getKey();
	        listaCampi.add(key);
	    }

	    return listaCampi;
	}

	public static void assegnaNuoviCampiModulo(Map<String, String> map, String pathSource, String pathDest, Session session) throws IOException, DocumentException {
		
		 PdfReader pdfReader = new PdfReader(pathSource);
		 PdfReader.unethicalreading = true;
		    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream(pathDest));
		    
		    
		    
		    AcroFields acroFields = pdfReader.getAcroFields();
		    AcroFields acroFields1 = stamper.getAcroFields();
		    
		    for (Map.Entry<String, String> entry : map.entrySet()) {
		    	
		    	acroFields.renameField(entry.getKey(), entry.getValue());
		        System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
		    }
		    
		    
//		    Map<String, Item> fields = acroFields.getFields();
//		    Set<Entry<String, Item>> entrySet = fields.entrySet();
//		    for (Entry<String, Item> entry : entrySet) {
//		        String key = entry.getKey();
//		        System.out.println(key);
//		    }
//		    acroFields1.setField("Cognome", "PAOLINO");
//		    acroFields1.setField("nome", "PAPERINO");
		
		    //stamper.setFormFlattening(true);
		    stamper.close();
		    pdfReader.close();
		
		
	}

	public static ModuloDTO getModulo(int idModulo, Session session) {
		
		return GestioneModuliDAO.getModulo(idModulo, session);
	}

	public static void getListaCampiFull(String path, String filename, Session session) throws IOException, DocumentException {

		PdfReader pdfReader = new PdfReader(path+filename);
		System.out.println(pdfReader.computeUserPassword());
		
		 PdfReader.unethicalreading = true;
		 File folder = new File(path+"\\correzioni\\");
		 if(!folder.exists()) {
			 folder.mkdirs();
		 }
		    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream(path+"\\correzioni\\"+filename));
		    
		    
		    
		    AcroFields acroFields = pdfReader.getAcroFields();
		    AcroFields acroFields1 = stamper.getAcroFields();
		    
//		    for (int i = 0; i <= pdfReader.getXrefSize(); i++)
//		    {
//		        PdfDictionary pd =   pdfReader.getPdfObject(i);
//		        if (pd != null)
//		        {
//		            pd.remove(PdfName.AA); // Removes automatic execution objects
//		            pd.remove(PdfName.JS); // Removes javascript objects
//		            pd.remove(PdfName.JAVASCRIPT); // Removes other javascript objects
//		        }
//		    }
		        
		       
 

		    Map<String, Item> fields = acroFields.getFields();
		    Set<Entry<String, Item>> entrySet = fields.entrySet();
		    for (Entry<String, Item> entry : entrySet) {
		       // String key = entry.getKey();
		    	AcroFields.Item fd = acroFields1.getFieldItem(entry.getKey());
		    	 PdfDictionary dictYes = (PdfDictionary) PdfReader.getPdfObject(fd.getWidget(0));
			      
			        dictYes.remove(PdfName.AA);
			        dictYes.remove(PdfName.JS);
			        dictYes.remove(PdfName.JAVASCRIPT);
			        
		        acroFields1.setField(entry.getKey(), entry.getKey());
		        
		    }
//		    acroFields1.setField("Cognome", "PAOLINO");
//		    acroFields1.setField("nome", "PAPERINO");
		
		    //stamper.setFormFlattening(true);
		    stamper.close();
		    pdfReader.close();
		
	}
	
	public static void correggiCampi(String path, String dest, String filename, Session session) throws IOException, DocumentException {

		PdfReader pdfReader = new PdfReader(path+filename);
		 PdfReader.unethicalreading = true;
		    PdfStamper stamper = new PdfStamper(pdfReader, new FileOutputStream(dest+filename));
		    
		    
		    
		    AcroFields acroFields = pdfReader.getAcroFields();
		    AcroFields acroFields1 = stamper.getAcroFields();
		    
		    
		    Map<String, Item> fields = acroFields.getFields();
		    Set<Entry<String, Item>> entrySet = fields.entrySet();
		    for (Entry<String, Item> entry : entrySet) {
		       // String key = entry.getKey();
		    	String value = acroFields1.getField(entry.getKey());
		        acroFields1.renameField(entry.getKey(), value);
			    //acroFields1.setField(value, "");
		    }
//		    acroFields1.setField("Cognome", "PAOLINO");
//		    acroFields1.setField("nome", "PAPERINO");
		
		    //stamper.setFormFlattening(true);
		    stamper.close();
		    pdfReader.close();
		
	}
}
