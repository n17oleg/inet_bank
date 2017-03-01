class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.string :number
      t.references :user
      t.integer :balance, default: 0
      t.timestamps
    end
  end
end
