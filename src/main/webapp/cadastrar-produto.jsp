<%@ page contentType="text/html;charset=UTF-8" language="Java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="pt_BR">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

    <script>
        <c:import url="WEB-INF/resources/js/jquery.mask.js"/>
    </script>

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
    <form action="produtos" method="POST">
        <div class="d-flex justify-content-center mb-3">
            <c:choose>
                <c:when test="${produto.id != null}">
                    <input type="hidden" name="id" value="${produto.id}">
                    <h1 class="display-6" style="margin: 30px">Editar produto</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="display-6" style="margin: 30px">Cadastro de produtos</h1>
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

        <div class="row g-3 mb-3">
            <div class="col-md">
                <div class="form-floating">
                    <input type="text" class="form-control" id="nome" name="nome" value="${produto.nome}" placeholder="Queijo Colonial" required>
                    <label for="nome">Nome</label>
                </div>
            </div>
            <div class="col-md">
                <div class="form-floating">
                    <input type="text" class="form-control" id="preco" name="preco" value="${produto.preco}" placeholder="20" required>
                    <label for="preco">Pre??o</label>
                </div>
            </div>
        </div>
        <div class="form-floating mb-3">
            <textarea class="form-control" id="detalhes" name="detalhes" placeholder="Fresco ou em inicio de matura????o" style="height: 120px;" required>${produto.detalhes}</textarea>
            <label for="detalhes">Detalhes</label>
        </div>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <c:choose>
                <c:when test="${produto.id == null}">
                    <button type="submit" class="btn btn-success" name="logica" value="Cadastrar">
                        <i class="bi bi-bag-check"></i>
                        Cadastrar
                    </button>
                    <a href="<c:url value="/"/>" class="btn btn-secondary">Cancelar</a>
                </c:when>
                <c:otherwise>
                    <button type="submit" class="btn btn-success" name="logica" value="Atualizar">
                        <i class="bi bi-bag-check"></i>
                        Atualizar
                    </button>
                    <a href="<c:url value="produtos?logica=Listar"/>" class="btn btn-secondary">Cancelar</a>
                </c:otherwise>
            </c:choose>
        </div>
    </form>
</section>
<script>
    $(document).ready(function($) {
        $('#preco').mask('#.##0.00', {reverse: true});
    });
</script>
</body>

</html>