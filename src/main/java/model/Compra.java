package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Compra {

    private int id;
    private BigDecimal valor;
    private LocalDate dataPedido;
    private Cliente cliente;
    private Vendedor vendedor;
    private ItemCompra item;
    private StatusCompra status;

    public Compra(int id, BigDecimal valor, LocalDate dataPedido, Cliente cliente, Vendedor vendedor, ItemCompra item, StatusCompra status) {
        this.id = id;
        this.valor = valor;
        this.dataPedido = dataPedido;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Compra(int id, BigDecimal valor, Cliente cliente, Vendedor vendedor, ItemCompra item, StatusCompra status) {
        this.id = id;
        this.valor = valor;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Compra(BigDecimal valor, LocalDate dataPedido, Cliente cliente, Vendedor vendedor, ItemCompra item, StatusCompra status) {
        this.valor = valor;
        this.dataPedido = dataPedido;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Compra(BigDecimal valor, Cliente cliente, Vendedor vendedor, ItemCompra item, StatusCompra status) {
        this.valor = valor;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.item = item;
        this.status = status;
    }

    public Compra(int id, StatusCompra status) {
        this.id = id;
        this.status = status;
    }

    public Compra(int id) {
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

    public ItemCompra getItem() {
        return item;
    }

    public void setItem(ItemCompra item) {
        this.item = item;
    }

    public StatusCompra getStatus() {
        return status;
    }

    public void setStatus(StatusCompra status) {
        this.status = status;
    }
}
