package dao;

import model.Compra;
import model.ItemCompra;

import java.sql.*;
import java.util.ArrayList;

public class CompraDao implements DAO<Compra> {

    private Connection conexao;

    public CompraDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<Compra> selecionar() {

        ArrayList<Compra> compras = new ArrayList<>();

        try {
            String sql = "SELECT * FROM compra";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Compra compra  = new Compra(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        new ClienteDao(conexao).selecionar(rs.getInt("cliente_id")),
                        new VendedorDao(conexao).selecionar(rs.getInt("vendedor_id")),
                        new ItemCompraDao(conexao).selecionar(rs.getInt("item_id")),
                        new StatusCompraDao(conexao).selecionar(rs.getInt("status_id"))
                );

                compras.add(compra);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return compras;
    }

    @Override
    public Compra selecionar(int id) {

        Compra compra = null;

        try {
            String sql = "SELECT * FROM compra WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                compra  = new Compra(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        new ClienteDao(conexao).selecionar(rs.getInt("cliente_id")),
                        new VendedorDao(conexao).selecionar(rs.getInt("vendedor_id")),
                        new ItemCompraDao(conexao).selecionar(rs.getInt("item_id")),
                        new StatusCompraDao(conexao).selecionar(rs.getInt("status_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return compra;
    }

    @Override
    public String inserir(Compra compra) {

        String retorno = new ItemCompraDao(conexao).inserir(compra.getItem());

        if (retorno.equals("OK")) {
            retorno = new StatusCompraDao(conexao).inserir(compra.getStatus());

            if (retorno.equals("OK")) {
                try {
                    conexao.setAutoCommit(false);

                    String sql = "INSERT INTO compra (valor, data_pedido, cliente_id, vendedor_id, item_id, status_id) " +
                            "VALUES (?, CURRENT_DATE, ?, ?, ?, ?)";
                    PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setBigDecimal(1, compra.getValor());
                    ps.setInt(2, compra.getCliente().getId());
                    ps.setInt(3, compra.getVendedor().getId());
                    ps.setInt(4, compra.getItem().getId());
                    ps.setInt(5, compra.getStatus().getId());
                    ps.executeUpdate();
                    ResultSet rs = ps.getGeneratedKeys();
                    rs.next();

                    if (rs.getInt(1) > 0) {
                        compra.setId(rs.getInt(1));
                        conexao.commit();
                        return "OK";
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return "Erro";
    }

    @Override
    public String atualizar(Compra compra) {

        try {
            conexao.setAutoCommit(false);
            String retorno = new StatusCompraDao(conexao).atualizar(compra.getStatus());

            if (retorno.equals("OK")) {
                conexao.commit();
                return "OK";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Erro";
    }

    @Override
    public String deletar(Compra compra) {
        return null;
    }
}
