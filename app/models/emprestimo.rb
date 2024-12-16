class Emprestimo < ApplicationRecord
  belongs_to :cliente
  belongs_to :filme

  validates :cliente_id, :filme_id, :data_emprestimo, :data_devolucao, presence: true

end