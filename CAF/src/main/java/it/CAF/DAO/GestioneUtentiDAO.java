package it.CAF.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.CAF.DTO.UtenteDTO;

public class GestioneUtentiDAO {
	
	public static UtenteDTO getUtente(int idUtente, Session session) {
		
		UtenteDTO utente = null;
		ArrayList<UtenteDTO> list = null;
		
		Query query = session.createQuery("from UtenteDTO where id = :_idUtente");
		query.setParameter("_idUtente", idUtente);
		
		list = (ArrayList<UtenteDTO>) query.list();
		
		if(list.size()>0) {
			utente = list.get(0);
		}
		
		return utente;
	}

}
