module SpreedlyTransaction
  def self.spreedly_env
    Spreedly::Environment.new(
      Rails.application.secrets.spreedly_key,
      Rails.application.secrets.spreedly_secret
    )
  end

  def self.purchase(invoice, amount, payment_method)
    transaction = spreedly_env
      .purchase_on_gateway(
        Rails.application.secrets.gateway_token,
        payment_method.token,
        amount,
        retain_on_success: true
      )
    if transaction.succeeded?
      Payment.create(invoice: invoice,
                     amount: amount,
                     payment_method: payment_method,
                     transaction_token: transaction.token)
    else
      raise Checkout::TransactionError, transaction.message
    end
  end
end
