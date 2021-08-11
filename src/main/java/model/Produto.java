package model;

import java.math.BigDecimal;

public class Produto {

    private int id;
    private String nome;
    private BigDecimal preco;
    private String detalhes;

    public Produto(int id, String nome, BigDecimal preco, String detalhes) {
        this.id = id;
        this.nome = nome;
        this.preco = preco;
        this.detalhes = detalhes;
    }

    public Produto(String nome, BigDecimal preco, String detalhes) {
        this.nome = nome;
        this.preco = preco;
        this.detalhes = detalhes;
    }

    public Produto(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public BigDecimal getPreco() {
        return preco;
    }

    public void setPreco(BigDecimal preco) {
        this.preco = preco;
    }

    public String getDetalhes() {
        return detalhes;
    }

    public void setDetalhes(String detalhes) {
        this.detalhes = detalhes;
    }
}
