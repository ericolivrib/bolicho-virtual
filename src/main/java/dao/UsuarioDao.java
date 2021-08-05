package dao;

import model.Permissao;
import model.Usuario;

import java.sql.*;
import java.util.ArrayList;

public class UsuarioDao {

    private String status;
    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;
    private Connection conexao;

    public UsuarioDao(Connection conexao) {
        this.conexao = conexao;
    }

    public ArrayList<Usuario> selecionar() {

        ArrayList<Usuario> usuarios = new ArrayList<>();

        try {
            sql = "SELECT * FROM usuario u, permissao p, usuario_permissao up " +
                    "WHERE u.id = up.usuario_id AND p.id = up.permissao_id";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Usuario usuario = new Usuario (
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("telefone"),
                        rs.getString("senha"),
                        rs.getDate("data_cadastro").toLocalDate(),
                        new EnderecoDao(conexao).selecionar(rs.getInt("endereco_id")),
                        new Permissao(rs.getInt("id"), rs.getString("descricao"))
                );

                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarios;
    }

    public Usuario selecionar(int id) {

        Usuario usuario = null;

        try {
            sql = "SELECT * FROM usuario u, permissao p, usuario_permissao up " +
                    "WHERE u.id = up.usuario_id AND p.id = up.permissao_id AND u.id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario (
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("telefone"),
                        rs.getString("senha"),
                        rs.getDate("data_cadastro").toLocalDate(),
                        new EnderecoDao(conexao).selecionar(rs.getInt("endereco_id")),
                        new Permissao(rs.getInt("id"), rs.getString("descricao"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }

    public String inserir(Usuario usuario) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new EnderecoDao(conexao).inserir(usuario.getEndereco());

            if (retorno.equals("OK")) {
                sql = "INSERT INTO usuario (nome, telefone, email, senha, endereco_id, data_cadastro) " +
                        "VALUES (?, ?, ?, ?, ?, CURRENT_DATE)";

                ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setString(1, usuario.getNome());
                ps.setString(2, usuario.getTelefone());
                ps.setString(3, usuario.getEmail());
                ps.setString(4, usuario.getSenha());
                ps.setInt(5, usuario.getEndereco().getId());

                ps.execute();
                rs = ps.getGeneratedKeys();
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
            return "Erro";
        }

        return "Erro";
    }

    public String atualizar(Usuario usuario) {

        try {
            conexao.setAutoCommit(false);

            String retorno = new EnderecoDao(conexao).atualizar(usuario.getEndereco());

            if (retorno.equals("OK")) {
                sql = "UPDATE usuario SET nome = ?, telefone = ?, email = ?, senha = ? WHERE id = ?";

                ps = conexao.prepareStatement(sql);
                ps.setString(1, usuario.getNome());
                ps.setString(2, usuario.getTelefone());
                ps.setString(3, usuario.getEmail());
                ps.setString(4, usuario.getSenha());
                ps.setInt(5, usuario.getId());

                ps.executeUpdate();

                if (ps.getUpdateCount() > 0) {
                    conexao.commit();
                    return "OK";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }

    public String deletar(Usuario usuario) {

        try {
            conexao.setAutoCommit(false);

            sql  = "DELETE FROM usuario_permissao WHERE usuario_id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, usuario.getId());
            ps.executeUpdate();

            if (ps.getUpdateCount() > 0) {
                sql = "DELETE FROM usuario WHERE id = ?";

                ps = conexao.prepareStatement(sql);
                ps.setInt(1, usuario.getId());
                ps.executeUpdate();

                if (ps.getUpdateCount() > 0) {
                    String retorno = new EnderecoDao(conexao).deletar(usuario.getEndereco());

                    if (retorno.equals("OK")) {
                        conexao.commit();
                        return "OK";
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Erro";
        }

        return "Erro";
    }
}
