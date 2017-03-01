require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  it "validates writeoff amount less than balance" do
    account = BankAccount.create(balance: 100)
    account_transaction = AccountTransaction.new(bank_account: account, amount: 200, operation_type: 'Write-off')
    expect(account_transaction).not_to be_valid
    expect(account_transaction.errors[:amount]).to be_present
  end
end
