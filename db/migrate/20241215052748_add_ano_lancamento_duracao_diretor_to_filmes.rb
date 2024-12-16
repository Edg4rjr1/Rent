class AddAnoLancamentoDuracaoDiretorToFilmes < ActiveRecord::Migration[8.0]
  def change
    add_column :filmes, :ano_lancamento, :integer
    add_column :filmes, :duracao, :integer
    add_column :filmes, :diretor, :string
  end
end
