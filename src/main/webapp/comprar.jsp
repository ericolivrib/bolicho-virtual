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
        <h1>${produto.nome}</h1>
        <p><strong>R$ ${produto.preco}</strong></p>

        <p><strong>Detalhes do produto</strong></p>
        <p>${produto.detalhes}</p>

        <form action="compras" method="POST">

            <input type="hidden" name="p" value="${param.p}">

            <label for="cliente"><strong>Cliente</strong></label>
            <select name="cliente" id="cliente">
                <option selected disabled>Selecione</option>
                <c:forEach var="c" items="${clientes}">
                    <option value="${c.id}">${c.usuario.nome}</option>
                </c:forEach>
            </select>

            <label for="vendedor"><strong>Vendedor</strong></label>
            <select name="vendedor" id="vendedor">
                <option selected disabled>Selecione</option>
                <c:forEach var="v" items="${vendedores}">
                    <option value="${v.id}">${v.usuario.nome}</option>
                </c:forEach>
            </select>

            <label for="quantidade"><strong>Quantidade</strong></label>
            <select name="quantidade" id="quantidade">
                <option selected disabled>Selecione</option>
                <c:forEach var="qtd" begin="1" end="20">
                    <option value="${qtd}">${qtd}</option>
                </c:forEach>
            </select>

            <button type="submit" name="logica" value="FinalizarCompra">Finalizar</button>
            <a href="http://localhost:8080/bolicho-virtual/"><button type="button">Cancelar</button></a>
        </form>
    </section>
</body>
</html>
