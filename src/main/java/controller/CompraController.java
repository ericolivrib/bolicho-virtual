package controller;

import dao.*;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Connection;
import java.util.ArrayList;

@WebServlet("comprar")
public class CompraController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.CompraController$" + parametro;

        try {
            Class<?> classe = Class.forName(nomeClasse);

            LogicaNegocio logica = (LogicaNegocio) classe.newInstance();
            String pagina = logica.executa(req, resp);

            req.getRequestDispatcher(pagina).forward(req, resp);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static class Comprar implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[COMPRA] Iniciando compra...");

            int id = Integer.parseInt(req.getParameter("p"));
            Connection conexao = (Connection) req.getAttribute("conexao");

            Produto produto = new ProdutoDao(conexao).selecionar(id);
            ArrayList<Cliente> clientes = new ClienteDao(conexao).selecionar();
            ArrayList<Vendedor> vendedores = new VendedorDao(conexao).selecionar();

            req.setAttribute("produto", produto);
            req.setAttribute("clientes", clientes);
            req.setAttribute("vendedores", vendedores);

            return "comprar.jsp";
        }
    }

    public static class FinalizarCompra implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[COMPRA] Finalizando compra...");

            int p = Integer.parseInt(req.getParameter("p"));
            int c = Integer.parseInt(req.getParameter("cliente"));
            int v = Integer.parseInt(req.getParameter("vendedor"));
            int quantidade = Integer.parseInt(req.getParameter("quantidade"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            Produto produto = new ProdutoDao(conexao).selecionar(p);
            Cliente cliente = new ClienteDao(conexao).selecionar(c);
            Vendedor vendedor = new VendedorDao(conexao).selecionar(v);

            // valor da compra
            BigDecimal valor = produto.getPreco().multiply(BigDecimal.valueOf(quantidade));

            Compra compra = new Compra(valor, cliente, vendedor);
            String r1 = new CompraDao(conexao).inserir(compra);

            StatusCompra status = new StatusCompra("PENDENTE", null, compra);
            String r2 = new StatusCompraDao(conexao).inserir(status);

            ItemCompra item = new ItemCompra(quantidade, produto, compra);
            String r3 = new ItemCompraDao(conexao).inserir(item);

            if (r1.equals("OK") && r2.equals("OK") && r3.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Compra efetuada com sucesso!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Ocorreram erros ao efetuar a compra.");
            }

            return "/";
        }
    }
}
