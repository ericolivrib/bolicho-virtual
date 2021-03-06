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
import java.sql.Connection;
import java.util.ArrayList;

@WebServlet("pedidos")
public class PedidoController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.PedidoController$" + parametro;

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

            String status = req.getParameter("status");
            ArrayList<Pedido> pedidos = new ArrayList<>();

            Connection conexao = (Connection) req.getAttribute("conexao");

            for (Pedido pedido : new PedidoDao(conexao).selecionar()) {
                if (pedido.getStatus().getDescricao().equals(status)) {
                    pedidos.add(pedido);
                }
            }

            req.setAttribute("status", status);
            req.setAttribute("pedidos", pedidos);

            return "visualizar-pedidos.jsp";
        }
    }

    public static class Registrar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            Connection conexao = (Connection) req.getAttribute("conexao");

            ArrayList<Produto> produtos = new ProdutoDao(conexao).selecionar();
            ArrayList<Cliente> clientes = new ClienteDao(conexao).selecionar();
            ArrayList<Vendedor> vendedores = new VendedorDao(conexao).selecionar();

            req.setAttribute("produtos", produtos);
            req.setAttribute("clientes", clientes);
            req.setAttribute("vendedores", vendedores);

            return "cadastrar-pedido.jsp";
        }
    }

    public static class Cadastrar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            int p = Integer.parseInt(req.getParameter("produto"));
            int c = Integer.parseInt(req.getParameter("cliente"));
            int v = Integer.parseInt(req.getParameter("vendedor"));
            int quantidade = Integer.parseInt(req.getParameter("quantidade"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            Produto produto = new ProdutoDao(conexao).selecionar(p);
            Cliente cliente = new ClienteDao(conexao).selecionar(c);
            Vendedor vendedor = new VendedorDao(conexao).selecionar(v);

            // valor da pedido
            BigDecimal valor = produto.getPreco().multiply(BigDecimal.valueOf(quantidade));

            StatusPedido status = new StatusPedido("PENDENTE", null);
            ItemPedido item = new ItemPedido(quantidade, produto);
            Pedido pedido = new Pedido(valor, cliente, vendedor, item, status);

            String retorno = new PedidoDao(conexao).inserir(pedido);

            if (retorno.equals("OK")) {
                req.setAttribute("xlink", "#check-circle-fill");
                req.setAttribute("classeAlert", "alert-success");
                req.setAttribute("retorno", "<strong>OK!</strong> O pedido foi cadastrado e adicionado ?? tabela de pedidos na sess??o PENDENTES!");
            } else {
                req.setAttribute("xlink", "#exclamation-triangle-fill");
                req.setAttribute("classeAlert", "alert-warning");
                req.setAttribute("retorno", "<strong>OPS!</strong> N??o foi poss??vel cadastrar o pedido!");
            }

            return "pedidos?logica=Registrar";
        }
    }

    public static class Atualizar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            int id = Integer.parseInt(req.getParameter("id"));
            int s = Integer.parseInt(req.getParameter("s"));

            String descricao;
            String motivo = req.getParameter("motivo");

            if (motivo == null) {
                descricao = "CONCLUIDO";
            } else {
                descricao = "CANCELADO";
            }

            StatusPedido status = new StatusPedido(s, descricao, motivo);
            Pedido pedido = new Pedido(id, status);

            Connection conexao = (Connection) req.getAttribute("conexao");

            PedidoDao dao = new PedidoDao(conexao);
            String retorno = dao.atualizar(pedido);

            if (retorno.equals("OK")) {
                req.setAttribute("xlink", "#check-circle-fill");
                req.setAttribute("classeAlert", "alert-success");

                if (descricao.equals("CANCELADO")) {
                    req.setAttribute("retorno", "<strong>OK!</strong> O pedido foi adicionado ?? sess??o CANCELADOS!");
                } else {
                    req.setAttribute("retorno", "<strong>OK!</strong> O pedido foi adicionado ?? sess??o CONCLU??DOS!");
                }
            } else {
                req.setAttribute("xlink", "#exclamation-triangle-fill");
                req.setAttribute("classeAlert", "alert-warning");

                if (descricao.equals("CANCELADO")) {
                    req.setAttribute("retorno", "<strong>OPS!</strong> N??o foi poss??vel cancelar o pedido!");
                } else {
                    req.setAttribute("retorno", "<strong>OPS!</strong> N??o foi poss??vel concluir o pedido!");
                }
            }

            return "pedidos?logica=Listar&status=PENDENTE";
        }
    }
}
