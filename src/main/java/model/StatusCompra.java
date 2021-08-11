package model;

import java.time.LocalDate;

public class StatusCompra {

    private int id;
    private String descricao;
    private LocalDate data;
    private String motivo;
    private Compra compra;

    public StatusCompra(int id, String descricao, LocalDate data, String motivo, Compra compra) {
        this.id = id;
        this.descricao = descricao;
        this.data = data;
        this.motivo = motivo;
        this.compra = compra;
    }

    public StatusCompra(String descricao, String motivo, Compra compra) {
        this.descricao = descricao;
        this.motivo = motivo;
        this.compra = compra;
    }

    public StatusCompra(int id, String descricao, String motivo, Compra compra) {
        this.id = id;
        this.descricao = descricao;
        this.motivo = motivo;
        this.compra = compra;
    }

    public StatusCompra(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }
}
