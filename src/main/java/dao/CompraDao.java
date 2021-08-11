package dao;

import model.Compra;

import java.sql.*;
import java.util.ArrayList;

public class CompraDao {

    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public CompraDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Compra> selecionar() {

        ArrayList<Compra> compras = new ArrayList<>();

        try {
            sql = "SELECT * FROM compra";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Compra compra  = new Compra(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        new ClienteDao(conexao).selecionar(rs.getInt("cliente_id")),
                        new VendedorDao(conexao).selecionar(rs.getInt("vendedor_id"))
                );

                compras.add(compra);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return compras;
    }

    public Compra selecionar(int id) {

        Compra compra = null;

        try {
            sql = "SELECT * FROM compra WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                compra  = new Compra(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        new ClienteDao(conexao).selecionar(rs.getInt("cliente_id")),
                        new VendedorDao(conexao).selecionar(rs.getInt("vendedor_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return compra;
    }

    public String inserir(Compra compra) {

        try {
            conexao.setAutoCommit(false);

            sql = "INSERT INTO compra (valor, data_pedido, cliente_id, vendedor_id) " +
                    "VALUES (?, CURRENT_DATE, ?, ?)";

            ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setBigDecimal(1, compra.getValor());
            ps.setInt(2, compra.getCliente().getId());
            ps.setInt(3, compra.getVendedor().getId());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            rs.next();

            if (rs.getInt(1) > 0) {
                compra.setId(rs.getInt(1));
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }
}
