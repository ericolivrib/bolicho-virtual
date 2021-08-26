<%@ page contentType="text/html;charset=UTF-8" language="Java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="pt">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style><%@ include file="css/style.css" %></style>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
          crossorigin="anonymous">

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
            crossorigin="anonymous"></script>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>

    <!-- Plug-in das máscaras -->
    <script src="js/jquery.maskedinput.js"></script>

    <!-- Máscaras dos formulários -->
    <script src="js/mask.js"></script>

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
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark bg-gradient">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Bolicho</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="float-end" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="produtos" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false" aria-current="page">
                            Produtos
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="produtos">
                            <li><a class="dropdown-item" href="<c:url value="operacoes-produto.jsp" />">Cadastrar Produto</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="<c:url value="produtos?logica=Listar" />">Listar Produtos</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="usuarios" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            Usuários
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="usuarios">
                            <li><a class="dropdown-item" href="<c:url value="operacoes-usuario.jsp" />">Cadastrar Usuário</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="<c:url value="usuarios?logica=Listar" />">Listar Usuários</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="#">Sobre nós</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<section class="container">

    <form action="produtos" method="POST">
        <div class="d-flex justify-content-center mb-3">
            <c:choose>
                <c:when test="${produto.id != null}">
                    <input type="hidden" name="id" value="${produto.id}">
                    <h1 class="titulo">Editar produto</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="titulo">Cadastro de produtos</h1>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${not empty retorno}">
            <div class="alert ${classeAlert} alert-dismissible fade show" role="alert">
                <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="${xlink}"/></svg>
                ${retorno}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <div class="">
            <div class="row g-2 mb-3">
                <div class="col-md">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="nome" name="nome" value="${produto.nome}" placeholder="Queijo Colonial"
                               required>
                        <label for="nome">Nome</label>
                    </div>
                </div>
                <div class="col-md">
                    <div class="form-floating">
                        <input type="number" step="0.01" min="0" class="form-control" id="preco" name="preco" value="${produto.preco}" placeholder="20" required>
                        <label for="preco">Preço</label>
                    </div>
                </div>
            </div>
            <div class="form-floating mb-3">
                <textarea class="form-control" id="detalhes" name="detalhes"
                          placeholder="Fresco ou em inicio de maturação"
                          style="height: 200px;" required>${produto.detalhes}</textarea>
                <label for="detalhes">Detalhes</label>
            </div>
            <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                <c:choose>
                    <c:when test="${produto.id == null}">
                        <button type="submit" class="btn btn-success" name="logica" value="Cadastrar">Confirmar</button>
                        <a href="<c:url value="/"/>" class="btn btn-secondary">Cancelar</a>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" class="btn btn-success" name="logica" value="Atualizar">Confirmar</button>
                        <a href="<c:url value="produtos?logica=Listar"/>" class="btn btn-secondary">Cancelar</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form>
</section>
</body>

</html>