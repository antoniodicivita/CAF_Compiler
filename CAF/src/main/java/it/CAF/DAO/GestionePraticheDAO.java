package it.CAF.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.CAF.DTO.AllegatoDTO;
import it.CAF.DTO.EmailConfigDTO;
import it.CAF.DTO.ModuloDTO;
import it.CAF.DTO.PraticaDTO;
import it.CAF.DTO.TipoPraticaDTO;

public class GestionePraticheDAO {


	
	public static ArrayList<PraticaDTO> getListaPratiche(Session session) {

		ArrayList<PraticaDTO> list = null;
		
		Query query = session.createQuery("from PraticaDTO where disabilitato = 0");		
		
		list = (ArrayList<PraticaDTO>) query.list();		
		
		return list;
	}

	public static PraticaDTO getPratica(int idPratica, Session session) {
		
		ArrayList<PraticaDTO> list = null;
		PraticaDTO result = null;
		
		Query query = session.createQuery("from PraticaDTO where id = :_id");	
		query.setParameter("_id", idPratica);
		
		list = (ArrayList<PraticaDTO>) query.list();		
		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}

	public static ArrayList<TipoPraticaDTO> getListaTipiPratiche(Session session) {
		
		ArrayList<TipoPraticaDTO> list = null;
		
		Query query = session.createQuery("from TipoPraticaDTO ");		
		
		list = (ArrayList<TipoPraticaDTO>) query.list();		
		
		return list;
	}

	public static ArrayList<AllegatoDTO> getListaAllegati(String idPratica, Session session) {
		ArrayList<AllegatoDTO> list = null;
		
		Query query = session.createQuery("from AllegatoDTO where id_pratica = :_id_pratica and disabilitato = 0");
		query.setParameter("_id_pratica", Integer.parseInt(idPratica));
		
		list = (ArrayList<AllegatoDTO>) query.list();		
		
		return list;
	}

	public static AllegatoDTO getAllegato(int idAllegato, Session session) {
		ArrayList<AllegatoDTO> list = null;
		AllegatoDTO result = null;
		
		Query query = session.createQuery("from AllegatoDTO where id = :_id");
		query.setParameter("_id", idAllegato);
		
		list = (ArrayList<AllegatoDTO>) query.list();		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}

	public static EmailConfigDTO getEmailConfig(Session session) {
		
		ArrayList<EmailConfigDTO> list = null;
		EmailConfigDTO result = null;
		
		Query query = session.createQuery("from EmailConfigDTO");
		
		list = (ArrayList<EmailConfigDTO>) query.list();		
		if(list.size()>0) {
			result = list.get(0);
		}
		
		return result;
	}

}
