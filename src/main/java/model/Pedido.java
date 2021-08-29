package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Pedido {

    private int id;
    private BigDecimal valor;
    private LocalDate dataPedido;
    private Cliente cliente;
    private Vendedor vendedor;
    private ItemPedido item;
    private StatusPedido status;

    public Pedido(int id, BigDecimal valor, LocalDate dataPedido, Cliente cliente, Vendedor vendedor, ItemPedido item, StatusPedido status) {
        this.id = id;
        this.valor = valor;
        this.dataPedido = dataPedido;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Pedido(int id, BigDecimal valor, Cliente cliente, Vendedor vendedor, ItemPedido item, StatusPedido status) {
        this.id = id;
        this.valor = valor;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Pedido(BigDecimal valor, LocalDate dataPedido, Cliente cliente, Vendedor vendedor, ItemPedido item, StatusPedido status) {
        this.valor = valor;
        this.dataPedido = dataPedido;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Pedido(BigDecimal valor, Cliente cliente, Vendedor vendedor, ItemPedido item, StatusPedido status) {
        this.valor = valor;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Pedido(int id, StatusPedido status) {
        this.id = id;
        this.status = status;
    }

    public Pedido(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public LocalDate getDataPedido() {
        return dataPedido;
    }

    public void setDataPedido(LocalDate dataPedido) {
        this.dataPedido = dataPedido;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Vendedor getVendedor() {
        return vendedor;
    }

    public void setVendedor(Vendedor vendedor) {
        this.vendedor = vendedor;
    }

    public ItemPedido getItem() {
        return item;
    }

    public void setItem(ItemPedido item) {
        this.item = item;
    }

    public StatusPedido getStatus() {
        return status;
    }

    public void setStatus(StatusPedido status) {
        this.status = status;
    }
}
