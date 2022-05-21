package it.CAF.DTO;

import java.util.HashSet;
import java.util.Set;

public class TemplateDTO {
	
	private int id;
	private String descrizione;
	private TipoPraticaDTO tipo;
	private int disabilitato;
	Set<ModuloDTO> listaModuli = new HashSet<ModuloDTO>();
	private int addIsee;
	
	public Set<ModuloDTO> getListaModuli() {
		return listaModuli;
	}
	public void setListaModuli(Set<ModuloDTO> listaModuli) {
		this.listaModuli = listaModuli;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public TipoPraticaDTO getTipo() {
		return tipo;
	}
	public void setTipo(TipoPraticaDTO tipo) {
		this.tipo = tipo;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public int getAddIsee() {
		return addIsee;
	}
	public void setAddIsee(int addIsee) {
		this.addIsee = addIsee;
	}
	
	

}
