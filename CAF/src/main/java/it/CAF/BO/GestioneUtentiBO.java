package it.CAF.BO;

import org.hibernate.Session;

import it.CAF.DAO.GestioneUtentiDAO;
import it.CAF.DTO.UtenteDTO;

public class GestioneUtentiBO {

	public static UtenteDTO getUtente(int idUtente, Session session) {
		
		return GestioneUtentiDAO.getUtente(idUtente, session);
	}

}
