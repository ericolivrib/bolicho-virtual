package dao;

import model.StatusPedido;

import java.sql.*;
import java.util.ArrayList;

public class StatusPedidoDao implements DAO<StatusPedido> {

    private Connection conexao;

    public StatusPedidoDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<StatusPedido> selecionar() {

        ArrayList<StatusPedido> statusPedidos = new ArrayList<>();

        try {
            String sql = "SELECT * FROM status_pedido";
            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                StatusPedido status = new StatusPedido(
                        rs.getInt("id"),
                        rs.getString("descricao"),
                        rs.getDate("data_status").toLocalDate(),
                        rs.getString("motivo")
                );
                statusPedidos.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusPedidos;
    }

    @Override
    public StatusPedido selecionar(int id) {

        StatusPedido statusPedido = null;

        try {
            String sql = "SELECT * FROM status_pedido WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                statusPedido = new StatusPedido(
                        rs.getInt("id"),
                        rs.getString("descricao"),
                        rs.getDate("data_status").toLocalDate(),
                        rs.getString("motivo")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return statusPedido;
    }

    @Override
    public String inserir(StatusPedido statusPedido) {
        try {
            conexao.setAutoCommit(false);

            String sql = "INSERT INTO status_pedido (descricao, data_status, motivo) VALUES (?, CURRENT_DATE, ?)";
            PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, statusPedido.getDescricao());
            ps.setString(2, statusPedido.getMotivo());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();

            if (rs.getInt(1) > 0) {
                statusPedido.setId(rs.getInt(1));
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Erro";
    }

    @Override
    public String atualizar(StatusPedido statusPedido) {
        try {
            String sql = "UPDATE status_pedido SET descricao = ?, motivo = ? WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, statusPedido.getDescricao());
            ps.setString(2, statusPedido.getMotivo());
            ps.setInt(3, statusPedido.getId());
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
    public String deletar(StatusPedido statusPedido) {
        return null;
    }
}
