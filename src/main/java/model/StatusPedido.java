package model;

import java.time.LocalDate;

public class StatusPedido {

    private int id;
    private String descricao;
    private LocalDate data;
    private String motivo;

    public StatusPedido(int id, String descricao, LocalDate data, String motivo) {
        this.id = id;
        this.descricao = descricao;
        this.data = data;
        this.motivo = motivo;
    }

    public StatusPedido(String descricao, String motivo) {
        this.descricao = descricao;
        this.motivo = motivo;
    }

    public StatusPedido(int id, String descricao, String motivo) {
        this.id = id;
        this.descricao = descricao;
        this.motivo = motivo;
    }

    public StatusPedido(int id) {
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
}
