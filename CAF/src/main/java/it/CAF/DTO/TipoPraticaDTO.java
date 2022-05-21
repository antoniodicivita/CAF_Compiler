package it.CAF.DTO;

public class TipoPraticaDTO {
	
	private int id; 
	private String descrizione;
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
	
	public TipoPraticaDTO() {
		super();
	}
	
	public TipoPraticaDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
	}

}
