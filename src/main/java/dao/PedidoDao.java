package dao;

import model.Pedido;

import java.sql.*;
import java.util.ArrayList;

public class PedidoDao implements DAO<Pedido> {

    private Connection conexao;

    public PedidoDao(Connection conexao) {
        this.conexao = conexao;
    }

    @Override
    public ArrayList<Pedido> selecionar() {

        ArrayList<Pedido> pedidos = new ArrayList<>();

        try {
            String sql = "SELECT * FROM pedido";

            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Pedido pedido = new Pedido(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        new ClienteDao(conexao).selecionar(rs.getInt("cliente_id")),
                        new VendedorDao(conexao).selecionar(rs.getInt("vendedor_id")),
                        new ItemPedidoDao(conexao).selecionar(rs.getInt("item_id")),
                        new StatusPedidoDao(conexao).selecionar(rs.getInt("status_id"))
                );

                pedidos.add(pedido);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pedidos;
    }

    @Override
    public Pedido selecionar(int id) {

        Pedido pedido = null;

        try {
            String sql = "SELECT * FROM pedido WHERE id = ?";

            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                pedido = new Pedido(
                        rs.getInt("id"),
                        rs.getBigDecimal("valor"),
                        rs.getDate("data_pedido").toLocalDate(),
                        new ClienteDao(conexao).selecionar(rs.getInt("cliente_id")),
                        new VendedorDao(conexao).selecionar(rs.getInt("vendedor_id")),
                        new ItemPedidoDao(conexao).selecionar(rs.getInt("item_id")),
                        new StatusPedidoDao(conexao).selecionar(rs.getInt("status_id"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pedido;
    }

    @Override
    public String inserir(Pedido pedido) {

        String retorno = new ItemPedidoDao(conexao).inserir(pedido.getItem());

        if (retorno.equals("OK")) {
            retorno = new StatusPedidoDao(conexao).inserir(pedido.getStatus());

            if (retorno.equals("OK")) {
                try {
                    conexao.setAutoCommit(false);

                    String sql = "INSERT INTO pedido (valor, data_pedido, cliente_id, vendedor_id, item_id, status_id) " +
                            "VALUES (?, CURRENT_DATE, ?, ?, ?, ?)";
                    PreparedStatement ps = conexao.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setBigDecimal(1, pedido.getValor());
                    ps.setInt(2, pedido.getCliente().getId());
                    ps.setInt(3, pedido.getVendedor().getId());
                    ps.setInt(4, pedido.getItem().getId());
                    ps.setInt(5, pedido.getStatus().getId());
                    ps.executeUpdate();
                    ResultSet rs = ps.getGeneratedKeys();
                    rs.next();

                    if (rs.getInt(1) > 0) {
                        pedido.setId(rs.getInt(1));
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
    public String atualizar(Pedido pedido) {

        try {
            conexao.setAutoCommit(false);
            String retorno = new StatusPedidoDao(conexao).atualizar(pedido.getStatus());

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
    public String deletar(Pedido pedido) {
        return null;
    }
}
