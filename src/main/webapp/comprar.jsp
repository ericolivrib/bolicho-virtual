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
            <h3><c:url value="/">Bolicho</c:url></h3>
            <ul>
                <li><c:url value="clientes?logica=ListarClientes">Clientes</c:url></li>
                <li><c:url value="vendedores?logica=ListarVendedores">Vendedores</c:url></li>
                <li><c:url value="produtos?logica=ListarProdutos">Produtos</c:url></li>
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
            <c:url value="/"><button type="button">Cancelar</button></c:url>
        </form>
    </section>
</body>
</html>
