package controller;

import dao.connection.ConexaoBase;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;


@WebFilter("/*")
public class FiltroRequisicao implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        try (Connection conexao = new ConexaoBase().getConexao()) {

            request.setAttribute("conexao", conexao);
            chain.doFilter(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
