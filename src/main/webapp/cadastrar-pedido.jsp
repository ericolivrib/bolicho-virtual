<%@ page contentType="text/html;charset=UTF-8" language="Java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="pt_BR">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>

    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
        <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
        </symbol>
        <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
            <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
        </symbol>
        <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
            <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
        </symbol>
    </svg>

    <title>Bolicho</title>
</head>

<body>
<header class="mb-5">
    <c:import url="WEB-INF/resources/jsp/navbar.jsp"/>
</header>

<section class="container">
    <div class="d-flex justify-content-center mb-3">
        <h1 class="display-6" style="margin: 30px">Cadastro de pedidos</h1>
    </div>

    <c:if test="${not empty retorno}">
        <div class="alert ${classeAlert} alert-dismissible fade show" role="alert">
            <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="${xlink}"/></svg>
            ${retorno}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <form action="pedidos" method="POST">
        <div class="form-floating mb-3">
            <select name="cliente" id="cliente" class="form-select" required>
                <option selected value="">Selecione</option>
                <c:forEach var="c" items="${clientes}">
                    <c:if test="${c.usuario.permissao.descricao == 'CLIENTE'}">
                        <c:if test="${c.usuario.ativo == true}">
                            <option value="${c.id}">${c.usuario.nome}</option>
                        </c:if>
                    </c:if>
                </c:forEach>
            </select>
            <label for="cliente">Cliente</label>
        </div>
        <div class="row g-2 mb-3">
            <div class="col-md">
                <div class="form-floating">
                    <select name="produto" id="produto" class="form-select" required>
                        <option selected value="">Selecione</option>
                        <c:forEach var="p" items="${produtos}">
                            <c:if test="${p.ativo == true}">
                                <option value="${p.id}">${p.nome}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <label for="produto">Produto</label>
                </div>
            </div>
            <div class="col-md">
                <div class="form-floating">
                    <select name="quantidade" id="quantidade" class="form-select" required>
                        <option selected value="">Selecione</option>
                        <c:forEach var="qtd" begin="1" end="50">
                            <option value="${qtd}">${qtd}</option>
                        </c:forEach>
                    </select>
                    <label for="quantidade">Quantidade</label>
                </div>
            </div>
        </div>
        <div class="form-floating mb-3">
            <select name="vendedor" id="vendedor" class="form-select" required>
                <option selected value="">Selecione</option>
                <c:forEach var="v" items="${vendedores}">
                    <c:if test="${v.usuario.permissao.descricao == 'VENDEDOR'}">
                        <c:if test="${v.usuario.ativo == true}">
                            <option value="${v.id}">${v.usuario.nome}</option>
                        </c:if>
                    </c:if>
                </c:forEach>
            </select>
            <label for="vendedor">Vendedor</label>
        </div>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button type="submit" class="btn btn-success" name="logica" value="Cadastrar">
                <i class="bi bi-cart-plus"></i>
                Cadastrar
            </button>
            <a href="<c:url value="/"/>" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</section>
</body>

</html>