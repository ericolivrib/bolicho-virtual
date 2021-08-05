package dao;

import dao.connection.ConexaoBase;
import model.Produto;

import java.sql.*;
import java.util.ArrayList;

public class ProdutoDao {

    private String status;
    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public ProdutoDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Produto> selecionar() {

        ArrayList<Produto> produtos = new ArrayList<>();

        try {
            sql = "SELECT * FROM produto";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Produto produto = new Produto(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getBigDecimal("preco")
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
            sql = "SELECT * FROM produto WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                produto = new Produto(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getBigDecimal("preco")
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

            sql = "INSERT INTO produto (nome, preco) VALUES (?, ?)";

            ps = conexao.prepareStatement(sql);
            ps.setString(1, produto.getNome());
            ps.setBigDecimal(2, produto.getPreco());
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

            sql = "UPDATE produto SET nome = ?, preco = ? WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setString(1, produto.getNome());
            ps.setBigDecimal(2, produto.getPreco());
            ps.setInt(3, produto.getId());

            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                conexao.commit();
                status = "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            status = "Erro";
        }

        return status;
    }

    public String deletar(Produto produto) {

        try {
            conexao.setAutoCommit(false);

            sql = "DELETE FROM produto WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, produto.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                conexao.commit();
                status = "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            status = "Erro";
        }

        return status;
    }
}
