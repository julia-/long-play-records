module ApplicationHelper
  def format_amount(amount)
    money = Money.new(amount)
    money.format
  end
end
