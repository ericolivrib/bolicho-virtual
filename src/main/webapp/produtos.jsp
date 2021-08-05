<%@ page contentType="text/html;charset=UTF-8" language="Java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Produtos</title>
</head>
<body>
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

        <input type="hidden" name="id" value="${produto.id}">

        <input type="text" name="nome" value="${produto.nome}" required placeholder="Nome">
        <input type="number" step="0.01" min="0" name="preco" value="${produto.preco}" required placeholder="Preço">

        <button type="submit" name="logica" value="${logica}">Confirmar</button>

        <c:if test="${logica == 'AtualizarProduto'}">
            <a href="http://localhost:8080/bolicho-virtual/produtos?logica=ListarProdutos"><button type="button">Cancelar</button></a>
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
                <th colspan="2">Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${produtos}">
                <tr>
                    <td>${p.nome}</td>
                    <td>${p.preco}</td>
                    <td><a href="http://localhost:8080/bolicho-virtual/produtos?logica=EditarProduto&id=${p.id}">EDITAR</a></td>
                    <td><a href="http://localhost:8080/bolicho-virtual/produtos?logica=RemoverProduto&id=${p.id}">REMOVER</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>