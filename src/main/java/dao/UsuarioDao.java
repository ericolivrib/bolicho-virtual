package dao;

import model.Permissao;
import model.Usuario;

import java.sql.*;
import java.util.ArrayList;

public class UsuarioDao implements DAO<Usuario> {

    private Connection conexao;

    public UsuarioDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<Usuario> selecionar() {

        ArrayList<Usuario> usuarios = new ArrayList<>();

        try {
            String sql = "SELECT * FROM usuario u, permissao p, usuario_permissao up " +
                    "WHERE u.id = up.usuario_id AND p.id = up.permissao_id";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Usuario usuario = new Usuario (
                        rs.getInt("usuario.id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("telefone"),
                        rs.getDate("data_cadastro").toLocalDate(),
                        rs.getBoolean("ativo"),
                        new EnderecoDao(conexao).selecionar(rs.getInt("endereco_id")),
                        new Permissao(rs.getInt("permissao_id"), rs.getString("descricao"))
                );

                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarios;
    }

    @Override
    public Usuario selecionar(int id) {

        Usuario usuario = null;

        try {
            String sql = "SELECT * FROM usuario u, permissao p, usuario_permissao up " +
                    "WHERE u.id = up.usuario_id AND p.id = up.permissao_id AND u.id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario (
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("telefone"),
                        rs.getDate("data_cadastro").toLocalDate(),
                        rs.getBoolean("ativo"),
                        new EnderecoDao(conexao).selecionar(rs.getInt("endereco_id")),
                        new Permissao(rs.getInt("permissao_id"), rs.getString("descricao"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }

    @Override
    public String inserir(Usuario usuario) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new EnderecoDao(conexao).inserir(usuario.getEndereco());

            if (retorno.equals("OK")) {
                String sql = "INSERT INTO usuario (nome, telefone, email, endereco_id, data_cadastro, ativo) " +
                        "VALUES (?, ?, ?, ?, CURRENT_DATE, ?)";

                PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setString(1, usuario.getNome());
                ps.setString(2, usuario.getTelefone());
                ps.setString(3, usuario.getEmail());
                ps.setInt(4, usuario.getEndereco().getId());
                ps.setBoolean(5, usuario.isAtivo());

                ps.execute();
                ResultSet rs = ps.getGeneratedKeys();
                rs.next();

                if (rs.getInt(1) > 0) {
                    usuario.setId(rs.getInt(1));

                    sql = "INSERT INTO usuario_permissao (usuario_id, permissao_id) VALUES (?, ?)";

                    ps = conexao.prepareStatement(sql);
                    ps.setInt(1, usuario.getId());
                    ps.setInt(2, usuario.getPermissao().getId());
                    ps.executeUpdate();

                    if (ps.getUpdateCount() > 0) {
                        conexao.commit();
                        return "OK";
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String atualizar(Usuario usuario) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new EnderecoDao(conexao).atualizar(usuario.getEndereco());

            if (retorno.equals("OK")) {
                String sql = "UPDATE usuario SET nome = ?, telefone = ?, email = ? WHERE id = ?";

                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, usuario.getNome());
                ps.setString(2, usuario.getTelefone());
                ps.setString(3, usuario.getEmail());
                ps.setInt(4, usuario.getId());

                ps.executeUpdate();

                if (ps.getUpdateCount() > 0) {
                    conexao.commit();
                    return "OK";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String deletar(Usuario usuario) {

        try {
            conexao.setAutoCommit(false);

            String sql = "UPDATE usuario SET ativo = ? WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setBoolean(1, usuario.isAtivo());
            ps.setInt(2, usuario.getId());

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
