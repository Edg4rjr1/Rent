class FilmesController < ApplicationController
  before_action :set_filme, only: %i[show edit update destroy]

  def index
    if params[:search].present?
      @filmes = Filme.joins(:categoria)
                     .where("filmes.titulo LIKE ? OR categorias.nome LIKE ? OR filmes.ano_lancamento LIKE ?", 
                            "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
                     .page(params[:page]).per(10)
    else
      @filmes = Filme.page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @filme = Filme.new
  end

  def create
    @filme = Filme.new(filme_params)
    if @filme.save
      redirect_to filmes_path, notice: 'Filme criado com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @filme.update(filme_params)
      redirect_to filmes_path, notice: 'Filme atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @filme.destroy
    redirect_to filmes_path, notice: 'Filme excluído com sucesso.'
  end

  # Ação para gerar o PDF
  def gerar_pdf
    @filmes = Filme.all
    pdf = criar_pdf(@filmes)
    
    send_data pdf.render, filename: "filmes.pdf", type: "application/pdf", disposition: "inline"
  end

  private

  # Método para encontrar o filme
  def set_filme
    @filme = Filme.find(params[:id])
  end

  # Parâmetros permitidos
  def filme_params
    params.require(:filme).permit(:titulo, :categoria_id, :ano_lancamento, :duracao, :diretor, :arquivo)
  end

  # Função para criar o PDF
  def criar_pdf(filmes)
    pdf = Prawn::Document.new
    pdf.text "Lista de Filmes", size: 20, style: :bold
    pdf.move_down 20

    data = [["Título", "Categoria", "Ano de Lançamento", "Duração", "Diretor"]]
    filmes.each do |filme|
      data << [filme.titulo, filme.categoria.nome, filme.ano_lancamento, filme.duracao, filme.diretor]
    end

    pdf.table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], position: :center, width: 500) do
      row(0).font_style = :bold
      columns(0..4).align = :center
    end

    pdf
  end
end