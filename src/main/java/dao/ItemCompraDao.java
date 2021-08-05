package dao;

import dao.connection.ConexaoBase;
import model.ItemCompra;

import java.sql.*;
import java.util.ArrayList;

public class ItemCompraDao {

    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public ItemCompraDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<ItemCompra> selecionar() {

        ArrayList<ItemCompra> itensCompra = new ArrayList<>();

        try {
            sql = "SELECT * FROM item_compra";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                ItemCompra itemCompra = new ItemCompra(
                        rs.getInt("id"),
                        rs.getInt("quantidade"),
                        new ProdutoDao(conexao).selecionar(rs.getInt("produto_id")),
                        new CompraDao(conexao).selecionar(rs.getInt("compra_id"))
                );

                itensCompra.add(itemCompra);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itensCompra;
    }

    public ItemCompra selecionar(int id) {

        ItemCompra itemCompra = null;

        try {
            sql = "SELECT * FROM item_compra WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                itemCompra = new ItemCompra(
                        rs.getInt("id"),
                        rs.getInt("quantidade"),
                        new ProdutoDao(conexao).selecionar(rs.getInt("produto_id")),
                        new CompraDao(conexao).selecionar(rs.getInt("compra_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemCompra;
    }

    public String inserir(ItemCompra itemCompra) {

        try {
            conexao.setAutoCommit(false);

            sql = "INSERT INTO item_compra (quantidade, produto_id, compra_id) VALUES (?, ?, ?)";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, itemCompra.getQuantidade());
            ps.setInt(2, itemCompra.getProduto().getId());
            ps.setInt(3, itemCompra.getCompra().getId());
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

    public String deletar(ItemCompra itemCompra) {

        try {
            conexao.setAutoCommit(false);

            sql = "DELETE FROM item_compra WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, itemCompra.getId());
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
}
