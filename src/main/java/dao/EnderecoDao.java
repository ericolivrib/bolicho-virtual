package dao;

import model.Endereco;

import java.sql.*;
import java.util.ArrayList;

public class EnderecoDao {

    private String status;
    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public EnderecoDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Endereco> selecionar() throws SQLException {

        ArrayList<Endereco> enderecos = new ArrayList<>();

        try (Connection conexao = new ConexaoBase().getConexao()) {

            sql = "SELECT * FROM endereco";

            stmt = conexao.createStatement();
            rs = ps.executeQuery(sql);

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

    public Endereco selecionar(int id) throws SQLException {

        Endereco endereco = null;

        sql = "SELECT * FROM endereco WHERE id = ?";

        ps = conexao.prepareStatement(sql);
        ps.setInt(1, id);

        rs = ps.executeQuery();

        if (rs.next()) {
            endereco = new Endereco(
                    rs.getInt("id"),
                    rs.getString("rua"),
                    rs.getInt("numero_casa"),
                    rs.getString("bairro"),
                    rs.getString("complemento")
            );
        }

        return endereco;
    }

    public String inserir(Endereco endereco) throws SQLException {

        conexao.setAutoCommit(false);

        sql = "INSERT INTO endereco (rua, numero_casa, bairro, complemento) VALUES (?, ?, ?, ?)";

        ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setString(1, endereco.getRua());
        ps.setInt(2, endereco.getNumeroCasa());
        ps.setString(3, endereco.getBairro());
        ps.setString(4, endereco.getComplemento());

        ps.execute();
        rs = ps.getGeneratedKeys();
        rs.next();

        if (rs.getInt(1) > 0) {
            endereco.setId(rs.getInt(1));
            conexao.commit();
            return "OK";
        }

        return "Erro";
    }

    public String atualizar(Endereco endereco) throws SQLException {

        conexao.setAutoCommit(false);

        sql = "UPDATE endereco SET rua = ?, numero_casa = ?, bairro = ?, complemento = ? WHERE id = ?";

        ps = conexao.prepareStatement(sql);
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

        return "Erro";
    }

    public String deletar(Endereco endereco)  throws SQLException {

        conexao.setAutoCommit(false);

        sql = "DELETE FROM endereco WHERE id = ?";

        ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setInt(1, endereco.getId());
        ps.executeUpdate();

        if (ps.getUpdateCount() > 0) {
            conexao.commit();
            return  "OK";
        }

        return "Erro";
    }
}
