package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/")
public class IndexController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("Redirecionando para a página inicial...");

        req.setAttribute("logica", "CadastrarCliente");

        req.getRequestDispatcher("clientes?logica=ListarClientes").forward(req, resp);
    }
}
