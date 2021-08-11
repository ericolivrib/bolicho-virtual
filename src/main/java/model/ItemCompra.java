package model;

public class ItemCompra {

    private int id;
    private int quantidade;
    private Produto produto;

    public ItemCompra(int id, int quantidade, Produto produto) {
        this.id = id;
        this.quantidade = quantidade;
        this.produto = produto;
    }

    public ItemCompra(int quantidade, Produto produto) {
        this.quantidade = quantidade;
        this.produto = produto;
    }

    public ItemCompra(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }
}
