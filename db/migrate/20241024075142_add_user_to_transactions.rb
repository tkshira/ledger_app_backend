class AddUserToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_reference :transactions, :user
  end
end
