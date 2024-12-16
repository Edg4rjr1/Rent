class CategoriasController < ApplicationController
  def index
    @categorias = Categoria.all
  end

  def show
    @categoria = Categoria.find(params[:id])
    @filmes = @categoria.filmes 
  end
end