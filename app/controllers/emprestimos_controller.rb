class EmprestimosController < ApplicationController
  def index
    if params[:search].present?
      @emprestimos = Emprestimo.joins(:cliente, :filme)
                               .where("clientes.nome LIKE ? OR filmes.titulo LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
                               .page(params[:page]).per(7)
    else
      @emprestimos = Emprestimo.all.page(params[:page]).per(7)
    end
  end

  def show
    begin
      @emprestimo = Emprestimo.find(params[:id]) # busca ID
    rescue ActiveRecord::RecordNotFound
      redirect_to emprestimos_path, alert: "Empréstimo não encontrado." # Caso não encontre, redireciona
    end
  end

  def new
    @emprestimo = Emprestimo.new
  end

  def create
    @emprestimo = Emprestimo.new(emprestimo_params)

    if @emprestimo.save
      redirect_to emprestimos_path, notice: 'Empréstimo criado com sucesso.'
    else
      render :new
    end
  end

  def edit
    @emprestimo = Emprestimo.find(params[:id])
  end

  def update
    @emprestimo = Emprestimo.find(params[:id])
    if @emprestimo.update(emprestimo_params)
      redirect_to emprestimos_path, notice: 'Empréstimo atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    if @emprestimo
      @emprestimo.destroy
      redirect_to emprestimos_path, notice: 'Empréstimo excluído com sucesso.'
    else
      redirect_to emprestimos_path, alert: 'Empréstimo não encontrado.'
    end
  end

  private

  def update
    @emprestimo = Emprestimo.find(params[:id])
    if @emprestimo.update(emprestimo_params)
      redirect_to emprestimos_path, notice: 'Empréstimo atualizado com sucesso.'
    else
      render :edit
    end
  end

  def emprestimo_params
    params.require(:emprestimo).permit(:cliente_id, :filme_id, :data_emprestimo, :data_devolucao)
  end
end