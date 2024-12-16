class Categoria < ApplicationRecord
    has_many :filmes
     self.table_name = 'categorias'
  end