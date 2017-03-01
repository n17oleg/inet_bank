class CreateAccountTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :account_transactions do |t|
      t.references :bank_account
      t.integer :amount, default: 0
      t.integer :operation_type
      t.timestamps
    end
  end
end
