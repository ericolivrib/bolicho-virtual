package dao;

import model.Compra;

import java.sql.*;
import java.util.ArrayList;

public class CompraDao {

    private String status;
    private String sql;
    private Statement stmt;
    private PreparedStatement ps;
    private ResultSet rs;

    public ArrayList<Compra> selecionar() {

        ArrayList<Compra> compras = new ArrayList<>();

        try (Connection conexao = new ConexaoBase().getConexao()) {

            sql = "SELECT * FROM compra";

            stmt = conexao.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Compra compra  = new Compra(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        rs.getString("forma_pagamento"),
                        new ClienteDao().selecionar(rs.getInt("cliente_id")),
                        new VendedorDao().selecionar(rs.getInt("vendedor_id")),
                        new StatusCompraDao(conexao).selecionar(rs.getInt("status_id"))
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

        try (Connection conexao = new ConexaoBase().getConexao()) {

            sql = "SELECT * FROM compra WHERE id = ?";

            ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                compra  = new Compra(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        rs.getString("forma_pagamento"),
                        new ClienteDao().selecionar(rs.getInt("cliente_id")),
                        new VendedorDao().selecionar(rs.getInt("vendedor_id")),
                        new StatusCompraDao(conexao).selecionar(rs.getInt("status_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return compra;
    }

    public String inserir(Compra compra) {

        try (Connection conexao = new ConexaoBase().getConexao()) {

            conexao.setAutoCommit(false);

            String retorno = new StatusCompraDao(conexao).inserir(compra.getStatus());

            if (retorno.equals("OK")) {
                sql = "INSERT INTO compra (valor, data_pedido, forma_pagamento, cliente_id, vendedor_id, status_id) " +
                        "VALUES (?, CURRENT_DATE, ?, ?, ?, ?)";

                ps = conexao.prepareStatement(sql);
                ps.setBigDecimal(1, compra.getValor());
                ps.setString(2, compra.getFormaPagamento());
                ps.setInt(3, compra.getCliente().getId());
                ps.setInt(4, compra.getVendedor().getId());
                ps.setInt(5, compra.getStatus().getId());
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

    public String atualizar(Compra compra) {

        try (Connection conexao = new ConexaoBase().getConexao()) {

            conexao.setAutoCommit(false);

            String retorno = new StatusCompraDao(conexao).atualizar(compra.getStatus());

            if (retorno.equals("OK")) {
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
