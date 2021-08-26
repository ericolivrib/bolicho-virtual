<%@ page contentType="text/html;charset=UTF-8" language="Java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="pt">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Meu CSS -->
    <style><%@ include file="css/style.css" %></style>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
            crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>

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
                        <a class="nav-link dropdown-toggle active" aria-current="page" href="#" id="produtosDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Produtos</a>
                        <ul class="dropdown-menu" aria-labelledby="produtosDropdown">
                            <li>
                                <a class="dropdown-item" href="<c:url value="operacoes-produto.jsp"/>">"Cadastrar Produto</a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <a class="dropdown-item" href="<c:url value="produtos?logica=Listar"/>">Listar Produtos</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="usuariosDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            Usuários
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="usuariosDropdown">
                            <li><a class="dropdown-item" href="<c:url value="operacoes-usuario.jsp"/>">Cadastrar Usuário</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="<c:url value="usuarios?logica=Listar"/>">Listar Usuários</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Sobre nós</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<section class="container">

    <div class="d-flex justify-content-center mb-3">
        <h1 class="titulo">Tabela de Usuários</h1>
    </div>

    <c:if test="${not empty retorno}">
        <div class="alert ${classeAlert} alert-dismissible fade show" role="alert">
            <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="${xlink}"/></svg>
            ${retorno}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <table class="table table-striped table-hover">
        <ul class="nav nav-tabs">
            <c:choose>
                <c:when test="${clientes != null}">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page">Clientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="usuarios?logica=Listar&permissao=vendedores"/>">Vendedores</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="usuarios?logica=Listar&permissao=clientes"/>">Clientes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page">Vendedores</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Nome</th>
            <th scope="col">E-mail</th>
            <th scope="col">Telefone</th>
            <th scope="col">Endereço</th>
            <th scope="col">Data de cadastro</th>
            <th scope="col">Ações</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty clientes}">
                <c:forEach var="u" items="${clientes}">
                    <tr>
                        <th scope="row">${u.id}</th>
                        <td>${u.usuario.nome}</td>
                        <td>${u.usuario.email}</td>
                        <td>${u.usuario.telefone}</td>
                        <td>
                            <a href="#" class="btn btn-outline-dark view_data" data-bs-toggle="modal" data-bs-target="#usuarioModal"
                               data-bs-whatever="${u.usuario.endereco.rua}+${u.usuario.endereco.numeroCasa}+${u.usuario.endereco.bairro}+${u.usuario.endereco.complemento}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="43" height="16" fill="currentColor" class="bi bi-file-text-fill" viewBox="0 0 16 16">
                                    <path d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM5 4h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1zm-.5 2.5A.5.5 0 0 1 5 6h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5zM5 8h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1zm0 2h3a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1z"/>
                                </svg>
                            </a>
                        </td>
                        <td>${u.usuario.dataCadastro}</td>
                        <td>
                            <a class="btn btn-primary" href="<c:url value="usuarios?logica=Editar&id=${u.id}&permissao=${u.usuario.permissao.id}" />">Editar</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach var="u" items="${vendedores}">
                    <tr>
                        <th scope="row">${u.id}</th>
                        <td>${u.usuario.nome}</td>
                        <td>${u.usuario.email}</td>
                        <td>${u.usuario.telefone}</td>
                        <td>
                            <a href="#" class="btn btn-outline-dark view_data" data-bs-toggle="modal" data-bs-target="#usuarioModal"
                               data-bs-whatever="${u.usuario.endereco.rua}+${u.usuario.endereco.numeroCasa}+${u.usuario.endereco.bairro}+${u.usuario.endereco.complemento}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="43" height="16" fill="currentColor" class="bi bi-file-text-fill" viewBox="0 0 16 16">
                                    <path d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM5 4h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1zm-.5 2.5A.5.5 0 0 1 5 6h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5zM5 8h6a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1zm0 2h3a.5.5 0 0 1 0 1H5a.5.5 0 0 1 0-1z"/>
                                </svg>
                            </a>
                        </td>
                        <td>${u.usuario.dataCadastro}</td>
                        <td>
                            <a class="btn btn-primary" href="<c:url value="usuarios?logica=Editar&id=${u.id}&permissao=${u.usuario.permissao.id}" />">Editar</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        </tbody>
        <tfoot>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Nome</th>
            <th scope="col">E-mail</th>
            <th scope="col">Telefone</th>
            <th scope="col">Endereço</th>
            <th scope="col">Data de cadastro</th>
            <th scope="col">Ações</th>
        </tr>
        </tfoot>
    </table>
</section>

<div class="modal fade" id="usuarioModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Endereço do usuário</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row g-2 mb-3">
                        <div class="col-md">
                            <div class="form-floating">
                                <input class="form-control" type="text" name="rua" id="rua" value="" disabled>
                                <label for="rua">Rua</label>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="form-floating">
                                <input class="form-control" type="number" name="numero" id="numero" value="" disabled>
                                <label for="numero">Número</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-floating mb-3">
                        <input class="form-control" type="text" name="bairro" id="bairro" value="" disabled>
                        <label for="bairro">Bairro</label>
                    </div>
                    <div class="form-floating">
                        <textarea class="form-control" name="complemento" id="complemento" style="height: 200px;" disabled></textarea>
                        <label for="complemento">Complemento</label>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
    </div>
</div>


<script>
    var produtoModal = document.getElementById('usuarioModal')
    produtoModal.addEventListener('show.bs.modal', function (event) {
        var botao = event.relatedTarget
        var address = botao.getAttribute('data-bs-whatever')

        var endereco = address.split("+")

        var rua = usuarioModal.querySelector('.modal-body #rua')
        var numero = usuarioModal.querySelector('.modal-body #numero')
        var bairro = usuarioModal.querySelector('.modal-body #bairro')
        var complemento = usuarioModal.querySelector('.modal-body #complemento')

        rua.value = endereco[0]
        numero.value = endereco[1]
        bairro.value = endereco[2]
        complemento.innerHTML = endereco[3]
    })
</script>
</body>

</html>