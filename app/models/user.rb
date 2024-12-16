class User < ApplicationRecord
  # Inclui os módulos do Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Outros métodos ou validações podem estar aqui
end