package it.CAF.DTO;

import java.util.Date;

public class PraticaDTO {

	private int id;
	private TipoPraticaDTO tipo; 
	private String note;
	private AnagraficaDTO anagrafica;
	private int disabilitato;
	private TemplateDTO template;
	private Date dataCreazione;
	private String nomeFile;
	private String nomeFileScansione;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public TipoPraticaDTO getTipo() {
		return tipo;
	}

	public void setTipo(TipoPraticaDTO tipo) {
		this.tipo = tipo;
	}



	public AnagraficaDTO getAnagrafica() {
		return anagrafica;
	}

	public void setAnagrafica(AnagraficaDTO anagrafica) {
		this.anagrafica = anagrafica;
	}

	public int getDisabilitato() {
		return disabilitato;
	}

	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public TemplateDTO getTemplate() {
		return template;
	}

	public void setTemplate(TemplateDTO template) {
		this.template = template;
	}

	public Date getDataCreazione() {
		return dataCreazione;
	}

	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}

	public String getNomeFile() {
		return nomeFile;
	}

	public void setNomeFile(String nomeFile) {
		this.nomeFile = nomeFile;
	}

	public String getNomeFileScansione() {
		return nomeFileScansione;
	}

	public void setNomeFileScansione(String nomeFileScansione) {
		this.nomeFileScansione = nomeFileScansione;
	}

	
	
	
	
}
