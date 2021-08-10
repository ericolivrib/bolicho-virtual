<%@ page contentType="text/html;charset=UTF-8" language="Java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <form action="vendedores" method="POST">
            <c:choose>
                <c:when test="${logica == 'AtualizarVendedor'}">
                    <input type="hidden" name="id" value="${vendedor.id}">
                    <input type="hidden" name="usuario_id" value="${vendedor.usuario.id}">
                    <input type="hidden" name="endereco_id" value="${vendedor.usuario.endereco.id}">

                    <h1>Editar vendedor</h1>
                </c:when>
                <c:otherwise>
                    <h1>Cadastrar vendedor</h1>
                </c:otherwise>
            </c:choose>

            <p><strong>Informações de usuário</strong></p>
            <input type="text" name="nome" value="${vendedor.usuario.nome}" required placeholder="Nome"><br>
            <input type="email" name="email" value="${vendedor.usuario.email}" required placeholder="E-mail"><br>
            <input type="text" name="telefone" value="${vendedor.usuario.telefone}" required placeholder="Telefone"><br>
            <input type="password" name="senha" value="${vendedor.usuario.senha}" required placeholder="Senha"><br><br>

            <p><strong>Informações de endereço</strong></p>
            <input type="text" name="rua" value="${vendedor.usuario.endereco.rua}" required placeholder="Rua"><br>
            <input type="number" min="0" name="numero_casa" value="${vendedor.usuario.endereco.numeroCasa}" required placeholder="Número"><br>
            <select name="bairro" required>
                <c:choose>
                    <c:when test="${logica == 'AtualizarVendedor'}">
                        <option selected value="${vendedor.usuario.endereco.bairro}">${vendedor.usuario.endereco.bairro}</option>
                    </c:when>
                    <c:otherwise>
                        <option selected disabled value="">Bairro</option>
                    </c:otherwise>
                </c:choose>
                <option value="Agroindustrial">Agroindustrial</option>
                <option value="Arroio Grande">Arroio Grande</option>
                <option value="Boi Morto">Boi Morto</option>
                <option value="Bonfim">Bonfim</option>
                <option value="Camobi">Camobi</option>
                <option value="Campestre do Menino Deus">Campestre do Menino Deus</option>
                <option value="Caramelo">Caramelo</option>
                <option value="Carolina">Carolina</option>
                <option value="Caturrita">Caturrita</option>
                <option value="Cauduro">Cauduro</option>
                <option value="Centro">Centro</option>
                <option value="Cerrito">Cerrito</option>
                <option value="Chácara das Flores">Chácara das Flores</option>
                <option value="Cohab F Ferrari">Cohab F Ferrari</option>
                <option value="Cohab Passo Ferreira">Cohab Passo Ferreira</option>
                <option value="Cohab Santa Maria">Cohab Santa Maria</option>
                <option value="Cohab Tancredo Neves">Cohab Tancredo Neves</option>
                <option value="Diácono João Luiz Pozzobon">Diácono João Luiz Pozzobon</option>
                <option value="Distrito Industrial">Distrito Industrial</option>
                <option value="Divina Providência">Divina Providência</option>
                <option value="Dom Antônio Reis">Dom Antônio Reis</option>
                <option value="Duque de Caxias">Duque de Caxias</option>
                <option value="Faixa Soo Pedro">Faixa Soo Pedro</option>
                <option value="Formosa">Formosa</option>
                <option value="Industrial">Industrial</option>
                <option value="Itararé">Itararé</option>
                <option value="Itarajú">Itarajú</option>
                <option value="Juscelino Kubitschek">Juscelino Kubitschek</option>
                <option value="Km 3">Km 3</option>
                <option value="Lorenzi">Lorenzi</option>
                <option value="Maringá">Maringá</option>
                <option value="Medianeira">Medianeira</option>
                <option value="Menino Jesus">Menino Jesus</option>
                <option value="Noal">Noal</option>
                <option value="Nonoai">Nonoai</option>
                <option value="Nossa Senhora das Dores">Nossa Senhora das Dores</option>
                <option value="Nossa Senhora de Fátima">Nossa Senhora de Fátima</option>
                <option value="Nossa Senhora de Lourdes">Nossa Senhora de Lourdes</option>
                <option value="Nossa Senhora do Perpétuo Socorro">Nossa Senhora do Perpétuo Socorro</option>
                <option value="Nossa Senhora do Rosário">Nossa Senhora do Rosário</option>
                <option value="Nossa Senhora Dores">Nossa Senhora Dores</option>
                <option value="Nossa Senhora Medianeira">Nossa Senhora Medianeira</option>
                <option value="Nova Santa Marta">Nova Santa Marta</option>
                <option value="Padre de Platano">Padre de Platano</option>
                <option value="Passo D'areia">Passo D'areia</option>
                <option value="Passo Tropas">Passo Tropas</option>
                <option value="Patronato">Patronato</option>
                <option value="Pinheiro Machado">Pinheiro Machado</option>
                <option value="Presidente João Goulart">Presidente João Goulart</option>
                <option value="Renascença">Renascença</option>
                <option value="Retiro Padres">Retiro Padres</option>
                <option value="Ruralcel">Ruralcel</option>
                <option value="Salgado Filho">Salgado Filho</option>
                <option value="São João">São João</option>
                <option value="São José">São José</option>
                <option value="Subúrbios">Subúrbios</option>
                <option value="Switch">Switch</option>
                <option value="Tancredo Neves">Tancredo Neves</option>
                <option value="Tomazetti">Tomazetti</option>
                <option value="Uglione">Uglione</option>
                <option value="Urlandia">Urlandia</option>
                <option value="Vila Arco-íris">Vila Arco-íris</option>
                <option value="Vila Bilibio">Vila Bilibio</option>
                <option value="Vila Fighera">Vila Fighera</option>
                <option value="Vila Formosa">Vila Formosa</option>
                <option value="Zona Rural">Zona Rural</option>
            </select><br>
            <input type="text" name="complemento" value="${vendedor.usuario.endereco.complemento}" placeholder="Complemento"><br>

            <button type="submit" name="logica" value="${logica}">Confirmar</button>
            <c:if test="${logica == 'AtualizarVendedor'}">
                <a href="http://localhost:8080/bolicho-virtual/vendedores?logica=ListarVendedores">
                    <button type="button">Cancelar</button></a>
            </c:if>
        </form>

        <c:if test="${not empty retorno}">
            <p>${retorno}</p>
        </c:if>

        <c:if test="${logica != 'AtualizarVendedor'}">
            <h2>Lista de vendedores</h2>

            <table>
                <thead>
                <tr>
                    <th>Nome</th>
                    <th>E-mail</th>
                    <th>Telefone</th>
                    <th>Endereço</th>
                    <th>Data de início</th>
                    <th colspan="2">Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="v" items="${vendedores}">
                    <tr>
                        <td>${v.usuario.nome}</td>
                        <td>${v.usuario.email}</td>
                        <td>${v.usuario.telefone}</td>
                        <td>${v.usuario.endereco.rua}, ${v.usuario.endereco.numeroCasa} - ${v.usuario.endereco.bairro}</td>
                        <td>${v.usuario.dataCadastro}</td>
                        <td><a href="http://localhost:8080/bolicho-virtual/vendedores?logica=EditarVendedor&id=${v.id}">Editar</a></td>
                        <td><a href="http://localhost:8080/bolicho-virtual/vendedores?logica=RemoverVendedor&id=${v.id}&usuario_id=${v.usuario.id}&endereco_id=${v.usuario.endereco.id}">Remover</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </section>
</body>
</html>
