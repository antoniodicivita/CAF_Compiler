package it.CAF.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.CAF.DTO.ModuloDTO;

public class GestioneModuliDAO {

	public static ArrayList<ModuloDTO> getListaModuli(Session session) {

		ArrayList<ModuloDTO> list = null;
		
		Query query = session.createQuery("from ModuloDTO where disabilitato = 0");		
		
		list = (ArrayList<ModuloDTO>) query.list();		
		
		return list;
	}

	public static ModuloDTO getModulo(int idModulo, Session session) {
		
		ArrayList<ModuloDTO> list = null;
		ModuloDTO result = null;
		
		Query query = session.createQuery("from ModuloDTO where id = :_id");	
		query.setParameter("_id", idModulo);
		
		list = (ArrayList<ModuloDTO>) query.list();		
		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}

}
