package it.CAF.BO;

import java.util.ArrayList;

import org.hibernate.Session;

import it.CAF.DAO.GestioneAnagraficheDAO;
import it.CAF.DTO.AnagraficaDTO;
import it.CAF.DTO.DocumentoIdentitaDTO;

public class GestioneAnagraficheBO {

	public static ArrayList<AnagraficaDTO> getListaAnagrafiche(Session session) {
		
		return GestioneAnagraficheDAO.getListaAnagrafiche(session);
	}

	public static AnagraficaDTO getAnagrafica(int id, Session session) {
		
		return GestioneAnagraficheDAO.getAnagrafica(id, session);
	}

	public static DocumentoIdentitaDTO getDocumento(int id, Session session) {
		
		return GestioneAnagraficheDAO.getDocumento(id, session);
	}

}
