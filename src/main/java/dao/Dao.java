package dao;

import java.util.ArrayList;

public interface Dao {

    ArrayList<Object> selecionar();
    Object selecionar(int integer);
    String inserir(Object o);
    String atualizar(Object o);
    String deletar(Object o);
}
