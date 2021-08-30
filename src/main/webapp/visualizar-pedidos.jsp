<%@ page contentType="text/html;charset=UTF-8" language="Java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="pt_BR">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

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
    <c:import url="WEB-INF/resources/components/navbar.jsp"/>
</header>

<section class="container">
    <div class="d-flex justify-content-center mb-3">
        <h1 class="display-6" style="margin: 30px">Tabela de pedidos</h1>
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
                <c:when test="${status == 'PENDENTE'}">
                    <li class="nav-item">
                        <a href="" class="nav-link active" aria-current="page">Pendentes</a>
                    </li>
                    <li class="nav-item">
                        <a href="pedidos?logica=Listar&status=CONCLUIDO" class="nav-link">Concluídos</a>
                    </li>
                    <li class="nav-item">
                        <a href="pedidos?logica=Listar&status=CANCELADO" class="nav-link">Cancelados</a>
                    </li>
                </c:when>
                <c:when test="${status == 'CONCLUIDO'}">
                    <li class="nav-item">
                        <a href="pedidos?logica=Listar&status=PENDENTE" class="nav-link">Pendentes</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="nav-link active" aria-current="page">Concluídos</a>
                    </li>
                    <li class="nav-item">
                        <a href="pedidos?logica=Listar&status=CANCELADO" class="nav-link">Cancelados</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a href="pedidos?logica=Listar&status=PENDENTE" class="nav-link">Pendentes</a>
                    </li>
                    <li class="nav-item">
                        <a href="pedidos?logica=Listar&status=CONCLUIDO" class="nav-link">Concluídos</a>
                    </li>
                    <li class="nav-item">
                        <a href="" class="nav-link active" aria-current="page">Cancelados</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
        <thead>
        <tr>
            <th scope="col">Cliente</th>
            <th scope="col">Vendedor</th>
            <th scope="col">Data Pedido</th>
            <c:choose>
                <c:when test="${status == 'CONCLUIDO'}">
                    <th scope="col">Data Entrega</th>
                </c:when>
                <c:when test="${status == 'CANCELADO'}">
                    <th scope="col">Data Cancelamento</th>
                    <th scope="col">Motivo</th>
                </c:when>
            </c:choose>
            <th scope="col">Produto</th>
            <th scope="col">Quantidade</th>
            <th scope="col">Valor</th>
            <c:if test="${status == 'PENDENTE'}">
                <th scope="col">Concluir</th>
                <th scope="col">Cancelar</th>
            </c:if>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${pedidos}">
            <tr>
                <td>${p.cliente.usuario.nome}</td>
                <td>${p.vendedor.usuario.nome}</td>
                <td scope="row">${p.dataPedido}</td>
                <c:choose>
                    <c:when test="${status == 'CONCLUIDO'}">
                        <td>${p.status.data}</td>
                    </c:when>
                    <c:when test="${status == 'CANCELADO'}">
                        <td>${p.status.data}</td>
                        <td>
                            <button type="button" class="btn btn-outline-dark view_data" data-bs-toggle="modal" data-bs-target="#motivoCancelamentoModal" data-bs-whatever="${p.status.motivo}">
                                <i class="bi bi-eye-fill"></i>
                            </button>
                        </td>
                    </c:when>
                </c:choose>
                <td>${p.item.produto.nome}</td>
                <td>${p.item.quantidade}</td>
                <td>R$ ${p.valor}</td>
                <c:if test="${status == 'PENDENTE'}">
                    <td>
                        <a href="<c:url value="pedidos?logica=Atualizar&id=${p.id}&s=${p.status.id}"/>" class="btn btn-primary">
                            <i class="bi bi-check-circle-fill"></i>
                        </a>
                    </td>
                    <td>
                        <button type="button" class="btn btn-danger view_data" data-bs-toggle="modal" data-bs-target="#pedidoModal" data-bs-whatever="${p.id}+${p.status.id}">
                            <i class="bi bi-x-octagon-fill"></i>
                        </button>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <th scope="col">Cliente</th>
            <th scope="col">Vendedor</th>
            <th scope="col">Data Pedido</th>
            <c:choose>
                <c:when test="${status == 'CONCLUIDO'}">
                    <th scope="col">Data Entrega</th>
                </c:when>
                <c:when test="${status == 'CANCELADO'}">
                    <th scope="col">Data Cancelamento</th>
                    <th scope="col">Motivo</th>
                </c:when>
            </c:choose>
            <th scope="col">Produto</th>
            <th scope="col">Quantidade</th>
            <th scope="col">Valor</th>
            <c:if test="${status == 'PENDENTE'}">
                <th scope="col">Concluir</th>
                <th scope="col">Cancelar</th>
            </c:if>
        </tr>
        </tfoot>
    </table>
</section>

<div class="modal fade" id="pedidoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Cancelamento de pedido</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="pedidos" method="POST">
                    <div class="mb-3">
                        <h6>Informe o motivo do cancelamento da compra:</h6>
                    </div>

                    <input type="hidden" name="id" id="id" value="">
                    <input type="hidden" name="s" id="statusId" value="">

                    <div class="form-floating mb-3">
                        <textarea class="form-control" id="motivo" name="motivo" style="height: 200px;"></textarea>
                        <label for="motivo">Motivo</label>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                        <button type="submit" class="btn btn-primary" name="logica" value="Atualizar">Confirmar Cancelamento</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="motivoCancelamentoModal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel1">Cancelamento de pedido</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="pedidos" method="POST">
                    <div class="mb-3">
                        <h6>Motivo do cancelamento</h6>
                    </div>

                    <div class="form-floating mb-3">
                        <textarea class="form-control" id="causa" name="motivo" style="height: 200px;" disabled></textarea>
                        <label for="causa">Motivo</label>
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
    var pedidoModal = document.getElementById('pedidoModal')
    pedidoModal.addEventListener('show.bs.modal', function (event) {
        var botao = event.relatedTarget
        var hidden = botao.getAttribute('data-bs-whatever').split("+")

        var inputHiddenPedido = pedidoModal.querySelector('.modal-body #id')
        var inputHiddenStatus = pedidoModal.querySelector('.modal-body #statusId')

        inputHiddenPedido.value = hidden[0]
        inputHiddenStatus.value = hidden[1]
    })

    var motivoCancelamentoModal = document.getElementById('motivoCancelamentoModal')
    motivoCancelamentoModal.addEventListener('show.bs.modal', function (event) {
        var botao = event.relatedTarget
        var causa = botao.getAttribute('data-bs-whatever')
        var textarea = motivoCancelamentoModal.querySelector('.modal-body #causa')
        textarea.innerHTML = causa
    })
</script>

</body>

</html>
