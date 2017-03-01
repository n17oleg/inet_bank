class User < ApplicationRecord
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :bank_account, dependent: :destroy

  after_create :create_bank_account

  private

  def create_bank_account
    self.create_bank_account!
  end
end
