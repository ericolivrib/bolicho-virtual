package model;

import java.time.LocalDate;

public class Usuario {

    private int id;
    private String nome;
    private String email;
    private String telefone;
    private LocalDate dataCadastro;
    private boolean ativo;
    private Endereco endereco;
    private Permissao permissao;

    public Usuario(String nome, String email, String telefone, boolean ativo, Endereco endereco, Permissao permissao) {
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.ativo = ativo;
        this.endereco = endereco;
        this.permissao = permissao;
    }

    public Usuario(int id, String nome, String email, String telefone, Endereco endereco, Permissao permissao) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.endereco = endereco;
        this.permissao = permissao;
    }

    public Usuario(int id, String nome, String email, String telefone, LocalDate dataCadastro, boolean ativo, Endereco endereco, Permissao permissao) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.telefone = telefone;
        this.dataCadastro = dataCadastro;
        this.ativo = ativo;
        this.endereco = endereco;
        this.permissao = permissao;
    }

    public Usuario(int id, Endereco endereco, Permissao permissao) {
        this.id = id;
        this.endereco = endereco;
        this.permissao = permissao;
    }

    public Usuario(int id, boolean ativo) {
        this.id = id;
        this.ativo = ativo;
    }

    public Usuario(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public LocalDate getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(LocalDate dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public boolean isAtivo() {
        return ativo;
    }

    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public Permissao getPermissao() {
        return permissao;
    }

    public void setPermissao(Permissao permissao) {
        this.permissao = permissao;
    }
}
