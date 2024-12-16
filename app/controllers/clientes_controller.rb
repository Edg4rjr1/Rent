class ClientesController < ApplicationController
  before_action :set_cliente, only: [:edit, :update, :destroy, :show]

  def index
    if params[:search].present?
      @clientes = Cliente.where("nome LIKE ? OR sobrenome LIKE ? OR email LIKE ? OR cpf LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(6)
    else
      @clientes = Cliente.page(params[:page]).per(6)
    end
  end

  # Ação para exibir o formulário de edição
  def edit
    # @cliente já foi carregado pelo before_action
  end

  # Ação para atualizar as informações do cliente
  def update
    if @cliente.update(cliente_params)
      redirect_to clientes_path, notice: 'Cliente atualizado com sucesso.'
    else
      render :edit
    end
  end

  # Ação para criar um novo cliente
  def create
    @cliente = Cliente.new(cliente_params)
    if @cliente.save
      redirect_to clientes_path, notice: 'Cliente criado com sucesso.'
    else
      render :new
    end
  end

  # Ação para excluir um cliente
  def destroy
    if @cliente.destroy
      redirect_to clientes_path, notice: 'Cliente deletado com sucesso.'
    else
      redirect_to clientes_path, alert: 'Erro ao deletar cliente.'
    end
  end

  # Ação para exibir o formulário de criação
  def new
    @cliente = Cliente.new
  end

  # Método para gerar o PDF com a lista de clientes
  def gerar_pdf
    @clientes = Cliente.all
    pdf = criar_pdf(@clientes)

    send_data pdf.render, filename: "clientes.pdf", type: "application/pdf", disposition: "inline"
  end

  # Ação para gerar o CSV com a lista de clientes
  def gerar_csv
    @clientes = Cliente.all
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["ID", "Nome", "Sobrenome", "Email", "Telefone", "CPF"]  # Cabeçalhos do CSV
      @clientes.each do |cliente|
        csv << [cliente.id, cliente.nome, cliente.sobrenome, cliente.email, cliente.telefone, cliente.cpf]
      end
    end

    send_data csv_data, filename: "clientes.csv", type: "text/csv", disposition: "inline"
  end

  private

  # Método para encontrar o cliente pelo id
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Método para permitir somente parâmetros permitidos
  def cliente_params
    params.require(:cliente).permit(:nome, :sobrenome, :email, :telefone, :endereco, :cpf)
  end

  # Método para criar o PDF com os dados dos clientes
  def criar_pdf(clientes)
    pdf = Prawn::Document.new
    pdf.text "Lista de Clientes", size: 20, style: :bold
    pdf.move_down 20

    # Dados a serem colocados na tabela
    data = [["Nome", "CPF", "Email", "Telefone", "Endereço"]]
    clientes.each do |cliente|
      data << [cliente.nome, cliente.cpf, cliente.email, cliente.telefone, cliente.endereco]
    end

    # Criando a tabela no PDF
    pdf.table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], position: :center, width: 500) do
      row(0).font_style = :bold
      columns(0..4).align = :center
    end

    pdf
  end
end