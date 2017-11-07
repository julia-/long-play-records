class OrderMailer < ApplicationMailer
  def order_confirmation(buyer_email, order)
    @buyer_email = buyer_email
    @product_title = order[:title]
    @product_artist = order[:artist]
    total_amount = (order[:total_amount] / 100)
    @order_amount = total_amount
    mail(to: @buyer_email, subject: "Order Confirmation")
  end
end
