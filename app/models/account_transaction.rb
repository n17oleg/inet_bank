class AccountTransaction < ApplicationRecord
  belongs_to :bank_account
  OPERATION_TYPES = ['Refill', 'Write-off']

  enum operation_type: OPERATION_TYPES

  validates_numericality_of :amount, greater_than_or_equal_to: 0
  validate :writeoff_amount_should_be_less_than_balance

  private

  def writeoff_amount_should_be_less_than_balance
    if operation_type == 'Write-off' && amount > bank_account.balance
      errors.add(:amount, "can't be greater than account balance")
    end
  end
end
