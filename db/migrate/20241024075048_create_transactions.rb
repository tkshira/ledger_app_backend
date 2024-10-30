class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :transaction_type, null: false, foreign_key: true
      t.datetime :date
      t.float :value
      t.string :comment

      t.timestamps
    end
  end
end
