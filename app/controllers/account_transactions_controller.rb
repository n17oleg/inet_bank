class AccountTransactionsController < ApplicationController
  def new
    @account_transaction = AccountTransaction.new
  end

  def create
    @account_transaction = current_user.bank_account.create_transaction(transaction_params)
    if @account_transaction.id
      flash[:notice] = 'Transaction successfully created'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:account_transaction).permit(:amount, :operation_type)
  end
end
