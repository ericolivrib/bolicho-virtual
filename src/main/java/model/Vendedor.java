package model;

import java.math.BigDecimal;

public class Vendedor {

    private int id;
    private int qauntidadeVendas;
    private Usuario usuario;
    private BigDecimal lucro;

    public Vendedor(Usuario usuario) {
        this.usuario = usuario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQauntidadeVendas() {
        return qauntidadeVendas;
    }

    public void setQauntidadeVendas(int qauntidadeVendas) {
        this.qauntidadeVendas = qauntidadeVendas;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public BigDecimal getLucro() {
        return lucro;
    }

    public void setLucro(BigDecimal lucro) {
        this.lucro = lucro;
    }
}
