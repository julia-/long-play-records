json.extract! order, :id, :buyer_id, :product_id, :charge_identifier, :created_at, :updated_at
json.url order_url(order, format: :json)
