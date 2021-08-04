package model;

public class ItemCompra {

    private int id;
    private int quantidade;
    private Produto produto;
    private Compra compra;

    public ItemCompra(int id, int quantidade, Produto produto, Compra compra) {
        this.id = id;
        this.quantidade = quantidade;
        this.produto = produto;
        this.compra = compra;
    }

    public ItemCompra(int quantidade, Produto produto, Compra compra) {
        this.quantidade = quantidade;
        this.produto = produto;
        this.compra = compra;
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

    public Compra getCompra() {
        return compra;
    }

    public void setCompra(Compra compra) {
        this.compra = compra;
    }
}
