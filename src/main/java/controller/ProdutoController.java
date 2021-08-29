package controller;

import dao.ProdutoDao;
import model.Produto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.ArrayList;

@WebServlet("produtos")
public class ProdutoController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.ProdutoController$" + parametro;

        try {
            Class<?> classe = Class.forName(nomeClasse);

            Logica logica = (Logica) classe.newInstance();
            String pagina = logica.executa(req, resp);

            req.getRequestDispatcher(pagina).forward(req, resp);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static class Listar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[PRODUTOS] Listando produtos...");

            Connection conexao = (Connection) req.getAttribute("conexao");

            ArrayList<Produto> produtos = new ProdutoDao(conexao).selecionar();

            req.setAttribute("produtos", produtos);
            req.setAttribute("logica", "Cadastrar");

            return "visualizar-produtos.jsp";
        }
    }

    public static class Cadastrar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[PRODUTOS] Adicionando produto...");

            String nome = req.getParameter("nome");
            BigDecimal preco = new BigDecimal(req.getParameter("preco"));
            String detalhes = req.getParameter("detalhes");

            Produto produto = new Produto(nome, preco, detalhes);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ProdutoDao(conexao).inserir(produto);

            if (retorno.equals("OK")) {
                req.setAttribute("xlink", "#check-circle-fill");
                req.setAttribute("classeAlert", "alert-success");
                req.setAttribute("retorno", "<strong>OK!</strong> " + nome + " foi cadastrado e adicionado à lista de produtos!");
            } else {
                req.setAttribute("xlink", "#exclamation-triangle-fill");
                req.setAttribute("classeAlert", "alert-warning");
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível cadastrar " + nome + "!");
            }

            req.setAttribute("logica", "Cadastrar");

            return "cadastrar-produto.jsp";
        }
    }

    public static class Editar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[PRODUTOS] Selecionando produto para edição...");

            int id = Integer.parseInt(req.getParameter("id"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            Produto produto = new ProdutoDao(conexao).selecionar(id);

            req.setAttribute("produto", produto);
            req.setAttribute("logica", "Atualizar");

            return "cadastrar-produto.jsp";
        }
    }

    public static class Atualizar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[PRODUTOS] Atualizando produto...");

            int id = Integer.parseInt(req.getParameter("id"));
            String nome = req.getParameter("nome");
            BigDecimal preco = new BigDecimal(req.getParameter("preco"));
            String detalhes = req.getParameter("detalhes");

            Produto produto = new Produto(id, nome, preco, detalhes);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ProdutoDao(conexao).atualizar(produto);

            if (retorno.equals("OK")) {
                req.setAttribute("xlink", "#check-circle-fill");
                req.setAttribute("classeAlert", "alert-success");
                req.setAttribute("retorno", "<strong>OK!</strong> Produto atualizado!");
            } else {
                req.setAttribute("xlink", "#exclamation-triangle-fill");
                req.setAttribute("classeAlert", "alert-warning");
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível atualizar o produto!");
            }

            req.setAttribute("logica", "Cadastrar");

            return "produtos?logica=Listar";
        }
    }

    public static class Remover implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[PRODUTOS] Removendo produto...");

            int id = Integer.parseInt(req.getParameter("id"));

            Produto produto = new Produto(id);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ProdutoDao(conexao).deletar(produto);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Produto removido!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível remover o produto!");
            }

//            new Listar().executa(req, resp);

            req.setAttribute("logica", "Cadastrar");

            return "produtos?logica=Listar";
        }
    }
}
