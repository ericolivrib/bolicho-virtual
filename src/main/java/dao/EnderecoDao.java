package dao;

import model.Endereco;

import java.sql.*;
import java.util.ArrayList;

public class EnderecoDao implements DAO<Endereco> {

    private Connection conexao;

    public EnderecoDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<Endereco> selecionar() {

        ArrayList<Endereco> enderecos = new ArrayList<>();

        try {
            String sql = "SELECT * FROM endereco";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Endereco endereco = new Endereco(
                        rs.getInt("id"),
                        rs.getString("rua"),
                        rs.getInt("numero_casa"),
                        rs.getString("bairro"),
                        rs.getString("complemento")
                );

                enderecos.add(endereco);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return enderecos;
    }

    @Override
    public Endereco selecionar(int id) {

        Endereco endereco = null;

        try {
            String sql = "SELECT * FROM endereco WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                endereco = new Endereco(
                        rs.getInt("id"),
                        rs.getString("rua"),
                        rs.getInt("numero_casa"),
                        rs.getString("bairro"),
                        rs.getString("complemento")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return endereco;
    }

    @Override
    public String inserir(Endereco endereco) {

        try {
            conexao.setAutoCommit(false);

            String sql = "INSERT INTO endereco (rua, numero_casa, bairro, complemento) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, endereco.getRua());
            ps.setInt(2, endereco.getNumeroCasa());
            ps.setString(3, endereco.getBairro());
            ps.setString(4, endereco.getComplemento());

            ps.execute();
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();

            if (rs.getInt(1) > 0) {
                endereco.setId(rs.getInt(1));
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String atualizar(Endereco endereco) {

        try {
            conexao.setAutoCommit(false);

            String sql = "UPDATE endereco SET rua = ?, numero_casa = ?, bairro = ?, complemento = ? WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, endereco.getRua());
            ps.setInt(2, endereco.getNumeroCasa());
            ps.setString(3, endereco.getBairro());
            ps.setString(4, endereco.getComplemento());
            ps.setInt(5, endereco.getId());

            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                conexao.commit();
                return  "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String deletar(Endereco endereco) {

        try {
            conexao.setAutoCommit(false);

            String sql = "DELETE FROM endereco WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, endereco.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                conexao.commit();
                return  "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }
}
