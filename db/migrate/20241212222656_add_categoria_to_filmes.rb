class AddCategoriaToFilmes < ActiveRecord::Migration[8.0]
  def change
    #add_reference :filmes, :categoria, null: false, foreign_key: true
  end
end
