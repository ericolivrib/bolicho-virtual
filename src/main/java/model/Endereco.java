package model;

public class Endereco {

    private int id;
    private String rua;
    private int numeroCasa;
    private String bairro;
    private String complemento;

    public Endereco(int id, String rua, int numeroCasa, String bairro, String complemento) {
        this.id = id;
        this.bairro = bairro;
        this.rua = rua;
        this.numeroCasa = numeroCasa;
        this.complemento = complemento;
    }

    public Endereco(String rua, int numeroCasa, String bairro, String complemento) {
        this.rua = rua;
        this.numeroCasa = numeroCasa;
        this.bairro = bairro;
        this.complemento = complemento;
    }

    public Endereco(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public int getNumeroCasa() {
        return numeroCasa;
    }

    public void setNumeroCasa(int numeroCasa) {
        this.numeroCasa = numeroCasa;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }
}
