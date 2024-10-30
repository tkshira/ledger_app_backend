class CreateTransactionTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :transaction_types do |t|
      t.string :name
      t.integer :direction

      t.timestamps
    end
  end
end
