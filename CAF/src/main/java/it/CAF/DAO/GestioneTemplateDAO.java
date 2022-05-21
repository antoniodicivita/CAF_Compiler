package it.CAF.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.CAF.DTO.ModuloDTO;
import it.CAF.DTO.TemplateDTO;

public class GestioneTemplateDAO {


	
	public static ArrayList<TemplateDTO> getListaTemplate(Session session) {

		ArrayList<TemplateDTO> list = null;
		
		Query query = session.createQuery("from TemplateDTO where disabilitato = 0");		
		
		list = (ArrayList<TemplateDTO>) query.list();		
		
		return list;
	}

	public static TemplateDTO getTemplate(int idTemplate, Session session) {
		
		ArrayList<TemplateDTO> list = null;
		TemplateDTO result = null;
		
		Query query = session.createQuery("from TemplateDTO where id = :_id");	
		query.setParameter("_id", idTemplate);
		
		list = (ArrayList<TemplateDTO>) query.list();		
		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}


}
