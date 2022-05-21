package it.CAF.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.CAF.DTO.AnagraficaDTO;
import it.CAF.DTO.DocumentoIdentitaDTO;

public class GestioneAnagraficheDAO {

	public static ArrayList<AnagraficaDTO> getListaAnagrafiche(Session session) {
		
		ArrayList<AnagraficaDTO> list = null;
		
		Query query = session.createQuery("from AnagraficaDTO where disabilitato = 0");		
		
		list = (ArrayList<AnagraficaDTO>) query.list();		
		
		return list;
	}

	public static AnagraficaDTO getAnagrafica(int id, Session session) {
		
		ArrayList<AnagraficaDTO> list = null;
		AnagraficaDTO result = null;
		
		Query query = session.createQuery("from AnagraficaDTO where id = :_id");
		query.setParameter("_id", id);
		
		list = (ArrayList<AnagraficaDTO>) query.list();		
		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}

	public static DocumentoIdentitaDTO getDocumento(int id, Session session) {
		
		ArrayList<DocumentoIdentitaDTO> list = null;
		DocumentoIdentitaDTO result = null;
		
		Query query = session.createQuery("from DocumentoIdentitaDTO where id = :_id");
		query.setParameter("_id", id);
		
		list = (ArrayList<DocumentoIdentitaDTO>) query.list();		
		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}
}
