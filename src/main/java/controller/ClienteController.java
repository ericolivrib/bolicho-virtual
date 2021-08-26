package controller;

import dao.ClienteDao;
import model.Cliente;
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

@WebServlet("clientes")
public class ClienteController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String parametro = req.getParameter("logica");
        String nomeClasse = "controller.ClienteController$" + parametro;

        try {
            Class<?> classe = Class.forName(nomeClasse);

            LogicaNegocio logica = (LogicaNegocio) classe.newInstance();
            String pagina = logica.executa(req, resp);

            req.getRequestDispatcher(pagina).forward(req, resp);
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static class ListarClientes implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[CLIENTES] Listando clientes...");

            Connection conexao = (Connection) req.getAttribute("conexao");

            ClienteDao dao = new ClienteDao(conexao);
            ArrayList<Cliente> clientes = dao.selecionar();

            req.setAttribute("clientes", clientes);
            req.setAttribute("logica", "CadastrarCliente");

            return "clientes.jsp";
        }
    }

    public static class CadastrarCliente implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[CLIENTES] Cadastrando cliente...");

            String nome = req.getParameter("nome");
            String email = req.getParameter("email");
            String telefone = req.getParameter("telefone");
            String senha = req.getParameter("senha");
            String rua = req.getParameter("rua");
            int numeroCasa = Integer.parseInt(req.getParameter("numero_casa"));
            String bairro = req.getParameter("bairro");
            String complemento = req.getParameter("complemento");

            Endereco endereco = new Endereco(rua, numeroCasa, bairro, complemento);
            Permissao permissao = new Permissao(1);
            Usuario usuario = new Usuario(nome, email, telefone, true, endereco, permissao);
            Cliente cliente = new Cliente(usuario);

            Connection conexao = (Connection) req.getAttribute("conexao");

            String retorno = new ClienteDao(conexao).inserir(cliente);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Cliente cadastrado!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível cadastrar o cliente!");
            }

            req.setAttribute("logica", "CadastrarCliente");

            return "clientes?logica=ListarClientes";
        }
    }

    public static class EditarCliente implements  LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[CLIENTES] Selecionando cliente para edição...");

            int id = Integer.parseInt(req.getParameter("id"));

            Connection conexao = (Connection) req.getAttribute("conexao");

            ClienteDao dao = new ClienteDao(conexao);
            Cliente cliente = dao.selecionar(id);

            req.setAttribute("cliente", cliente);
            req.setAttribute("logica", "AtualizarCliente");

            return "clientes.jsp";
        }
    }

    public static class AtualizarCliente implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[CLIENTES] Atualizando cliente...");

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
            Permissao permissao = new Permissao(1);
            Usuario usuario = new Usuario(usuarioId, nome, email, telefone, endereco, permissao);
            Cliente cliente = new Cliente(id, usuario);

            Connection conexao = (Connection) req.getAttribute("conexao");

            ClienteDao dao = new ClienteDao(conexao);
            String retorno = dao.atualizar(cliente);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Cliente atualizado!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível atualizar o cliente!");
            }

            req.setAttribute("logica", "CadastrarCliente");

            return "clientes?logica=ListarClientes";
        }
    }

    public static class RemoverCliente implements LogicaNegocio {

        @Override
        public String executa(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {

            System.out.println("[CLIENTES] Removendo cliente");

            int id = Integer.parseInt(req.getParameter("id"));
            int usuarioId = Integer.parseInt(req.getParameter("usuario_id"));
            int enderecoId = Integer.parseInt(req.getParameter("endereco_id"));

            Endereco endereco = new Endereco(enderecoId);
            Permissao permissao = new Permissao(1);
            Usuario usuario = new Usuario(usuarioId, endereco, permissao);
            Cliente cliente = new Cliente(id, usuario);

            Connection conexao = (Connection) req.getAttribute("conexao");

            ClienteDao dao = new ClienteDao(conexao);
            String retorno = dao.deletar(cliente);

            if (retorno.equals("OK")) {
                req.setAttribute("retorno", "<strong>OK!</strong> Cliente removido!");
            } else {
                req.setAttribute("retorno", "<strong>OPS!</strong> Não foi possível remover o cliente!");
            }

            req.setAttribute("logica", "CadastrarCliente");

            return "clientes?logica=ListarClientes";
        }
    }
}
