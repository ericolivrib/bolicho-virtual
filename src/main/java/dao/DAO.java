package dao;

import java.util.ArrayList;

public interface DAO<T> {

    ArrayList<T> selecionar();
    T selecionar(int id);
    String inserir(T t);
    String atualizar(T t);
    String deletar(T t);
}
