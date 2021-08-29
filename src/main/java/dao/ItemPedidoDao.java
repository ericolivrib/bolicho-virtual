package dao;

import model.ItemPedido;

import java.sql.*;
import java.util.ArrayList;

public class ItemPedidoDao implements DAO<ItemPedido> {

    private Connection conexao;

    public ItemPedidoDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<ItemPedido> selecionar() {

        ArrayList<ItemPedido> itensCompra = new ArrayList<>();

        try {
            String sql = "SELECT * FROM item_pedido";
            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                ItemPedido itemPedido = new ItemPedido(
                        rs.getInt("id"),
                        rs.getInt("quantidade"),
                        new ProdutoDao(conexao).selecionar(rs.getInt("produto_id"))
                );
                itensCompra.add(itemPedido);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itensCompra;
    }

    @Override
    public ItemPedido selecionar(int id) {

        ItemPedido itemPedido = null;

        try {
            String sql = "SELECT * FROM item_pedido WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                itemPedido = new ItemPedido(
                        rs.getInt("id"),
                        rs.getInt("quantidade"),
                        new ProdutoDao(conexao).selecionar(rs.getInt("produto_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemPedido;
    }

    @Override
    public String inserir(ItemPedido itemPedido) {

        try {
            conexao.setAutoCommit(false);

            String sql = "INSERT INTO item_pedido (quantidade, produto_id) VALUES (?, ?)";
            PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, itemPedido.getQuantidade());
            ps.setInt(2, itemPedido.getProduto().getId());
            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();

            if (rs.getInt(1) > 0) {
                itemPedido.setId(rs.getInt(1));
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String atualizar(ItemPedido itemPedido) {
        return null;
    }

    @Override
    public String deletar(ItemPedido itemPedido) {

        try {
            conexao.setAutoCommit(false);

            String sql = "DELETE FROM item_pedido WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, itemPedido.getId());
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
