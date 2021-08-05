package dao;

import dao.connection.ConexaoBase;
import model.Cliente;

import java.sql.*;
import java.util.ArrayList;

public class ClienteDao {

    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public ClienteDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Cliente> selecionar() {

        ArrayList<Cliente> clientes = new ArrayList<>();

        try {
            sql = "SELECT * FROM cliente";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Cliente cliente = new Cliente(
                        rs.getInt("id"),
                        new UsuarioDao(conexao).selecionar(rs.getInt("usuario_id"))
                );

                clientes.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return clientes;
    }

    public Cliente selecionar(int id) {

        Cliente cliente = null;

        try {
            sql = "SELECT * FROM cliente WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                cliente = new Cliente(
                        rs.getInt("id"),
                        new UsuarioDao(conexao).selecionar(rs.getInt("usuario_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cliente;
    }

    public String inserir(Cliente cliente) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).inserir(cliente.getUsuario());

            if (retorno.equals("OK")) {
                sql = "INSERT INTO cliente (usuario_id) VALUES (?)";

                ps = conexao.prepareStatement(sql);
                ps.setInt(1, cliente.getUsuario().getId());
                ps.executeUpdate();

                if (ps.getUpdateCount() > 0) {
                    conexao.commit();
                    return "OK";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }

    public String atualizar(Cliente cliente) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).atualizar(cliente.getUsuario());

            if (retorno.equals("OK")) {
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }

    public String deletar(Cliente cliente) {

        try {
            conexao.setAutoCommit(false);

            sql = "DELETE FROM cliente WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, cliente.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                String retorno = new UsuarioDao(conexao).deletar(cliente.getUsuario());

                if (retorno.equals("OK")) {
                    conexao.commit();
                    return "OK";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }
}
