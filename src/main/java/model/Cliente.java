package model;

public class Cliente {

    private int id;
    private Usuario usuario;

    public Cliente(int id) {
        this.id = id;
    }

    public Cliente(Usuario usuario) {
        this.usuario = usuario;
    }

    public Cliente(int id, Usuario usuario) {
        this.id = id;
        this.usuario = usuario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
}
