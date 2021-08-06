package dao;

import model.Vendedor;

import java.sql.*;
import java.util.ArrayList;

public class VendedorDao {

    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public VendedorDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Vendedor> selecionar() {

        ArrayList<Vendedor> vendedores = new ArrayList<>();

        try {
            sql = "SELECT * FROM vendedor";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

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

    public Vendedor selecionar(int id) {

        Vendedor vendedor = null;

        try {
            sql = "SELECT * FROM vendedor WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

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

    public String inserir(Vendedor vendedor) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new UsuarioDao(conexao).inserir(vendedor.getUsuario());

            if (retorno.equals("OK")) {
                sql = "INSERT INTO vendedor (usuario_id) VALUES (?)";

                ps = conexao.prepareStatement(sql);
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
            return "Erro";
        }

        return "Erro";
    }

    public String deletar(Vendedor vendedor) {

        try {
            conexao.setAutoCommit(false);

            sql = "DELETE FROM vendedor WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, vendedor.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                String retorno = new UsuarioDao(conexao).deletar(vendedor.getUsuario());

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
