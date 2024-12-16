# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Criar algumas categorias
comedia = Categoria.create(nome: 'Comédia')
acao = Categoria.create(nome: 'Ação')
drama = Categoria.create(nome: 'Drama')
sci_fi = Categoria.create(nome: 'Ficção Científica')

# Criar alguns filmes
Filme.create(titulo: 'O Grande Lebowski', categoria: comedia)
Filme.create(titulo: 'Vingadores: Ultimato', categoria: acao)
Filme.create(titulo: 'A Origem', categoria: sci_fi)
Filme.create(titulo: 'A Espera de um Milagre', categoria: drama)
Filme.create(titulo: 'Matrix', categoria: sci_fi)
Filme.create(titulo: 'O Poderoso Chefão', categoria: drama)
Filme.create(titulo: 'Deadpool', categoria: comedia)
Filme.create(titulo: 'John Wick', categoria: acao)
