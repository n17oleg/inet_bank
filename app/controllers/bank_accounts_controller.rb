class BankAccountsController < ApplicationController
  def show
    @bank_account = current_user.bank_account
    ActiveRecord::Associations::Preloader.new.preload(@bank_account, :account_transactions)
  end
end
