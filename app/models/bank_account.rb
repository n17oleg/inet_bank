class BankAccount < ApplicationRecord
  NUMBER_LENGTH = 20

  belongs_to :user

  before_create :generate_number

  private

  def generate_number
    begin 
      self.number = (0...NUMBER_LENGTH).map{ rand(10) }.join 
    end while BankAccount.where(number: self.number).exists?
  end
end
