package it.CAF.DTO;

public class AllegatoDTO {
	
	private int id;
	private String nomeFile;
	private PraticaDTO pratica;
	private int disabilitato;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNomeFile() {
		return nomeFile;
	}
	public void setNomeFile(String nomeFile) {
		this.nomeFile = nomeFile;
	}
	public PraticaDTO getPratica() {
		return pratica;
	}
	public void setPratica(PraticaDTO pratica) {
		this.pratica = pratica;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	
	

}
