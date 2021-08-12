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

        <c:choose>
            <c:when test="${logica == 'AtualizarStatus'}">
                <h1>Dados da compra</h1>

                <h3>${compra.item.produto.nome}</h3>

                <p><strong>Cliente:</strong> ${compra.cliente.usuario.nome}</p>
                <p><strong>Vendedor:</strong> ${compra.vendedor.usuario.nome}</p>
                <p><strong>Data do pedido:</strong> ${compra.dataPedido}</p>
                <p><strong>Quantidade requisitada:</strong> ${compra.item.quantidade}</p>
                <p><strong>Valor total:</strong> ${compra.valor}</p>
                <p><strong>Status:</strong> ${compra.status.descricao}</p>

                <c:if test="${compra.status.descricao == 'CANCELADO'}">
                    <p><strong>Motivo do cancelamento:</strong> ${compra.status.motivo}</p>
                </c:if>

                <c:if test="${compra.status.descricao == 'PENDENTE'}">
                    <h2>Atualizar status da compra</h2>

                    <form action="compras" method="POST">
                        <input type="radio" name="descricao" id="status1" value="CONCLUIDO">
                        <label for="status1">Concluída</label>

                        <input type="radio" name="descricao" id="status2" value="CANCELADO">
                        <label for="status2">Cancelada</label><br><br>

                        <label for="motivo">Informe o motívo do cancelamento da compra:</label><br>
                        <textarea name="motivo" id="motivo" cols="30" rows="10"></textarea><br><br>

                        <input type="hidden" name="id" value="${compra.id}">
                        <input type="hidden" name="s" value="${compra.status.id}">
                        
                        <button type="submit" name="logica" value="AtualizarStatus">Atualizar</button>
                        <c:url value="/"><button type="button">Voltar</button></c:url>
                    </form>
                </c:if>
            </c:when>
            <c:otherwise>
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
                                <c:url value="compras?logica=Comprar&p=${p.id}"><button type="button">Comprar</button></c:url>
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
                        <th colspan="1">Ações</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="c" items="${compras}">
                        <c:choose>
                            <c:when test="${c.status.descricao == 'CONCLUIDO'}">
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
                            <td><c:url value="compras?logica=DadosCompra&id=${c.id}"><button type="button">Dados</button></c:url></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </section>

    <footer>
        <%-- Preencher mais tarde --%>
    </footer>
</body>
</html>
