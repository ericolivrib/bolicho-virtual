package dao;

import model.ItemCompra;
import model.StatusCompra;

import java.sql.*;
import java.util.ArrayList;

public class StatusCompraDao implements DAO<StatusCompra> {

    private Connection conexao;

    public StatusCompraDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<StatusCompra> selecionar() {

        ArrayList<StatusCompra> statusCompras = new ArrayList<>();

        try {
            String sql = "SELECT * FROM status_compra";
            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                StatusCompra status = new StatusCompra(
                        rs.getInt("id"),
                        rs.getString("descricao"),
                        rs.getDate("data_status").toLocalDate(),
                        rs.getString("motivo")
                );
                statusCompras.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusCompras;
    }

    @Override
    public StatusCompra selecionar(int id) {

        StatusCompra statusCompra = null;

        try {
            String sql = "SELECT * FROM status_compra WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                statusCompra = new StatusCompra(
                        rs.getInt("id"),
                        rs.getString("descricao"),
                        rs.getDate("data_status").toLocalDate(),
                        rs.getString("motivo")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusCompra;
    }

    @Override
    public String inserir(StatusCompra statusCompra) {

        try {
            conexao.setAutoCommit(false);

            String sql = "INSERT INTO status_compra (descricao, data_status, motivo) VALUES (?, CURRENT_DATE, ?)";
            PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, statusCompra.getDescricao());
            ps.setString(2, statusCompra.getMotivo());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();

            if (rs.getInt(1) > 0) {
                statusCompra.setId(rs.getInt(1));
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String atualizar(StatusCompra statusCompra) {

        try {
            String sql = "UPDATE status_compra SET descricao = ?, motivo = ? WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, statusCompra.getDescricao());
            ps.setString(2, statusCompra.getMotivo());
            ps.setInt(3, statusCompra.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }

    @Override
    public String deletar(StatusCompra statusCompra) {
        return null;
    }
}
