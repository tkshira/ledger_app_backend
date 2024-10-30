class TransactionType < ApplicationRecord
  validates :name, presence: true
  validates :direction, presence: true
end
