package it.CAF.DTO;

public class TipoDocumentoIdentitaDTO {
	
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
	
	public TipoDocumentoIdentitaDTO() {
		super();
	}

	public TipoDocumentoIdentitaDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
	}
}
