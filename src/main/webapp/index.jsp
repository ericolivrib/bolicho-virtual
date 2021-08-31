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

    <title>Bolicho</title>
</head>

<body>
<header class="mb-5">
    <c:import url="WEB-INF/resources/jsp/navbar.jsp"/>
</header>

<section class="container">

    <div class="d-flex justify-content-center">
        <h1 class=" display-4" style="margin: 30px">Olá!</h1>
    </div>
    <div class="d-flex justify-content-center mb-4">
        <h2 class="display-6">Escolha uma operação:</h2>
    </div>

    <div class="row g-5 mb-3">
        <div class="col">
            <div class="border border-4 border-dark bg-primary bg-gradient" style="border-radius: 10px;">
                <div class="d-flex justify-content-center">
                    <i class="bi bi-people-fill" style="font-size: 6em"></i>
                </div>
                <div class="accordion accordion-flush" id="accordionFlushUsuarios">
                    <div class="accordion-item border" style="border-bottom-left-radius: 7px; border-bottom-right-radius: 7px">
                        <h2 class="accordion-header" id="flush-headingOne">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#acoes-usuarios" aria-expanded="false" aria-controls="acoes-usuarios">
                                Usuários
                            </button>
                        </h2>
                        <div id="acoes-usuarios" class="accordion-collapse collapse border border-0" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushUsuarios" style="background-color: #e1e1e1;">
                            <div class="accordion-body">
                                <a href="<c:url value="/cadastrar-usuario.jsp"/>" class="btn d-flex justify-content-center">
                                    Cadastrar Usuário
                                </a>
                            </div>
                        </div>
                        <div id="acoes-usuarios" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushUsuarios">
                            <div class="accordion-body">
                                <a href="<c:url value="usuarios?logica=Listar"/>" class="btn d-flex justify-content-center">
                                    Visualizar Usuários
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="border border-4 border-dark bg-warning bg-gradient" style="border-radius: 10px;">
                <div class="d-flex justify-content-center">
                    <i class="bi bi-basket2-fill" style="font-size: 6em"></i>
                </div>
                <div class="accordion accordion-flush" id="accordionFlushProdutos">
                    <div class="accordion-item border" style="border-bottom-left-radius: 7px; border-bottom-right-radius: 7px">
                        <h2 class="accordion-header" id="flush-headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#acoes-produtos" aria-expanded="false" aria-controls="acoes-produtos">
                                Produtos
                            </button>
                        </h2>
                        <div id="acoes-produtos" class="accordion-collapse collapse border border-0" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushProdutos" style="background-color: #e1e1e1;">
                            <div class="accordion-body">
                                <a href="<c:url value="/cadastrar-produto.jsp"/>" class="btn d-flex justify-content-center">
                                    Cadastrar Produto
                                </a>
                            </div>
                        </div>
                        <div id="acoes-produtos" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushProdutos">
                            <div class="accordion-body">
                                <a href="<c:url value="produtos?logica=Listar"/>" class="btn d-flex justify-content-center">
                                    Visualizar Produtos
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="border border-4 border-dark bg-success bg-gradient" style="border-radius: 10px;">
                <div class="d-flex justify-content-center">
                    <i class="bi bi-table" style="font-size: 6em"></i>
                </div>
                <div class="accordion accordion-flush" id="accordionFlushPedidos">
                    <div class="accordion-item border" style="border-bottom-left-radius: 7px; border-bottom-right-radius: 7px">
                        <h2 class="accordion-header" id="flush-headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#acoes-pedido" aria-expanded="false" aria-controls="acoes-pedido">
                                Pedidos
                            </button>
                        </h2>
                        <div id="acoes-pedido" class="accordion-collapse collapse border border-0" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushPedidos" style="background-color: #e1e1e1;">
                            <div class="accordion-body">
                                <a href="<c:url value="pedidos?logica=Registrar"/>" class="btn d-flex justify-content-center">
                                    Cadastrar Pedido
                                </a>
                            </div>
                        </div>
                        <div id="acoes-pedido" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushPedidos">
                            <div class="accordion-body">
                                <a href="<c:url value="pedidos?logica=Listar&status=PENDENTE"/>" class="btn d-flex justify-content-center">
                                    Visualizar Pedidos
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

</body>

</html>