package model;

public class Permissao {

    private int id;
    private String descricao;

    public Permissao(int id) {
        this.id = id;
    }

    public Permissao(String descricao) {
        this.descricao = descricao;
    }

    public Permissao(int id, String descricao) {
        this.id = id;
        this.descricao = descricao;
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
}
