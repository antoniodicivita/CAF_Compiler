package it.CAF.DTO;

import java.util.Date;

public class DocumentoIdentitaDTO {
	private int id;
	private TipoDocumentoIdentitaDTO tipo;
	private String numero;
	private String nomeFile;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TipoDocumentoIdentitaDTO getTipo() {
		return tipo;
	}
	public void setTipo(TipoDocumentoIdentitaDTO tipo) {
		this.tipo = tipo;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public Date getDataRilascio() {
		return dataRilascio;
	}
	public void setDataRilascio(Date dataRilascio) {
		this.dataRilascio = dataRilascio;
	}
	public Date getDataScadenza() {
		return dataScadenza;
	}
	public void setDataScadenza(Date dataScadenza) {
		this.dataScadenza = dataScadenza;
	}
	public String getRilasciatoDa() {
		return rilasciatoDa;
	}
	public void setRilasciatoDa(String rilasciatoDa) {
		this.rilasciatoDa = rilasciatoDa;
	}
	public String getNomeFile() {
		return nomeFile;
	}
	public void setNomeFile(String nomeFile) {
		this.nomeFile = nomeFile;
	}
	private Date dataRilascio;
	private Date dataScadenza;
	private String rilasciatoDa;
	
	

}
