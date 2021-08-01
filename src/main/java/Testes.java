import dao.ConnectionFactory;

public class Testes {

    public static void main(String[] args) {

        System.out.println(new ConnectionFactory().getConexao());
    }
}
