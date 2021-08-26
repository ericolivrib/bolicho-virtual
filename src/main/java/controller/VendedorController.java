package controller;

import dao.VendedorDao;
import model.Vendedor;
import model.Endereco;
import model.Permissao;
import model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

@WebServlet("vendedores")
public class VendedorController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.VendedorController$" + parametro;

        try {
            Class<?> classe = Class.forName(nomeClasse);

            LogicaNegocio logica = (LogicaNegocio) classe.newInstance();
            String pagina = logica.executa(req, resp);

            req.getRequestDispatcher(pagina).forward(req, resp);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static class ListarVendedores implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[VENDEDORES] Listando vendedores...");

            Connection conexao = (Connection) req.getAttribute("conexao");

            VendedorDao dao = new VendedorDao(conexao);
            ArrayList<Vendedor> vendedores = dao.selecionar();

            req.setAttribute("vendedores", vendedores);
            req.setAttribute("logica", "CadastrarVendedor");

            return "vendedores.jsp";
        }
    }

    public static class CadastrarVendedor implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[VENDEDORES] Cadastrando vendedor...");

            String nome = req.getParameter("nome");
            String email = req.getParameter("email");
            String telefone = req.getParameter("telefone");
            String senha = req.getParameter("senha");
            String rua = req.getParameter("rua");
            int numeroCasa = Integer.parseInt(req.getParameter("numero_casa"));
            String bairro = req.getParameter("bairro");
            String complemento = req.getParameter("complemento");

            Endereco endereco = new Endereco(rua, numeroCasa, bairro, complemento);
            Permissao permissao = new Permissao(2);
            Usuario usuario = new Usuario(nome, email, telefone, true, endereco, permissao);
            Vendedor vendedor = new Vendedor(usuario);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new VendedorDao(conexao).inserir(vendedor);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Vendedor cadastrado!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível cadastrar o vendedor!");
            }

            req.setAttribute("logica", "CadastrarVendedor");

            return "vendedores?logica=ListarVendedores";
        }
    }

    public static class EditarVendedor implements  LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[VENDEDORES] Selecionando vendedor para edição...");

            int id = Integer.parseInt(req.getParameter("id"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            VendedorDao dao = new VendedorDao(conexao);
            Vendedor vendedor = dao.selecionar(id);

            req.setAttribute("vendedor", vendedor);
            req.setAttribute("logica", "AtualizarVendedor");

            return "vendedores.jsp";
        }
    }

    public static class AtualizarVendedor implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[VENDEDORES] Atualizando vendedor...");

            int id = Integer.parseInt(req.getParameter("id"));
            int usuarioId = Integer.parseInt(req.getParameter("usuario_id"));
            int enderecoId = Integer.parseInt(req.getParameter("endereco_id"));

            String nome = req.getParameter("nome");
            String email = req.getParameter("email");
            String telefone = req.getParameter("telefone");
            String senha = req.getParameter("senha");
            String rua = req.getParameter("rua");
            int numeroCasa = Integer.parseInt(req.getParameter("numero_casa"));
            String bairro = req.getParameter("bairro");
            String complemento = req.getParameter("complemento");

            Endereco endereco = new Endereco(enderecoId, rua, numeroCasa, bairro, complemento);
            Permissao permissao = new Permissao(2);
            Usuario usuario = new Usuario(usuarioId, nome, email, telefone, endereco, permissao);
            Vendedor vendedor = new Vendedor(id, usuario);

            Connection conexao = (Connection) req.getAttribute("conexao");

            VendedorDao dao = new VendedorDao(conexao);
            String retorno = dao.atualizar(vendedor);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Vendedor atualizado!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível atualizar o vendedor!");
            }

            req.setAttribute("logica", "CadastrarVendedor");

            return "vendedores?logica=ListarVendedores";
        }
    }

    public static class RemoverVendedor implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[VENDEDORES] Removendo vendedor");

            int id = Integer.parseInt(req.getParameter("id"));
            int usuarioId = Integer.parseInt(req.getParameter("usuario_id"));
            int enderecoId = Integer.parseInt(req.getParameter("endereco_id"));

            Endereco endereco = new Endereco(enderecoId);
            Permissao permissao = new Permissao(1);
            Usuario usuario = new Usuario(usuarioId, endereco, permissao);
            Vendedor vendedor = new Vendedor(id, usuario);

            Connection conexao = (Connection) req.getAttribute("conexao");

            VendedorDao dao = new VendedorDao(conexao);
            String retorno = dao.deletar(vendedor);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Vendedor removido!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível remover o vendedor!");
            }

            req.setAttribute("logica", "CadastrarVendedor");

            return "vendedores?logica=ListarVendedores";
        }
    }
}
