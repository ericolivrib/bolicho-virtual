package controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface LogicaNegocio {

    String executa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
}
