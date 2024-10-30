class Transaction < ApplicationRecord
  belongs_to :transaction_type

  validates :transaction_type, presence: true
  validates :date, presence: true
  validates :value, presence: true
end
