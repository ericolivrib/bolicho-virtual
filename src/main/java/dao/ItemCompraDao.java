package dao;

import model.ItemCompra;

import java.sql.*;
import java.util.ArrayList;

public class ItemCompraDao implements DAO<ItemCompra> {

    private Connection conexao;

    public ItemCompraDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<ItemCompra> selecionar() {

        ArrayList<ItemCompra> itensCompra = new ArrayList<>();

        try {
            String sql = "SELECT * FROM item_compra";
            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                ItemCompra itemCompra = new ItemCompra(
                        rs.getInt("id"),
                        rs.getInt("quantidade"),
                        new ProdutoDao(conexao).selecionar(rs.getInt("produto_id"))
                );
                itensCompra.add(itemCompra);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itensCompra;
    }

    @Override
    public ItemCompra selecionar(int id) {

        ItemCompra itemCompra = null;

        try {
            String sql = "SELECT * FROM item_compra WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                itemCompra = new ItemCompra(
                        rs.getInt("id"),
                        rs.getInt("quantidade"),
                        new ProdutoDao(conexao).selecionar(rs.getInt("produto_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemCompra;
    }

    @Override
    public String inserir(ItemCompra itemCompra) {

        try {
            conexao.setAutoCommit(false);

            String sql = "INSERT INTO item_compra (quantidade, produto_id) VALUES (?, ?)";
            PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, itemCompra.getQuantidade());
            ps.setInt(2, itemCompra.getProduto().getId());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();

            if (rs.getInt(1) > 0) {
                itemCompra.setId(rs.getInt(1));
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String atualizar(ItemCompra itemCompra) {
        return null;
    }

    @Override
    public String deletar(ItemCompra itemCompra) {

        try {
            conexao.setAutoCommit(false);

            String sql = "DELETE FROM item_compra WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, itemCompra.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }
}
