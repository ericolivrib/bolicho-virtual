package model;

public class Vendedor {

    private int id;
    private Usuario usuario;

    public Vendedor(Usuario usuario) {
        this.usuario = usuario;
    }

    public Vendedor(int id) {
        this.id = id;
    }

    public Vendedor(int id, Usuario usuario) {
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
