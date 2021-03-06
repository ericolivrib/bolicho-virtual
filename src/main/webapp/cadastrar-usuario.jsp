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
    <form method="POST" action="usuarios" class="mb-3">
        <div class="d-flex justify-content-center mb-3">
            <c:choose>
                <c:when test="${u.id != null}">
                    <h1 class="display-6">Editar Usu??rio</h1>
                    <input type="hidden" name="id" value="${u.id}">
                    <input type="hidden" name="p" value="${u.usuario.permissao.id}">
                    <input type="hidden" name="e" value="${u.usuario.endereco.id}">
                    <input type="hidden" name="u" value="${u.usuario.id}">
                </c:when>
                <c:otherwise>
                    <h1 class="display-6" style="margin: 30px">Cadastro de Usu??rio</h1>
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

        <div class="mb-3">
            <h5>Informa????es de contato:</h5>
        </div>

        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="nome" id="nome" value="${u.usuario.nome}" placeholder="Helena Silva Oliveira" required>
            <label for="nome">Nome</label>
        </div>
        <div class="row g-2 mb-3">
            <div class="col-md">
                <div class="form-floating">
                    <input type="email" class="form-control" name="email" id="email" value="${u.usuario.email}" placeholder="usuario@exemplo.com" required>
                    <label for="email">E-mail</label>
                </div>
            </div>
            <div class="col-md">
                <div class="form-floating">
                    <input type="text" class="form-control" name="telefone" id="telefone" value="${u.usuario.telefone}" required>
                    <label for="telefone">Telefone</label>
                </div>
            </div>
        </div>

        <div class="mb-3">
            <h5>Informa????es de endere??o:</h5>
        </div>

        <div class="row g-2 mb-3">
            <div class="col-md">
                <div class="form-floating">
                    <input type="text" class="form-control" name="rua" id="rua" value="${u.usuario.endereco.rua}" placeholder="Avenida Roraima" required>
                    <label for="rua">Rua</label>
                </div>
            </div>
            <div class="col-md">
                <div class="form-floating">
                    <input type="number" class="form-control" name="numero" id="numero" value="${u.usuario.endereco.numeroCasa}" placeholder="1000" required>
                    <label for="numero">N??mero</label>
                </div>
            </div>
            <div class="col-md">
                <div class="form-floating">
                    <select name="bairro" id="bairro" class="form-select" required>
                        <c:choose>
                            <c:when test="${u.id != null}">
                                <option selected value="${u.usuario.endereco.bairro}">${u.usuario.endereco.bairro}</option>
                            </c:when>
                            <c:otherwise>
                                <option selected value="">Selecione</option>
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
                        <option value="Ch??cara das Flores">Ch??cara das Flores</option>
                        <option value="Cohab F Ferrari">Cohab F Ferrari</option>
                        <option value="Cohab Passo Ferreira">Cohab Passo Ferreira</option>
                        <option value="Cohab Santa Maria">Cohab Santa Maria</option>
                        <option value="Cohab Tancredo Neves">Cohab Tancredo Neves</option>
                        <option value="Di??cono Jo??o Luiz Pozzobon">Di??cono Jo??o Luiz Pozzobon</option>
                        <option value="Distrito Industrial">Distrito Industrial</option>
                        <option value="Divina Provid??ncia">Divina Provid??ncia</option>
                        <option value="Dom Ant??nio Reis">Dom Ant??nio Reis</option>
                        <option value="Duque de Caxias">Duque de Caxias</option>
                        <option value="Faixa Soo Pedro">Faixa Soo Pedro</option>
                        <option value="Formosa">Formosa</option>
                        <option value="Industrial">Industrial</option>
                        <option value="Itarar??">Itarar??</option>
                        <option value="Itaraj??">Itaraj??</option>
                        <option value="Juscelino Kubitschek">Juscelino Kubitschek</option>
                        <option value="Km 3">Km 3</option>
                        <option value="Lorenzi">Lorenzi</option>
                        <option value="Maring??">Maring??</option>
                        <option value="Medianeira">Medianeira</option>
                        <option value="Menino Jesus">Menino Jesus</option>
                        <option value="Noal">Noal</option>
                        <option value="Nonoai">Nonoai</option>
                        <option value="Nossa Senhora das Dores">Nossa Senhora das Dores</option>
                        <option value="Nossa Senhora de F??tima">Nossa Senhora de F??tima</option>
                        <option value="Nossa Senhora de Lourdes">Nossa Senhora de Lourdes</option>
                        <option value="Nossa Senhora do Perp??tuo Socorro">Nossa Senhora do Perp??tuo Socorro</option>
                        <option value="Nossa Senhora do Ros??rio">Nossa Senhora do Ros??rio</option>
                        <option value="Nossa Senhora Dores">Nossa Senhora Dores</option>
                        <option value="Nossa Senhora Medianeira">Nossa Senhora Medianeira</option>
                        <option value="Nova Santa Marta">Nova Santa Marta</option>
                        <option value="Padre de Platano">Padre de Platano</option>
                        <option value="Passo D'areia">Passo D'areia</option>
                        <option value="Passo Tropas">Passo Tropas</option>
                        <option value="Patronato">Patronato</option>
                        <option value="Pinheiro Machado">Pinheiro Machado</option>
                        <option value="Presidente Jo??o Goulart">Presidente Jo??o Goulart</option>
                        <option value="Renascen??a">Renascen??a</option>
                        <option value="Retiro Padres">Retiro Padres</option>
                        <option value="Ruralcel">Ruralcel</option>
                        <option value="Salgado Filho">Salgado Filho</option>
                        <option value="S??o Jo??o">S??o Jo??o</option>
                        <option value="S??o Jos??">S??o Jos??</option>
                        <option value="Sub??rbios">Sub??rbios</option>
                        <option value="Switch">Switch</option>
                        <option value="Tancredo Neves">Tancredo Neves</option>
                        <option value="Tomazetti">Tomazetti</option>
                        <option value="Uglione">Uglione</option>
                        <option value="Urlandia">Urlandia</option>
                        <option value="Vila Arco-??ris">Vila Arco-??ris</option>
                        <option value="Vila Bilibio">Vila Bilibio</option>
                        <option value="Vila Fighera">Vila Fighera</option>
                        <option value="Vila Formosa">Vila Formosa</option>
                        <option value="Zona Rural">Zona Rural</option>
                    </select>
                    <label for="bairro">Bairro</label>
                </div>
            </div>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="complemento" id="complemento" value="${u.usuario.endereco.complemento}" placeholder="CEU II">
            <label for="complemento">Complemento</label>
        </div>

        <div class="mb-3">
            <h5>Permiss??o do usu??rio:</h5>
        </div>

        <c:if test="${u.id == null}">
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="permissao" id="permissao1" value="CLIENTE" checked>
                <label class="form-check-label" for="permissao1">Cliente</label>
            </div>
            <div class="form-check form-check-inline mb-3">
                <input class="form-check-input" type="radio" name="permissao" id="permissao2" value="VENDEDOR">
                <label class="form-check-label" for="permissao2">Vendedor</label>
            </div>
        </c:if>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <c:choose>
                <c:when test="${u.id == null}"> <%-- Cadastrar um usu??rio --%>
                    <button type="submit" class="btn btn-success" name="logica" value="Cadastrar">
                        <i class="bi bi-person-plus"></i>
                        Cadastrar
                    </button>
                    <a href="<c:url value="/"/>" class="btn btn-secondary">Cancelar</a>
                </c:when>
                <c:otherwise> <%-- Atualizar um usu??rio --%>
                    <button type="submit" class="btn btn-success" name="logica" value="Atualizar">
                        <i class="bi bi-person-check"></i>
                        Atualizar
                    </button>
                    <a href="<c:url value="usuarios?logica=Listar"/>" class="btn btn-secondary">Cancelar</a>
                </c:otherwise>
            </c:choose>
        </div>
    </form>
</section>
<script>
    $(document).ready(function($) {
        $("#telefone").mask("(00) 00000-0000", {placeholder: "(  ) _____-____"});
    });
</script>
</body>

</html>