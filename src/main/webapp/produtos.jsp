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
        <form action="produtos" method="POST">
            <c:choose>
                <c:when test="${logica == 'AtualizarProduto'}">
                    <input type="hidden" name="id" value="${produto.id}">
                    <h1>Editar produto</h1>
                </c:when>
                <c:otherwise>
                    <h1>Adicionar produto</h1>
                </c:otherwise>
            </c:choose>

            <input type="text" name="nome" value="${produto.nome}" required placeholder="Nome"><br>
            <input type="number" step="0.01" min="0" name="preco" value="${produto.preco}" required placeholder="Preço (R$)"><br><br>

            <textarea name="detalhes" cols="30" rows="10" placeholder="Descreva o produto em detalhes">${produto.detalhes}
            </textarea><br>

            <button type="submit" name="logica" value="${logica}">Confirmar</button>

            <c:if test="${logica == 'AtualizarProduto'}">
                <a href="http://localhost:8080/bolicho-virtual/produtos?logica=ListarProdutos">
                    <button type="button">Cancelar</button></a>
            </c:if>
        </form>

        <c:if test="${not empty retorno}">
            <p>${retorno}</p>
        </c:if>

        <c:if test="${logica != 'AtualizarProduto'}">
            <h2>Lista de produtos</h2>

            <table>
                <thead>
                <tr>
                    <th>Nome</th>
                    <th>Preço</th>
                    <th>Detalhes</th>
                    <th colspan="2">Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${produtos}">
                    <tr>
                        <td>${p.nome}</td>
                        <td>${p.preco}</td>
                        <td>${p.detalhes}</td>
                        <td><a href="http://localhost:8080/bolicho-virtual/produtos?logica=EditarProduto&id=${p.id}">Editar</a></td>
                        <td><a href="http://localhost:8080/bolicho-virtual/produtos?logica=RemoverProduto&id=${p.id}">Remover</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </section>
</body>
</html>