class Filme < ApplicationRecord
  has_one_attached :arquivo

  
  belongs_to :categoria
    has_many :emprestimos
    has_many :clientes, through: :emprestimos

    validates :ano_lancamento, presence: true
  validates :duracao, presence: true
  validates :diretor, presence: true
  end