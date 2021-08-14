package dao;

import model.Produto;

import java.sql.*;
import java.util.ArrayList;

public class ProdutoDao implements DAO<Produto> {

    private Connection conexao;

    public ProdutoDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Produto> selecionar() {

        ArrayList<Produto> produtos = new ArrayList<>();

        try {
            String sql = "SELECT * FROM produto";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Produto produto = new Produto(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getBigDecimal("preco"),
                        rs.getString("detalhes")
                );

                produtos.add(produto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return produtos;
    }

    public Produto selecionar(int id) {

        Produto produto = null;

        try {
            String sql = "SELECT * FROM produto WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                produto = new Produto(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getBigDecimal("preco"),
                        rs.getString("detalhes")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return produto;
    }

    public String inserir(Produto produto) {

        try {
            conexao.setAutoCommit(false);

            String sql = "INSERT INTO produto (nome, preco, detalhes) VALUES (?, ?, ?)";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, produto.getNome());
            ps.setBigDecimal(2, produto.getPreco());
            ps.setString(3, produto.getDetalhes());
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

    public String atualizar(Produto produto) {

        try {
            conexao.setAutoCommit(false);

            String sql = "UPDATE produto SET nome = ?, preco = ?, detalhes = ? WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, produto.getNome());
            ps.setBigDecimal(2, produto.getPreco());
            ps.setString(3, produto.getDetalhes());
            ps.setInt(4, produto.getId());

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

    public String deletar(Produto produto) {

        try {
            conexao.setAutoCommit(false);

            String sql = "DELETE FROM produto WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, produto.getId());
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
