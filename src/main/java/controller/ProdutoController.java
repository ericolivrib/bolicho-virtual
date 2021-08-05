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

@WebServlet("/produtos")
public class ProdutoController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.ProdutoController$" + parametro;

        try {
            Class<?> classe = Class.forName(nomeClasse);

            LogicaNegocio logica = (LogicaNegocio) classe.newInstance();
            String pagina = logica.executa(req, resp);

            req.getRequestDispatcher(pagina).forward(req, resp);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static class ListarProdutos implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            System.out.println("[PRODUTO] Listando produtos...");

            Connection conexao = (Connection) req.getAttribute("conexao");

            ArrayList<Produto> produtos = new ProdutoDao(conexao).selecionar();

            req.setAttribute("produtos", produtos);
            req.setAttribute("logica", "AdicionarProduto");

            return "produtos.jsp";
        }
    }

    public static class AdicionarProduto implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            System.out.println("[PRODUTO] Adicionando produto...");

            String nome = req.getParameter("nome");
            BigDecimal preco = new BigDecimal(req.getParameter("preco"));

            Produto produto = new Produto(nome, preco);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ProdutoDao(conexao).inserir(produto);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Produto adicionado!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível adicionar o produto!");
            }

            new ListarProdutos().executa(req, resp);

            req.setAttribute("logica", "AdicionarProduto");

            return "produtos.jsp";
        }
    }

    public static class EditarProduto implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            System.out.println("[PRODUTO] Selecionando produto para edição...");

            int id = Integer.parseInt(req.getParameter("id"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            Produto produto = new ProdutoDao(conexao).selecionar(id);

            req.setAttribute("produto", produto);
            req.setAttribute("logica", "AtualizarProduto");

            return "produtos.jsp";
        }
    }

    public static class AtualizarProduto implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            System.out.println("[PRODUTO] Atualizando produto...");

            int id = Integer.parseInt(req.getParameter("id"));
            String nome = req.getParameter("nome");
            BigDecimal preco = new BigDecimal(req.getParameter("preco"));

            Produto produto = new Produto(id, nome, preco);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ProdutoDao(conexao).atualizar(produto);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Produto atualizado!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível atualizar o produto!");
            }

            new ListarProdutos().executa(req, resp);

            req.setAttribute("logica", "AdicionarProduto");

            return "produtos.jsp";
        }
    }

    public static class RemoverProduto implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            System.out.println("[PRODUTO] Removendo produto...");

            int id = Integer.parseInt(req.getParameter("id"));

            Produto produto = new Produto(id);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ProdutoDao(conexao).deletar(produto);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Produto removido!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível remover o produto!");
            }

            new ListarProdutos().executa(req, resp);

            req.setAttribute("logica", "AdicionarProduto");

            return "produtos.jsp";
        }
    }
}
