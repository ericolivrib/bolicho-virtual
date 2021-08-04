package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Compra {

    private int id;
    private BigDecimal valor;
    private LocalDate dataPedido;
    private String formaPagamento;
    private Cliente cliente;
    private Vendedor vendedor;
    private StatusCompra statusCompra;

    public Compra(int id, BigDecimal valor, LocalDate dataPedido, String formaPagamento, Cliente cliente, Vendedor vendedor, StatusCompra statusCompra) {
        this.id = id;
        this.valor = valor;
        this.dataPedido = dataPedido;
        this.formaPagamento = formaPagamento;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.statusCompra = statusCompra;
    }

    public Compra(int id, BigDecimal valor, String formaPagamento, Cliente cliente, Vendedor vendedor, StatusCompra statusCompra) {
        this.id = id;
        this.valor = valor;
        this.formaPagamento = formaPagamento;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.statusCompra = statusCompra;
    }

    public Compra(BigDecimal valor, LocalDate dataPedido, String formaPagamento, Cliente cliente, Vendedor vendedor, StatusCompra statusCompra) {
        this.valor = valor;
        this.dataPedido = dataPedido;
        this.formaPagamento = formaPagamento;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.statusCompra = statusCompra;
    }

    public Compra(BigDecimal valor, String formaPagamento, Cliente cliente, Vendedor vendedor, StatusCompra statusCompra) {
        this.valor = valor;
        this.formaPagamento = formaPagamento;
        this.cliente = cliente;
        this.vendedor = vendedor;
        this.statusCompra = statusCompra;
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

    public String getFormaPagamento() {
        return formaPagamento;
    }

    public void setFormaPagamento(String formaPagamento) {
        this.formaPagamento = formaPagamento;
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

    public StatusCompra getStatus() {
        return statusCompra;
    }

    public void setStatus(StatusCompra statusCompra) {
        this.statusCompra = statusCompra;
    }

}
