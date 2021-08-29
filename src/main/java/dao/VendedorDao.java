package dao;

import model.Vendedor;

import java.sql.*;
import java.util.ArrayList;

public class VendedorDao implements DAO<Vendedor> {

    private Connection conexao;

    public VendedorDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<Vendedor> selecionar() {

        ArrayList<Vendedor> vendedores = new ArrayList<>();

        try {
            String sql = "SELECT * FROM vendedor";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Vendedor vendedor = new Vendedor(
                        rs.getInt("id"),
                        new UsuarioDao(conexao).selecionar(rs.getInt("usuario_id"))
                );

                vendedores.add(vendedor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vendedores;
    }

    @Override
    public Vendedor selecionar(int id) {

        Vendedor vendedor = null;

        try {
            String sql = "SELECT * FROM vendedor WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                vendedor = new Vendedor(
                        rs.getInt("id"),
                        new UsuarioDao(conexao).selecionar(rs.getInt("usuario_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vendedor;
    }

    @Override
    public String inserir(Vendedor vendedor) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).inserir(vendedor.getUsuario());

            if (retorno.equals("OK")) {
                String sql = "INSERT INTO vendedor (usuario_id) VALUES (?)";

                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setInt(1, vendedor.getUsuario().getId());
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

    @Override
    public String atualizar(Vendedor vendedor) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).atualizar(vendedor.getUsuario());

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
    public String deletar(Vendedor vendedor) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).deletar(vendedor.getUsuario());

            if (retorno.equals("OK")) {
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Erro";
    }
}
