require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  it "creates bank account after user create" do
    user = User.create(email: 'example@example.com', password: 'password')
    expect(user.bank_account).to be_present
    expect(user.bank_account.number).to be_present
  end

  describe '#create_transaction' do
    let(:user){ User.create(email: 'example@example.com', password: 'password') }
    let(:account){ BankAccount.create(user: user) } 

    context 'with valid attributes' do
      let(:transaction_attributes){{
        operation_type: 'Refill',
        amount: 100
      }}

      it "creates transaction" do
        expect { account.create_transaction(transaction_attributes) }.to change { account.account_transactions.count }.by(1)
      end

      it "sends email to user" do
        expect { account.create_transaction(transaction_attributes) }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(ActionMailer::Base.deliveries.last.subject).to eq 'Your transaction was successfully created'
        expect(ActionMailer::Base.deliveries.last.to).to eq [user.email]
      end

      it "update_balance" do
        expect { account.create_transaction(transaction_attributes) }.to change { account.balance }.by(100)
      end
    end

    context 'with invalid attributes' do
      let(:transaction_attributes){{
        operation_type: 'Write-off',
        amount: 1000
      }}

      it "doesn't create transaction" do
        expect { account.create_transaction(transaction_attributes) }.not_to change { account.account_transactions.count }
      end

      it "sends email to admin" do
        expect { account.create_transaction(transaction_attributes) }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(ActionMailer::Base.deliveries.last.subject).to eq 'Transaction creation was failed'
        expect(ActionMailer::Base.deliveries.last.to).to eq [AccountTransactionsMailer::ADMIN_EMAIL]
      end

      it "update_balance" do
        expect { account.create_transaction(transaction_attributes) }.not_to change { account.reload.balance }
      end
    end
  end
end
