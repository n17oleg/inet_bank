class BankAccount < ApplicationRecord
  NUMBER_LENGTH = 20

  belongs_to :user
  has_many :account_transactions, dependent: :destroy

  validates_numericality_of :balance, greater_than_or_equal_to: 0

  before_create :generate_number

  def create_transaction(attributes)
    account_transaction = self.account_transactions.new(attributes)
    ActiveRecord::Base.transaction do
      account_transaction.save
      update_balance(account_transaction)
    end
    if !account_transaction.id
      # send mail
    end
    account_transaction
  end

  private

  def generate_number
    begin 
      self.number = (0...NUMBER_LENGTH).map{ rand(10) }.join 
    end while BankAccount.where(number: self.number).exists?
  end

  def update_balance(account_transaction)
    if account_transaction.operation_type == 'Refill'
      self.balance = self.balance + account_transaction.amount
    else
      self.balance = self.balance - account_transaction.amount
    end
    save
  end
end
