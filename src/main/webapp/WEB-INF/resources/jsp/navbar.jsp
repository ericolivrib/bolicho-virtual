<%@ page contentType="text/html;charset=UTF-8" language="Java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <button class="navbar-toggler ml-auto custom-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" style="border-color: #ffffff;">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand mb-0 h1" href="<c:url value="/"/>" style="font-family: 'Open Sans', sans-serif;">Bolicho</a>
        <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel" style="background-color: #000000;">
            <div class="offcanvas-header bg-dark" style="color: #ffffff;">
                <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Menu</h5>
                <button type="button" class="btn-close btn-close-white text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 ">
                    <li>
                        <a href="<c:url value="/"/>" class="nav-link px-0 align-middle active">
                            <i class="bi bi-house"></i>
                            <span class="ms-1 d-none d-sm-inline">Home</span>
                        </a>
                    </li>
                    <li><hr class="dropdown-divider bg-white"></li>
                    <li>
                        <a href="#submenu1" data-bs-toggle="collapse" class="nav-link px-0 align-middle active">
                            <i class="bi bi-table"></i>
                            <span class="ms-1 d-none d-sm-inline">Pedidos</span>
                        </a>
                        <ul class="collapse show nav flex-column ms-1" id="submenu1" data-bs-parent="#menu">
                            <li class="w-100"><a href="<c:url value="pedidos?logica=Registrar"/>" class="nav-link px-0"> <span class="d-none d-sm-inline">Cadastrar Pedido</span></a></li>
                            <li><a href="<c:url value="pedidos?logica=Listar&status=PENDENTE"/>" class="nav-link px-0"> <span class="d-none d-sm-inline">Visualizar Pedidos</span></a></li>
                        </ul>
                    </li>
                    <li><hr class="dropdown-divider bg-white"></li>
                    <li>
                        <a href="#submenu2" data-bs-toggle="collapse" class="nav-link px-0 align-middle active">
                            <i class="bi bi-basket2"></i>
                            <span class="ms-1 d-none d-sm-inline">Produtos</span>
                        </a>
                        <ul class="collapse show nav flex-column ms-1" id="submenu2" data-bs-parent="#menu">
                            <li class="w-100"><a href="<c:url value="/cadastrar-produto.jsp"/>" class="nav-link px-0"> <span class="d-none d-sm-inline">Cadastrar Produto</span></a></li>
                            <li><a href="<c:url value="produtos?logica=Listar"/>" class="nav-link px-0"> <span class="d-none d-sm-inline">Visualizar Produtos</span></a></li>
                        </ul>
                    </li>
                    <li><hr class="dropdown-divider bg-white"></li>
                    <li>
                        <a href="#submenu3" data-bs-toggle="collapse" class="nav-link px-0 align-middle active">
                            <i class="bi bi-people"></i>
                            <span class="ms-1 d-none d-sm-inline">Usuários</span>
                        </a>
                        <ul class="collapse show nav flex-column ms-1" id="submenu3" data-bs-parent="#menu">
                            <li class="w-100"><a href="<c:url value="/cadastrar-usuario.jsp"/>" class="nav-link px-0"> <span class="d-none d-sm-inline">Cadastrar Usuário</span></a></li>
                            <li><a href="<c:url value="usuarios?logica=Listar"/>" class="nav-link px-0"> <span class="d-none d-sm-inline">Visualizar Usuários</span></a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="offcanvas-footer"></div>
        </div>
    </div>
</nav>
