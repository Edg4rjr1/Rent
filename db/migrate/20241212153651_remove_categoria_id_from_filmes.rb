class RemoveCategoriaIdFromFilmes < ActiveRecord::Migration[8.0]
  def change
    remove_column :filmes, :categoria_id, :integer
  end
end
