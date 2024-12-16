class CreateEmprestimos < ActiveRecord::Migration[7.0]
  def change
    create_table :emprestimos do |t|
      t.references :cliente, foreign_key: true  # Associação com clientes
      t.references :filme, foreign_key: true    # Associação com filmes
      t.date :data_emprestimo
      t.date :data_devolucao
      t.string :status  # Adicionando a coluna de status

      t.timestamps
    end
  end
end