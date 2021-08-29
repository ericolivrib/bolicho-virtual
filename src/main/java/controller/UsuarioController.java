package controller;

import dao.ClienteDao;
import dao.VendedorDao;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("usuarios")
public class UsuarioController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.UsuarioController$" + parametro;

        try {
            Class<?> classe = Class.forName(nomeClasse);

            Logica logica = (Logica) classe.newInstance();
            String pagina = logica.executa(req, resp);

            req.getRequestDispatcher(pagina).forward(req, resp);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static class Listar implements Logica  {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[USUÁRIOS] Gerando lista de usuários do sistema...");

            Connection conexao = (Connection) req.getAttribute("conexao");

            String permissao = req.getParameter("permissao");

            if (permissao == null || permissao.equals("clientes")) {
                req.setAttribute("clientes", new ClienteDao(conexao).selecionar());
            } else {
                req.setAttribute("vendedores", new VendedorDao(conexao).selecionar());
            }

            return "visualizar-usuarios.jsp";
        }
    }

    public static class Cadastrar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[USUARIOS] Cadastrando usuário...");

            String nome = req.getParameter("nome");
            String email = req.getParameter("email");
            String telefone = req.getParameter("telefone");
            String rua = req.getParameter("rua");
            int numeroCasa = Integer.parseInt(req.getParameter("numero"));
            String bairro = req.getParameter("bairro");
            String complemento = req.getParameter("complemento");

            String p = req.getParameter("permissao");

            Connection conexao = (Connection) req.getAttribute("conexao");
            String retorno;

            if (p.equals("CLIENTE")) {
                Endereco endereco = new Endereco(rua, numeroCasa, bairro, complemento);
                Permissao permissao = new Permissao(1);
                Usuario usuario = new Usuario(nome, email, telefone, true, endereco, permissao);
                Cliente cliente = new Cliente(usuario);
                retorno = new ClienteDao(conexao).inserir(cliente);
            } else {
                Endereco endereco = new Endereco(rua, numeroCasa, bairro, complemento);
                Permissao permissao = new Permissao(2);
                Usuario usuario = new Usuario(nome, email, telefone, true, endereco, permissao);
                Vendedor vendedor = new Vendedor(usuario);
                retorno = new VendedorDao(conexao).inserir(vendedor);
            }

            if (retorno.equals("OK")) {
                req.setAttribute("xlink", "#check-circle-fill");
                req.setAttribute("classeAlert", "alert-success");
                req.setAttribute("retorno", "<strong>OK!</strong> O usuário foi cadastrado!");
            } else {
                req.setAttribute("xlink", "#exclamation-triangle-fill");
                req.setAttribute("classeAlert", "alert-warning");
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível cadastrar o usuário!");
            }

            return "cadastrar-usuario.jsp";
        }
    }

    public static class Editar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[USUÁRIOS] Selecionando usuário para edição...");

            int id = Integer.parseInt(req.getParameter("id"));
            int permissao = Integer.parseInt(req.getParameter("permissao"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            if (permissao == 1) {
                ClienteDao dao = new ClienteDao(conexao);
                Cliente cliente = dao.selecionar(id);
                req.setAttribute("u", cliente);
            } else {
                VendedorDao dao = new VendedorDao(conexao);
                Vendedor vendedor = dao.selecionar(id);
                req.setAttribute("u", vendedor);
            }

            return "cadastrar-usuario.jsp";
        }
    }

    public static class Atualizar implements Logica {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            int id = Integer.parseInt(req.getParameter("id"));
            int u = Integer.parseInt(req.getParameter("u"));
            int e = Integer.parseInt(req.getParameter("e"));
            int p = Integer.parseInt(req.getParameter("p"));

            String nome = req.getParameter("nome");
            String email = req.getParameter("email");
            String telefone = req.getParameter("telefone");
            String rua = req.getParameter("rua");
            int numeroCasa = Integer.parseInt(req.getParameter("numero"));
            String bairro = req.getParameter("bairro");
            String complemento = req.getParameter("complemento");

            Connection conexao = (Connection) req.getAttribute("conexao");
            String retorno;

            Endereco endereco = new Endereco(e, rua, numeroCasa, bairro, complemento);
            Permissao permissao = new Permissao(p);
            Usuario usuario = new Usuario(u, nome, email, telefone, endereco, permissao);

            if (p == 1) {
                Cliente cliente = new Cliente(id, usuario);
                retorno = new ClienteDao(conexao).atualizar(cliente);
            } else {
                Vendedor vendedor = new Vendedor(id, usuario);
                retorno = new VendedorDao(conexao).atualizar(vendedor);
            }

            if (retorno.equals("OK")) {
                req.setAttribute("xlink", "#check-circle-fill");
                req.setAttribute("classeAlert", "alert-success");
                req.setAttribute("retorno", "<strong>OK!</strong> O usuário foi atualizado!");
            } else {
                req.setAttribute("xlink", "#exclamation-triangle-fill");
                req.setAttribute("classeAlert", "alert-warning");
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível atualizar o usuário!");
            }

            return "usuarios?logica=Listar";
        }
    }
}
