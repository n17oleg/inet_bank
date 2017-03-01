class AccountTransactionsMailer < ApplicationMailer
  ADMIN_EMAIL = 'admin@example.com'

  def success(user_id)
    @user = User.find(user_id)
    mail  to: @user.email,
          subject: "Your transaction was successfully created"
  end

  def fail(user_id)
    @user = User.find(user_id)
    mail  to: ADMIN_EMAIL,
          subject: "Transaction creation was failed"
  end
end
