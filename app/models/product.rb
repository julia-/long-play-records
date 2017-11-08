class Product < ApplicationRecord
  belongs_to :user
  has_one :order

  def self.convert_to_cents(amount)
    amount_in_cents = amount.gsub(/[^\d]/, '').to_i
  end

  def self.search(query)
    results = where(title_search(query).or(artist_search(query)))
    if results.empty?
      all
    else
      results
    end
  end

  # does a case-insensitive check to see if query matches artist column
  def self.title_search(query)
    table = Product.arel_table
    table[:title].matches(query)
  end

  # does a case-insensitive check to see if query matches artist column
  def self.artist_search(query)
    table = Product.arel_table
    table[:artist].matches(query)
  end

  def self.filter(filter_by)
    if filter_by == "ten"
      where("price_cents < ? ", 1000)
    elsif filter_by == "twenty"
      where("price_cents < ? ", 2000)
    elsif filter_by == "fifty"
      where("price_cents < ? ", 5000)
    elsif filter_by == "hundred"
      where("price_cents < ? ", 10000)
    else
      where("price_cents > ? ", 0)
    end
  end

  def self.order_products(sort_order)
    if sort_order == "newest" || sort_order.blank?
      order(created_at: :desc)
    elsif sort_order == "lowestprice"
      order(price_cents: :asc)
    elsif sort_order == "highestprice"
      order(price_cents: :desc)
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
