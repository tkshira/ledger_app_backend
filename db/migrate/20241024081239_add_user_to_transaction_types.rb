class AddUserToTransactionTypes < ActiveRecord::Migration[7.2]
  def change
    add_reference :transaction_types, :user
  end
end
