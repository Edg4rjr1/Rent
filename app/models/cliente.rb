class Cliente < ApplicationRecord
  has_many :emprestimos

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true
  validates :telefone, presence: true
  validates :endereco, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :sobrenome, presence: true
end