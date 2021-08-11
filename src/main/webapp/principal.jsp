<%@ page contentType="text/html;charset=UTF-8" language="Java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="pt_BR">
<head>
    <title>Bolicho</title>
</head>
<body>
    <header>
        <nav>
            <h3><a href="http://localhost:8080/bolicho-virtual/">Bolicho</a></h3>
            <ul>
                <li><a href="http://localhost:8080/bolicho-virtual/clientes?logica=ListarClientes">Clientes</a></li>
                <li><a href="http://localhost:8080/bolicho-virtual/vendedores?logica=ListarVendedores">Vendedores</a></li>
                <li><a href="http://localhost:8080/bolicho-virtual/produtos?logica=ListarProdutos">Produtos</a></li>
            </ul>
        </nav>
    </header>

    <section>
        <c:if test="${not empty retorno}">
            <p>${retorno}</p>
        </c:if>

        <form>
            <input type="text" name="pesquisar" placeholder="Pesquisar...">
        </form>

        <table>
            <thead>
                <tr>
                    <th>Produto</th>
                    <th>Preço</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${produtos}">
                    <tr>
                        <td>${p.nome}</td>
                        <td>R$ ${p.preco}</td>
                        <td>
                            <a href="http://localhost:8080/bolicho-virtual/compras?logica=Comprar&p=${p.id}">
                                <button type="button">Comprar</button></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2>Vendas recentes</h2>

        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Produto</th>
                    <th>Cliente</th>
                    <th>Vendedor</th>
                    <th>Data</th>
                    <th>Quantidade</th>
                    <th>Valor total</th>
                    <th colspan="2">Alterar Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${compras}">
                    <c:choose>
                        <c:when test="${c.status.descricao == 'CONCLUÍDO'}">
                            <tr style="background-color: #1F681F">
                        </c:when>
                        <c:when test="${c.status.descricao == 'CANCELADO'}">
                            <tr style="background-color: #FF0000">
                        </c:when>
                    </c:choose>
                        <td>${c.id}</td>
                        <td>${c.item.produto.nome}</td>
                        <td>${c.cliente.usuario.nome}</td>
                        <td>${c.vendedor.usuario.nome}</td>
                        <td>${c.dataPedido}</td>
                        <td>${c.item.quantidade}</td>
                        <td>${c.valor}</td>
                        <td><a href="http://localhost:8080/bolicho-virtual/compras?logica=ConcluirCompra&id=${c.id}&s=${c.status.id}"><button type="button">Concluir</button></a></td>
                        <td><a href="http://localhost:8080/bolicho-virtual/compras?logica=CancelarCompra&id=${c.id}&s=${c.status.id}"><button type="button">Cancelar</button></a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </section>

    <footer>
        <%-- Preencher mais tarde --%>
    </footer>
</body>
</html>
