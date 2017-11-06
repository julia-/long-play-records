class Product < ApplicationRecord
  belongs_to :user
  #
  # scope :under_150000, -> { where("night_fee_cents < ? ", "150000") }
  # scope :under_200000, -> { where("night_fee_cents < ? ", "200000") }

  def self.filter(filter_by)
    if filter_by == "ten"
      where("price < ? ", 10)
    elsif filter_by == "twenty"
      where("price < ? ", 20)
    elsif filter_by == "fifty"
      where("price < ? ", 50)
    elsif filter_by == "hundred"
      where("price < ? ", 100)
    else
      where("price > ? ", 0)
    end
  end

  def self.order_products(sort_order)
    if sort_order == "newest" || sort_order.blank?
      order(created_at: :desc)
    elsif sort_order == "lowestprice"
      order(price: :asc)
    elsif sort_order == "highestprice"
      order(price: :desc)
    elsif sort_order == "artist"
      order(artist: :asc)
    elsif sort_order == "title"
      order(title: :asc)
    elsif sort_order == "title"
      order(title: :asc)
    else
      order(created_at: :asc)
    end
  end
end
