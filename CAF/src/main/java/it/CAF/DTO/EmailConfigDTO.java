package it.CAF.DTO;

public class EmailConfigDTO {

	private int id;
	private String destinatarioDefault;
	private String mittenteDefault;
	private String password;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDestinatarioDefault() {
		return destinatarioDefault;
	}
	public void setDestinatarioDefault(String destinatarioDefault) {
		this.destinatarioDefault = destinatarioDefault;
	}
	public String getMittenteDefault() {
		return mittenteDefault;
	}
	public void setMittenteDefault(String mittenteDefault) {
		this.mittenteDefault = mittenteDefault;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	
	
}
