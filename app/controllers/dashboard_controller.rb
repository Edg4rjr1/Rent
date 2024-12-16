class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @clientes = Cliente.all
    @filmes = Filme.all
    @categorias = Categoria.all
    @emprestimos = Emprestimo.all
  end

  def gerar_csv_filmes
    @filmes = Filme.all
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["ID", "Título", "Categoria", "Ano de Lançamento", "Duração", "Diretor"]
      @filmes.each do |filme|
        csv << [filme.id, filme.titulo, filme.categoria.nome, filme.ano_lancamento, filme.duracao, filme.diretor]
      end
    end
    send_data csv_data, filename: "filmes.csv", type: "text/csv", disposition: "inline"
  end

  def gerar_csv_clientes
    @clientes = Cliente.all
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["ID", "Nome", "Sobrenome", "Email", "Telefone", "CPF"]
      @clientes.each do |cliente|
        csv << [cliente.id, cliente.nome, cliente.sobrenome, cliente.email, cliente.telefone, cliente.cpf]
      end
    end
    send_data csv_data, filename: "clientes.csv", type: "text/csv", disposition: "inline"
  end
end