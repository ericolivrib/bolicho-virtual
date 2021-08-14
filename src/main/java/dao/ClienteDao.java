package dao;

import model.Cliente;

import java.sql.*;
import java.util.ArrayList;

public class ClienteDao implements DAO<Cliente> {

    private Connection conexao;

    public ClienteDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<Cliente> selecionar() {

        ArrayList<Cliente> clientes = new ArrayList<>();

        try {
            String sql = "SELECT * FROM cliente";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

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

    @Override
    public Cliente selecionar(int id) {

        Cliente cliente = null;

        try {
            String sql = "SELECT * FROM cliente WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

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

    @Override
    public String inserir(Cliente cliente) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).inserir(cliente.getUsuario());

            if (retorno.equals("OK")) {
                String sql = "INSERT INTO cliente (usuario_id) VALUES (?)";

                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setInt(1, cliente.getUsuario().getId());
                ps.executeUpdate();

                if (ps.getUpdateCount() > 0) {
                    conexao.commit();
                    return "OK";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
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
        }

        return "Erro";
    }

    @Override
    public String deletar(Cliente cliente) {

        try {
            conexao.setAutoCommit(false);

            String sql = "DELETE FROM cliente WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
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
        }

        return "Erro";
    }
}
