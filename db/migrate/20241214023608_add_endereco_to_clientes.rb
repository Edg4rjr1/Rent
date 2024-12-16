class AddEnderecoToClientes < ActiveRecord::Migration[8.0]
  def change
    add_column :clientes, :endereco, :string
  end
end
