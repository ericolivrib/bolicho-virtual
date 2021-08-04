package dao;

import model.StatusCompra;

import java.sql.*;

public class StatusCompraDao {

    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public StatusCompraDao(Connection conexao) {
        this.conexao = conexao;
    }

    public StatusCompra selecionar(int id) throws SQLException {

        StatusCompra statusCompra = null;

        sql = "SELECT * FROM status_compra WHERE id = ?";

        ps = conexao.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            statusCompra = new StatusCompra(
                    rs.getInt("id"),
                    rs.getString("descricao"),
                    rs.getDate("data_status").toLocalDate(),
                    rs.getString("motivo")
            );
        }

        return statusCompra;
    }

    public String inserir(StatusCompra statusCompra) throws SQLException {

        conexao.setAutoCommit(false);

        sql = "INSERT INTO status_compra (descricao, data_status, motivo) VALUES (?, CURRENT_DATE, ?)";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, statusCompra.getDescricao());
        ps.setString(2, statusCompra.getMotivo());
        ps.executeUpdate();

        if (ps.getUpdateCount() > 0) {
            conexao.commit();
            return "OK";
        }

        return "Erro";
    }

    public String atualizar(StatusCompra statusCompra) throws SQLException {

        sql = "UPDATE status_compra SET descricao = ?, motivo = ? WHERE id = ?";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, statusCompra.getDescricao());
        ps.setString(2, statusCompra.getMotivo());
        ps.setInt(3, statusCompra.getId());
        ps.executeUpdate();

        if (ps.getUpdateCount() > 0) {
            conexao.commit();;
            return "OK";
        }

        return "Erro";
    }
}
