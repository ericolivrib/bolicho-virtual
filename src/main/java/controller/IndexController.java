package controller;

import dao.ProdutoDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/")
public class IndexController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("Redirecionando para a página inicial...");

        Connection conexao = (Connection) req.getAttribute("conexao");

        req.setAttribute("produtos", new ProdutoDao(conexao).selecionar());
        req.setAttribute("logica", "AdicionarProduto");

        req.getRequestDispatcher("/produtos.jsp").forward(req, resp);
    }
}
